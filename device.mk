# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := device/xiaomi/mist
$(call inherit-product, hardware/qcom-caf/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
PRODUCT_USE_DYNAMIC_PARTITIONS := true
# Mist ODM stock first_api_level is 36; vendor platform first_api_level is 35.
PRODUCT_SHIPPING_API_LEVEL := 36
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 4096
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH) hardware/xiaomi
PRODUCT_PACKAGES += fstab.qcom fstab.qcom.vendor_ramdisk fastbootd update_engine update_engine_sideload update_verifier
# Effect chains distort the software A2DP output
TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default \
    audioadsprpcd \
    audiohalservice.qti \
    libagm_compress_plugin \
    libagm_mixer_plugin \
    libagm_pcm_plugin \
    libagmipcservice \
    libaudiochargerlistener \
    libbatterylistener \
    libfmpal \
    libhfp_pal \
    libmediautils_vendor.vendor \
    libmemunreachable.vendor \
    libpalipcservice \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndcardparser \
    libsoundtriggerhal.qti \
    libvolumelistener \
    qtiaudiohalvendorextn

PRODUCT_PACKAGES += \
    libalsautilsv2.vendor \
    libbundleaidl \
    libdownmixaidl \
    libdynamicsprocessingaidl \
    libloudnessenhanceraidl \
    libreverbaidl \
    libvisualizeraidl

PRODUCT_PACKAGES += \
    android.hardware.audio.common-V1-ndk.vendor \
    android.hardware.audio.core-V2-ndk.vendor \
    android.hardware.audio.core.sounddose-V1-ndk.vendor \
    libalsautilsv2.vendor \
    libaudioaidlcommon.vendor \
    libaudioutils_shim \
    libmediautils_vendor.vendor \
    libmemunreachable.vendor

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl \
    lib_bt_aptx \
    lib_bt_ble \
    lib_bt_bundle

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    libfilefinder \
    mapper.qti \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.demura-service \
    vendor.qti.hardware.display.snapalloc-impl

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# HWUI
TARGET_USES_VULKAN := true

# Memtrack
PRODUCT_PACKAGES += \
    vendor.qti.hardware.memtrack-service

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal \
    sensors.dynamic_sensor_hal

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti-telephony-utils-prd \
    qti_telephony_utils.xml \
    qti_telephony_utils_prd.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Vibrator
$(call soong_config_set,qti_vibrator,libpalclient_namespace,hardware/qcom-caf/sm8450-6.6)
$(call soong_config_set_bool,qti_vibrator,use_libpalclient,true)

PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwifi-hal-ctrl \
    libwifi-hal-qcom \
    wpa_supplicant \
    wpa_supplicant.conf

# Firmware mount points
PRODUCT_PACKAGES += vendor_bt_firmware_mountpoint vendor_dsp_mountpoint vendor_firmware_mnt_mountpoint

PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/usb/etc
$(call inherit-product, vendor/xiaomi/mist/mist-vendor.mk)
