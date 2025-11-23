# Notiiver

A lightweight Flutter-based push notification receiver with Firebase Messaging support. Handles foreground, background, and terminated-state messages with local notifications. Built with clean architecture and scalable structure.

## Features

- 🔔 **Push Notifications** - Firebase Cloud Messaging integration
- 📱 **Foreground Notifications** - Display notifications when app is active
- 🔄 **Background Handler** - Process notifications in background
- 💤 **Terminated State** - Handle notifications when app is closed
- 🏗️ **Clean Architecture** - Organized folder structure (core/, features/)
- 📦 **Local Notifications** - Flutter local notifications for foreground display
- 🎨 **Material Design 3** - Modern UI with device token display

## Project Structure

```
lib/
├── core/
│   ├── models/
│   │   └── notification_model.dart
│   └── services/
│       └── notification_service.dart
├── features/
│   └── notifications/
│       ├── data/
│       │   └── models/
│       ├── domain/
│       └── presentation/
│           ├── screens/
│           │   └── home_screen.dart
│           └── widgets/
├── firebase_options.dart
└── main.dart
```

## Setup Instructions

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase project created at [Firebase Console](https://console.firebase.google.com/)
- Android Studio / Xcode for platform-specific builds

### Firebase Configuration

1. **Create a Firebase project** at [Firebase Console](https://console.firebase.google.com/)

2. **For Android:**
   - Add an Android app to your Firebase project
   - Download `google-services.json`
   - Replace the placeholder file at `android/app/google-services.json`
   - Update package name in `android/app/build.gradle` if needed

3. **For iOS:**
   - Add an iOS app to your Firebase project
   - Download `GoogleService-Info.plist`
   - Replace the placeholder file at `ios/GoogleService-Info.plist`
   - Update bundle identifier if needed

4. **Update Firebase Options:**
   - Replace placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration

### Installation

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Usage

The app will automatically:
- Request notification permissions on startup
- Register device with Firebase Cloud Messaging
- Display the FCM device token on the home screen
- Handle notifications in foreground, background, and terminated states

### Sending Test Notifications

1. Get the device token from the home screen
2. Go to Firebase Console > Cloud Messaging
3. Click "Send your first message"
4. Enter notification title and body
5. Send to your device token

## Dependencies

- `firebase_core` - Firebase initialization
- `firebase_messaging` - Push notifications
- `flutter_local_notifications` - Local notification display

## Platform Support

- ✅ Android (API 21+)
- ✅ iOS (13.0+)

## Notes

- API keys in placeholder files should be replaced with your actual Firebase configuration
- For production, ensure proper security rules and API key restrictions are set in Firebase Console
- Background message handler must be a top-level function (not inside a class)

## License

See LICENSE file for details.
