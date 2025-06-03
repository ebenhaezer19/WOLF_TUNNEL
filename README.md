🔐 Secure VPS Setup: SSH & WireGuard VPN Configuration
This project provides a step-by-step setup for securing a Linux-based VPS (Debian/Ubuntu) using OpenSSH and WireGuard VPN. The goal is to enable secure remote access and private encrypted tunneling for administrative tasks or internal traffic routing.

✅ Features
Install and configure OpenSSH Server for secure remote login

Setup and manage WireGuard VPN (wg0 interface)

Enable IP forwarding and configure UFW firewall rules

Handle systemd-related service issues (e.g. wg-quick@wg0 already exists)

Scripts and commands included to persist configuration across reboots

Focus on security, reproducibility, and minimalism

Connect from Android using WireGuard app

📱 Connect from Android
Install the WireGuard app from Google Play.

On the VPS, generate a client config (e.g. android.conf) with:

ini
Copy
Edit
[Interface]
PrivateKey = <your-android-private-key>
Address = 10.0.0.2/32
DNS = 1.1.1.1

[Peer]
PublicKey = <server-public-key>
Endpoint = <your-vps-ip>:51820
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
Transfer the config to your phone (via QR code or file).

In the app: Add Tunnel → Import from file or scan QR code.

Toggle the switch to connect — you're now securely tunneled!

📂 Files
wg0.conf – example server config

android-client.conf – example client config

README.md – full setup guide & troubleshooting

🔧 Requirements
A VPS (DigitalOcean, Vultr, etc.)

Ubuntu 20.04/22.04 or Debian 10/11

Root or sudo access

