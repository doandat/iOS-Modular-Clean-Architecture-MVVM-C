# iOS-Modular-Clean-Architecture-MVVM-C

## Overview

TxGitAdmin is an advanced iOS application showcasing modern architectural patterns and best practices in mobile development. This project demonstrates how to organize a large-scale codebase using a modular approach, implementing Clean Architecture in conjunction with MVVM-C pattern and Combine framework, along with essential features such as dark/light mode support, localization, and module navigation through deeplinks.

## Architecture

### Modular Architecture with Swift Package Manager (SPM)

The project leverages Swift Package Manager (SPM) to create a fully modular architecture, dividing the codebase into two main categories:

1. **Core Packages**: Foundation modules providing shared functionality across the application
   - `TxDesignSystem`: Comprehensive design system including:
     - Theme management (colors, dimensions)
     - Typography system
     - UI components library
     - Dark/light mode support
   - `TxDeeplink`: Sophisticated navigation system enabling inter-module communication
   - `TxLocalization`: Runtime language switching and localization support
   - `TxNetworking`: Network layer with request/response handling and error management
   - `TxLogger`: Centralized logging system for debugging and analytics
   - `TxFoundation`: Basic utilities, extensions, and shared protocols

2. **Feature Packages**: Independent modules for specific application features
   - `TxGithubProfiles`: GitHub profile management module
   - Each feature is completely isolated and can be developed, tested, and maintained separately

This modular approach provides several key benefits:
- **Faster build times**: Parallel compilation and incremental builds
- **Better dependency management**: Explicit dependencies between modules
- **Enhanced reusability**: Modules can be reused across different applications
- **Improved maintainability**: Smaller, focused codebases are easier to understand and modify
- **Team scalability**: Multiple teams can work on different modules simultaneously
- **Feature isolation**: Bugs in one module don't affect others

### Clean Architecture + MVVM-C + Combine

Each feature module implements Clean Architecture with three distinct layers:

1. **Domain Layer**: The core business logic
   - **Entities**: Pure business models free from any framework dependencies
   - **Use Cases**: Business logic operations encapsulating specific application rules
   - **Repository Interfaces**: Abstract definitions of data operations
   - This layer has no dependencies on any external frameworks or UI

2. **Data Layer**: Data management and external interactions
   - **Repository Implementations**: Concrete implementations of domain repositories
   - **Remote Data Sources**: API clients and network request handlers
   - **Local Data Sources**: Database and file storage operations
   - **DTOs**: Data Transfer Objects for mapping between external data and domain entities
   - **Mappers**: Conversion logic between DTOs and domain entities

3. **Presentation Layer**: UI and user interaction, implementing MVVM-C pattern
   - **Models**: UI-specific data structures
   - **Views**: SwiftUI views for rendering UI components
   - **ViewModels**: Presentation logic using Combine for reactive state management
   - **Coordinators**: Navigation flow control between screens
   - **States**: UI state representations (loading, error, success)

The layers communicate through:
- Domain layer exposes interfaces that data layer implements
- Presentation layer consumes use cases from domain layer
- Combine publishers/subscribers manage async data flows between layers

This separation ensures:
- **Testability**: Each component can be tested in isolation
- **Maintainability**: Changes in one layer don't affect others
- **Scalability**: New features can be added without modifying existing code

## Navigation with Deeplinks

The application employs a sophisticated deeplink system (`TxDeeplink`) for navigation between feature modules:

- **Route Registration**: Each feature module registers its available routes with the central deeplink service
- **Path & Parameter Handling**: Support for complex URLs with dynamic parameters and query strings
- **Type-Safe Navigation**: Strongly-typed parameters ensure compile-time safety
- **Callbacks & Completion Handlers**: Support for passing data back to the calling module
- **Universal Links**: Integration with iOS universal links for external deeplinks

Benefits of this approach:
- **Decoupled modules**: Features don't need to know about each other's implementation details
- **Flexible navigation**: Support for deep linking from notifications, external apps, etc.
- **Testable navigation flows**: Routes can be tested in isolation
- **Dynamic feature loading**: Support for features that are loaded dynamically

## Key Features

### Dark/Light Mode

The application features a comprehensive theming system:

- **System Integration**: Automatic theme switching based on device settings
- **Manual Override**: User can manually select preferred theme
- **Centralized Management**: Themes are managed through `TxDesignSystem`
- **Dynamic Updates**: All UI elements update instantly when theme changes
- **Semantic Colors**: Color definitions are based on usage rather than specific values

### Localization

The application supports multiple languages with runtime switching:

- **Module-Specific Bundles**: Each module contains its own localization files
- **Runtime Switching**: Language can be changed without app restart
- **Fallback Mechanism**: Default language used for missing translations
- **String Interpolation**: Support for dynamic values in localized strings
- **Pluralization**: Proper handling of plural forms across languages

### Unit Testing

Comprehensive testing strategy across all layers:

- **Domain Layer Tests**: Testing business logic in isolation
- **Repository Tests**: Verifying data operations with mock data sources
- **ViewModel Tests**: Ensuring correct state transitions and business logic
- **UI Tests**: Validating user flows and interactions
- **Mock Objects**: Extensive use of mocks and stubs for dependencies
- **Test Coverage**: Automated tracking of code coverage


## Dependency Injection

The project uses `Resolver` for dependency injection:

- **Service Registration**: Core services are registered at app startup
- **View Model Injection**: ViewModels receive dependencies through constructors
- **Testing Support**: Easy swapping of real implementations with mocks
- **Lazy Initialization**: Services are instantiated only when needed


## Error Handling

Comprehensive error handling strategy:

- **Domain-Specific Errors**: Custom error types for each feature domain
- **User-Friendly Messages**: Error messages are localized and user-friendly
- **Graceful Degradation**: UI adapts to show partial content when possible
- **Retry Mechanisms**: Critical operations include automatic retry logic
- **Error Reporting**: Integration with logging systems for error tracking

## Technologies

- **Swift & SwiftUI**: Primary language and UI framework
- **Combine**: Reactive programming and asynchronous event handling
- **Swift Package Manager**: Module and dependency management
- **XCTest**: Unit and UI testing
- **Resolver**: Dependency injection
- **Swift Concurrency**: Task-based asynchronous operations

## Project Structure

```
TxGitAdmin/
├── TxGitAdmin/                 # Main application code
├── TxGitAdminTests/            # Application tests
├── TxGitAdminUITests/          # UI tests
├── Packages/                   # Core packages
│   ├── TxDesignSystem/         # Design system
│   ├── TxDeeplink/             # Navigation system
│   ├── TxLocalization/         # Localization
│   ├── TxNetworking/           # Networking
│   ├── TxLogger/               # Logging
│   └── TxFoundation/           # Base utilities
└── Features/                   # Feature packages
    └── TxGithubProfiles/       # GitHub profiles feature
        ├── Sources/
        │   └── TxGithubProfiles/
        │       ├── Domain/     # Business logic
        │       ├── Data/       # Data handling
        │       └── Presentation/ # UI & ViewModels
        └── Tests/              # Feature tests
```

## System Requirements

- iOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open TxGitAdmin.xcodeproj in Xcode
3. Select the desired scheme
4. Build and run

## Future Improvements

- Continuous Integration pipeline
- Analytics integration
- Enhanced accessibility support
- Performance monitoring
