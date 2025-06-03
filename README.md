Secure VPS Setup: SSH & WireGuard VPN Configuration
Proyek ini menyediakan langkah-langkah untuk mengamankan VPS Linux (Debian/Ubuntu) dengan mengatur OpenSSH dan WireGuard VPN. Tujuannya adalah untuk menyediakan akses remote yang aman dan tunneling terenkripsi untuk keperluan administratif maupun lalu lintas internal.

Fitur Utama
Instalasi dan konfigurasi OpenSSH Server

Instalasi dan konfigurasi WireGuard VPN (interface wg0)

Mengaktifkan IP forwarding dan konfigurasi firewall UFW

Disediakan skrip otomatis untuk sisi server dan klien

Perbaikan error systemd: "wg-quick@wg0 already exists"

Panduan setup klien Android disertakan

Fokus pada keamanan, kemudahan replikasi, dan kesederhanaan

File yang Disertakan
setup_ssh_vps.sh → Skrip untuk setup SSH dan WireGuard di VPS (server side)

setup_wg_client.sh → Skrip untuk generate konfigurasi klien WireGuard

wg0.conf → Contoh konfigurasi WireGuard server (dibuat otomatis)

README.txt → Panduan lengkap instalasi dan troubleshooting

Panduan Konfigurasi WireGuard di Android
Install aplikasi WireGuard dari Google Play Store.

Buka aplikasi, lalu tekan tombol "+" untuk membuat tunnel baru.

Pilih "Create from scratch" atau "Import from file".

Jika membuat manual, gunakan template berikut:

[Interface]
PrivateKey = <private key klien>
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = <public key server>
Endpoint = <IP publik VPS>:51820
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25

Ganti nilai <private key klien>, <public key server>, dan <IP publik VPS> sesuai konfigurasi kamu.

Simpan dan aktifkan tunnel. Sekarang seluruh koneksi internet kamu akan melewati VPS secara terenkripsi.

Catatan
Cocok untuk penggunaan pribadi atau tim kecil yang membutuhkan jaringan privat yang ringan, aman, dan mudah dikonfigurasi.

