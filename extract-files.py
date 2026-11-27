#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
# SPDX-License-Identifier: Apache-2.0
from extract_utils.main import ExtractUtils, ExtractUtilsModule

module = ExtractUtilsModule(
    'mist', 'xiaomi',
    namespace_imports=['device/xiaomi/mist', 'hardware/xiaomi',
                       'hardware/qcom-caf/sm8450-6.6', 'hardware/qcom-caf/wlan'],
)
if __name__ == '__main__':
    ExtractUtils.device(module).run()
