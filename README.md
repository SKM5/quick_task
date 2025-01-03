Cross Platform Application Development Quick Task Assignment

# QuickTask

QuickTask is a Flutter-based task management app designed to help users organize and track their daily tasks efficiently.

## Features
- **User Authentication:** Secure signup and login powered by Back4App.
- **Task Management:**
    - Add new tasks.
    - View all tasks in an organized list.
    - Delete tasks effortlessly.
    - Toggle task status (completed/pending).
- **Optional Enhancements:**
    - UI improvements for a polished user experience.
    - Comprehensive error handling for a seamless app experience.

## Technologies Used
- **Frontend:** Built with Flutter, offering a beautiful, responsive, and cross-platform UI.
- **Backend:** Powered by Back4App for data storage and user authentication.

## Project Structure
    quick_task/  
    ├── android/  
    ├── ios/  
    ├── lib/  
    │   ├── models/       # Data models for tasks and users  
    │   ├── services/     # Back4App integration and database support  
    │   ├── screens/      # UI screens (Home, Login, etc.)  
    │   ├── main.dart     # App entry point  
    ├── test/             # Unit and widget tests  
    ├── pubspec.yaml      # Project dependencies  
    └── README.md         # Project documentation

## Installation and Setup

## Clone the repository:
   ```bash  
   git clone https://github.com/SKM5/quick_task.git  
   cd quick_task
   ```
## Install Dependencies:
    ```bash
    flutter pub get
    ```
 
## Configuration:
- Open `lib/back4app_service.dart`.
- Update the ApiConstants class with your Back4App details (className, appId, restApiKey).  

=======

