# TODO
## Chores
- [ ] Unify the unit of each directory
- [ ] Enable brightness control of second monitor
- [ ] Window move/focus across monitors
- [ ] Enable zoom in/out in Terminal, Qutebrowser
- [ ] Migrate all the Issues to TODO.mdadm
- [ ] Re-enable grave key

## shell scripts to organize the whole repository
### Symlink automizer
#### ETC directory
1. System Identity & Locale
*Who this machine is and where/when it is.*

| Path | Purpose |
|---|---|
| `/etc/hostname` | Machine's network hostname |
| `/etc/machine-id` | Globally unique 128-bit machine identifier (used by systemd, D-Bus) |
| `/etc/os-release` | OS name, version, ID (e.g. `ID=arch`) — parsed by tools like `hostnamectl` |
| `/etc/arch-release` | Arch-specific release marker (empty file, presence signals Arch) |
| `/etc/adjtime` | Hardware clock drift correction data and UTC/local setting |
| `/etc/localtime` | Symlink to active timezone file under `/usr/share/zoneinfo/` |
| `/etc/locale.conf` | Active locale settings (`LANG=`, `LC_*=`) |
| `/etc/locale.gen` | Which locales `locale-gen` should build |
| `/etc/vconsole.conf` | Virtual console keyboard map and font |
| `/etc/issue` | Pre-login banner shown on TTYs |
| `/etc/issue.pacnew` | Upstream `issue` template from the latest package upgrade |
| `/etc/environment` | System-wide, shell-agnostic environment variables |

---

2. User & Group Management
The account database — who may exist on this system.*

| Path | Purpose |
|---|---|
| `/etc/passwd` | User account records (username, UID, GID, home, shell) |
| `/etc/passwd-` | Automatic backup of `passwd` before last edit |
| `/etc/passwd.OLD` | Older manual/tool backup of `passwd` |
| `/etc/shadow` | Hashed passwords and aging policy (root-readable only) |
| `/etc/shadow-` | Backup of `shadow` |
| `/etc/group` | Group membership records |
| `/etc/group-` | Backup of `group` |
| `/etc/gshadow` | Group password hashes and administrator lists |
| `/etc/gshadow-` | Backup of `gshadow` |
| `/etc/subuid` | UID ranges delegated to users for user-namespace containers |
| `/etc/subuid-` | Backup of `subuid` |
| `/etc/subgid` | GID ranges delegated to users for user-namespace containers |
| `/etc/subgid-` | Backup of `subgid` |
| `/etc/login.defs` | Defaults for `useradd`, UID/GID ranges, password aging policy |
| `/etc/shells` | Whitelist of valid login shells |
| `/etc/skel/` | Template files copied into every new user's home directory |
| `/etc/securetty` | TTYs from which root is allowed to log in directly |
| `/etc/userdb/` | Supplementary JSON user/group records (systemd-userdb format) |
| `/etc/.pwd.lock` | Advisory lock file preventing concurrent edits to the password db |

---

3. Authentication
*Verifying that a claimed identity is genuine.*

| Path | Purpose |
|---|---|
| `/etc/pam.d/` | Per-service PAM (Pluggable Authentication Modules) stacks — one file per service (`sudo`, `sshd`, `login`, `ly`, `swaylock`, etc.) defining auth/account/session/password chains |
| `/etc/security/` | PAM module configuration: `limits.conf` (resource limits), `access.conf` (host/user login rules), `pwquality.conf` (password strength), etc. |
| `/etc/krb5.conf` | Kerberos 5 client configuration (realms, KDCs, ticket settings) |

---

4. Authorization & Privilege Escalation
*What authenticated users are allowed to do.*

| Path | Purpose |
|---|---|
| `/etc/sudoers` | Core sudo rules (edited via `visudo`) |
| `/etc/sudoers.d/` | Drop-in sudo rules for packages/admins |
| `/etc/sudoers.pacnew` | Upstream sudo defaults from the latest package |
| `/etc/sudo.conf` | Sudo plugin configuration (which policy/audit plugins to load) |
| `/etc/sudo_logsrvd.conf` | Sudo log server daemon config (TLS, remote logging) |
| `/etc/polkit-1/` | PolicyKit authorization rules — governs GUI-level privilege (e.g. mounting drives as a user) |

---

5. Boot & Initramfs
*Getting the system from power-on to a running userspace.*

