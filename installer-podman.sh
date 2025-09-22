#!/usr/bin/env bash
set -e

GREEN="\033[1;32m"
RED="\033[1;31m"
NC="\033[0m"

echo -e "${GREEN}=== PERSEUS Installer ===${NC}"

echo -e "${GREEN}0/7: Create folders...${NC}"
mkdir -p custom-services custom-states backups

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please execute as root or using sudo!${NC}"
    exit 1
fi

# --- Paketmanager erkennen ---
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

echo -e "${GREEN}1/7: Update packages...${NC}"
eval "$UPDATE_CMD"


echo -e "${GREEN}2/7: Install podman...${NC}"
if ! command -v podman >/dev/null 2>&1; then
    eval "$INSTALL_CMD podman"
else
    echo "Podman is already installed"
fi


echo -e "${GREEN}Install podman compose if necessary...${NC}"
if ! command -v podman-compose >/dev/null 2>&1; then
    eval "$INSTALL_CMD podman-compose" || pip3 install podman-compose
else
    echo "Podman compose is already installed"
fi


echo -e "${GREEN}3/7: Create user 'perseus'...${NC}"
if ! id -u perseus >/dev/null 2>&1; then
    useradd -m -s /bin/bash perseus
else
    echo "User 'perseus' already exists"
fi


echo -e "${GREEN}4/7: Configure UID/GID mapping...${NC}"
if ! grep -q "^perseus:" /etc/subuid; then
    echo "perseus:100000:65536" >> /etc/subuid
fi
if ! grep -q "^perseus:" /etc/subgid; then
    echo "perseus:100000:65536" >> /etc/subgid
fi


echo -e "${GREEN}5/7: Install nginx...${NC}"
if ! command -v nginx >/dev/null 2>&1; then
    eval "$INSTALL_CMD nginx"
else
    echo "Nginx is already installed"
fi


echo -e "${GREEN}6/7: Podman-Compose-Setup (rootless) starten...${NC}"
if [ ! -f docker-compose.yml ]; then
    echo -e "${RED}docker-compose.yml nicht im aktuellen Verzeichnis gefunden.${NC}"
    exit 1
fi

sudo loginctl enable-linger 1000
su - perseus -c "cd $(pwd) && podman-compose pull && podman-compose up -d"

# remove nginx default configuration
NGINX_DEFAULT_CONFIG="/etc/nginx/sites-enabled/default"
if [ -L "$NGINX_DEFAULT_CONFIG" ]; then
    echo -e "${GREEN}Removing Nginx Default Config: $NGINX_DEFAULT_CONFIG...${NC}"
    rm -- "$NGINX_DEFAULT_CONFIG"
fi

mkdir -p /etc/nginx/ssl

echo -e "${GREEN}7/7: Nginx-Konfiguration ersetzen...${NC}"
if [ ! -f nginx.conf ]; then
    echo -e "${RED}nginx.conf nicht im aktuellen Verzeichnis gefunden.${NC}"
    exit 1
fi

cp nginx.conf /etc/nginx/sites-available/perseus.conf
ln -s /etc/nginx/sites-available/perseus.conf /etc/nginx/sites-enabled/
nginx -t

echo -e "${GREEN}Reload nginx...${NC}"
systemctl enable nginx
systemctl restart nginx

echo -e "${GREEN}=== Completed PERSEUS installation! ===${NC}"
