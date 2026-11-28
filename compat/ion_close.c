// SPDX-License-Identifier: Apache-2.0
#include <errno.h>
#include <unistd.h>

// Preserve the legacy libion close contract without enabling obsolete ION allocation.
int ion_close(int fd) {
    int ret = close(fd);
    return ret < 0 ? -errno : ret;
}
