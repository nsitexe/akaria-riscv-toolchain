
SUBMODULES = linux-headers binutils gcc-stage1-glibc glibc gcc-stage2-glibc

include riscv64-common.mk


build: build-gcc-stage2-glibc

install: install-gcc-stage2-glibc


build-linux-headers:
	$(call make_macro, linux-headers, build)

build-binutils:
	$(call make_macro, binutils, build)

build-gcc-stage1-glibc: install-binutils
	$(call make_macro, gcc-stage1-glibc, build)

build-glibc: install-linux-headers install-gcc-stage1-glibc
	$(call make_macro, glibc, build)

build-gcc-stage2-glibc: install-glibc
	$(call make_macro, gcc-stage2-glibc, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers, install)

install-binutils: build-binutils
	$(call make_macro, binutils, install)

install-gcc-stage1-glibc: build-gcc-stage1-glibc
	$(call make_macro, gcc-stage1-glibc, install)

install-glibc: build-glibc
	$(call make_macro, glibc, install)

install-gcc-stage2-glibc: build-gcc-stage2-glibc
	$(call make_macro, gcc-stage2-glibc, install)
