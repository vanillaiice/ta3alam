# Ta3alam (تعلم)

Ta3alam is a unified learning management platform designed to simplify teaching and learning, espacially for non-traditional education systems. It provides tools for teachers to manage courses, organize classes, distribute assignments, and track student progress, all in one place.

## Features

- **Course Management**: Organize classes, modules, and lessons.
- **Assignments & Grading**: Create assignments with multiple accepted file types (including native in-app audio recording), receive student submissions, and provide feedback.
- **Role-Based Access**: Specialized views and actions for Teachers and Students.
- **Modern UI**: Clean and responsive design powered by TailwindCSS and DaisyUI.

## Getting Started

### Prerequisites
- Ruby 3.4.5+

### Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup the database:
   ```bash
   bin/rails db:setup
   ```

3. Run the application:
   ```bash
   bin/dev
   ```

The application will be available at `http://localhost:3000`.

## Running Tests

Run the test suite using:
```bash
bin/rails test
```

## Author

- [vanillaiice](https://github.com/vanillaiice)

## License

This project is licensed under the GNU Affero General Public License v3.0.