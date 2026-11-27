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
    libaudioaidlcommon.vendor \
    libaudioutils_shim

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

# Codec2 audio configuration and matching service seccomp policies.
PRODUCT_COPY_FILES += \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/codec2/media_codecs_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_audio.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/codec2/service/1.0/c2audio.vendor.base-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.base-arm64.policy \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/codec2/service/1.0/c2audio.vendor.ext-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.ext-arm64.policy

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

# Stock Mist WLAN firmware aliases.
PRODUCT_PACKAGES += mist_wlanmdsp_otaupdate_symlink mist_wcnss_config_symlink

# Firmware mount points
PRODUCT_PACKAGES += vendor_bt_firmware_mountpoint vendor_dsp_mountpoint vendor_firmware_mnt_mountpoint

PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/usb/etc
# Boot control and OTA
PRODUCT_PACKAGES += android.hardware.boot-service.qti android.hardware.boot-service.qti.recovery checkpoint_gc otapreopt_script
AB_OTA_POSTINSTALL_CONFIG += RUN_POSTINSTALL_system=true POSTINSTALL_PATH_system=system/bin/otapreopt_script FILESYSTEM_TYPE_system=ext4 POSTINSTALL_OPTIONAL_system=true
AB_OTA_POSTINSTALL_CONFIG += RUN_POSTINSTALL_vendor=true POSTINSTALL_PATH_vendor=bin/checkpoint_gc FILESYSTEM_TYPE_vendor=erofs POSTINSTALL_OPTIONAL_vendor=true

# Audio policy support files; retain Mist stock mixer and resource-manager files.
PRODUCT_COPY_FILES += \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/parrot/audio_effects_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects_config.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/parrot/card-defs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/card-defs.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/parrot/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/parrot/vendor_audio_interfaces.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vendor_audio_interfaces.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

$(call inherit-product, vendor/xiaomi/mist/mist-vendor.mk)

# Mist boot initialization
PRODUCT_PACKAGES += init.mist.rc init.mist.recovery.rc system_dlkm_modprobe.sh toolbox_vendor ueventd.mist.rc

# Mist touchscreen firmware in recovery ramdisk
PRODUCT_COPY_FILES += vendor/xiaomi/mist/proprietary/vendor/firmware/focaltech_ts_fw_sanxing.bin:recovery/root/lib/firmware/focaltech_ts_fw_sanxing.bin
PRODUCT_COPY_FILES += vendor/xiaomi/mist/proprietary/vendor/firmware/focaltech_ts_fw_sanxing1.bin:recovery/root/lib/firmware/focaltech_ts_fw_sanxing1.bin
PRODUCT_COPY_FILES += vendor/xiaomi/mist/proprietary/vendor/firmware/focaltech_ts_fw_sanxing2.bin:recovery/root/lib/firmware/focaltech_ts_fw_sanxing2.bin
PRODUCT_COPY_FILES += vendor/xiaomi/mist/proprietary/vendor/firmware/focaltech_ts_fw_sanxing3.bin:recovery/root/lib/firmware/focaltech_ts_fw_sanxing3.bin
PRODUCT_COPY_FILES += vendor/xiaomi/mist/proprietary/vendor/firmware/focaltech_ts_fw_sanxing4.bin:recovery/root/lib/firmware/focaltech_ts_fw_sanxing4.bin

# Hardware feature declarations (advanced capabilities require runtime validation).
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml

# Lineage charging control, matching the stock Xiaomi input_suspend node.
PRODUCT_PACKAGES += vendor.lineage.health-service.default
$(call soong_config_set_bool,lineage_health,charging_control_supports_bypass,false)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/qcom-battery/input_suspend)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)

# Phase 4C codec include closure
PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml
PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2.xml
PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml
PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml
PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml
PRODUCT_COPY_FILES += hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml
