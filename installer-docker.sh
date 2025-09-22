#!/usr/bin/env bash

set -e

# Farben für Ausgaben
GREEN="\033[1;32m"
RED="\033[1;31m"
NC="\033[0m"

echo -e "${GREEN}=== PERSEUS Installer ===${NC}"

echo -e "${GREEN}0/5: Create folders...${NC}"
mkdir -p custom-services custom-states backup

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please execute as root or using sudo!${NC}"
    exit 1
fi


if command -v apt-get >/dev/null 2>&1; then
    UPDATE_CMD="apt-get update -y"
    INSTALL_CMD="apt-get install -y"
elif command -v yum >/dev/null 2>&1; then
    UPDATE_CMD="yum makecache -y"
    INSTALL_CMD="yum install -y"
elif command -v dnf >/dev/null 2>&1; then
    UPDATE_CMD="dnf makecache -y"
    INSTALL_CMD="dnf install -y"
elif command -v zypper >/dev/null 2>&1; then
    UPDATE_CMD="zypper refresh"
    INSTALL_CMD="zypper install -y"
else
    echo -e "${RED}Cannot find supported package manager${NC}"
    exit 1
fi

echo -e "${GREEN}1/5: Update packages...${NC}"
eval "$UPDATE_CMD"

echo -e "${GREEN}2/5: Install docker...${NC}"
if ! command -v docker >/dev/null 2>&1; then
    eval "$INSTALL_CMD docker.io" || eval "$INSTALL_CMD docker"
else
    echo "Docker is already installed"
fi

echo -e "${GREEN}Install docker compose plugin if necessary...${NC}"
if ! docker compose version >/dev/null 2>&1; then
    eval "$INSTALL_CMD docker-compose-plugin" || eval "$INSTALL_CMD docker-compose"
fi

echo -e "${GREEN}3/5: Install nginx...${NC}"
if ! command -v nginx >/dev/null 2>&1; then
    eval "$INSTALL_CMD nginx"
else
    echo "Nginx is already installed"
fi

echo -e "${GREEN}4/5: Run docker-compose.yml...${NC}"
if [ ! -f docker-compose.yml ]; then
    echo -e "${RED}could not find docker-compose.yml in the current directory${NC}"
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

$DOCKER_COMPOSE pull
$DOCKER_COMPOSE up -d

echo -e "${GREEN}5/5: Overwrite nginx configuration...${NC}"
if [ ! -f nginx.conf ]; then
    echo -e "${RED}could not find nginx.conf in the current directory${NC}"
    exit 1
fi

# remove nginx default configuration
NGINX_DEFAULT_CONFIG="/etc/nginx/sites-enabled/default"
if [ -L "$NGINX_DEFAULT_CONFIG" ]; then
    echo -e "${GREEN}Removing Nginx Default Config: $NGINX_DEFAULT_CONFIG...${NC}"
    rm -- "$NGINX_DEFAULT_CONFIG"
fi

mkdir -p /etc/nginx/ssl

cp nginx.conf /etc/nginx/sites-available/perseus.conf
ln -s /etc/nginx/sites-available/perseus.conf /etc/nginx/sites-enabled/
nginx -t

echo -e "${GREEN}Reload nginx...${NC}"
systemctl enable nginx
systemctl restart nginx

echo -e "${GREEN}=== Completed PERSEUS installation! ===${NC}"
