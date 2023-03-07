
#REPO_NAME      ?= binutils-2.39.tar.xz
#REPO_ORG       ?= binutils-2.39
#REPO_TYPE      ?= tar
#REPO_URL       ?= https://ftp.gnu.org/gnu/binutils/$(REPO_NAME)

REPO_NAME      ?= binutils-gdb
REPO_BRANCH    ?= binutils-2_39
REPO_TYPE      ?= git
REPO_URL       ?= https://sourceware.org/git/$(REPO_NAME).git

SRC_NAME       ?= binutils
BUILD_NAME     ?= $(SRC_NAME)
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
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-binutils \
	  --enable-gas \
	  --enable-gdb \
	  --enable-gold \
	  --enable-gprof \
	  --enable-ld \
	  --enable-libdecnumber \
	  --enable-libreadline \
	  --enable-sim \
	  --disable-werror \
	  --with-expat=yes

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