| Path | Purpose |
|---|---|
| `/etc/mkinitcpio.conf` | Main initramfs configuration: HOOKS (e.g. `encrypt`, `filesystems`), MODULES, FILES |
| `/etc/mkinitcpio.conf.d/` | Drop-in overrides for mkinitcpio |
| `/etc/mkinitcpio.d/` | Kernel-specific preset files (determines which images to build, e.g. `linux.preset`) |
| `/etc/initcpio/` | Custom mkinitcpio hooks and install scripts |
| `/etc/grub.d/` | Shell scripts that compose the final `grub.cfg` (e.g. `10_linux`, `40_custom`) |
| `/etc/kernel/` | Parameters and install scripts for `kernel-install` (appends kernel to ESP) |

---

6. Kernel Configuration
*Tuning the running kernel — modules, parameters, binary formats.*

| Path | Purpose |
|---|---|
| `/etc/modprobe.d/` | Per-module options and blacklists (e.g. `blacklist pcspkr.conf`) |
| `/etc/modules-load.d/` | Modules to load unconditionally at boot |
| `/etc/sysctl.d/` | Kernel parameter tuning applied via `sysctl` at boot (networking, memory, etc.) |
| `/etc/binfmt.d/` | Extra binary format interpreters (e.g. run `.exe` via Wine, `.jar` via Java) |
| `/etc/depmod.d/` | Overrides for `depmod` module dependency resolution |

---

7. Filesystem & Storage
*How disks, volumes, and files are organized and accessed.*

| Path | Purpose |
|---|---|
| `/etc/fstab` | Static mount table — which devices mount where at boot |
| `/etc/crypttab` | Encrypted block devices to unlock/map at boot (LUKS volumes) |
| `/etc/cryptsetup-keys.d/` | Key files for automated LUKS unlock |
| `/etc/mtab` | Symlink → `/proc/mounts` (live view of current mounts) |
| `/etc/mke2fs.conf` | Defaults for `mkfs.ext2/3/4` (block size, features, reserved blocks) |
| `/etc/e2scrub.conf` | Ext4 online scrub schedule configuration |
| `/etc/mdadm.conf` | Software RAID (md) array definitions and monitoring |
| `/etc/xattr.conf` | Extended-attribute namespace mapping (maps short names to xattr namespaces) |
| `/etc/fuse.conf` | FUSE permission policy (whether non-root users may mount) |

---

8. Package & Build Management
*Installing and building software on Arch Linux.*

| Path | Purpose |
|---|---|
| `/etc/pacman.conf` | pacman package manager: repositories, options, `IgnorePkg`, `HoldPkg` |
| `/etc/pacman.conf.pacnew` | Upstream pacman.conf from latest package (unmerged) |
| `/etc/pacman.d/mirrorlist` | Ranked list of Arch package mirrors |
| `/etc/pacman.d/mirrorlist.pacnew` | Upstream mirrorlist template |
| `/etc/pacman.d/gnupg/` | pacman's GPG keyring (trusted package-signing keys, trust DB) |
| `/etc/paru.conf` | paru AUR helper configuration |
| `/etc/makepkg.conf` | PKGBUILD build flags (`CFLAGS`, `MAKEFLAGS`, compression method) |
| `/etc/makepkg.conf.d/` | Drop-in makepkg settings |
| `/etc/makepkg.d/` | Additional makepkg configuration fragments |

---

9. Service & Process Management (systemd)
*Supervising long-running processes and system resources.*

