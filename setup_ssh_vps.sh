#!/bin/bash

# Nama file: setup-vps.sh
# Pastikan file ini bisa dieksekusi: chmod +x setup-vps.sh
# Jalankan sebagai root atau gunakan sudo ./setup-vps.sh

# -----------------------------
# SSH SERVER SETUP
# -----------------------------
echo "[*] Installing and starting OpenSSH Server..."
apt update && apt install -y openssh-server
systemctl enable ssh
systemctl restart ssh
systemctl status ssh --no-pager

# -----------------------------
# WIREGUARD SETUP
# -----------------------------
echo "[*] Bringing down existing wg0 (if exists)..."
wg-quick down wg0 2>/dev/null

echo "[*] Starting WireGuard interface wg0..."
systemctl restart wg-quick@wg0
systemctl status wg-quick@wg0 --no-pager

# -----------------------------
# FIREWALL RULES
# -----------------------------
echo "[*] Allowing UDP port 51820 on firewall..."
ufw allow 51820/udp
ufw reload

echo "[✓] Setup complete."
