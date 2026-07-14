# pacman


```sh
:: Synchronizing package databases...
```
Downloads the latest package lists (core, extra, multilib) from
your mirrors so pacman knows what versions are currently
available.

```sh
:: Starting full system upgrade... / resolving dependencies...
```

pacman computes the full dependency graph — which packages need
updating and what order to install them in. This is where
conflicts are detected.

```sh
Packages (865) ...
```
The full list of packages that would be upgraded. 865 packages is
a large batch, suggesting your system hadn't been updated in a
while. Notable entries: glibc-2.43, linux-7.0.5, hyprland-0.54.3,
neovim-0.12.2, etc.

Total Download Size: 878.25 MiB / Total Installed Size: 10038.71
MiB / Net Upgrade Size: 835.87 MiB
- Download: what will be fetched from the internet
- Installed: total disk space after install
- Net: how much extra disk space this upgrade will consume

```sh
:: Retrieving packages...
```
Actually downloading. Only 1 of 267 batches downloaded before the
error.

```sh
error: failed retrieving file
'linux-7.0.5.arch1-1-x86_64.pkg.tar.zst.sig' from
mirror.rackspace.com : The requested URL returned error: 404
```
The mirror (mirror.rackspace.com) doesn't have the signature file
for the new Linux kernel — the mirror is stale/out of sync.
pacman requires the .sig to verify package integrity.