| Path | Purpose |
|---|---|
| `/etc/systemd/system.conf` | Global systemd manager settings (default timeout, CPU affinity, etc.) |
| `/etc/systemd/user.conf` | Per-user service manager defaults |
| `/etc/systemd/system/` | Enabled units and drop-in overrides for system services; `*.wants/` symlinks represent enabled units |
| `/etc/systemd/user/` | Enabled units and overrides for user-session services (e.g. PipeWire) |
| `/etc/systemd/network/` | systemd-networkd configs — `25-wireless.network`, `wireless.network` |
| `/etc/systemd/networkd.conf` | Global systemd-networkd daemon settings |
| `/etc/systemd/resolved.conf` | systemd-resolved DNS settings (upstream servers, DNSSEC) |
| `/etc/systemd/journald.conf` | Journal storage, size limits, compression |
| `/etc/systemd/logind.conf` | Login session policy (lid-close action, idle timeouts) |
| `/etc/systemd/timesyncd.conf` | NTP servers for systemd-timesyncd |
| `/etc/systemd/sleep.conf` | Suspend/hibernate settings |
| `/etc/systemd/coredump.conf` | Core dump capture settings |
| `/etc/systemd/homed.conf` | systemd-homed home directory management |
| `/etc/systemd/oomd.conf` | Out-of-memory daemon settings |
| `/etc/systemd/pstore.conf` | Persistent storage (pstore) handling for crash data |
| `/etc/systemd/journal-remote.conf` | Journal reception over HTTPS |
| `/etc/systemd/journal-upload.conf` | Journal forwarding to a remote server |
| `/etc/tmpfiles.d/` | Rules for creating/removing/permissions of volatile files/dirs at boot |
| `/etc/conf.d/` | OpenRC-style environment variable files for init scripts (used by some Arch packages) |
| `/etc/default/` | Sysvinit-style service defaults (legacy, some packages still use it) |
| `/etc/sysconfig/` | More SysV-style service configuration variables |

---

10. Scheduled Tasks
*Running commands on a time-based schedule.*

| Path | Purpose |
|---|---|
| `/etc/crontab` | System crontab with user column (runs hourly/daily/weekly/monthly scripts) |
| `/etc/cron.d/` | Per-package cron job files |
| `/etc/cron.hourly/` | Scripts run every hour by cron |
| `/etc/cron.daily/` | Scripts run once daily |
| `/etc/cron.weekly/` | Scripts run once weekly |
| `/etc/cron.monthly/` | Scripts run once monthly |
| `/etc/cron.deny` | Users barred from using `crontab` |
| `/etc/anacrontab` | Anacron config — re-runs missed daily/weekly/monthly jobs after resume |

---

11. Networking — Connectivity & Name Resolution
*Connecting to networks and resolving names.*

| Path | Purpose |
|---|---|
| `/etc/hosts` | Static hostname-to-IP overrides (before DNS) |
| `/etc/resolv.conf` | DNS resolver config (nameservers, search domain) — often managed by systemd-resolved or NetworkManager |
| `/etc/nsswitch.conf` | Name Service Switch — controls lookup order for hosts, passwords, groups, etc. |
| `/etc/host.conf` | Legacy resolver library behavior (ordering, multi-homed) |
| `/etc/gai.conf` | `getaddrinfo()` address-family preference ordering (IPv4 vs IPv6) |
| `/etc/netconfig` | RPC transport binding (used by Sun RPC/NFS) |
| `/etc/protocols` | IP protocol number → name mapping (`/etc/protocols 6 tcp`) |
| `/etc/rpc` | RPC program numbers (used by NFS, NIS, etc.) |
| `/etc/services` | TCP/UDP port number → service name mapping |
| `/etc/ethertypes` | Ethernet frame type number → name mapping |
| `/etc/NetworkManager/NetworkManager.conf` | NetworkManager global configuration |
| `/etc/NetworkManager/system-connections/` | Saved Wi-Fi/ethernet connection profiles |
| `/etc/NetworkManager/conf.d/` | Drop-in NM configs |
| `/etc/NetworkManager/dispatcher.d/` | Scripts run when network state changes (up/down/pre-up/pre-down) |
| `/etc/NetworkManager/dnsmasq.d/` | Dnsmasq config snippets when NM uses dnsmasq for DNS |
| `/etc/wpa_supplicant/` | Per-interface WPA/WPA2 configuration files |
| `/etc/wpa_supplicant.conf` | Global `wpa_supplicant` configuration |

---

12. Firewall & Network Filtering
*Controlling which packets are allowed in/out.*

| Path | Purpose |
|---|---|
| `/etc/nftables.conf` | nftables ruleset (modern, primary firewall framework) |
| `/etc/iptables/` | iptables and ip6tables rules (legacy, loaded by `iptables-restore`) |
| `/etc/firewalld/` | firewalld zones, policies, and services (high-level firewall manager using nftables/iptables backend) |

---

13. Security Enforcement & Sandboxing
*Mandatory access control and process isolation.*

