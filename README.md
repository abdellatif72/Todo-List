# Simple Todo List App with Flutter

A simple and clean Flutter todo app for managing your daily tasks.

## Features

- **Add tasks**: Type a task in the input field and tap the **+** button or press **Enter** to add it.
- **Mark as done**: Check the box to mark a task as completed; completed tasks are shown with a strikethrough.
- **Delete tasks**: Remove a task using the close (`x`) icon.
- **Remaining counter**: See how many tasks are still remaining.
- **Responsive layout**: Centered layout with a max width for a nicer experience on larger screens.
- **State management**: Uses the `provider` package for managing the todo list.

## Design

The UI design of this app is inspired by the
[Clean & Minimal Todo List Design on Dribbble](https://dribbble.com/shots/24425951-Clean-Minimal-Todo-List-Design?utm_source=Clipboard_Shot&utm_campaign=arknnx_&utm_content=Clean%20%26%20Minimal%20Todo%20List%20Design&utm_medium=Social_Share&utm_source=Clipboard_Shot&utm_campaign=arknnx_&utm_content=Clean%20%26%20Minimal%20Todo%20List%20Design&utm_medium=Social_Share).

## Getting Started

### Prerequisites

- **Flutter SDK** installed: see the [official Flutter documentation](https://docs.flutter.dev/get-started/install).
- An Android emulator, iOS simulator, or a physical device connected.

### Run the app

```bash
git clone Simple-Todo-List.git
cd my_todo_app_1
flutter pub get
flutter run
```

To run on a specific platform, use:

```bash
flutter run -d android    # Android device/emulator
flutter run -d ios        # iOS simulator/device
flutter run -d chrome     # Web (if enabled)
```

## Project Structure

- `lib/main.dart`: Application entry point.
- `lib/pages/todo_page.dart`: Main todo screen UI and interactions.
- `lib/models/todo.dart`: `Todo` model representing each task.
- `lib/providers/todo_provider.dart`: State management for the todo list.

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State management**: Provider
