# 🛍️ Shopping App 

A production-grade **Flutter e-commerce application** built with **Clean Architecture**, **Bloc state management**, and a **RESTful supermarket API**. Features full authentication, product browsing, search, a persistent cart with EGP pricing, favourites, and a complete user profile.

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter&logoColor=white&style=for-the-badge)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12+-0175C2?logo=dart&logoColor=white&style=for-the-badge)](https://dart.dev)
[![Bloc](https://img.shields.io/badge/State-Bloc-29B6F6?style=for-the-badge)](https://bloclibrary.dev)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Code-6DB33F?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---

## 📋 Table of Contents

- [✨ Features](#-features)
- [🛠️ Tech Stack](#-tech-stack)
- [🏗️ Architecture](#️-architecture)
- [📂 Project Structure](#-project-structure)
- [🚀 Getting Started](#-getting-started)
- [🌐 API Reference](#-api-reference)
- [📱 Screens & Flow](#-screens--flow)
- [🧠 How It Works](#-how-it-works)
- [🎨 Design System](#-design-system)
- [🛣️ Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## ✨ Features

### 🎬 Onboarding & Welcome
- ✅ **3-step onboarding** with animated transitions & smooth page indicator
- ✅ **Skip** option to jump straight into the app
- ✅ **Welcome ("Hello") screen** with animated greeting & Lottie illustrations
- ✅ **Smart launcher** that routes new vs. returning users

### 🔐 Authentication
- ✅ **Full user registration** — name, email, password & avatar
- ✅ **Secure login** with JWT-based authentication
- ✅ **Password reset** flow (reset code → activate → new password)
- ✅ **Token persistence** via `SharedPreferences` + secure storage
- ✅ **Auto session restore** — logged-in users skip auth screen
- ✅ **Form validation** with friendly error messages

### 🏠 Home & Products
- ✅ **Live product feed** from the REST API
- ✅ **Infinite scroll** — paginated loading (10 per page)
- ✅ **Category chips** for quick filtering
- ✅ **Search by category** with real-time query results
- ✅ **Product cards** with image, title, price & favourite toggle
- ✅ **Skeleton shimmer loading** for a smooth UX

### 🗂️ Categories
- ✅ **Browse products by category** with dedicated routes
- ✅ **Category filtering** on the search screen
- ✅ **Dynamic product grids** per category

### 🛒 Shopping Cart
- ✅ **Add / remove / update** item quantities
- ✅ **Live cart badge** (99+ handling) on the bottom nav
- ✅ **Persistent cart** synced with the backend
- ✅ **EGP pricing** with subtotal, shipping fee & total breakdown
- ✅ **Checkout** with a success confirmation dialog
- ✅ **Empty cart state** with engaging illustration

### ❤️ Favourites
- ✅ **Add / remove favourites** with instant UI feedback
- ✅ **Favourite status** synced across Home, Product Details & list
- ✅ **Dedicated Favourites screen**

### 👤 Account
- ✅ **User profile** display (avatar, name, email)
- ✅ **Edit user data** & **upload profile image**
- ✅ **Account management** integrated with the backend

### 🧩 Robust UX Infrastructure
- ✅ **Unified state handling** (Loading / Success / Error) via `BaseState`
- ✅ **Error handling screens** — 404, network errors & under-maintenance
- ✅ **Lottie animations** for loading, searching & empty states
- ✅ **Reusable components** — buttons, cards, shimmer, error widgets
- ✅ **Portrait-only** orientation lock for a focused mobile experience

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | [Flutter](https://flutter.dev) | Cross-platform UI framework |
| **Language** | [Dart](https://dart.dev) | Programming language |
| **Architecture** | Clean Architecture | Data / Domain / Presentation separation |
| **State Management** | [Flutter Bloc](https://bloclibrary.dev) | Reactive state management (Cubit/Bloc) |
| **DI** | [get_it](https://pub.dev/packages/get_it) + [injectable](https://pub.dev/packages/injectable) | Dependency injection & service locator |
| **Networking** | [Dio](https://pub.dev/packages/dio) | HTTP client with interceptors |
| **Serialization** | json_annotation + json_serializable | Type-safe JSON models |
| **Storage** | `shared_preferences` | Local token & cache persistence |
| **Images** | `cached_network_image` | Efficient image caching |
| **Animations** | `animate_do`, `lottie`, `shimmer` | Micro-interactions & loading states |
| **UI Extras** | `carousel_slider`, `flutter_slidable`, `smooth_page_indicator` | Product gallery, swipe actions, onboarding |

### 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.10.0
  flutter_bloc: ^9.1.1
  get_it: ^9.2.1
  injectable: ^3.0.0
  json_annotation: ^4.12.0
  cached_network_image: ^3.4.1
  shared_preferences: ^2.2.0
  flutter_svg: ^2.3.0
  shimmer: ^3.0.0
  animate_do: ^5.1.0
  smooth_page_indicator: ^2.0.1
  lottie: ^3.5.1
  equatable: ^2.1.0
  pretty_dio_logger: ^1.4.0
  carousel_slider: ^5.1.2
  stream_transform: ^2.1.1
  image_picker: ^1.2.3
  bloc: ^9.2.1
  flutter_slidable: ^4.0.3
```

---

## 🏗️ Architecture

The app follows a **feature-first Clean Architecture**, separating each feature into three layers:

### 🔻 Data Layer
- **Models** — JSON-serializable DTOs (`*.g.dart`)
- **Data Sources** — API calls & remote fetching
- **Repositories implementation** — implements the domain interfaces

### 🔶 Domain Layer
- **Entities** — pure business objects
- **Repository interfaces** — contracts for data access
- **Use Cases** — single-responsibility business actions

### 🖥️ Presentation Layer
- **Screens / Views** — UI widgets
- **View Models** — Cubits / Blocs handling state & events
- **Widgets** — reusable UI components

### 🔁 Dependency Flow
```
Presentation → Domain ← Data
     ↓           ↑          ↑
   Cubits      UseCases   Repositories
     ↓           ↓          ↓
   Blocs      Interfaces  DataSources
```

Dependencies are injected via **`get_it`** using **`injectable`** (auto-generated through `build_runner`).

---

## 📂 Project Structure

```
lib/
├── main.dart                      # Entry point — init storage, token, DI, observer
├── shopping_app.dart              # MaterialApp + routing + theme
├── core/
│   ├── common/                    # Shared infrastructure
│   │   ├── base_state/            # BaseState (Loading/Success/Error) + builder
│   │   ├── favourite/             # Favourite status service
│   │   ├── model/                 # Product item DTO/entity, pagination params
│   │   ├── pagination/            # Paginated cubit + pagination state
│   │   ├── screens/               # Launcher, Error404, UnderMaintenance
│   │   └── widgets/               # Buttons, cards, shimmer, error widgets
│   ├── constants/                 # Assets, strings, spacing, tabs
│   ├── di/                        # Service locator (get_it + injectable)
│   ├── extensions/                # Context, navigation, animation helpers
│   ├── network/                   # Dio module, API constants, auth bootstrap
│   ├── routing/                   # Named routes + onGenerateRoute
│   ├── storage_helper/            # SharedPreferences wrapper + keys
│   ├── theme/                     # Colors, text styles, theme
│   └── utils/                     # AppBlocObserver, methods
└── features/
    ├── account/                   # Profile, edit user data, upload image
    ├── app_section/               # Bottom-nav shell (Home/Cart/Fav/Account)
    ├── auth/                      # Login, Register, token parser
    ├── cart/                      # Cart model, add/delete, views
    ├── category/                  # Category browsing & products
    ├── favourite/                 # Favourites data & screen
    ├── hello/                     # Welcome screen
    ├── home/                      # Home feed, categories, products
    ├── onboarding/                # Onboarding steps
    ├── product_details_screen/    # Product gallery, reviews, add-to-cart
    └── search/                    # Search products by category
```

### 📜 Key File Responsibilities

| File | Responsibility |
|------|----------------|
| `core/di/service_locator.dart` | Registers all dependencies via `@InjectableInit` |
| `core/network/dio_module.dart` | Dio instance + JWT auth interceptor + logging |
| `core/network/auth_bootstrap.dart` | Ensures a token exists before app launch |
| `core/routing/app_router.dart` | Named-route generation with Bloc wiring |
| `core/common/base_state/` | Unified Loading/Success/Error UI handling |
| `features/app_section/view/app_section_screen.dart` | Bottom nav + live cart badge |

---

## 🚀 Getting Started

### 📋 Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24+)
- [Dart SDK](https://dart.dev/get-dart) (3.12+)
- An active internet connection (the app uses a live REST API)

### 🛠️ Installation

```bash
# 1. Clone the repository
git clone https://github.com/kerols-Gamal0/shopping_app.git
cd shopping_app

# 2. Fetch dependencies
flutter pub get

# 3. Generate code (models & DI) — needed after cloning
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### 📱 Supported Platforms

Android | iOS | Web | Windows | macOS | Linux

---

## 🌐 API Reference

The app consumes a **supermarket REST API**. Base URL:

```
https://supermarket-dan1.onrender.com/api/v1
```

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/auth/signUp` | POST | Create a new account |
| `/auth/signIn` | POST | Authenticate & get JWT |
| `/auth/resetPassCode` | POST | Request a password reset code |
| `/auth/activeResetPass` | POST | Activate the reset code |
| `/auth/resetPassword` | POST | Set a new password |
| `/portfoilo/userData` | GET | Fetch user profile |
| `/portfoilo/addImage` | POST | Upload a profile image |
| `/portfoilo/editUserData` | PUT | Update user data |
| `/home/products` | GET | Fetch all products (paginated) |
| `/home/products/category/{slug}` | GET | Products by category |
| `/home/products/{id}` | GET | Single product details |
| `/home/productsFilter` | GET | Search/filter products |
| `/home/categories` | GET | Fetch all categories |
| `/user/getCart` | GET | Fetch the user's cart |
| `/user/addCart` | POST | Add item to cart |
| `/user/deleteCart` | DELETE | Remove item from cart |
| `/user/getFavorite` | GET | Fetch favourites |
| `/user/addFavorite` | POST | Add favourite |
| `/user/deleteFavorite` | DELETE | Remove favourite |

> **Auth:** All protected endpoints require a `Bearer` token, automatically attached by the Dio interceptor.

---

## 📱 Screens & Flow

### 1. 🚀 Launcher Screen
- Decides the initial route based on auth state
- Routes to **Onboarding** (new users) or **Home** (returning users)

### 2. 🎠 Onboarding Screen
- 3 animated pages with full-screen images
- **Skip** button + **Next** / **Get Started** primary button
- Smooth page indicator with swap effect

### 3. 👋 Hello Screen
- Animated welcome illustration & greeting
- Buttons to proceed into the app or to authentication

### 4. 🔐 Login / Register Screens
- Full forms with validation (name, email, password)
- **Login** → JWT issued & stored
- **Register** → creates account then signs in
- Password reset flow available

### 5. 🏠 Home Screen
- Header with greeting & search access
- **Categories** section
- **Products** grid with infinite scroll & shimmer loading
- Favourite toggles on every product card

### 6. 🗂️ Category Screen
- Lists all products within a selected category
- Bloc-driven loading with pagination

### 7. 🔍 Search Screen
- Real-time search field
- Results stream from the backend as you type

### 8. 📦 Product Details Screen
- **Image carousel** with swipe navigation
- Price, discount & rating display
- **Description** section
- **Reviews** section
- **Add to Cart** button + favourite toggle

### 9. 🛒 Cart Screen
- Item list with quantity controls & swipe-to-delete
- **Subtotal, shipping fee & total** in EGP
- **Checkout** button → success dialog
- Empty state with illustration

### 10. ❤️ Favourites Screen
- All favourited products with quick remove

### 11. 👤 Account Screen
- Profile card (avatar, name, email)
- Edit profile & upload image
- Logout

---

## 🧠 How It Works

### App Bootstrap
```dart
// main.dart — the full startup sequence
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();           // 1. Init storage
  await AuthBootstrap.ensureToken(); // 2. Ensure JWT token
  await configureDependencies();     // 3. Register DI (get_it + injectable)
  await serviceLocator<FavouriteStatusService>().initialize();
  Bloc.observer = AppBlocObserver(); // 4. Global Bloc observer
  // 5. Lock portrait + run app
  SystemChrome.setPreferredOrientations([...]).then((_) => runApp(const ShoppingApp()));
}
```

### JWT Authentication Interceptor
```dart
// dio_module.dart — attaches the token to every request
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    final token = SharedPref.getString(StorageKey.userToken) ?? ApiConstants.token;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  },
));
```

### Dependency Injection
```dart
// service_locator.dart — auto-generated container
final GetIt serviceLocator = GetIt.instance;

@InjectableInit(initializerName: 'init', asExtension: true)
Future<void> configureDependencies() async {
  serviceLocator.init();
}
```

### State Management with Bloc
```dart
// app_section_screen.dart — reactive bottom nav + live cart badge
BlocBuilder<CartCubit, CartState>(
  builder: (context, cartState) {
    int cartCount = 0;
    final cartStatus = cartState.cartStatus;
    if (cartStatus is BaseSuccessState<List<CartEntity>>) {
      cartCount = cartStatus.data.length;
    }
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: AppTabs.tabs),
      bottomNavigationBar: BottomNavigationBar(...),
    );
  },
);
```

### Infinite Scroll Pagination
```dart
// home_screen.dart — loads the next page near the scroll end
_scrollController.addListener(() {
  if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200) {
    context.read<ProductsCubit>().fetchNextPage();
  }
});
```

### Unified State Handling
```dart
// cart_screen.dart — one builder handles Loading / Error / Success
return BaseStateBuilder<List<CartEntity>>(
  state: state.cartStatus,
  onLoading: () => _buildOnLoadingWidget(),
  onError: (error) => _buildOnFailureWidget(error, context),
  onSuccess: (cartItems) => _buildOnSuccessWidget(cartItems: cartItems, context: context),
);
```

---

## 🎨 Design System

| Token | Value | Usage |
|-------|-------|-------|
| **Primary** | `#FF9900` (orange) | Buttons, accents, active states |
| **Primary Light** | `#FFB700` | Hover / secondary accent |
| **Primary Dark** | `#E67E00` | Pressed states |
| **Background** | `#FFFFFF` | App background |
| **Heading** | `#1E1B32` | Titles & headings |
| **Body** | `#3D3D5C` | Primary text |
| **Body Light** | `#7A7D8C` | Secondary text |
| **Success** | `#22C55E` | Checkout confirmation |
| **Warning** | `#FFB700` | Alerts |
| **Error** | `#FF5A5F` | Errors & validation |

### ✨ Signature Patterns
- **Material 3** with a warm orange color scheme
- **Inter font family** (9 weights) for consistent typography
- **Skeleton shimmer** loading states across lists
- **Lottie animations** for loading, search & empty states
- **Custom SVG icons** for the bottom navigation
- **Rounded cards** & soft shadows throughout
- **Responsive grids** & carousels for product display

---

## 🛣️ Roadmap

> Ideas to take this project further.

- [ ] 💳 **Online payment gateway** integration
- [ ] 🔔 **Push notifications** for orders & offers
- [ ] 📦 **Order history & tracking**
- [ ] ⭐ **Product ratings & reviews** submission
- [ ] 🌙 **Dark mode**
- [ ] 🏷️ **Coupons & discount codes**
- [ ] 🌍 **Multi-language** (AR/EN) & RTL support
- [ ] 📊 **Admin dashboard**
- [ ] 💾 **Offline-first** with local caching

---

## 🤝 Contributing

Contributions are what make the open-source community an amazing place to learn and grow. Any contributions you make are **greatly appreciated**.

1. 🍴 Fork the Project
2. 🌿 Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. 💾 Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. 🚀 Push to the Branch (`git push origin feature/AmazingFeature`)
5. 📬 Open a Pull Request

---

## 📄 License

Distributed under the **MIT License**. See `LICENSE` for more information.

---

<div align="center">

**🎓 Made with 💚 by the NTI Graduation Project — Group 4**

</div>
</content>
