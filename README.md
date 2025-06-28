# 🛠️ Flutter Maintenance App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

A robust and internationalized mobile application for managing work orders, scheduling technicians, and maintaining an organized overview of maintenance tasks. Built with Flutter, leveraging modern architectural patterns and best practices.

---

## 📚 Table of Contents

- [1. Introduction](#1-introduction)
- [2. Features](#2-features)
- [3. Architecture Overview](#3-architecture-overview)
  - [3.1 Project Structure](#31-project-structure)
  - [3.2 State Management (Cubit)](#32-state-management-cubit)
  - [3.3 Dependency Injection (GetIt)](#33-dependency-injection-getit)
  - [3.4 Navigation (go_router)](#34-navigation-go_router)
  - [3.5 Local Data Persistence (Hive)](#35-local-data-persistence-hive)
  - [3.6 Internationalization (easy_localization)](#36-internationalization-easy_localization)
- [4. Setup Instructions](#4-setup-instructions)
- [5. Screen-Recorded Demo](#6-screen-recorded-demo)

---

## 1. Introduction

This application serves as a comprehensive tool for streamlined maintenance operations. It allows users to create, view, filter, and manage work orders, assign them to technicians, schedule time slots, and keep track of tasks via a weekly calendar. The app is built with a strong emphasis on clean architecture, performance, and a delightful user experience, including full multi-language support.

---

## 2. Features

- ✅ **Work Order Management**: Create, view, and remove maintenance work orders.
- 🔍 **Filtering & Searching**: Filter by status, technician, date range, and search by title/description.
- 👷 **Technician Assignment**: Assign work orders to specific technicians.
- 🗓️ **Schedule Picker**: Select available time slots for assigned work orders.
- 📅 **Weekly Calendar**: View all scheduled appointments in a weekly calendar format.
- 🌍 **Internationalization**: Full support for English and Arabic with dynamic language switching.
- 📦 **Local Persistence**: Offline access with Hive for fast local storage.
- 📱 **Responsive UI**: Scales across screen sizes using `flutter_screenutil`.

---

## 3. Architecture Overview

This application follows a **feature-first** and **clean architecture** pattern for better modularity, testability, and scalability.

### 3.1 Project Structure

- `core/`: Global constants, utilities, and services.
- `features/`: Each feature (e.g., work_order, calendar) has its own folder containing:
  - `models/`
  - `viewmodels/` (Cubits + States)
  - `views/` (Screens and UI)
  - `widgets/`: Further subdivided into `components/`, `screen_sections/`, `filter_widgets/`, etc.

### 3.2 State Management (Cubit)

- 🔄 Uses `flutter_bloc` with Cubit.
- 🧠 Business logic lives inside `*Cubit` classes.
- 📦 State classes extend `Equatable` for optimized rebuilds.
- 🔁 Data flow: **Event → Cubit → State → UI**.

### 3.3 Dependency Injection (GetIt)

- 🔧 `GetIt` is used to register global services like `HiveService`.
- 🧪 Promotes testability by decoupling service access.
- 🎯 Cubits are injected into widgets using `BlocProvider`.

### 3.4 Navigation (go_router)

- 🧭 Declarative and flexible navigation via `go_router`.
- 🛤️ Supports path params, dynamic routes, and nested navigation.

### 3.5 Local Data Persistence (Hive)

- ⚡ Fast and lightweight NoSQL local DB.
- 🧩 Custom `TypeAdapter`s for `WorkOrderModel`.
- 🛠️ `HiveService` handles DB abstraction for all local operations.

### 3.6 Internationalization (easy_localization)

- 🌐 Full i18n with `easy_localization`.
- 🗂️ Translations stored in:
  - `assets/translations/en.json`
  - `assets/translations/ar.json`
- 🕓 Locale-aware formatting using `intl`.
- 🔁 In-app language switching at runtime.

---

## 4. Setup Instructions

### 4.1 Prerequisites

- ✅ Flutter SDK (stable channel)
- ✅ VS Code / Android Studio
- ✅ Git

### 4.2 Clone the Repository

```bash
git clone <repository_url>
cd <project_directory>

### 4.3 Install Dependencies
flutter pub get


### 4.4 Generate Hive Adapters


flutter packages pub run build_runner build --delete-conflicting-outputs
🔁 Re-run this whenever you change Hive models.

### 4.5 Run the Application
flutter run


## 5. Screen-Recorded Demo

📺 Watch Demo Video

https://github.com/user-attachments/assets/52ec9925-99f5-46e6-b2fd-60d04db50fc7

