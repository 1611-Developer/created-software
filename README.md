# Created.Software

Created.Software is a portfolio platform designed for developers to create, share, and showcase their projects with ease. It aims to help developers professionally present their work, enabling seamless project submission, custom profiles, friendly URLs, and social discovery features.

## Features

- Secure user registration and authentication with Devise
- Customizable user profiles (name, bio, avatar)
- Project management (create, read, update, delete) including repository and demo links
- Privacy controls for public or private projects
- Friendly URLs for profiles and projects (e.g., created.software/by/alexander/project/stocktracker)
- Public project gallery & Discover page with search and filtering
- Admin dashboard for content moderation and reporting
- Responsive UI built with Tailwind CSS
- Frontend interactivity powered by vanilla JavaScript, Turbo, and Stimulus

## Technology Stack

- Ruby on Rails 8 (MVC architecture)
- PostgreSQL (database)
- Tailwind CSS (UI styling)
- Devise (authentication)
- JavaScript, Turbo, Stimulus (frontend behavior)
- Render.com (deployment)
- GitHub (version control)

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Node.js and Yarn/NPM (for managing JS dependencies)

### Installation

1. Clone the repository:
git clone https://github.com/your-username/created.software.git

2. Install dependencies:
bundle install
yarn install

3. Set up the database:
rails db:create db:migrate

4. Run the server:
rails server

### Configuration

- Configure environment variables as per `.env.example` for database credentials, email service, etc.

## Testing

Run the test suite with:

rails test

## Deployment

The app is deployed on Render.com. For local deployment, ensure environment-specific credentials are set, and assets are precompiled.

## Contributing

Contributions are welcome! Please open issues or pull requests as needed.

## License

MIT Licence

## Contact

Zander @ created.software
