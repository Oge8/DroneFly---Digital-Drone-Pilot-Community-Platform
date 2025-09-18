;; DroneFly - Digital Drone Pilot Community Platform
;; A blockchain-based platform for flight zones, mission logs,
;; and pilot community rewards

;; Contract constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))
(define-constant err-invalid-input (err u104))

;; Token constants
(define-constant token-name "DroneFly Pilot Token")
(define-constant token-symbol "DFT")
(define-constant token-decimals u6)
(define-constant token-max-supply u35000000000) ;; 35k tokens with 6 decimals

;; Reward amounts (in micro-tokens)
(define-constant reward-flight u2300000) ;; 2.3 DFT
(define-constant reward-zone u2700000) ;; 2.7 DFT
(define-constant reward-milestone u9800000) ;; 9.8 DFT

;; Data variables
(define-data-var total-supply uint u0)
(define-data-var next-zone-id uint u1)
(define-data-var next-flight-id uint u1)

;; Token balances
(define-map token-balances principal uint)

;; Pilot profiles
(define-map pilot-profiles
  principal
  {
    username: (string-ascii 24),
    drone-type: (string-ascii 12), ;; "racing", "photography", "mapping", "freestyle", "commercial"
    flights-logged: uint,
    zones-shared: uint,
    flight-hours: uint,
    pilot-level: uint, ;; 1-5
    join-date: uint
  }
)

;; Flight zones
(define-map flight-zones
  uint
  {
    zone-name: (string-ascii 30),
    coordinates: (string-ascii 24),
    zone-type: (string-ascii 12), ;; "open", "restricted", "recreational", "commercial"
    altitude-limit: uint, ;; meters
    terrain: (string-ascii 12), ;; "urban", "rural", "coastal", "mountain"
    restrictions: (string-ascii 20),
    discoverer: principal,
    flight-count: uint,
    average-rating: uint
  }
)

;; Flight logs
(define-map flight-logs
  uint
  {
    zone-id: uint,
    pilot: principal,
    flight-duration: uint, ;; minutes
    max-altitude: uint, ;; meters
    weather-condition: (string-ascii 8), ;; "clear", "windy", "cloudy"
    mission-type: (string-ascii 12), ;; "recreation", "photography", "survey", "practice"
    flight-notes: (string-ascii 100),
    flight-date: uint,
    successful: bool
  }
)

;; Zone reviews
(define-map zone-reviews
  { zone-id: uint, reviewer: principal }
  {
    rating: uint, ;; 1-10
    review-text: (string-ascii 110),
    safety-rating: (string-ascii 8), ;; "excellent", "good", "fair", "risky"
    review-date: uint,
    useful-votes: uint
  }
)

;; Pilot milestones
(define-map pilot-milestones
  { pilot: principal, milestone: (string-ascii 12) }
  {
    achievement-date: uint,
    flight-count: uint
  }
)

;; Helper function to get or create profile
(define-private (get-or-create-profile (pilot principal))
  (match (map-get? pilot-profiles pilot)
    profile profile
    {
      username: "",
      drone-type: "photography",
      flights-logged: u0,
      zones-shared: u0,
      flight-hours: u0,
      pilot-level: u1,
      join-date: stacks-block-height
    }
  )
)

;; Token functions
(define-read-only (get-name)
  (ok token-name)
)

(define-read-only (get-symbol)
  (ok token-symbol)
)

(define-read-only (get-decimals)
  (ok token-decimals)
)

(define-read-only (get-balance (user principal))
  (ok (default-to u0 (map-get? token-balances user)))
)

(define-private (mint-tokens (recipient principal) (amount uint))
  (let (
    (current-balance (default-to u0 (map-get? token-balances recipient)))
    (new-balance (+ current-balance amount))
    (new-total-supply (+ (var-get total-supply) amount))
  )
    (asserts! (<= new-total-supply token-max-supply) err-invalid-input)
    (map-set token-balances recipient new-balance)
    (var-set total-supply new-total-supply)
    (ok amount)
  )
)

;; Add flight zone
(define-public (add-flight-zone (zone-name (string-ascii 30)) (coordinates (string-ascii 24)) (zone-type (string-ascii 12)) (altitude-limit uint) (terrain (string-ascii 12)) (restrictions (string-ascii 20)))
  (let (
    (zone-id (var-get next-zone-id))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len zone-name) u0) err-invalid-input)
    (asserts! (> (len coordinates) u0) err-invalid-input)
    (asserts! (> altitude-limit u0) err-invalid-input)
    
    (map-set flight-zones zone-id {
      zone-name: zone-name,
      coordinates: coordinates,
      zone-type: zone-type,
      altitude-limit: altitude-limit,
      terrain: terrain,
      restrictions: restrictions,
      discoverer: tx-sender,
      flight-count: u0,
      average-rating: u0
    })
    
    ;; Update profile
    (map-set pilot-profiles tx-sender
      (merge profile {zones-shared: (+ (get zones-shared profile) u1)})
    )
    
    ;; Award zone sharing tokens
    (try! (mint-tokens tx-sender reward-zone))
    
    (var-set next-zone-id (+ zone-id u1))
    (print {action: "flight-zone-added", zone-id: zone-id, discoverer: tx-sender})
    (ok zone-id)
  )
)

