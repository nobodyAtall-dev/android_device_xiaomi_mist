#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
from extract_utils.fixups_blob import blob_fixup
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
    blob_fixups={
        # These legacy memory services reference scripts absent in Mist stock.
        'vendor/etc/init/hw/init.qti.kernel.rc': blob_fixup()
            .regex_replace(r'(?m)^service memory-(?:init|post)-boot[^\n]*\n(?:[ \t]+[^\n]*\n)*', '')
            .regex_replace(r'(?m)^[ \t]+start memory-(?:init|post)-boot\n', ''),
        'vendor/lib64/android.hardware.bluetooth.audio-impl_prebuilt.so': blob_fixup()
            .replace_needed('libbluetooth_audio_session_aidl.so', 'libbluetooth_audio_session_aidl_prebuilt.so'),
        'vendor/lib64/libaudioserviceexampleimpl.so': blob_fixup()
            .replace_needed('android.hardware.bluetooth.audio-impl.so', 'android.hardware.bluetooth.audio-impl_prebuilt.so')
            .replace_needed('libaudio_aidl_conversion_common_ndk.so', 'libaudio_aidl_conversion_common_ndk_prebuilt.so')
            .replace_needed('libbluetooth_audio_session_aidl.so', 'libbluetooth_audio_session_aidl_prebuilt.so'),
        'vendor/etc/init/fingerprint-odm.rc': blob_fixup()
            .regex_replace(r'IFingerprint/virtual', 'IFingerprint/default'),
    },
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
