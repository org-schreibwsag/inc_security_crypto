# *******************************************************************************
# Copyright (c) 2026 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
# *******************************************************************************

# ------------------------------------------------------------------------------
# Merge NXP pkcs11-unix.h with OASIS pkcs11.h from the archive.
# We rewrite the include inside pkcs11-unix.h so it includes pkcs11_base.h
# instead of pkcs11.h, avoiding recursive self-inclusion.
# ------------------------------------------------------------------------------

genrule(
    name = "merge_pkcs11_headers",
    srcs = [
        "@nxp_pkcs11_hse//:libpkcs/include/pkcs11-unix.h",
        "@nxp_pkcs11_hse//:libpkcs/redist/pkcs11.h",
        "@nxp_pkcs11_hse//:libpkcs/redist/pkcs11f.h",
        "@nxp_pkcs11_hse//:libpkcs/redist/pkcs11t.h",
    ],
    outs = [
        "include/pkcs11.h",
        "include/pkcs11_base.h",
        "include/pkcs11t.h",
        "include/pkcs11f.h",
    ],
    cmd = """
        mkdir -p $(RULEDIR)/include

        # Step 1: Copy OASIS pkcs11.h to pkcs11_base.h
        cp $(location @nxp_pkcs11_hse//:libpkcs/redist/pkcs11.h) \
           $(RULEDIR)/include/pkcs11_base.h

        # Step 2: Rewrite pkcs11-unix.h to include pkcs11_base.h
        sed 's/#include \"pkcs11.h\"/#include \"pkcs11_base.h\"/' \
            $(location @nxp_pkcs11_hse//:libpkcs/include/pkcs11-unix.h) \
            > $(RULEDIR)/include/pkcs11.h

        # Step 3: Append the original pkcs11.h content
        echo "" >> $(RULEDIR)/include/pkcs11.h
        cat $(RULEDIR)/include/pkcs11_base.h >> $(RULEDIR)/include/pkcs11.h

        # Step 4: Copy remaining headers unchanged
        cp $(location @nxp_pkcs11_hse//:libpkcs/redist/pkcs11t.h) \
           $(RULEDIR)/include/pkcs11t.h

        cp $(location @nxp_pkcs11_hse//:libpkcs/redist/pkcs11f.h) \
           $(RULEDIR)/include/pkcs11f.h
    """,
    visibility = ["//visibility:private"],
)

# ------------------------------------------------------------------------------
# Provide the merged PKCS#11 header set.
# ------------------------------------------------------------------------------
cc_library(
    name = "pkcs11_hse_header",
    hdrs = [":merge_pkcs11_headers"],
    includes = ["include"],
    visibility = ["//visibility:private"],
)
