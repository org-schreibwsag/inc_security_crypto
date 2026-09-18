#!/bin/sh
echo "[*] Building with pkcs11_dynload."
echo "[*] pkcs11.h from @softhsm_source"
echo "[*] Path to pkcs11 module: /usr/lib/softhsm/libsofthsm2.so unless PKCS11_LIB_OVERRIDE sets something else."
echo "[*] SoftHSM setup done."
echo "[*] HSE token label: \"SoftHSM\""

bazel build //score/crypto/... //score/iav_primula/... //score/tests/... \
  --copt=-DALLOW_PKCS11_LIB_OVERRIDE \
  --define pkcs11_lib=/usr/lib/softhsm/libsofthsm2.so \
  --//score/crypto/src/backend:pkcs11_backend=//third_party/pkcs11_dynload:pkcs11_dynload_shared \
  $*
