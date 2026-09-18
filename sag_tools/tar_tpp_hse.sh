#!/bin/sh
tar czf tpp_dynload.tar.gz ./bazel-bin/score/crypto/src/daemon/provider/tests/provider_test/test_pkcs11_provider \
  ./bazel-bin/score/crypto/src/daemon/provider/tests/provider_test/test_pkcs11_provider-0.params ./bazel-bin/score/crypto/src/daemon/provider/tests/provider_test/test_pkcs11_provider.repo_mapping ./bazel-bin/score/crypto/src/daemon/provider/tests/provider_test/test_pkcs11_provider.runfiles ./bazel-bin/score/crypto/src/daemon/provider/tests/provider_test/test_pkcs11_provider.runfiles_manifest score --dereference
