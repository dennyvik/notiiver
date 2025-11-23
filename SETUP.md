# Notiiver Setup Guide

This document provides detailed setup instructions for the Notiiver Flutter application.

## Quick Start

1. Clone the repository
2. Run `flutter pub get`
3. Configure Firebase (see below)
4. Run `flutter run`

## Firebase Configuration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Follow the setup wizard

### Step 2: Configure Android

1. In Firebase Console, add an Android app
2. Register with package name: `com.example.notiiver` (or your custom package)
3. Download `google-services.json`
4. Replace the file at: `android/app/google-services.json`
5. If you change the package name, update:
   - `android/app/build.gradle` - `applicationId`
   - `android/app/src/main/AndroidManifest.xml` - `package` attribute
   - `android/app/src/main/kotlin/com/example/notiiver/MainActivity.kt` - package name

### Step 3: Configure iOS

1. In Firebase Console, add an iOS app
2. Register with bundle ID: `com.example.notiiver` (or your custom bundle)
3. Download `GoogleService-Info.plist`
4. Replace the file at: `ios/GoogleService-Info.plist`
5. If you change the bundle ID, update it in Xcode project settings

### Step 4: Update Firebase Options

Edit `lib/firebase_options.dart` and replace placeholder values:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',      // From google-services.json
  appId: 'YOUR_ANDROID_APP_ID',        // From google-services.json
  messagingSenderId: 'YOUR_SENDER_ID', // From google-services.json
  projectId: 'your-project-id',        // Your Firebase project ID
  storageBucket: 'your-bucket.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_IOS_API_KEY',          // From GoogleService-Info.plist
  appId: 'YOUR_IOS_APP_ID',            // From GoogleService-Info.plist
  messagingSenderId: 'YOUR_SENDER_ID', // From GoogleService-Info.plist
  projectId: 'your-project-id',        // Your Firebase project ID
  storageBucket: 'your-bucket.appspot.com',
  iosBundleId: 'com.example.notiiver',
);
```

## Testing Push Notifications

### Method 1: Firebase Console

1. Run the app and copy the device token from the home screen
2. Go to Firebase Console > Cloud Messaging
3. Click "Send your first message"
4. Enter:
   - Notification title
   - Notification text
5. Click "Send test message"
6. Paste your device token
7. Click "Test"

### Method 2: Using Firebase Admin SDK

```javascript
// Node.js example
const admin = require('firebase-admin');
admin.initializeApp();

const message = {
  notification: {
    title: 'Test Notification',
    body: 'This is a test from Notiiver',
  },
  token: 'YOUR_DEVICE_TOKEN',
};

admin.messaging().send(message)
  .then((response) => {
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });
```

## Notification Behavior

### Foreground (App Active)
- Notification received by `FirebaseMessaging.onMessage`
- Displayed as local notification
- Custom handling in `NotificationService._handleForegroundMessage`

### Background (App in Background)
- Handled by system notification tray
- Tapping notification calls `FirebaseMessaging.onMessageOpenedApp`
- Custom handling in `NotificationService._handleMessageOpenedApp`

### Terminated (App Closed)
- Handled by `firebaseMessagingBackgroundHandler` (top-level function)
- Tapping notification calls `getInitialMessage()` on app start
- Custom handling in `main.dart`

## Architecture Overview

### Core Layer
- **Models**: Data structures (`notification_model.dart`)
- **Services**: Business logic (`notification_service.dart`)

### Features Layer
- **Notifications Feature**
  - **Data**: Data models specific to notifications
  - **Domain**: Business rules (currently placeholder)
  - **Presentation**: UI screens and widgets

### Entry Point
- `main.dart`: App initialization, Firebase setup, background handler

## Customization

### Change App Name
1. Update in `pubspec.yaml`: `name: your_app_name`
2. Update in `android/app/src/main/AndroidManifest.xml`: `android:label`
3. Update in `ios/Runner/Info.plist`: `CFBundleDisplayName`

### Change Package/Bundle ID
1. Android: Update in `android/app/build.gradle`, manifest, and Kotlin file
2. iOS: Update in Xcode project settings and Info.plist

### Customize Notifications
Edit `NotificationService.showLocalNotification()` to modify:
- Channel settings
- Notification icon
- Sound
- Priority
- Actions

## Troubleshooting

### Android: Notifications not received
- Check that Firebase is properly configured
- Verify google-services.json is in correct location
- Ensure `POST_NOTIFICATIONS` permission is granted (Android 13+)
- Check Firebase Console logs

### iOS: Notifications not received
- Check that push notifications capability is enabled in Xcode
- Verify GoogleService-Info.plist is in correct location
- Ensure APNs certificate is configured in Firebase Console
- Check that device has internet connection

### Token not displayed
- Check Firebase initialization in logs
- Verify Firebase configuration is correct
- Ensure internet connectivity
- Check for permission issues

## Additional Resources

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [Flutter Local Notifications Documentation](https://pub.dev/packages/flutter_local_notifications)
- [Firebase for Flutter](https://firebase.flutter.dev/)

## Support

For issues or questions, please refer to:
- Firebase documentation
- Flutter documentation
- Package documentation on pub.dev
