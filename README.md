**Prerequisites**

- Ensure you have Flutter installed on your machine. If not, follow the Flutter installation guide.
- Clone the repository to your local machine.


**Installation**
1. Open a terminal and navigate to the project directory.
2. Run the following command to install dependencies including Hive databse:

    flutter pub get

Run the app on an emulator or physical device using the following command:

flutter run

**State Management**
The app uses the Bloc architecture for efficient state management.

TasksBloc: Manages the overall state of tasks in the application. TasksEvent: Represents events triggering state changes. TasksState: Represents different states of the tasks, such as loading, success, or failure.

**Error Handling**
Error handling is implemented throughout the app to ensure a seamless user experience. The LoadTaskFailure, AddTaskFailure, and UpdateTaskFailure states provide details about errors encountered during data loading, task creation, and task updates.