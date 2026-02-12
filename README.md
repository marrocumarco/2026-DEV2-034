# Berlin Clock Kata

[![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-_26.1-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![Xcode](https://img.shields.io/badge/Xcode-26.1-blue.svg)](https://developer.apple.com/xcode/)

## Description

Implementation of the **Berlin Clock** for **iOS** using **Swift**, **SwiftUI**, and a **Clean Architecture** approach.

## Prerequisites

- **Xcode 26.1+** → [Download](https://developer.apple.com/xcode/)
- **iOS 26.1+ SDK**

---

## Clone repository
```bash
git clone https://github.com/your-username/2026-DEV2-034
```
## Run Application

1. Open `BerlinClock.xcodeproj` in Xcode.
2. Select the `BerlinClock` scheme.
3. Choose an iOS Simulator or a connected device.
4. Press `Cmd + R` to run.

> [!NOTE]
> The first time you run the project, **Xcode** might ask to activate the **SwiftLint** plugin. Simply click **Activate** to proceed.

> [!IMPORTANT]
> To run the application on a **real device**, you must select a **Development Team** in the project settings (Signing & Capabilities).

---

## Run Tests

### Run all tests in Xcode
Press `Cmd + U` to run the test suite.

---

## Design Decisions

### 1. Test-Driven Development (TDD)
- **Red-Green-Refactor**: Strict adherence to TDD cycle.
- **Test-First**: Business logic tests written prior to implementation.
- **Coverage**: **85% code coverage** on critical paths.

### 2. Architecture
- **Clean Architecture**: Strict separation of **Core**, **Domain**, and **Presentation** layers.
- **Dependency Injection**: Initializer-based injection for loose coupling and testability.
- **Use Cases**: Encapsulate business logic and orchestrate data flow.
- **MVVM & Humble Object**: ViewModels handle state, Views are passive "Humble Objects".

### 3. Code Quality
- **SOLID**: Adherence to principles for maintainability.
- **SwiftLint**: Enforced coding standards and conventions.
- **Clean Code**: Focus on readability and single responsibility.

---

## References

- [Berlin Clock Description](https://stephane-genicot.github.io/BerlinClock.html)