;; Log flight mission
(define-public (log-flight (zone-id uint) (flight-duration uint) (max-altitude uint) (weather-condition (string-ascii 8)) (mission-type (string-ascii 12)) (flight-notes (string-ascii 100)) (successful bool))
  (let (
    (flight-id (var-get next-flight-id))
    (zone (unwrap! (map-get? flight-zones zone-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> flight-duration u0) err-invalid-input)
    (asserts! (<= max-altitude (get altitude-limit zone)) err-invalid-input)
    
    (map-set flight-logs flight-id {
      zone-id: zone-id,
      pilot: tx-sender,
      flight-duration: flight-duration,
      max-altitude: max-altitude,
      weather-condition: weather-condition,
      mission-type: mission-type,
      flight-notes: flight-notes,
      flight-date: stacks-block-height,
      successful: successful
    })
    
    ;; Update zone flight count
    (map-set flight-zones zone-id
      (merge zone {flight-count: (+ (get flight-count zone) u1)})
    )
    
    ;; Update profile if successful
    (if successful
      (begin
        (map-set pilot-profiles tx-sender
          (merge profile {
            flights-logged: (+ (get flights-logged profile) u1),
            flight-hours: (+ (get flight-hours profile) (/ flight-duration u60)),
            pilot-level: (+ (get pilot-level profile) (/ flight-duration u45))
          })
        )
        (try! (mint-tokens tx-sender reward-flight))
        true
      )
      (begin
        (map-set pilot-profiles tx-sender
          (merge profile {flights-logged: (+ (get flights-logged profile) u1)})
        )
        (try! (mint-tokens tx-sender (/ reward-flight u4)))
        true
      )
    )
    
    (var-set next-flight-id (+ flight-id u1))
    (print {action: "flight-logged", flight-id: flight-id, zone-id: zone-id})
    (ok flight-id)
  )
)

;; Write zone review
(define-public (write-review (zone-id uint) (rating uint) (review-text (string-ascii 110)) (safety-rating (string-ascii 8)))
  (let (
    (zone (unwrap! (map-get? flight-zones zone-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (and (>= rating u1) (<= rating u10)) err-invalid-input)
    (asserts! (> (len review-text) u0) err-invalid-input)
    (asserts! (is-none (map-get? zone-reviews {zone-id: zone-id, reviewer: tx-sender})) err-already-exists)
    
    (map-set zone-reviews {zone-id: zone-id, reviewer: tx-sender} {
      rating: rating,
      review-text: review-text,
      safety-rating: safety-rating,
      review-date: stacks-block-height,
      useful-votes: u0
    })
    
    ;; Update zone average rating (simplified calculation)
    (let (
      (current-avg (get average-rating zone))
      (flight-count (get flight-count zone))
      (new-avg (if (> flight-count u0)
                 (/ (+ (* current-avg flight-count) rating) (+ flight-count u1))
                 rating))
    )
      (map-set flight-zones zone-id (merge zone {average-rating: new-avg}))
    )
    
    (print {action: "review-written", zone-id: zone-id, reviewer: tx-sender})
    (ok true)
  )
)

;; Vote review useful
(define-public (vote-useful (zone-id uint) (reviewer principal))
  (let (
    (review (unwrap! (map-get? zone-reviews {zone-id: zone-id, reviewer: reviewer}) err-not-found))
  )
    (asserts! (not (is-eq tx-sender reviewer)) err-unauthorized)
    
    (map-set zone-reviews {zone-id: zone-id, reviewer: reviewer}
      (merge review {useful-votes: (+ (get useful-votes review) u1)})
    )
    
    (print {action: "review-voted-useful", zone-id: zone-id, reviewer: reviewer})
    (ok true)
  )
)

;; Update drone type
(define-public (update-drone-type (new-drone-type (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-drone-type) u0) err-invalid-input)
    
    (map-set pilot-profiles tx-sender (merge profile {drone-type: new-drone-type}))
    
    (print {action: "drone-type-updated", pilot: tx-sender, type: new-drone-type})
    (ok true)
  )
)

;; Claim milestone
(define-public (claim-milestone (milestone (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (is-none (map-get? pilot-milestones {pilot: tx-sender, milestone: milestone})) err-already-exists)
    
    ;; Check milestone requirements
    (let (
      (milestone-met
        (if (is-eq milestone "pilot-60") (>= (get flights-logged profile) u60)
        (if (is-eq milestone "explorer-11") (>= (get zones-shared profile) u11)
        false)))
    )
      (asserts! milestone-met err-unauthorized)
      
      ;; Record milestone
      (map-set pilot-milestones {pilot: tx-sender, milestone: milestone} {
        achievement-date: stacks-block-height,
        flight-count: (get flights-logged profile)
      })
      
      ;; Award milestone tokens
      (try! (mint-tokens tx-sender reward-milestone))
      
      (print {action: "milestone-claimed", pilot: tx-sender, milestone: milestone})
      (ok true)
    )
  )
)

;; Update username
(define-public (update-username (new-username (string-ascii 24)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-username) u0) err-invalid-input)
    (map-set pilot-profiles tx-sender (merge profile {username: new-username}))
    (print {action: "username-updated", pilot: tx-sender})
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-pilot-profile (pilot principal))
  (map-get? pilot-profiles pilot)
)

(define-read-only (get-flight-zone (zone-id uint))
  (map-get? flight-zones zone-id)
)

(define-read-only (get-flight-log (flight-id uint))
  (map-get? flight-logs flight-id)
)

(define-read-only (get-zone-review (zone-id uint) (reviewer principal))
  (map-get? zone-reviews {zone-id: zone-id, reviewer: reviewer})
)

(define-read-only (get-milestone (pilot principal) (milestone (string-ascii 12)))
  (map-get? pilot-milestones {pilot: pilot, milestone: milestone})
)