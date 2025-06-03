#!/bin/bash

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Variabel konfigurasi
SERVER_PUBLIC_KEY="qBX/G2RQ+D42SeriiwVX/Hmz7X8gHdXgH5N7VKTnH2U="
SERVER_ENDPOINT="134.209.108.228:51820"
ALLOWED_IPS="10.0.0.0/24"

# Pastikan wireguard-tools dan coreutils terinstal
if ! command -v wg &> /dev/null; then
    echo -e "${RED}WireGuard tidak ditemukan. Menginstal dependensi...${NC}"
    if [ -f /system/bin/termux-info ]; then
        # Untuk Termux
        pkg update && pkg install wireguard-tools coreutils
    else
        # Untuk distribusi Linux lain
        sudo apt update && sudo apt install -y wireguard-tools
    fi
fi

# Buat direktori untuk menyimpan kunci
mkdir -p ~/.wireguard
cd ~/.wireguard

# Peer 1 (10.0.0.2)
echo -e "${GREEN}Mengatur Peer 1 (10.0.0.2)...${NC}"
wg genkey | tee client1_privatekey | wg pubkey > client1_publickey
CLIENT1_PRIVATE=$(cat client1_privatekey)
CLIENT1_PUBLIC=$(cat client1_publickey)

cat > client1.conf << EOF
[Interface]
PrivateKey = $CLIENT1_PRIVATE
Address = 10.0.0.2/24

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_ENDPOINT
AllowedIPs = $ALLOWED_IPS
EOF

# Peer 2 (10.0.0.3)
echo -e "${GREEN}Mengatur Peer 2 (10.0.0.3)...${NC}"
wg genkey | tee client2_privatekey | wg pubkey > client2_publickey
CLIENT2_PRIVATE=$(cat client2_privatekey)
CLIENT2_PUBLIC=$(cat client2_publickey)

cat > client2.conf << EOF
[Interface]
PrivateKey = $CLIENT2_PRIVATE
Address = 10.0.0.3/24

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_ENDPOINT
AllowedIPs = $ALLOWED_IPS
EOF

# Berikan izin pada file
chmod 600 client1.conf client2.conf client1_privatekey client2_privatekey

# Cek apakah /sdcard/Download tersedia dan salin file client1.conf
if [ -d "/sdcard/Download" ]; then
    cp client1.conf /sdcard/Download/
    echo -e "${GREEN}File client1.conf telah disalin ke /sdcard/Download/.${NC}"
    echo "Buka aplikasi WireGuard Android dan impor file tersebut."
else
    echo -e "${RED}/sdcard/Download tidak ditemukan. Silakan salin file client1.conf secara manual.${NC}"
fi

# Ringkasan output
echo -e "${GREEN}Setup selesai! File konfigurasi disimpan di ~/.wireguard:${NC}"
echo "Peer 1: client1.conf (PrivateKey: $CLIENT1_PRIVATE, PublicKey: $CLIENT1_PUBLIC)"
echo "Peer 2: client2.conf (PrivateKey: $CLIENT2_PRIVATE, PublicKey: $CLIENT2_PUBLIC)"
echo
echo "Silakan salin PublicKey masing-masing ke server (wg0.conf) jika perlu."
echo "Atau impor file client1.conf ke aplikasi WireGuard Android."
