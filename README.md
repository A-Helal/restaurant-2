# 🍽️ Restaurant Task - Flutter Mobile App

[![CI/CD Pipeline](https://github.com/yourusername/restaurant-app/actions/workflows/flutter_ci_cd.yml/badge.svg)](https://github.com/yourusername/restaurant-app/actions/workflows/flutter_ci_cd.yml)
[![codecov](https://codecov.io/gh/yourusername/restaurant-app/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/restaurant-app)

A complete Flutter restaurant mobile application with Firebase backend, featuring user authentication, menu browsing, and shopping cart functionality. Built with clean architecture using Cubit state management and Material Design 3.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

### 🔐 Authentication System
- **Email/Password Authentication** using Firebase Auth
- **Form Validation** with proper error handling
- **Persistent Login State** across app sessions
- **Password Reset** functionality
- **User Registration** with terms acceptance
- **Loading States** and error feedback

### 🍔 Menu Display
- **Dynamic Menu Loading** from Firebase Firestore
- **Category Filtering** (Appetizers, Main Courses, Desserts, etc.)
- **Search Functionality** to find specific dishes
- **Grid Layout** with attractive food cards
- **Image Caching** with error handling
- **Pull-to-Refresh** capability
- **Offline Support** with cached data

### 🛒 Shopping Cart System
- **Add/Remove Items** with quantity controls
- **Cart State Persistence** using HydratedBloc
- **Price Calculations** with delivery fees
- **Cart Summary** with detailed breakdown
- **Free Delivery** threshold notifications
- **Clear Cart** functionality
- **Optimistic UI Updates**

### 🎨 UI/UX Design
- **Material Design 3** principles
- **Responsive Layout** for different screen sizes
- **Consistent Color Scheme** with primary/secondary colors
- **Loading Animations** and skeleton screens
- **Error States** with retry mechanisms
- **Smooth Navigation** with GoRouter
- **Custom Widgets** for reusability

## 🏗️ Architecture

This app follows **Clean Architecture** principles with:

```
lib/
├── main.dart                    # App entry point with Firebase setup
├── models/                      # Data models
│   ├── user_model.dart         # User entity
│   ├── menu_item_model.dart    # Menu item entity
│   └── cart_item_model.dart    # Cart item entity
├── cubits/                      # State management (Cubit pattern)
│   ├── auth/                   # Authentication state
│   ├── menu/                   # Menu state
│   └── cart/                   # Cart state
├── services/                    # Business logic layer
│   ├── auth_service.dart       # Firebase Auth operations
│   ├── firestore_service.dart  # Firestore operations
│   └── cart_service.dart       # Local cart storage
├── screens/                     # UI screens
│   ├── auth/                   # Login/Signup screens
│   ├── menu/                   # Menu display screens
│   └── cart/                   # Shopping cart screens
├── widgets/                     # Reusable UI components
│   ├── custom_button.dart      # Styled buttons
│   ├── custom_text_field.dart  # Form inputs
│   └── loading_widget.dart     # Loading states
└── utils/                       # Utilities and constants
    ├── constants.dart          # App constants
    ├── validators.dart         # Form validation
    ├── app_colors.dart         # Color scheme
    └── app_router.dart         # Navigation setup
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.7.2 or later)
- **Dart SDK** (3.7.2 or later)
- **Android Studio** or **VS Code** with Flutter extensions
- **Firebase CLI** (optional, for advanced setup)
- **Git** for version control

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/restaurant_task.git
   cd restaurant_task
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Follow the detailed instructions in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

4. **Run the app:**
   ```bash
   flutter run
   ```

### Firebase Configuration

This app requires Firebase for:
- **Authentication:** User login/signup
- **Firestore:** Menu items storage
- **Storage:** Image hosting (optional)

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for complete setup instructions.

## 📱 Screens Overview

### Authentication Flow
- **Login Screen:** Email/password authentication with validation
- **Signup Screen:** User registration with terms acceptance
- **Password Reset:** Email-based password recovery

### Main App Flow
- **Menu Screen:** Browse dishes with search and filter
- **Item Details:** Detailed view with quantity selection
- **Cart Screen:** Review items, adjust quantities, checkout
- **Profile Menu:** User options and logout

## 🛠️ Technologies Used

### Core Framework
- **Flutter 3.7.2+** - Cross-platform mobile development
- **Dart 3.7.2+** - Programming language

### State Management
- **flutter_bloc 8.1.3** - Cubit pattern for state management
- **hydrated_bloc 9.1.2** - State persistence
- **equatable 2.0.5** - Value equality

### Backend & Storage
- **Firebase Core 2.24.2** - Firebase initialization
- **Firebase Auth 4.15.3** - User authentication
- **Cloud Firestore 4.13.6** - NoSQL database
- **Firebase Storage 11.5.6** - File storage
- **SharedPreferences 2.2.2** - Local storage

### UI & Navigation
- **GoRouter 12.1.3** - Declarative routing
- **Cached Network Image 3.3.0** - Image caching
- **Material Design 3** - Google's design system

### Utilities
- **Email Validator 2.1.17** - Email validation
- **Intl 0.19.0** - Internationalization
- **Path Provider 2.1.1** - File system paths

### Development
- **Flutter Lints 5.0.0** - Code quality
- **Bloc Test 9.1.4** - Testing utilities
- **Mocktail 1.0.0** - Mocking framework

## 🔧 Configuration

### Environment Setup

Create your Firebase project and add configuration files:

**Android:** `android/app/google-services.json`
**iOS:** `ios/Runner/GoogleService-Info.plist`

### App Customization

Modify these files to customize the app:

- **`lib/utils/constants.dart`** - App name, colors, sizes
- **`lib/utils/app_colors.dart`** - Color scheme
- **`pubspec.yaml`** - App metadata and dependencies

## 🧪 Testing

### Run Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Specific test file
flutter test test/cubits/auth_cubit_test.dart
```

### Test Coverage
```bash
# Generate coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🔐 Security Considerations

### Development vs Production

**Development (Current Setup):**
- Firestore rules allow authenticated read access
- Test mode security rules
- Debug authentication

**For Production:**
- Implement strict Firestore security rules
- Enable email verification
- Add rate limiting
- Implement proper error logging
- Use environment variables for sensitive data

### Recommended Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /menu_items/{document} {
      allow read: if request.auth != null;
      allow write: if false; // Admin only via Firebase Console
    }
    
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
  }
}
```

## 🚀 Deployment

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Google Play)
flutter build appbundle --release
```

### iOS
```bash
# Build iOS app
flutter build ios --release

# Archive in Xcode for App Store
open ios/Runner.xcworkspace
```

### Web (Optional)
```bash
# Build web app
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch:** `git checkout -b feature/amazing-feature`
3. **Commit changes:** `git commit -m 'Add amazing feature'`
4. **Push to branch:** `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Guidelines

- Follow **Flutter best practices**
- Write **unit tests** for new features
- Use **conventional commits**
- Update **documentation** as needed
- Ensure **code passes linting:** `flutter analyze`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/yourusername/restaurant_task/issues)
- **Discussions:** [GitHub Discussions](https://github.com/yourusername/restaurant_task/discussions)
- **Documentation:** [Flutter Documentation](https://docs.flutter.dev/)

## 🎯 Future Enhancements

### Planned Features
- [ ] **Push Notifications** for order updates
- [ ] **Dark Mode** support
- [ ] **User Profiles** with preferences
- [ ] **Order History** tracking
- [ ] **Payment Integration** (Stripe/PayPal)
- [ ] **Restaurant Reviews** system
- [ ] **Real-time Order Tracking**
- [ ] **Multi-language Support**
- [ ] **Offline Mode** improvements
- [ ] **Admin Panel** for menu management

### Performance Optimizations
- [ ] **Image Optimization** with different resolutions
- [ ] **Lazy Loading** for large menus
- [ ] **Caching Strategies** improvement
- [ ] **Bundle Size** optimization
- [ ] **Animation Performance** enhancements

---

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Firebase Team** for the backend services
- **Material Design** for the design system
- **Unsplash** for placeholder images
- **Open Source Community** for the packages used

---

**Built with ❤️ using Flutter**