| Path | Purpose |
|---|---|
| `/etc/apparmor/` | AppArmor global configuration |
| `/etc/apparmor.d/` | AppArmor profiles — one file per application, restricting filesystem/network access; `abstractions/` are shared reusable snippets |
| `/etc/firejail/` | Firejail sandbox profiles — per-application seccomp/namespace restrictions |
| `/etc/audit/` | Linux Audit daemon rules and configuration (`auditd.conf`, `audit.rules`) |
| `/etc/audisp/` | Audit dispatcher plugins (forward audit events to syslog, remote servers, etc.) |
| `/etc/tpm2-tss/` | TPM2 Software Stack configuration (FAPI profiles, key storage backend) |

---

14. Cryptography, Certificates & Key Management
*Trust anchors, TLS, and key/credential storage.*

| Path | Purpose |
|---|---|
| `/etc/ssl/` | System SSL/TLS certificates and private keys |
| `/etc/ca-certificates/` | CA certificate bundle configuration (which CAs to trust) |
| `/etc/gnutls/` | GnuTLS library configuration (certificate verification flags) |
| `/etc/pkcs11/` | PKCS#11 token module configuration (smart cards, HSMs) |
| `/etc/keyutils/` | `request-key` and keyring utility configuration |
| `/etc/request-key.conf` | Kernel key-request upcall handler rules |
| `/etc/request-key.d/` | Drop-in key request handler definitions |
| `/etc/credstore/` | systemd encrypted credential store (plaintext credentials) |
| `/etc/credstore.encrypted/` | systemd encrypted credential store (encrypted credentials) |

---

15. Shell & Terminal Environment
*The interactive command-line experience.*

| Path | Purpose |
|---|---|
| `/etc/profile` | Login shell initialization script (sourced by all POSIX login shells) |
| `/etc/profile.d/` | Drop-in scripts sourced by `/etc/profile` (typically set PATH, env vars per-package) |
| `/etc/bash.bashrc` | System-wide Bash interactive-shell initialization |
| `/etc/bash.bash_logout` | System-wide Bash logout script |
| `/etc/bash_completion.d/` | System-wide Bash tab-completion definitions |
| `/etc/zsh/` | System-wide Zsh configuration (`zshenv`, `zshrc`, `zprofile`, `zlogin`) |
| `/etc/inputrc` | GNU Readline key bindings (shared by bash, python REPL, etc.) |
| `/etc/vimrc` | System-wide Vim configuration |
| `/etc/tigrc` | tig (text-mode git viewer) global configuration |
| `/etc/slsh.rc` | S-Lang shell (slsh) startup configuration |

---

16. Graphical Desktop & Display
*Everything from X/Wayland startup to fonts, input, and display managers.*

| Path | Purpose |
|---|---|
| `/etc/X11/` | X.org configuration: `xorg.conf.d/` drop-ins, `Xwrapper.config` (permission to run X), `xinit/` scripts |
| `/etc/xdg/` | XDG base-dir config: `autostart/` (per-session autostart .desktops), `menus/` (application menu spec) |
| `/etc/dconf/` | GNOME dconf system-level overrides (locks and defaults for GNOME settings) |
| `/etc/gtk-3.0/` | GTK3 global settings and bookmarks |
| `/etc/fonts/` | Fontconfig configuration: which directories to scan, aliases, rendering rules |
| `/etc/libinput/` | libinput device quirk overrides for touchpads, mice, tablets |
| `/etc/gnome-remote-desktop/` | GNOME Remote Desktop (RDP/VNC) system configuration |
| `/etc/tigervnc/` | TigerVNC server configuration |
| `/etc/ly/` | ly display manager (TUI login manager) configuration |
| `/etc/interception/` | Interception Tools low-level input event pipeline configuration |
| `/etc/keyd/` | keyd keyboard remapping daemon configuration |
| `/etc/rc_keymaps` | ir-keytable IR remote control keymap files |
| `/etc/rc_maps.cfg` | ir-keytable mapping of remote models to keymaps |
| `/etc/colord/` | colord color management daemon — display profiles and calibration rules |

---

17. Audio
*The sound subsystem stack.*

| Path | Purpose |
|---|---|
| `/etc/alsa/conf.d/` | ALSA configuration snippets — `50-pipewire.conf` redirects ALSA to PipeWire; `99-pipewire-default.conf` sets PipeWire as default |
| `/etc/pipewire/` | PipeWire audio/video server configuration (context, client, media-session rules) |
| `/etc/pulse/` | PulseAudio configuration (used either natively or via the PipeWire PulseAudio compatibility layer) |
| `/etc/libao.conf` | libao audio output library driver selection |

---

18. Printing
*Print server, drivers, and paper configuration.*

