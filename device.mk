# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := device/xiaomi/mist
$(call inherit-product, hardware/qcom-caf/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_SHIPPING_API_LEVEL := 36
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 4096
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH) hardware/xiaomi
PRODUCT_PACKAGES += fstab.qcom fstab.qcom.vendor_ramdisk fastbootd update_engine update_engine_sideload update_verifier
$(call inherit-product, vendor/xiaomi/mist/mist-vendor.mk)
