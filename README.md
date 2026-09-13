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

> Feel free to reach out to us and share you experiences and feedback: https://perseus-project.pc2.uni-paderborn.de/contact/

PERSEUS is a compute project management software for scientific HPC centers. It allows you to
* professionalize your workflows
* deploy center-wide automation
* fully customize workflow items (states), (micro)services and reports

Here’s a first look at the software:

<img src="screens.gif" alt="PERSEUS logo" />

## What's new?

<!-- CHANGELOG START -->
Version **27.0.0** includes the following updates:


### PERSEUS

- _Added_
  - Configurable logo and color scheme via theme and logo fields in AndromedaConfiguration
  - Compute-projects endpoint now includes start date, end date, and granted resources
  - Dashboard component for the service catalog added to the frontend
  - Project workflow system
  - Andromeda sub-service for project overview now returns start, end, is_active, is_followup, and predecessor_id
  - Bibtex publications: added bibtex as source, automatic population of details, and optional abstract field
  - Andromeda sub-service for public project database (paginated, filterable endpoints for project overview)
  - Andromeda Service Catalog
  - Project editor improvements: inactive clusters removed, default partitions and values
  - Resource priorities in compute projects now displayed as colored chips
- _Changed_
  - Publications section in the frontend adapted to the new publications object type
  - Demo mode enhanced: project count reduced to 25% and missing data added (e.g., users as members)
- _Fixed_
  - Andromeda configuration is now automatically created with sensible defaults on startup if missing
  - Resolved performance issue causing long loading times due to cronjobs blocking worker processes

### Andromeda

- _Added_
  - Publications in Project Manager
  - Configurable "My Projects" overview with JOBS and PRIORITES options
  - New "project-overview" module with public project browsing and detailed views
  - Andromeda Service Catalog (frontend)
  - Configurable logo and color scheme
- _Changed_
  - Proposal module updated to use dedicated funding and public information attributes instead of custom data
- _Fixed_
  - Support ticket project selection no longer shows non-active or duplicate projects
  - Compute project resources now display only those from the current phase
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
* [Andromeda](https://github.com/pc2-perseus/andromeda)
* [PERSEUS gateway](https://github.com/pc2-perseus/perseus-gateway)
* [PERSEUS worker](https://github.com/pc2-perseus/perseus-worker)
* [Plugins](https://github.com/pc2-perseus/perseus-plugins) (states, services & reports)

## License

This project is licensed under the terms of the **MIT License**.
See the [LICENSE](https://github.com/pc2-perseus/perseus/blob/main/LICENSE) file for details.
