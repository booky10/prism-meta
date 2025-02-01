# Prism Launcher Meta

Scripts to generate jsons and jars that Prism Launcher will access.

This repository is a fork of https://github.com/PrismLauncher/meta because I want to use this with docker.

## Deployment with docker

You need to have [Docker](https://docker.com/) installed for this to work.

1. Download this git repository
2. Copy `config.example.sh` to `config.sh` and configure
3. Place your git push key at `deploy.key`
4. Run `docker compose run --rm meta init` to clone the initial git repositories
5. Run `docker compose up -d` to start the cron scheduler

## Manual updates

1. Execute steps 1-4 from the deployment guide above if you haven't already
2. Run `docker compose run --rm meta update`
