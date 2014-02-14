PRODUCT_BRAND ?= aosb

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

## ProBAM boot animation
PRODUCT_COPY_FILES +=  \
    vendor/aosb/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/aosb/CHANGELOG.mkdn:system/etc/CHANGELOG-AOSB.txt

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/aosb/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/aosb/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/aosb/prebuilt/common/bin/50-aosb.sh:system/addon.d/50-aosb.sh \
    vendor/aosb/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# Screen recorder
PRODUCT_PACKAGES += \
    ScreenRecorder \
    libscreenrecorder

# init.d support
PRODUCT_COPY_FILES += \
    vendor/aosb/prebuilt/common/bin/sysinit:system/bin/sysinit

# Set Selinux Permissive 
# Configurable init.d
# PropModder files
# userinit support
# SELinux filesystem labels
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/aosb/prebuilt/common/etc/init.d,system/etc/init.d)

PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/aosb/prebuilt/common/etc/cron,system/etc/cron)

# Configurable
PRODUCT_COPY_FILES += \
    vendor/aosb/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/aosb/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg \
    vendor/aosb/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/aosb/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/aosb/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/aosb/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is AOSB!
PRODUCT_COPY_FILES += \
    vendor/aosb/config/permissions/com.aosb.android.xml:system/etc/permissions/com.aosb.android.xml

# T-Mobile theme engine
include vendor/aosb/config/themes_common.mk

# Required AOSB packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    BluetoothExt

# Optional AOSB packages
PRODUCT_PACKAGES += \
    VoicePlus \
    Basic \
    libemoji

# Custom AOSB packages
    #Trebuchet \

PRODUCT_PACKAGES += \
    Launcher3 \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf \
    CMWallpapers \
    Apollo \
    CMFileManager \
    LockClock \
    CMFota \
    WhisperPush

# AOSB Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Extra tools in AOSB
PRODUCT_PACKAGES += \
    libsepol \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    procmem \
    procrank \
    ProBamStats \
    OmniSwitch

PRODUCT_COPY_FILES += \
    vendor/aosb/prebuilt/common/su/su:system/xbin/su \
    vendor/aosb/prebuilt/common/su/daemonsu:system/xbin/daemonsu \
    vendor/aosb/prebuilt/common/su/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon \
    vendor/aosb/prebuilt/common/su/install-recovery.sh:system/etc/install-recovery.sh \
    vendor/aosb/prebuilt/common/su/Superuser.apk:system/app/Superuser.apk \
    vendor/aosb/prebuilt/common/su/.installed_su_daemon:system/etc/.installed_su_daemon

############### Add PROBAM GAPPS

# copy gapps
#PRODUCT_COPY_FILES += \
#	$(call find-copy-subdir-files,*,vendor/aosb/prebuilt/common/gapps,system)

############### Add PROBAM GAPPS

# ProBAM Updater and Xposed
PRODUCT_COPY_FILES +=  \
    vendor/aosb/proprietary/appsetting.apk:system/app/appsetting.apk \
    vendor/aosb/proprietary/xposed_installer.apk:system/app/xposed_installer.apk \
    vendor/aosb/proprietary/AosbOTA.apk:system/app/AosbOTA.apk


# Terminal Emulator
PRODUCT_COPY_FILES +=  \
    vendor/aosb/proprietary/Term.apk:system/app/Term.apk \
    vendor/aosb/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1
else

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

endif

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/aosb/overlay/common

PRODUCT_VERSION_MAJOR = 11
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-RC0

# Set AOSB_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef AOSB_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "AOSB_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^AOSB_||g')
        AOSB_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(AOSB_BUILDTYPE)),)
    AOSB_BUILDTYPE :=
endif

ifdef AOSB_BUILDTYPE
    ifneq ($(AOSB_BUILDTYPE), SNAPSHOT)
        ifdef AOSB_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            AOSB_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from AOSB_EXTRAVERSION
            AOSB_EXTRAVERSION := $(shell echo $(AOSB_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to AOSB_EXTRAVERSION
            AOSB_EXTRAVERSION := -$(AOSB_EXTRAVERSION)
        endif
    else
        ifndef AOSB_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            AOSB_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from AOSB_EXTRAVERSION
            AOSB_EXTRAVERSION := $(shell echo $(AOSB_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to AOSB_EXTRAVERSION
            AOSB_EXTRAVERSION := -$(AOSB_EXTRAVERSION)
        endif
    endif
else
    # If AOSB_BUILDTYPE is not defined, set to UNOFFICIAL
    AOSB_BUILDTYPE := UNOFFICIAL
    AOSB_EXTRAVERSION :=
endif

ifeq ($(AOSB_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        AOSB_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(AOSB_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        AOSB_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(AOSB_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            AOSB_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(AOSB_BUILD)
        else
            AOSB_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(AOSB_BUILD)
        endif
    endif
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        AOSB_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(AOSB_BUILDTYPE)$(AOSB_EXTRAVERSION)-$(AOSB_BUILD)
    else
        AOSB_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(AOSB_BUILDTYPE)$(AOSB_EXTRAVERSION)-$(AOSB_BUILD)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.aosb.version=$(AOSB_VERSION) \
  ro.modversion=$(AOSB_VERSION)

# Add AOSB version
AOSB_VERSION_MAJOR = 1.2.9
AOSB_VERSION_MINOR = stable
AOSB_GOO_VERSION = 129
VERSION := $(AOSB_VERSION_MAJOR)_$(AOSB_VERSION_MINOR)
AOSB_VERSION := $(VERSION)_$(shell date +%Y%m%d-%H%M%S)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.developerid=probam \
    ro.goo.rom=probam \
    ro.goo.version=$(AOSB_GOO_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.probamstats.url=http://stats.codexc.com \
    ro.probamstats.name=ProBam \
    ro.probamstats.version=$(AOSB_VERSION_MAJOR) \
    ro.probamstats.tframe=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.aosb.version=$(AOSB_VERSION_MAJOR) \
    ro.aosb.version=AOSB_$(AOSB_VERSION)

-include vendor/cm-priv/keys/keys.mk

AOSB_DISPLAY_VERSION := $(AOSB_VERSION)

ifneq ($(DEFAULT_SYSTEM_DEV_CERTIFICATE),)
ifneq ($(DEFAULT_SYSTEM_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(AOSB_BUILDTYPE), UNOFFICIAL)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(AOSB_EXTRAVERSION),)
        TARGET_VENDOR_RELEASE_BUILD_ID := $(AOSB_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := -$(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := -$(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    AOSB_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)$(TARGET_VENDOR_RELEASE_BUILD_ID)
  endif
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.aosb.display.version=$(AOSB_DISPLAY_VERSION)

-include $(WORKSPACE)/hudson/image-auto-bits.mk

-include vendor/cyngn/product.mk

