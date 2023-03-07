
SUBMODULES = binutils gcc-stage1-newlib newlib gcc-stage2-newlib

include riscv64-common.mk


build: build-gcc-stage2-newlib

install: install-gcc-stage2-newlib


build-binutils:
	$(call make_macro, binutils, build)

build-gcc-stage1-newlib: install-binutils
	$(call make_macro, gcc-stage1-newlib, build)

build-newlib: install-gcc-stage1-newlib
	$(call make_macro, newlib, build)

build-gcc-stage2-newlib: install-newlib
	$(call make_macro, gcc-stage2-newlib, build)


install-binutils: build-binutils
	$(call make_macro, binutils, install)

install-gcc-stage1-newlib: build-gcc-stage1-newlib
	$(call make_macro, gcc-stage1-newlib, install)

install-newlib: build-newlib
	$(call make_macro, newlib, install)

install-gcc-stage2-newlib: build-gcc-stage2-newlib
	$(call make_macro, gcc-stage2-newlib, install)
