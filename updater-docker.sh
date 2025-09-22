#!/usr/bin/env bash

set -e

GREEN="\033[1;32m"
RED="\033[1;31m"
NC="\033[0m"

echo -e "${GREEN}=== PERSEUS Updater ===${NC}"

# Prüfen, ob docker installiert ist
if ! command -v docker >/dev/null 2>&1; then
    echo -e "${RED}Docker is not installed!${NC}"
    exit 1
fi

# Determine correct docker-compose command
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo "Error: Docker Compose is not installed." >&2
    exit 1
fi

# Prüfen, ob docker-compose.yml existiert
if [ ! -f docker-compose.yml ]; then
    echo -e "${RED}Could not find docker-compose.yml in the current directory${NC}"
    exit 1
fi

echo -e "${GREEN}1/4: Stopping containers...${NC}"
$DOCKER_COMPOSE down

echo -e "${GREEN}2/4: Pull images...${NC}"
$DOCKER_COMPOSE pull

echo -e "${GREEN}3/4: Starting containers...${NC}"
$DOCKER_COMPOSE up -d

echo -e "${GREEN}4/4: Removing unused containers...${NC}"
docker image prune -f

echo -e "${GREEN}=== Completed PERSEUS update! ===${NC}"