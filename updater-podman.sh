#!/usr/bin/env bash
set -e

GREEN="\033[1;32m"
RED="\033[1;31m"
NC="\033[0m"

echo -e "${GREEN}=== PERSEUS Updater ===${NC}"

if ! id -u perseus >/dev/null 2>&1; then
    echo -e "${RED}Cannot find user 'perseus'${NC}"
    exit 1
fi

if [ ! -f docker-compose.yml ]; then
    echo -e "${RED}Could not find docker-compose.yml in the current directory${NC}"
    exit 1
fi

echo -e "${GREEN}1/3: Stopping containers...${NC}"
su - perseus -c "cd $(pwd) && podman-compose down"

echo -e "${GREEN}2/3: Pull images and restart containers...${NC}"
su - perseus -c "cd $(pwd) && podman-compose pull && podman-compose up -d"

echo -e "${GREEN}3/3: Removing unused containers...${NC}"
su - perseus -c "podman image prune -f"

echo -e "${GREEN}=== Completed PERSEUS update! ===${NC}"