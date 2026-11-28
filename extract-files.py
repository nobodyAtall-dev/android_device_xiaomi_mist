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
        'vendor/lib64/hw/anc.hal.so': blob_fixup()
            .add_needed('libmist_ion_compat.so'),
        # Android 17 LLNDK stubs are unversioned; runtime exports were verified.
        'vendor/lib64/libarcsoft_beautyshot.so': blob_fixup()
            .clear_symbol_version('AHardwareBuffer_allocate')
            .clear_symbol_version('AHardwareBuffer_describe')
            .clear_symbol_version('AHardwareBuffer_lock')
            .clear_symbol_version('AHardwareBuffer_release')
            .clear_symbol_version('AHardwareBuffer_unlock'),
        'vendor/lib64/libMiPhotoFilter.so': blob_fixup()
            .clear_symbol_version('AHardwareBuffer_allocate')
            .clear_symbol_version('AHardwareBuffer_describe')
            .clear_symbol_version('AHardwareBuffer_isSupported')
            .clear_symbol_version('AHardwareBuffer_lockPlanes')
            .clear_symbol_version('AHardwareBuffer_release')
            .clear_symbol_version('AHardwareBuffer_unlock'),
        # Preserve stock implicit root UID explicitly for Android 17 init verification.
        'vendor/etc/init/qms.rc': blob_fixup()
            .regex_replace(r'(?m)^(service vendor\.qms[^\n]*\n[ \t]+class main\n)(?![ \t]+user[ \t])', r'\1     user root\n'),
        'vendor/etc/init/vendor.dpmd.rc': blob_fixup()
            .regex_replace(r'(?m)^(service vendor\.dpmd[^\n]*\n[ \t]+class late_start\n)(?![ \t]+user[ \t])', r'\1    user root\n'),
        'vendor/lib64/camera/components/com.qti.node.dewarp.so': blob_fixup()
            .remove_needed('android.hardware.graphics.allocator-V1-ndk.so'),
        'vendor/lib64/hw/com.qti.chi.override.so': blob_fixup()
            .remove_needed('android.hardware.graphics.allocator-V1-ndk.so'),
        'vendor/lib64/libcamximageformatutils.so': blob_fixup()
            .remove_needed('android.hardware.graphics.allocator-V1-ndk.so'),
        'vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so': blob_fixup()
            .remove_needed('android.hardware.graphics.allocator-V1-ndk.so')
            .remove_needed('android.hardware.camera.common-V2-ndk.so'),
        'vendor/lib64/libaodoptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libapengine.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libcamerapoweroptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libgamepoweroptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/liboffscreenpoweroptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libpsmoptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libqcodec2_core.so': blob_fixup()
            .replace_needed('android.hardware.graphics.common-V5-ndk.so', 'android.hardware.graphics.common-V7-ndk.so'),
        'vendor/lib64/libqcodec2_utils.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libqti-perfd.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libvideooptfeature.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libwfddisplayconfig_vendor.so': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libwfdmmsrc_proprietary.so': blob_fixup()
            .replace_needed('android.media.audio.common.types-V2-ndk.so', 'android.media.audio.common.types-V3-ndk.so'),
        'vendor/bin/qguard': blob_fixup()
            .replace_needed('vendor.qti.hardware.display.config-V5-ndk.so', 'vendor.qti.hardware.display.config-V12-ndk.so'),
        'vendor/lib64/libmifpext_fod.so': blob_fixup()
            .replace_needed('android.hardware.sensors-V2-ndk.so', 'android.hardware.sensors-V3-ndk.so'),
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
