# User & Administrator Documentation

This document provides instructions on how to run, access, and manage the Inception infrastructure from an administrator or end-user perspective.

## 1. Starting and Stopping the Infrastructure

The entire infrastructure is managed via a `Makefile` at the root of the repository.

- **To start the website:** 
  Run `make` or `make up`. This will build the containers and launch them in the background.
- **To stop the website:** 
  Run `make down`. This safely halts the servers without deleting your data.
- **To view running services:** 
  Run `make status` to see the health and uptime of the containers.

## 2. Accessing the Website and Admin Panel

The services are accessible strictly via HTTPS on port 443.

- **Main Website:** Navigate to `https://aelkadir.42.fr`
- **Administrator Panel:** Navigate to `https://aelkadir.42.fr/wp-admin`

*Note on Security:* Because the infrastructure uses a self-signed SSL certificate, your browser will display a "Connection is not private" warning. You must click "Advanced" and "Proceed to aelkadir.42.fr (unsafe)" to access the site.

## 3. Managing Credentials

All initial credentials for the database and WordPress administrators are securely injected using a `.env` file during the first boot. 

- **First-time setup:** Ensure your `.env` file (located in `/srcs/`) contains the necessary database passwords and WordPress user credentials before running `make`.
- **Ongoing management:** Once the site is live, administrators should manage passwords, add new authors, and moderate comments directly through the WordPress Admin Panel (`/wp-admin`).

## 4. Basic Checks

To ensure the infrastructure is functioning correctly:
1. Load the main website and verify the WordPress default theme appears.
2. Log into the `/wp-admin` panel using the secondary (non-admin) user credentials.
3. Leave a comment on a post to verify that the WordPress application can successfully write to the MariaDB database.