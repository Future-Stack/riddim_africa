# Artist Home Screen — Clean Architecture Guide

This document explains the step-by-step flow and implementation details of the **Artist Home Screen** we just built. It serves as a practical example to help you understand **Feature-First Clean Architecture** so you can implement other screens in this app.

---

## 1. The Core Idea of Clean Architecture

Clean Architecture separates your code into three distinct layers to ensure your UI (Presentation) doesn't care about where data comes from (Data), and your business rules (Domain) remain independent of both. 

The flow of data always looks like this:
**Data Layer** ➔ **Domain Layer** ➔ **Presentation Layer**

When a user opens a screen, the flow of execution goes backward:
**Screen** (UI) calls ➔ **Controller** calls ➔ **UseCase** calls ➔ **Repository** calls ➔ **DataSource** (API).

---

## 2. Step-by-Step Implementation of `artist_home`

Here is exactly how the `artist_home` feature is structured and how you should approach building your next feature:

### Step 1: The Domain Layer (The "What")
*Folder: `domain/`*

Before writing any UI or API calls, you must define **what** data your feature needs. The Domain layer is the heart of your feature. It depends on absolutely nothing else.

1. **Entities (`domain/entities/`)**: 
   - We created `ArtistDashboardStatsEntity` and `ArtistRecentOrderEntity`. 
   - These are pure Dart classes. They represent the data exactly as the UI needs it. No JSON parsing happens here.
2. **Repository Interfaces (`domain/repositories/`)**: 
   - We created `ArtistHomeRepository`. 
   - This is an `abstract class` (an interface). It defines the *contract* (e.g., `getDashboardStats()`). It says "I need this data," but it doesn't care *how* it gets fetched.
3. **Use Cases (`domain/usecases/`)**: 
   - We created `GetArtistDashboardStatsUseCase` and `GetArtistRecentOrdersUseCase`.
   - A Use Case represents a single action a user can take. The Controller calls the UseCase, and the UseCase calls the Repository.

### Step 2: The Data Layer (The "How")
*Folder: `data/`*

Now we define **how** we get the data. This layer talks to APIs, databases, and handles JSON.

1. **Models (`data/models/`)**: 
   - We created `ArtistDashboardStatsModel` and `ArtistRecentOrderModel`.
   - These classes *extend* our Domain Entities. Their only job is to provide `fromJson` and `toJson` methods to convert raw API data into the pure Objects our Domain layer expects.
2. **Data Sources (`data/datasources/`)**: 
   - We created `ArtistHomeRemoteDataSource`. 
   - This is where the actual HTTP calls (using Dio/NetworkCaller) happen. For now, we mocked the data with a `Future.delayed` to mimic a real API.
3. **Repository Implementations (`data/repositories/`)**: 
   - We created `ArtistHomeRepositoryImpl`.
   - This class implements the `ArtistHomeRepository` interface from the Domain layer. It acts as the bridge: it calls the `RemoteDataSource`, gets the `Model`, and passes it back to the Domain layer as an `Entity`.

### Step 3: The Presentation Layer (The UI)
*Folder: `presentation/`*

This is what the user sees and interacts with.

1. **Controllers (`presentation/controllers/`)**: 
   - We created `ArtistHomeController` (extends `GetxController`).
   - The Controller holds the reactive state (using `.obs`). It calls our UseCases in `onInit()` to fetch data, updates its internal `stats` and `recentOrders` variables, and flips `isLoading` to false. 
   - **Rule:** Controllers *never* make API calls directly. They only talk to UseCases.
2. **Widgets (`presentation/widgets/`)**: 
   - We broke the complex UI down into smaller, reusable pieces: `ArtistHomeAppBar`, `RevenueCard`, `StatsRow`, `RecentOrderCard`, and `VerificationBanner`. 
   - **Rule:** Keep widgets "dumb". Pass data into them via constructors. They shouldn't contain heavy logic.
3. **Screens (`presentation/screens/`)**: 
   - We created `ArtistHomeScreen` (extends `GetView<ArtistHomeController>`).
   - This is the main page. It uses `Obx(() { ... })` to listen to the Controller. When the Controller's data changes, the UI automatically rebuilds to show the widgets.

### Step 4: Tying it together (Bindings & Routing)
*Folder: `bindings/`*

How does the Controller know which UseCase to use, and how does the UseCase know which Repository to use? Dependency Injection.

1. **Bindings (`bindings/artist_home_binding.dart`)**:
   - We used `Get.lazyPut()` to register our classes in memory.
   - We inject them in order of dependency (bottom to top): 
     `DataSource` ➔ `RepositoryImpl` ➔ `UseCase` ➔ `Controller`.
2. **Routing (`lib/routes/app_routes.dart`)**:
   - We attach `ArtistHomeBinding()` to the route so that when the user navigates to the Artist Home, GetX automatically creates the Controller and all its dependencies, and destroys them when the user leaves.

---

## Summary Checklist for your next screen:

1. [ ] Create the folder skeleton (`data`, `domain`, `presentation`, `bindings`).
2. [ ] Write the **Entities** (What data do you need?).
3. [ ] Write the abstract **Repository** in `domain/`.
4. [ ] Write the **UseCases**.
5. [ ] Write the **Models** (JSON parsing) in `data/`.
6. [ ] Write the **RemoteDataSource** (API calls).
7. [ ] Write the **RepositoryImpl** in `data/`.
8. [ ] Write the **Controller** to manage state and call UseCases.
9. [ ] Build the **Widgets** and **Screen**.
10. [ ] Wire it all up in a **Binding** file.
