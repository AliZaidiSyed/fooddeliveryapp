
<div align="center">

<img width="200" height="430" alt="01_Welcome" src="https://github.com/user-attachments/assets/778e0d6c-f25a-43ed-b17a-166d2025e7f7" />


# Food Delivery App

### A Food Delivery Application Built with Flutter

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![State Management](https://img.shields.io/badge/State_Management-Provider-purple)
![SharedPreferences](https://img.shields.io/badge/SharedPreferences-Local_Storage-607D8B)

![Firebase](https://img.shields.io/badge/Firebase-orange?logo=firebase)
![Supabase](https://img.shields.io/badge/Supabase-green?logo=supabase)

![Stripe](https://img.shields.io/badge/Payments-Stripe-blue?logo=stripe)

</div>

---

## 📱 Screenshots

The screenshots showcase the main features and user interface of Hot Flavour.
<img width="800" height="2226" alt="Hot_Flavour_Screenshots_With_Profile_Preview" src="https://github.com/user-attachments/assets/c9d16e24-3b1e-4e4e-b930-e999bcfabd2a" />


<div align="center">

<img src="screenshots/Hot_Flavour_Collage.png" width="850" alt="Hot Flavour Screenshots">

</div>

---

## 🌟 Features

### 🔐 Authentication

- User registration and login using Firebase Authentication.
- Email and password authentication.
- Password reset functionality.
- User information stored in Cloud Firestore.
- User session management.
- Logout functionality.

### 🏠 Home

- Browse food items by category.
- Available categories:
  - Pizza
  - Burger
  - Chinese
  - Mexican
- Search food items by name.
- View food images and prices.
- Navigate between categories.
- View detailed information about food items.

### 🛒 Food Ordering

- Select food items.
- View product descriptions and prices.
- Increase or decrease item quantity.
- Calculate total price based on quantity.
- Enter delivery address.
- Place food orders.
- Store order details in Cloud Firestore.
- View pending orders.
- Cancel pending orders.
- Refund cancelled order amounts to the wallet.

### 💳 Wallet & Payments

- View wallet balance.
- Add money to the wallet.
- Stripe payment integration.
- Secure payment sheet interface.
- View wallet transaction history.
- Store transaction records in Cloud Firestore.
- Wallet balance updates after successful payment.
- Refund amounts for cancelled orders.

### 📦 Order Management

- View placed orders.
- Check order information.
- Display order quantity and total price.
- View delivery address.
- Cancel pending orders.
- Display pending and delivered order statuses.

### 👤 Profile

- View user name and email.
- Select profile pictures from the gallery.
- Upload profile images to Supabase Storage.
- Save image Public URL in Cloud Firestore.
- Display uploaded profile pictures.
- Show a default person icon when no image exists.
- Logout from the application.
- Delete account functionality.

### 🛠️ Admin Panel

- Admin login.
- Admin dashboard.
- Manage customer accounts.
- View registered users.
- Display user profile pictures.
- Remove users.
- View customer orders.
- View pending orders.
- Mark orders as delivered.

---

## 🏗️ Architecture

The application follows a feature-based folder structure with Provider for state management.

The codebase is organized into independent features to improve readability, maintenance, and scalability.

```text
lib/
│
├── core/
│   ├── config/
│   │   └── constant.dart
│   │
│   ├── services/
│   │   ├── database.dart
│   │   ├── profile_image_service.dart
│   │   └── shared_pref.dart
│   │
│   └── theme/
│       ├── hot_flavour_theme.dart
│       └── widget_support.dart
│
├── features/
│   │
│   ├── admin/
│   │   └── screens/
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   └── services/
│   │   └── screens/
│   │
│   ├── catalog/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── sources/
│   │   └── screens/
│   │
│   ├── navigation/
│   │   └── screens/
│   │
│   ├── orders/
│   │   └── screens/
│   │
│   ├── profile/
│   │   └── screens/
│   │
│   └── wallet/
│       └── screens/
│
├── providers/
│   ├── admin_orders_provider.dart
│   ├── auth_form_provider.dart
│   ├── catalog_provider.dart
│   ├── food_delivery_provider.dart
│   ├── manage_users_provider.dart
│   ├── order_action_provider.dart
│   ├── product_detail_provider.dart
│   ├── profile_provider.dart
│   └── wallet_provider.dart
│
├── firebase_options.dart
└── main.dart
```

---

## 🧠 State Management

The application uses **Provider** with **ChangeNotifier** for managing UI state.

Provider separates state-related logic from UI widgets and updates screens using `notifyListeners()`.

| Provider | Responsibility |
|----------|----------------|
| `AuthFormProvider` | Manage authentication form state |
| `CatalogProvider` | Handle food search and category selection |
| `FoodDeliveryProvider` | Manage bottom navigation |
| `ProductDetailProvider` | Manage quantity, pricing and product details |
| `OrderActionProvider` | Handle order and cancellation states |
| `WalletProvider` | Manage wallet data, transactions and payment state |
| `ProfileProvider` | Manage profile data and image upload state |
| `AdminOrdersProvider` | Manage admin orders |
| `ManageUsersProvider` | Manage admin user list |

---

## 🔥 Firebase Integration

Firebase is used for authentication and cloud database operations.

### Firebase Authentication

- User registration.
- User login.
- Password recovery.
- Authentication session management.

### Cloud Firestore

- User information.
- Food order records.
- Wallet balance.
- Transaction history.
- Order status updates.
- Profile image URLs.

---

## 🖼️ Supabase Storage

Supabase Storage is used for storing user profile pictures.

### Image Upload Flow

1. User selects an image from the gallery.
2. Image is uploaded to Supabase Storage.
3. Supabase generates a Public URL.
4. The Public URL is saved in Cloud Firestore.
5. Profile and Admin screens display the uploaded image.

**Storage Bucket:** `profile-images`

If a user has not uploaded an image, a default person icon is displayed.

---

## 💰 Payment Integration

Stripe is integrated into the wallet feature.

The payment flow includes:

1. User selects an amount.
2. Stripe Payment Sheet opens.
3. User completes the payment.
4. Wallet balance is updated.
5. Transaction details are stored in Cloud Firestore.

The wallet also supports refunds when eligible orders are cancelled.

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `firebase_core` | Firebase initialization |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Cloud database |
| `supabase_flutter` | Profile image storage |
| `image_picker` | Select images from gallery |
| `image` | Image processing |
| `flutter_stripe` | Payment integration |
| `shared_preferences` | Local data storage |
| `http` | HTTP requests |
| `intl` | Date formatting |
| `random_string` | Generate random identifiers |

---

## 🎨 UI Design

The application uses a custom **Hot Flavour** theme.

- Red primary color.
- Dark red action buttons.
- Cream and peach backgrounds.
- Rounded cards and input fields.
- Category selection buttons.
- Bottom navigation bar.
- Responsive Flutter widgets.

The theme is managed through:

`lib/core/theme/hot_flavour_theme.dart`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Firebase project
- Supabase project
- Stripe account for payment testing



### 3. Install Dependencies

```bash
flutter pub get
```



### 7. Run Application

```bash
flutter run
```




## 👨‍💻 Developer

**Muhammad Ali**

Flutter Developer

GitHub: [AliZaidiSyed](https://github.com/AliZaidiSyed)

---

<div align="center">

### Made with ❤️ using Flutter

**Food Delivery App**

</div>
