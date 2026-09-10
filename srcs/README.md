*This project has been created as part of the 42 curriculum by *aelkadir**

# Inception

## Description
This project is a system administration exercise that introduces Docker and Docker Compose. The goal is to broaden knowledge of system administration by virtualizing several Docker images, creating them in a new personal virtual machine. 

The infrastructure consists of three separate containers functioning together on a dedicated Docker network:
- **NGINX**: The web server acting as a reverse proxy with TLS/SSL encryption.
- **WordPress + PHP-FPM**: The application layer for website management.
- **MariaDB**: The database layer for data persistence.

## Instructions
Please refer to the following documentation files for detailed instructions based on your role:

- **[USER_DOC.md](./USER_DOC.md)**: For end-users and administrators (Starting the service, accessing the website, managing credentials, and basic usage).
- **[DEV_DOC.md](./DEV_DOC.md)**: For developers and evaluators (Prerequisites, host setup, Makefile rules, and data persistence).

**Quick Start:**
Ensure your `.env` file is configured inside the `srcs/` directory, then run the following command at the root of the repository to build and start the infrastructure:
```bash
make up