PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aosp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aosp/prebuilt/common/bin/50-legendrom.sh:system/addon.d/50-legendrom.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# LegendROM-specific init file
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init.local.rc:root/init.legendrom.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/aosp/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/aosp/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# LegendROM-specific startup services
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aosp/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/aosp/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt
#    WolvesDen \
#    ThemeInterfacer \
#    Eleven \
#    OmniSwitch \
#    OmniJaws \
#    OmniStyle \
#    Turbo \
#    GZRoms \
#    Nova \
#    NovaGoogleCompanion

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# MusicFX advanced effects
#ifneq ($(TARGET_NO_DSPMANAGER), true)
#PRODUCT_PACKAGES += \
#    libcyanogen-dsp \
#    audio_effects.conf
#endif

# Custom off-mode charger
#ifneq ($(WITH_CM_CHARGER),false)
#PRODUCT_PACKAGES += \
#    charger_res_images \
#    cm_charger_res_images \
#    font_log.png \
#    libhealthd.cm
#endif

# DU Utils library
#PRODUCT_BOOT_JARS += \
#    org.dirtyunicorns.utils

# DU Utils library
#PRODUCT_PACKAGES += \
#    org.dirtyunicorns.utils

#ifeq ($(DEFAULT_ROOT_METHOD),magisk)
# Magisk Manager
#PRODUCT_PACKAGES += \
#    MagiskManager

# Magisk
#PRODUCT_COPY_FILES += \
#   vendor/aosp/prebuilt/common/addon.d/magisk.zip:system/addon.d/magisk.zip
#endif

#ifeq ($(DEFAULT_ROOT_METHOD),supersu)
# SuperSU
#PRODUCT_COPY_FILES += \
#   vendor/aosp/prebuilt/common/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
#   vendor/aosp/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon
#endif

# Explict rootless defined, or none of the root methods defined,
# default rootless : nothing todo
#ifeq ($(DEFAULT_ROOT_METHOD),rootless)
#endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/aosp/overlay/common

# Bootanimation
$(call inherit-product, vendor/aosp/prebuilt/common/bootanimation/bootanimation.mk)

# Versioning System
# LegendROM first version.
PRODUCT_VERSION_MAJOR = 8.1
PRODUCT_VERSION_MINOR = Beta
PRODUCT_VERSION_MAINTENANCE = 1.0
LEGENDROM_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef LEGENDROM_BUILD_EXTRA
    LEGENDROM_POSTFIX := -$(LEGENDROM_BUILD_EXTRA)
endif

ifndef LEGENDROM_BUILD_TYPE
    LEGENDROM_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
LEGENDROM_VERSION := LegendROM-$(LEGENDROM_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(LEGENDROM_BUILD_TYPE)$(LEGENDROM_POSTFIX)
LEGENDROM_MOD_VERSION := LegendROM-$(LEGENDROM_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(LEGENDROM_BUILD_TYPE)$(LEGENDROM_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    legendrom.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.legendrom.version=$(LEGENDROM_VERSION) \
    ro.modversion=$(LEGENDROM_MOD_VERSION) \
    ro.legendrom.buildtype=$(LEGENDROM_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/aosp/tools/legendrom_process_props.py

