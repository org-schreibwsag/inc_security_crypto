#!/bin/sh
echo "[*] Building with pkcs11_dynload for aarch64-linux."
echo "[*] pkcs11.h from //third_party/pkcs11_hse:pkcs11_hse_header"
echo "[*] Path to pkcs11 module: /usr/lib/libpkcs-hse.so.1 unless PKCS11_LIB_OVERRIDE sets something else."
echo "[*] SoftHSM setup skipped."
echo "[*] HSE token label: \"NXP-HSE-Token\""

bazel build //score/crypto/src/daemon/provider/tests/provider_test/... \
  --copt=-DALLOW_PKCS11_LIB_OVERRIDE \
  --define pkcs11_lib=/usr/lib/libpkcs-hse.so.1 \
  --copt=-DNO_SOFTHSM_SETUP --copt=-DTOKEN_HSE  \
  --//score/crypto/src/backend:pkcs11_backend=//third_party/pkcs11_dynload:pkcs11_dynload_shared \
  --//third_party/pkcs11_dynload:pkcs11_header_source=//third_party/pkcs11_hse:pkcs11_hse_header \
  --config=aarch64-linux $*
