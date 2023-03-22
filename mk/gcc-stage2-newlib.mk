
REPO_NAME      ?= riscv-gcc
REPO_BRANCH    ?= bb25a476796046c03dacbd4e4b4477765c5541b1
REPO_TYPE      ?= git
REPO_URL       ?= https://github.com/riscv-collab/$(REPO_NAME).git

SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-stage2-newlib
BUILDER_NAME   ?= $(BUILD_NAME).mk
CONFIGURE_NAME ?= configure
MAKEFILE_NAME  ?= Makefile

# Override
BINARY_PATH    ?= FORCE

include common.mk

# Define body targets.

download-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  CFLAGS="-O2 $(ARCH_CFLAGS)" \
	  CXXFLAGS="-O2 $(ARCH_CFLAGS)" \
	  CFLAGS_FOR_TARGET="-O2 $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-O2 $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-checking=yes \
	  --enable-languages=c,c++,fortran \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libsanitizer \
	  --disable-libssp \
	  --enable-libstdcxx-pch \
	  --enable-long-long \
	  --enable-lto \
	  --disable-multiarch \
	  --enable-multilib \
	  --enable-nls \
	  --enable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --enable-tls \
	  --disable-werror \
	  --enable-__cxa_atexit \
	  --with-native-system-header-dir=/include \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
