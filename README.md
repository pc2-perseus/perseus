<div>
    <div align="center">
        <img src="perseus.svg" alt="PERSEUS logo" width="256" height="256" />
    </div>
    <div align="center">
        <img src="https://img.shields.io/github/v/release/pc2-perseus/perseus?color=826CC6" alt="Release badge" />
        <img src="https://img.shields.io/badge/license-MIT-green" alt="License badge" />
    </div>
    <div align="center">
        <a href="https://perseus-project.pc2.uni-paderborn.de/docs/">Documentation</a><br />
        <a href="https://perseus-project.pc2.uni-paderborn.de/preview/">Live demo</a><br />
        <a href="https://perseus-project.pc2.uni-paderborn.de/contact/">Contact</a><br />
        <a href="https://github.com/pc2-perseus/perseus-plugins">Available plugins</a>
    </div>
</div>


## What is PERSEUS?

> PERSEUS is currently in beta. Some features are still experimental and maybe don't work as expected.
> Feel free to reach out to us and share you experiences and feedback: https://perseus-project.pc2.uni-paderborn.de/contact/

PERSEUS is a compute project management software for scientific HPC centers. It allows you to
* professionalize your workflows
* deploy center-wide automation
* fully customize workflow items (states), (micro)services and reports

Here’s a first look at the software:

<img src="screens.gif" alt="PERSEUS logo" />

## What's new?

<!-- CHANGELOG START -->
Version **0.16.0** includes the following updates:


### PERSEUS

- _Added_
  - Added funding and public information fields to the Project data model for better reporting and public visibility
  - Added database indexes for group job attributes to improve query performance
  - Added an `is_active` flag to clusters to allow hiding inactive systems from resource allocation
  - Added a total job count to the Andromeda job endpoint for accurate pagination and display
  - Improved test coverage across core PERSEUS services
  - Added system status permissions for L1, L2, and L3 support roles
  - Added endpoints to fetch and add project publications directly from Andromeda
  - Implemented a responsive design for the PERSEUS frontend to improve usability on tablets and mobile devices
  - Enhanced the Person Details view with ORCID, connected identities, and dedicated panels for jobs and resource usage
  - Added new endpoints to the JobManager and Usage services for retrieving user-specific job and resource data
  - Added a native database count method to improve performance when querying large collections
  - Added a backend endpoint to securely validate and update user ORCID identifiers
  - Added backend endpoints for managing compute project members, handling email invitations, and assigning project coordinator roles
  - Introduced a templated HTML email system with configurable branding and plain-text fallbacks
  - Added support for retrieving historical system status entries and updated the existing endpoint to accept optional date ranges
- _Changed_
  - Updated the system status API to support a new "maintenance" category and improved historical data retrieval
- _Fixed_
  - Fixed datetime parsing in the SystemStatusEntry loader to correctly handle entries stored as datetime objects
  - Fixed missing Andromeda endpoints in the Swagger UI documentation
  - Fixed incorrect ordering of compute project phases so they now sort correctly by start date

### Andromeda

- _Added_
  - Redesigned the system status view to display the last 14 days of history and clearly highlight active and planned maintenance
  - Added the ability for users to update their ORCID identifier in the profile section
  - Added a comprehensive user management interface for project managers, including member invitations and role assignments
- _Changed_
  - Updated frontend dependencies and upgraded the Node.js runtime to version 24 LTS
- _Fixed_
  - Fixed several UI issues in the compute project details view, including graph axis scaling, tooltip formatting, job pagination, and priority color coding
  - Fixed the email input field on the profile page to use full width
  - Fixed the Project Manager view to operate at the top-level project scope rather than individual compute projects
  - Fixed the usage graph filters to only display resources actually used by the selected compute project

### Gateway

- _Removed_
  - Removed the unused SystemStatus endpoint from the Gateway's allowed routes
- _Fixed_
  - Fixed incorrect forwarding of list parameters in GET requests to ensure all values are passed correctly
<!-- CHANGELOG END -->

<a href="https://perseus-project.pc2.uni-paderborn.de/changelog/">Click here to view the complete changelog</a>.


## Getting Started

There are multiple ways to run PERSEUS.
You can either use our automated installer scripts or deploy it manually using Docker or Podman.

### Installer & Updater

If you prefer an automated setup that installs all dependencies and configures the environment for you, we provide installer scripts that set up **Docker or Podman**, along with **Nginx** and required configuration files.

Compared to the manual `docker-compose` approach, the installer scripts offer a **more opinionated**, out-of-the-box experience – ideal for quick testing, small-scale deployments, or first-time users.

We currently offer two variants:

* [`installer-docker.sh`](https://github.com/pc2-perseus/perseus/blob/main/installer-docker.sh) – for Docker-based setups (requires root)
* [`installer-podman.sh`](https://github.com/pc2-perseus/perseus/blob/main/installer-podman.sh) – for Podman-based setups (runs containers as a dedicated non-root user)

> The scripts support most major Linux distributions and will automatically detect your package manager.

To keep your deployment up to date, we also provide:

* [`updater-docker.sh`](https://github.com/pc2-perseus/perseus/blob/main/updater-docker.sh)
* [`updater-podman.sh`](https://github.com/pc2-perseus/perseus/blob/main/updater-podman.sh)

These update scripts stop the running containers, pull the latest images, restart the services, and clean up unused resources.

📖 Read more about the installer workflow in our
[**official documentation**](https://perseus-project.pc2.uni-paderborn.de/installation/use_install_script/)

### Run via Docker

We also provide a ready-to-use [`docker-compose.yml`](https://github.com/pc2-perseus/perseus/blob/main/docker-compose.yml) to run PERSEUS using **Docker** or **Podman**.

Our prebuilt container images are available on [Docker Hub](https://hub.docker.com/u/pc2upb).

> ⚠️ Note: This approach requires you to set up a reverse proxy (e.g. Nginx, Traefik, or Caddy) yourself to route requests to the frontend and backend containers. We recommend serving the API under '/api' and the frontend at '/'.

📖 To learn more about this installation method, visit the [official documentation](https://perseus-project.pc2.uni-paderborn.de/installation/use_docker-compose/).



## Components

PERSEUS comes with the following components:
* [PERSEUS core](https://github.com/pc2-perseus/perseus-core)
* [PERSEUS frontend](https://github.com/pc2-perseus/perseus-frontend)
* [PERSEUS worker](https://github.com/pc2-perseus/perseus-worker)
* [Plugins](https://github.com/pc2-perseus/perseus-plugins) (states, services & reports)

## License

This project is licensed under the terms of the **MIT License**.
See the [LICENSE](https://github.com/pc2-perseus/perseus/blob/main/LICENSE) file for details.
