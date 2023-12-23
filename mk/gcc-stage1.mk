
REPO_NAME      ?= riscv-gcc
REPO_BRANCH    ?= bb25a476796046c03dacbd4e4b4477765c5541b1
REPO_TYPE      ?= git
REPO_URL       ?= https://github.com/riscv-collab/$(REPO_NAME).git

SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-stage1
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

$(SRC_PATH)/mpc:
	cd $(SRC_PATH) && ./contrib/download_prerequisites

configure-body: $(SRC_PATH)/mpc
	cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  CFLAGS="-O2 $(ARCH_CFLAGS)" \
	  CXXFLAGS="-O2 $(ARCH_CFLAGS)" \
	  CFLAGS_FOR_TARGET="-O2 $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-O2 $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-languages=c \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libsanitizer \
	  --disable-libssp \
	  --disable-libstdcxx-pch \
	  --enable-long-long \
	  --enable-lto \
	  --disable-multiarch \
	  --enable-multilib \
	  --disable-nls \
	  --disable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --enable-tls \
	  --enable-__cxa_atexit \
	  --without-headers \
	  --with-local-prefix=$(SYSROOT) \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -C $(BUILD_PATH) all-gcc
	$(MAKE) -C $(BUILD_PATH) all-target-libgcc

install-body:
	$(MAKE) -C $(BUILD_PATH) install-gcc
	$(MAKE) -C $(BUILD_PATH) install-target-libgcc

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
