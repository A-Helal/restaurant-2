# Firebase Setup Instructions for Restaurant App

This guide will walk you through setting up Firebase for the Restaurant Task Flutter app.

## Prerequisites

- Flutter development environment set up
- A Google account
- Android Studio or Xcode (for mobile app testing)

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `restaurant-task-app` (or your preferred name)
4. Choose whether to enable Google Analytics (recommended for production apps)
5. Select or create a Google Analytics account if enabled
6. Click "Create project"

## Step 2: Configure Firebase Authentication

1. In the Firebase Console, navigate to **Authentication** in the left sidebar
2. Click "Get started"
3. Go to the **Sign-in method** tab
4. Enable **Email/Password** authentication:
   - Click on "Email/Password"
   - Toggle "Enable" to ON
   - Toggle "Email link (passwordless sign-in)" to OFF (unless you want this feature)
   - Click "Save"

## Step 3: Set up Cloud Firestore

1. Navigate to **Firestore Database** in the left sidebar
2. Click "Create database"
3. Choose **Start in test mode** (for development)
   - Note: For production, you'll want to configure proper security rules
4. Select a location closest to your users
5. Click "Done"

### Create the Menu Items Collection

1. In Firestore, click "Start collection"
2. Collection ID: `menu_items`
3. Add sample documents with the following structure:

**Document ID:** `item_1`
```json
{
  "name": "Margherita Pizza",
  "description": "Fresh tomatoes, mozzarella, basil, and olive oil on thin crust",
  "price": 14.99,
  "category": "Main Courses",
  "imageUrl": "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400",
  "isAvailable": true
}
```

**Document ID:** `item_2`
```json
{
  "name": "Caesar Salad",
  "description": "Crisp romaine lettuce, parmesan cheese, croutons, and Caesar dressing",
  "price": 8.99,
  "category": "Salads",
  "imageUrl": "https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400",
  "isAvailable": true
}
```

**Document ID:** `item_3`
```json
{
  "name": "Grilled Salmon",
  "description": "Fresh Atlantic salmon grilled to perfection with lemon butter sauce",
  "price": 22.99,
  "category": "Main Courses",
  "imageUrl": "https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400",
  "isAvailable": true
}
```

**Document ID:** `item_4`
```json
{
  "name": "Chocolate Brownie",
  "description": "Rich chocolate brownie served warm with vanilla ice cream",
  "price": 6.99,
  "category": "Desserts",
  "imageUrl": "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400",
  "isAvailable": true
}
```

**Document ID:** `item_5`
```json
{
  "name": "Fresh Orange Juice",
  "description": "Freshly squeezed orange juice, served chilled",
  "price": 4.99,
  "category": "Beverages",
  "imageUrl": "https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=400",
  "isAvailable": true
}
```

**Document ID:** `item_6`
```json
{
  "name": "Chicken Wings",
  "description": "Crispy buffalo wings served with ranch dipping sauce",
  "price": 12.99,
  "category": "Appetizers",
  "imageUrl": "https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400",
  "isAvailable": true
}
```

Add more items as needed for different categories.

## Step 4: Configure Firestore Security Rules

Replace the default rules with these development-friendly rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read access to menu items for authenticated users
    match /menu_items/{document} {
      allow read: if request.auth != null;
      allow write: if false; // Disable writes from client for now
    }
    
    // Allow users to read/write their own user documents
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // For development only - remove in production
    match /{document=**} {
      allow read: if request.auth != null;
    }
  }
}
```

**Important:** For production, implement more restrictive security rules!

## Step 5: Add Firebase to Your Flutter App

### For Android:

1. In Firebase Console, click "Add app" and select Android
2. Enter package name: `com.example.restaurant_task` (or your actual package name from `android/app/build.gradle`)
3. Enter app nickname: "Restaurant Task Android"
4. Download the `google-services.json` file
5. Place it in `android/app/` directory
6. Firebase will show the SDK setup steps, but these are already configured in the project

### For iOS:

1. In Firebase Console, click "Add app" and select iOS
2. Enter iOS bundle ID: `com.example.restaurantTask` (from `ios/Runner/Info.plist`)
3. Enter app nickname: "Restaurant Task iOS"
4. Download the `GoogleService-Info.plist` file
5. Open `ios/Runner.xcworkspace` in Xcode
6. Right-click on "Runner" and select "Add Files to Runner"
7. Select the downloaded `GoogleService-Info.plist` file
8. Make sure "Copy items if needed" is checked
9. Click "Add"

### For Web (Optional):

1. In Firebase Console, click "Add app" and select Web
2. Enter app nickname: "Restaurant Task Web"
3. Check "Also set up Firebase Hosting" if you want to host the web app
4. Copy the Firebase configuration object
5. Create `web/firebase-config.js` and add the configuration

## Step 6: Test Firebase Connection

1. Run the app: `flutter run`
2. Try creating a test user account
3. Check if the authentication appears in Firebase Console > Authentication > Users
4. Try viewing the menu items - they should load from Firestore

## Step 7: Optional - Firebase Storage Setup

If you want to store images in Firebase Storage instead of using external URLs:

1. Go to **Storage** in Firebase Console
2. Click "Get started"
3. Choose "Start in test mode" for development
4. Select a location
5. Create folders: `menu_items/`, `user_avatars/`

## Security Considerations for Production

1. **Authentication Rules:**
   - Implement proper email verification
   - Add password complexity requirements
   - Set up rate limiting

2. **Firestore Security Rules:**
   - Restrict read/write access based on user roles
   - Validate data before writing
   - Implement field-level security

3. **Storage Rules:**
   - Restrict file uploads by size and type
   - Implement proper access controls

## Troubleshooting

### Common Issues:

1. **"No Firebase project found"**
   - Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
   - Check that the package name/bundle ID matches

2. **"Permission denied" in Firestore**
   - Check Firestore security rules
   - Ensure user is authenticated

3. **Authentication not working**
   - Verify that Email/Password authentication is enabled in Firebase Console
   - Check for proper error handling in the app

4. **Network issues**
   - Test on a real device
   - Check internet connectivity
   - Verify Firebase project is active

### Debug Commands:

```bash
# Check Firebase connection
flutter pub deps
flutter clean
flutter pub get

# For Android
flutter run --verbose

# For iOS
cd ios && pod install && cd ..
flutter run --verbose
```

## Next Steps

1. **Add more menu items** through Firebase Console
2. **Set up Firebase Analytics** for user behavior tracking
3. **Implement push notifications** using Firebase Cloud Messaging
4. **Add crash reporting** with Firebase Crashlytics
5. **Set up continuous integration** with Firebase Test Lab

## Sample Data for Testing

You can import this JSON directly into Firestore or use the Firebase CLI:

```json
{
  "menu_items": {
    "item_1": {
      "name": "Margherita Pizza",
      "description": "Fresh tomatoes, mozzarella, basil, and olive oil",
      "price": 14.99,
      "category": "Main Courses",
      "imageUrl": "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400",
      "isAvailable": true
    },
    "item_2": {
      "name": "Caesar Salad",
      "description": "Crisp romaine lettuce with parmesan and croutons",
      "price": 8.99,
      "category": "Salads",
      "imageUrl": "https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400",
      "isAvailable": true
    }
  }
}
```

## Support

If you encounter issues:
1. Check the [Firebase Documentation](https://firebase.google.com/docs)
2. Review the [FlutterFire Documentation](https://firebase.flutter.dev/)
3. Check the app's error logs and console output
4. Ensure all dependencies are up to date

---

**Note:** This setup is for development purposes. For production deployment, implement proper security rules, error handling, and monitoring. 