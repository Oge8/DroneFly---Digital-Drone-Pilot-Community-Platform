# DroneFly - Digital Drone Pilot Community Platform

A blockchain-based platform for flight zones, mission logs, and pilot community rewards built on the Stacks blockchain using Clarity smart contracts.

[![Built with Stacks](https://img.shields.io/badge/Built_with-Stacks-purple.svg)](https://www.stacks.co/)
[![Smart Contract](https://img.shields.io/badge/Smart_Contract-Clarity-orange.svg)](https://clarity-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

DroneFly creates a decentralized community where drone pilots can discover and share flight zones, log detailed mission data, review locations for safety and quality, and earn DFT (DroneFly Pilot Token) rewards for their contributions to the piloting community. The platform emphasizes safety, responsible flying, and knowledge sharing among drone enthusiasts.

## Key Features

### Flight Zone Discovery & Sharing
- **Comprehensive Zone Database**: Detailed location data with coordinates, altitude limits, and terrain types
- **Zone Classification**: Open, restricted, recreational, and commercial flight area categorization
- **Safety Information**: Restriction details and regulatory compliance data
- **Community Discovery**: Pilot-driven zone identification and sharing system
- **Terrain Mapping**: Urban, rural, coastal, and mountain environment tracking

### Detailed Flight Mission Logging
- **Mission Documentation**: Flight duration, altitude tracking, and weather condition recording
- **Mission Type Classification**: Recreation, photography, survey, and practice flight categories
- **Safety Compliance**: Altitude limit validation against zone restrictions
- **Success Tracking**: Mission outcome recording with performance analytics
- **Personal Flight Journal**: Detailed notes and observations for each mission

### Community Review & Safety System
- **Zone Safety Ratings**: Community-driven safety assessments with detailed feedback
- **Quality Reviews**: 1-10 rating system for zone characteristics and flying conditions
- **Safety Classification**: Excellent, good, fair, and risky safety level categorization
- **Useful Vote System**: Community validation for helpful reviews and information
- **Experience Sharing**: Detailed flight experiences for community learning

### Pilot Progression & Recognition
- **Flight Hour Tracking**: Cumulative flight time and experience measurement
- **Skill Level Development**: Progressive pilot level system based on flight experience
- **Drone Type Specialization**: Racing, photography, mapping, freestyle, and commercial focus areas
- **Achievement Milestones**: Recognition for consistent flying and zone discovery contributions

## Token Economy (DFT - DroneFly Pilot Token)

### Token Details
- **Name**: DroneFly Pilot Token
- **Symbol**: DFT
- **Decimals**: 6
- **Total Supply**: 35,000 DFT
- **Blockchain**: Stacks

### Reward Structure
![DroneFly Reward Structure](images/dronefly-reward-structure.png)

## Smart Contract Architecture

### Core Data Structures

#### Pilot Profile
![Pilot Profile Structure](images/pilot-profile-structure.png)

#### Flight Zone
![Flight Zone Structure](images/flight-zone-structure.png)

#### Flight Log
![Flight Log Structure](images/flight-log-structure.png)

#### Zone Review System
![Zone Review Structure](images/zone-review-structure.png)

### Drone Type Categories

The platform supports various drone applications and specializations:

- **Racing**: High-speed competitive flying with agility focus
- **Photography**: Aerial imaging and cinematography applications
- **Mapping**: Surveying, inspection, and data collection missions
- **Freestyle**: Creative flying and aerobatic maneuvers
- **Commercial**: Professional services and business applications

### Flight Zone Classifications

Comprehensive zone categorization for safe and legal flying:

| Zone Type | Description | Typical Use Cases |
|-----------|-------------|-------------------|
| Open | Unrestricted airspace | General flying, practice, recreation |
| Restricted | Limited access areas | Controlled airspace, special permissions |
| Recreational | Designated leisure zones | Hobbyist flying, community events |
| Commercial | Business operation areas | Professional services, inspections |

## Getting Started

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks smart contract development tool
- [Stacks Wallet](https://www.hiro.so/wallet) - For blockchain interactions
- Understanding of drone regulations and safety practices
- Knowledge of Clarity smart contracts

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/dronefly-platform.git
cd dronefly-platform
```

2. **Install Clarinet**
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.8.0/clarinet-linux-x64.tar.gz | tar xz
mv clarinet /usr/local/bin/
```

3. **Initialize project**
```bash
clarinet new dronefly-project
cd dronefly-project
# Copy contract to contracts/dronefly.clar
```

### Deployment

1. **Test the contract**
```bash
clarinet test
```

2. **Deploy to devnet**
```bash
clarinet integrate
```

3. **Deploy to testnet/mainnet**
```bash
clarinet deployment apply -p testnet
```

## Usage Examples

### Add Flight Zone
![Add Flight Zone Function](images/add-flight-zone-function.png)

### Log Flight Mission
![Log Flight Function](images/log-flight-function.png)

### Write Zone Review
![Write Review Function](images/write-zone-review-function.png)

### Vote Review Useful
![Vote Useful Function](images/vote-useful-function.png)

### Update Drone Type
![Update Drone Type Function](images/update-drone-type-function.png)

### Claim Achievement Milestone
![Claim Milestone Function](images/claim-milestone-function.png)

## Core Functions

### Zone Management
- `add-flight-zone(...)` - Share new flight locations with detailed information
- `get-flight-zone(zone-id)` - Retrieve zone details and community ratings
- `write-review(...)` - Submit safety and quality feedback for zones
- `vote-useful(...)` - Appreciate helpful community reviews and information

### Flight Tracking
- `log-flight(...)` - Record mission details with safety compliance validation
- `get-flight-log(flight-id)` - View individual flight mission data
- `update-drone-type(type)` - Update pilot specialization and focus area

### Community Features
- `claim-milestone(milestone)` - Unlock achievement rewards for dedication
- `update-username(username)` - Update pilot profile information
- `get-pilot-profile(pilot)` - View pilot statistics and experience levels

### Token Operations
- `get-balance(user)` - Check DFT token balance
- `get-name()`, `get-symbol()`, `get-decimals()` - Token metadata

## Safety & Compliance Features

### Regulatory Compliance
- **Altitude Limit Enforcement**: Automatic validation against zone restrictions
- **Zone Restriction Information**: Clear documentation of flying limitations
- **Safety Rating System**: Community-driven safety assessment for zones
- **Weather Condition Tracking**: Environmental factor documentation for flight planning

### Risk Management
- **Mission Success Tracking**: Performance monitoring for safety improvement
- **Community Safety Feedback**: Pilot experience sharing for risk awareness
- **Terrain Classification**: Environmental hazard identification and preparation
- **Regulatory Information**: Zone-specific compliance requirements and restrictions

### Educational Support
- **Experience Documentation**: Detailed flight logging for skill development
- **Community Knowledge Sharing**: Review system for pilot education and improvement
- **Safety Best Practices**: Community-driven safety information and recommendations
- **Progressive Skill Development**: Level-based recognition encouraging responsible advancement

## Pilot Progression System

### Experience Development
- **Flight Hours**: Cumulative flight time tracking for experience measurement
- **Mission Count**: Total flights logged across all zones and conditions
- **Success Rate**: Mission completion statistics for skill assessment
- **Level Progression**: 1-5 pilot levels based on experience and flight duration

### Achievement Milestones
![Achievement Milestones](images/achievement-milestones-dronefly.png)

### Community Recognition
- **Zone Discovery**: Recognition for finding and sharing new flight locations
- **Safety Contribution**: Appreciation for helpful reviews and safety information
- **Experience Sharing**: Community validation through useful vote system
- **Skill Development**: Progressive recognition for consistent flying and improvement

## Access Controls & Requirements

### Zone Sharing
- Location coordinates and altitude limit specification required
- Zone type classification for appropriate usage guidance
- Terrain and restriction information for safety awareness

### Flight Logging
- Altitude compliance validation against zone restrictions
- Mission duration and success outcome recording
- Weather condition documentation for safety analysis

### Review System
- One review per zone per pilot to ensure diverse perspectives
- Safety rating classification for community guidance
- Community useful voting for review validation

## Security Features

### Safety Validation
- Altitude limit enforcement preventing unsafe flight logging
- Zone restriction compliance for regulatory adherence
- Weather condition documentation for risk assessment
- Mission success tracking for safety pattern analysis

### Input Validation
- Coordinate format validation for accurate location data
- Altitude range checking within realistic and safe parameters
- String length limits appropriate for flight terminology and descriptions
- Mission duration validation for realistic flight logging

### Access Control
- Self-voting prevention for useful review voting
- Zone review restrictions to prevent spam and ensure quality
- Personal flight logging validation for authentic experience tracking
- Profile updates restricted to account owners

### Error Handling
![DroneFly Error Codes](images/dronefly-error-codes.png)

## Drone Community Features

### Knowledge Sharing
- **Flight Experience Documentation**: Detailed mission notes for community learning
- **Zone Characteristics**: Terrain, weather, and safety information sharing
- **Safety Feedback**: Community-driven risk assessment and mitigation advice
- **Technical Discussion**: Drone type specialization and application knowledge

### Community Safety Culture
- **Responsible Flying**: Regulatory compliance and safety-first approach
- **Risk Awareness**: Community sharing of challenging conditions and hazards
- **Skill Development**: Progressive learning through experience documentation
- **Regulatory Education**: Zone restriction and compliance information sharing

### Environmental Awareness
- **Terrain Considerations**: Mountain, coastal, urban, and rural flying characteristics
- **Weather Impact**: Condition-specific flying advice and safety considerations
- **Wildlife Protection**: Responsible flying practices in natural environments
- **Noise Considerations**: Community awareness of drone impact in populated areas

## Development Roadmap

### Phase 1: Core Pilot Platform
- Smart contract deployment with comprehensive zone and flight tracking
- Community review system with safety-focused feedback mechanisms
- Pilot progression system encouraging responsible flying practices
- Token reward distribution for community participation and safety contribution

### Phase 2: Enhanced Safety Features
- Weather integration with real-time condition updates and alerts
- Regulatory compliance tools with automated restriction checking
- Advanced flight planning tools with route optimization and safety analysis
- Mobile application for real-time flight logging and zone discovery

### Phase 3: Professional Integration
- Commercial pilot certification and advanced training modules
- Integration with drone service providers and professional operations
- Advanced analytics for flight performance and safety improvement
- Partnership with regulatory bodies for compliance and education

### Phase 4: Technology Innovation
- Integration with drone telemetry systems for automated flight logging
- AI-powered flight planning and safety recommendation systems
- Virtual reality training environments for pilot skill development
- Global flight zone database with international regulatory compliance

## Safety & Responsibility

### Regulatory Compliance
- Emphasis on following local and national drone regulations
- Zone restriction awareness and compliance validation
- Altitude limit enforcement for safe and legal flying
- Community education about regulatory requirements and changes

### Environmental Responsibility
- Respectful flying practices in natural environments
- Wildlife protection awareness and seasonal flying considerations
- Noise reduction consciousness in populated areas
- Leave-no-trace principles for outdoor flying locations

### Community Standards
- Safety-first approach to all flying activities and community interactions
- Respectful sharing of flight zones and community resources
- Constructive feedback focused on safety improvement and learning
- Support for new pilots learning responsible flying practices

## Testing

```bash
# Run comprehensive tests
clarinet test

# Test specific drone modules
clarinet test tests/flight_zone_test.ts
clarinet test tests/mission_logging_test.ts
clarinet test tests/safety_review_test.ts
clarinet test tests/pilot_progression_test.ts

# Validate contract
clarinet check
```

## API Reference

### Read-Only Functions
- `get-pilot-profile(pilot)` - Pilot statistics and experience levels
- `get-flight-zone(zone-id)` - Zone details and community safety ratings
- `get-flight-log(flight-id)` - Individual mission data and performance
- `get-zone-review(zone-id, reviewer)` - Review content and safety assessments
- `get-milestone(pilot, milestone)` - Achievement status and completion dates

### Write Functions
- Zone discovery and sharing functions
- Flight mission logging and tracking functions
- Community review and safety feedback functions
- Profile and specialization management functions
- Achievement milestone claiming functions

## Contributing

We welcome contributions from drone pilots, safety experts, aviation professionals, and developers!

### Development Guidelines
1. Fork the repository and create feature branches
2. Write comprehensive tests for aviation safety scenarios
3. Follow drone industry safety standards and terminology
4. Update documentation with safety-focused context and examples
5. Submit pull requests with detailed aviation use case descriptions

### Contribution Areas
- Aviation safety smart contract enhancements
- Mobile flight logging and zone discovery applications
- Weather integration and safety alert systems
- Regulatory compliance tools and educational features
- Community feedback and safety review system improvements

## Community Standards

### Safety-First Culture
- Prioritize safety in all community interactions and flight activities
- Share accurate and helpful information about flight zones and conditions
- Promote responsible flying practices and regulatory compliance
- Support new pilots in learning safe and legal drone operation

### Environmental Stewardship
- Respect natural environments and wildlife during flight operations
- Practice noise-conscious flying in populated areas
- Follow seasonal and environmental restrictions for protected areas
- Promote sustainable and responsible drone usage in the community

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Community

- **Documentation**: [docs.dronefly.io](https://docs.dronefly.io)
- **Discord**: [Join our pilot community](https://discord.gg/dronefly)
- **Twitter**: [@DroneFlyPlatform](https://twitter.com/droneflyplatform)
- **Email**: support@dronefly.io

## Acknowledgments

- Built on Stacks blockchain infrastructure
- Powered by Clarity smart contract language
- Inspired by the global drone pilot community
- Dedicated to safe and responsible drone operation
- Community-driven development with pilot safety focus

---

**Flying responsibly, sharing knowledge, building community**
