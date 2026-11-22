<div align="center">

# 🍕 Hot Flavour — Food Delivery App

A Flutter food delivery application with category browsing, food search, wallet payments, order tracking, profile photos, and an admin dashboard.

**Flutter · Dart · Provider · Firebase · Supabase Storage · Stripe**

</div>

---

## 📱 App Screenshots

*Screenshots are captured from the running Android application.*

### Welcome & Authentication

| Welcome | Sign Up | Login |
|:---:|:---:|:---:|
| <img src="screenshots/01_Welcome.png" width="210"> | <img src="screenshots/02_Signup.png" width="210"> | <img src="screenshots/03_Login.png" width="210"> |

### Browse Food

| Pizza | Burger | Mexican |
|:---:|:---:|:---:|
| <img src="screenshots/04_Home_Pizza.png" width="210"> | <img src="screenshots/05_Home_Burger.png" width="210"> | <img src="screenshots/06_Home_Mexican.png" width="210"> |

### Product Details & Orders

| Product Details | Add Address | Pending Order |
|:---:|:---:|:---:|
| <img src="screenshots/11_Food_Detail_Tikka_Pizza.png" width="210"> | <img src="screenshots/12_Add_Address.png" width="210"> | <img src="screenshots/13_Pending_Order.png" width="210"> |

### Wallet & Payments

| Wallet | Add Money | Stripe Checkout |
|:---:|:---:|:---:|
| <img src="screenshots/07_Wallet.png" width="210"> | <img src="screenshots/08_Add_Amount.png" width="210"> | <img src="screenshots/09_Stripe_Checkout.png" width="210"> |

### Profile

| Default Avatar | Profile Photo Uploaded |
|:---:|:---:|
| <img src="screenshots/18_Profile_Default_Avatar.png" width="210"> | <img src="screenshots/19_Profile_Photo_Uploaded.png" width="210"> |

### Admin Dashboard

| Admin Dashboard | Manage Users | All Orders |
|:---:|:---:|:---:|
| <img src="screenshots/15_Admin_Home.png" width="210"> | <img src="screenshots/16_Admin_Manage_Users.png" width="210"> | <img src="screenshots/17_Admin_All_Orders.png" width="210"> |

---

## ✨ Features

### 🔐 Authentication
- Sign up and log in with Firebase Authentication.
- Password reset flow and logout.

### 🍔 Food Catalog
- Browse food categories: Pizza, Burger, Chinese, and Mexican.
- Search food items by name.
- View product descriptions and prices.
- Select item quantities before ordering.

### 📦 Ordering
- Add a delivery address when placing an order.
- Place orders with Firestore-backed order records.
- View pending orders and cancel an order with a wallet refund.
- Admin can view and update order delivery status.

### 💳 Wallet & Payments
- View wallet balance and transaction history.
- Add money using a Stripe payment sheet.
- Pay for orders using the app's wallet balance.
- Record wallet top-ups and order refunds in Firestore.

### 👤 Profile
- View account information and log out.
- Pick a profile photo from the gallery.
- Upload the image to Supabase Storage and save its public URL in Firestore.
- Show the uploaded image in the profile and admin's user list; otherwise display a default person icon.

### 🛠️ Admin
- Admin sign-in screen and dashboard.
- Manage users and view their profile pictures.
- View orders and mark them as delivered.

---

## 🏗️ Project Structure

Feature-based Flutter structure with a shared `providers/` directory:

```text
lib/
├── core/
│   ├── config/
│   ├── services/
│   └── theme/
├── features/
│   ├── admin/screens/
│   ├── auth/
│   │   ├── data/services/
│   │   └── screens/
│   ├── catalog/
│   │   ├── data/models/
│   │   ├── data/sources/
│   │   └── screens/
│   ├── navigation/screens/
│   ├── orders/screens/
│   ├── profile/screens/
│   └── wallet/screens/
├── providers/
├── firebase_options.dart
└── main.dart
```

## 🧠 State Management

Uses **Provider (`ChangeNotifier`)** for UI state such as catalog search, selected category, quantity and total price, navigation, authentication-form visibility, wallet state, order actions, profile photo upload, and admin lists.

| Provider | Responsibility |
|---|---|
| `CatalogProvider` | Search and selected food category |
| `ProductDetailProvider` | Quantity, total price, checkout details |
| `FoodDeliveryProvider` | Selected navigation tab |
| `AuthFormProvider` | Authentication form UI state |
| `WalletProvider` | Wallet balance, transactions, payment progress |
| `OrderActionProvider` | Orders and cancellation state |
| `ProfileProvider` | User profile data and image upload |
| `AdminOrdersProvider` | Admin orders data |
| `ManageUsersProvider` | Admin user list |

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| Flutter & Dart | Cross-platform mobile UI |
| Provider | UI state management |
| Firebase Authentication | User login and registration |
| Cloud Firestore | Users, orders, wallet and transaction data |
| Supabase Storage | Profile image uploads |
| Image Picker | Choose a profile image from the gallery |
| Stripe (`flutter_stripe`) | Wallet top-ups and payment sheet |
| SharedPreferences | Locally cached user information |
| `http` | Payment API requests |
| `intl` | Formatting transaction dates |

---

## 🚀 Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/AliZaidiSyed/fooddeliveryapp.git
   cd fooddeliveryapp
   ```

2. Install Flutter dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase Authentication and Firestore using your own Firebase project.
4. Set up Supabase Storage and its access policies for profile image uploads.
5. Configure Stripe test keys and a **secure backend** for creating PaymentIntents (never embed a Stripe secret key in the Flutter app).
6. Run the app:

   ```bash
   flutter run
   ```

> **Security note:** Before publishing the repository, remove any real Stripe secret keys and other sensitive credentials from source control. Rotate credentials already committed. Ensure that Firestore and Supabase Storage rules restrict unauthorized access. Screenshots should be reviewed for personal details and payment data before making them public.

---

## 📌 Project Notes

This project demonstrates a Flutter food ordering flow with a customer-facing app and admin management screens. Payment functionality requires valid Stripe configuration. This README describes the features present in the uploaded `lib` source and accompanying app recordings.

---

<div align="center">

Made with ❤️ using Flutter.

</div>
