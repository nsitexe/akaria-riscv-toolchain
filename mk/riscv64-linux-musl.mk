
SUBMODULES = linux-headers binutils gcc-stage1-musl musl gcc-stage2-musl

include riscv64-common.mk


build: build-gcc-stage2-musl

install: install-gcc-stage2-musl


build-linux-headers:
	$(call make_macro, linux-headers, build)

build-binutils:
	$(call make_macro, binutils, build)

build-gcc-stage1-musl: install-binutils
	$(call make_macro, gcc-stage1-musl, build)

build-musl: install-linux-headers install-gcc-stage1-musl
	$(call make_macro, musl, build)

build-gcc-stage2-musl: install-musl
	$(call make_macro, gcc-stage2-musl, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers, install)

install-binutils: build-binutils
	$(call make_macro, binutils, install)

install-gcc-stage1-musl: build-gcc-stage1-musl
	$(call make_macro, gcc-stage1-musl, install)

install-musl: build-musl
	$(call make_macro, musl, install)

install-gcc-stage2-musl: build-gcc-stage2-musl
	$(call make_macro, gcc-stage2-musl, install)
