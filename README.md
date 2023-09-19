# Insurance Quotation App

## Overview

The Insurance Quotation App is a mobile application built to provide insurance quotes to users. It utilizes Flutter for the frontend, Golang with GORM and Gin for the backend, and MySQL as the database.

## Features

- User registration and login.
- Requesting insurance quotes.
- Storing user information and quote history in a MySQL database.
- RESTful API endpoints for managing user requests.
- Intuitive and user-friendly mobile interface built with Flutter.

## Technologies Used

- Frontend:
  - Flutter - A cross-platform mobile application framework

- Backend:
  - Golang
  - Gin - A web framework for Golang
  - GORM - Object-relational mapping library

- Database:
  - MySQL

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter and Dart (for frontend development)
- Golang (for backend development)
- MySQL (for the database)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/insurance-quotation-app.git
   ```

2. Install frontend dependencies:

   ```bash
   cd frontend
   flutter pub get
   ```

3. Install backend dependencies:

   ```bash
   cd backend
   go get ./...
   ```

4. Set up the database:
   - Create a MySQL database and update the database configuration in `backend/config/config.go` with your database credentials.

5. Start the backend server:

   ```bash
   go run main.go
   ```

6. Start the Flutter app:

   ```bash
   cd frontend
   flutter run
   ```

7. The app should launch on your emulator or connected device.

## API Endpoints

- `POST /api/register`: Register a new user.
- `POST /api/login`: User login.
- `GET /api/quotes`: Get insurance quotes.
- `POST /api/quotes`: Request a new insurance quote.
- `GET /api/history`: Get user's quote history.

## Contributing

Contributions are welcome! If you would like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them with clear and concise commit messages.
4. Push your branch to your fork.
5. Create a pull request to the `main` branch of this repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thank you to the open-source community for the tools and libraries used in this project.

## Contact

If you have any questions or need further assistance, feel free to contact us at kishorework77@email.com
