#
# /etc/modprobe.d/example.conf
# Kernel module blacklist and configuration
#
# This directory contains kernel module configuration files.
# Each file in this directory is processed alphabetically.
#
# Common use cases:
# - Blacklist problematic modules
# - Set module parameters
# - Disable certain hardware support
#

# BLACKLIST - Prevent modules from being loaded
# Use 'blacklist' to prevent a module from being automatically loaded.
# You can still load it manually with modprobe.

# Example: Disable Nouveau (if using NVIDIA proprietary driver)
# blacklist nouveau

# Example: Disable Intel integrated graphics (if using separate GPU)
# blacklist i915

# Example: Disable Realtek WiFi if using different driver
# blacklist rtw88

# Example: Disable some old/problematic modules
# blacklist dvb_usb_v2
# blacklist pcspkr

#
# MODULE PARAMETERS - Set kernel module options
# Format: options module_name parameter=value
#

# Example: Set NVIDIA driver parameters (if using nouveau)
# options nouveau modeset=1

# Example: Configure Intel audio
# options snd_hda_intel model=auto index=0,1

# Example: Network driver parameters
# options r8169 use_dma=1

# Example: Disable power saving on USB ports
# options usbcore autosuspend=-1

#
# INSTALL/REMOVE HOOKS - Run commands before/after module load
#

# Example: Disable microphone after module loads
# install snd /sbin/modprobe --ignore-install snd && /usr/bin/pkill -f "micmute"

#
# COMMON SYSTEM CONFIGURATIONS
#

# For systems with NVIDIA GPU (disable nouveau)
# blacklist nouveau
# options nvidia_drm modeset=1

# For systems with AMD GPU
# blacklist amdgpu  # (if you want to use radeon instead)

# For laptop suspend issues
# blacklist iTCO_wdt  # Watchdog timer that may prevent sleep

# For reducing power consumption
# options snd_hda_intel power_save=1

# For disabling specific USB devices
# options usbhid mousepoll=0
