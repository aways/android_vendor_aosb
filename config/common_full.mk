# Inherit common AOSB stuff
$(call inherit-product, vendor/aosb/config/common.mk)

# Bring in all video files
$(call inherit-product, frameworks/base/data/videos/VideoPackage2.mk)

# Include AOSB audio files
include vendor/aosb/config/aosb_audio.mk

# Include AOSB LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/aosb/overlay/dictionaries

# Optional AOSB packages
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers \
    PhotoTable \
    VoiceDialer \
    SoundRecorder

PRODUCT_PACKAGES += \
    VideoEditor \
    libvideoeditor_jni \
    libvideoeditor_core \
    libvideoeditor_osal \
    libvideoeditor_videofilters \
    libvideoeditorplayer

# Extra tools in AOSB
PRODUCT_PACKAGES += \
    vim
