#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
from extract_utils.fixups_lib import lib_fixups
from extract_utils.main import ExtractUtils, ExtractUtilsModule

def lib_fixup_vendor_suffix(lib, partition, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

module = ExtractUtilsModule(
    'mist', 'xiaomi',
    namespace_imports=[
        'device/xiaomi/mist', 'hardware/xiaomi',
        'hardware/qcom-caf/sm8450-6.6', 'hardware/qcom-caf/wlan',
        'vendor/qcom/opensource/commonsys-intf/display',
        'vendor/qcom/opensource/commonsys/display',
        'vendor/qcom/opensource/dataservices',
    ],
    lib_fixups={
        **lib_fixups,
        (
            'vendor.qti.ImsRtpService-V1-ndk',
            'vendor.qti.diaghal-V1-ndk',
            'vendor.qti.hardware.dpmaidlservice-V1-ndk',
            'vendor.qti.hardware.wifidisplaysession_aidl-V1-ndk',
            'vendor.qti.qccsyshal_aidl-V1-ndk',
            'vendor.qti.qccvndhal_aidl-V1-ndk',
        ): lib_fixup_vendor_suffix,
    },
)
if __name__ == '__main__':
    ExtractUtils.device(module).run()