| Path | Purpose |
|---|---|
| `/etc/cups/` | CUPS print server: `cupsd.conf` (server policy), `printers.conf` (installed printers), `ppd/` (printer description files) |
| `/etc/cupshelpers/` | Python helper scripts and data used by CUPS backends |
| `/etc/foomatic/` | Foomatic printer driver filter database |
| `/etc/printcap` | Legacy BSD printer capability database (generated from CUPS) |
| `/etc/papersize` | System default paper size (e.g. `a4`) |
| `/etc/paperspecs` | Full paper dimension database (width/height in mm for each paper type) |
| `/etc/libpaper.d/` | libpaper drop-in paper size overrides |

---

19. Hardware Support & Low-Level Library Configuration
*Device management, shared-library loading, hardware drivers.*

**Dynamic linker:**
| Path | Purpose |
|---|---|
| `/etc/ld.so.conf` | Root config for `ldconfig` — includes `/etc/ld.so.conf.d/*.conf` |
| `/etc/ld.so.conf.d/` | Per-package shared-library search path additions |
| `/etc/ld.so.cache` | Binary cache of all found shared libraries (rebuilt by `ldconfig`) |

**Device & hardware management:**
| Path | Purpose |
|---|---|
| `/etc/udev/` | udev rules for device naming, permissions, and event actions |
| `/etc/udisks2/` | UDisks2 automount policy and device configuration |
| `/etc/UPower/` | UPower battery/power source event thresholds |
| `/etc/bluetooth/` | BlueZ Bluetooth daemon (`main.conf`), per-device settings |
| `/etc/avahi/` | Avahi mDNS/DNS-SD daemon (`avahi-daemon.conf`), service files |
| `/etc/sensors3.conf` | lm-sensors hardware monitor chip configuration |
| `/etc/sensors.d/` | Drop-in lm-sensors chip definitions |
| `/etc/ts.conf` | tslib touchscreen calibration and plugin chain |

**Graphics & multimedia libraries:**
| Path | Purpose |
|---|---|
| `/etc/libva.conf` | VA-API (Intel/AMD GPU video acceleration) backend selection |
| `/etc/vdpau_wrapper.cfg` | VDPAU wrapper for routing NVIDIA VDPAU calls to VA-API |

**Other library configs:**
| Path | Purpose |
|---|---|
| `/etc/libblockdev/` | libblockdev plugin configuration (which storage technology plugins to load) |
| `/etc/libnl/` | Netlink library configuration |
| `/etc/libaudit.conf` | Audit library connection settings |
| `/etc/bindresvport.blacklist` | Port numbers barred from `bindresvport()` (prevents privileged port squatting) |

**Java:**
| Path | Purpose |
|---|---|
| `/etc/java-openjdk/` | OpenJDK JVM security policy, logging, and management configuration |

---

20. Application-Specific Configuration
*Configs that belong to a single application.*

| Path | Purpose |
|---|---|
| `/etc/ssh/ssh_config` | System-wide OpenSSH client options |
| `/etc/ssh/ssh_config.d/` | Drop-in client config snippets |
| `/etc/ssh/sshd_config` | OpenSSH server options (port, auth methods, etc.) |
| `/etc/ssh/sshd_config.d/` | Drop-in server config snippets |
| `/etc/ssh/ssh_host_*_key[.pub]` | Server host keys (RSA, ECDSA, Ed25519) |
| `/etc/ssh/moduli` | Diffie-Hellman group parameters for key exchange |
| `/etc/nginx/` | nginx web server: `nginx.conf`, `mime.types`, `conf.d/`, `sites-*/` |
| `/etc/openldap/` | OpenLDAP client (`ldap.conf`) and server (`slapd.conf`) configuration |
| `/etc/wgetrc` | wget default options (proxy, timeout, retries) |
| `/etc/rsyncd.conf` | rsync daemon module definitions and ACLs |
| `/etc/man_db.conf` | man-db manual page database paths and caching behavior |
| `/etc/mailcap` | MIME type → handler program registry (used by `run-mailcap`, mutt, etc.) |
| `/etc/mime.types` | File extension → MIME type mapping |
| `/etc/xml/` | XML catalog — maps public XML DTD identifiers to local paths |
| `/etc/ImageMagick-7/` | ImageMagick security policy, resource limits, codec delegates |
| `/etc/dcmtk/` | DCMTK DICOM medical imaging toolkit configuration |
| `/etc/arp-scan/` | arp-scan OUI vendor database |
| `/etc/imv_config` | imv image viewer global configuration |
| `/etc/gdb/` | GDB debugger system-wide initialization (`gdbinit`) |
| `/etc/gprofng.rc` | gprofng (Oracle performance profiler) global settings |
| `/etc/ardour8/` | Ardour 8 DAW system configuration |
| `/etc/libreoffice/` | LibreOffice system-level settings and templates |
| `/etc/bitcoin/` | Bitcoin Core node configuration |
| `/etc/anthy-conf` | Anthy Japanese input method engine configuration |
| `/etc/debuginfod/` | debuginfod URL list — where `gdb`/`valgrind` fetch debug symbols from |
| `/etc/cni/` | Container Network Interface plugin configurations (used by Podman, etc.) |

---

21. Databases
*Database server configuration.*

| Path | Purpose |
|---|---|
| `/etc/my.cnf` | MySQL/MariaDB server root config (includes `my.cnf.d/`) |
| `/etc/my.cnf.d/` | Drop-in MariaDB/MySQL config files (client, server, mysqldump, etc.) |

---

22. Logging, Monitoring & Auditing
*Recording what happened.*

| Path | Purpose |
|---|---|
| `/etc/logrotate.d/` | Log rotation rules per service (size, frequency, compression, retention) |
| `/etc/audit/` | Linux Audit daemon rules and config |
| `/etc/audisp/` | Audit dispatcher plugins |
| `/etc/healthd.conf` | healthd hardware health monitoring daemon thresholds (temperature, fan) |

---

23. Metadata & Miscellaneous
*Bookkeeping files that don't fit a functional category.*

| Path | Purpose |
|---|---|
| `/etc/.updated` | Timestamp written by `systemd-update-done` after a package upgrade — signals services to reload |
| `/etc/pacman.conf.pacnew` / `/etc/sudoers.pacnew` / `/etc/issue.pacnew` | Unmerged upstream config versions left by pacman when your local file differed |

---

Summary Map

```
/etc/
├── Identity & Locale          → hostname, machine-id, localtime, locale.*, vconsole.conf …
├── Users & Groups             → passwd, shadow, group, gshadow, subuid/gid, skel/ …
├── Authentication             → pam.d/, security/, krb5.conf
├── Authorization              → sudoers, sudoers.d/, polkit-1/
├── Boot & Initramfs           → mkinitcpio.*, initcpio/, grub.d/, kernel/
├── Kernel Config              → modprobe.d/, sysctl.d/, binfmt.d/, modules-load.d/
├── Filesystem & Storage       → fstab, crypttab, mdadm.conf, mke2fs.conf …
├── Package Management         → pacman.conf, pacman.d/, paru.conf, makepkg.*
├── Service Management         → systemd/, tmpfiles.d/, conf.d/, default/
├── Scheduled Tasks            → crontab, cron.{d,daily,weekly,…}, anacrontab
├── Networking                 → hosts, resolv.conf, nsswitch.conf, NetworkManager/, wpa_supplicant*
├── Firewall                   → nftables.conf, iptables/, firewalld/
├── Security Enforcement       → apparmor.d/, firejail/, audit/, audisp/, tpm2-tss/
├── Cryptography & Certs       → ssl/, ca-certificates/, gnutls/, pkcs11/, credstore*/
├── Shell & Terminal           → profile, profile.d/, bash.bashrc, zsh/, inputrc, vimrc
├── Desktop & Display          → X11/, xdg/, dconf/, fonts/, ly/, keyd/, libinput/
├── Audio                      → alsa/, pipewire/, pulse/
├── Printing                   → cups/, foomatic/, papersize …
├── Hardware & Library Config  → ld.so.*, udev/, udisks2/, bluetooth/, sensors*, libva.conf …
├── Applications               → ssh/, nginx/, openldap/, gdb/, ImageMagick-7/, bitcoin/ …
├── Databases                  → my.cnf, my.cnf.d/
├── Logging & Monitoring       → logrotate.d/, healthd.conf
└── Metadata                   → .updated, *.pacnew
```

##### System Identity & Release


### Color automizer
#### Define color layer
- General
  - Simple
  - Minimal
  - Monotone color
    - But use purple(Sophia color)
- Character color
  - Weight
  - Font family
    - JetBrain
- Shadow
  - None
#### 

# Play with Kernel
