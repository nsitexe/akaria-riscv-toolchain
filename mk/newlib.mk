
REPO_NAME      ?= newlib-4.1.0.tar.gz
REPO_ORG       ?= newlib-4.1.0
REPO_TYPE      ?= tar
REPO_URL       ?= https://sourceware.org/pub/newlib/$(REPO_NAME)

#REPO_NAME      ?= newlib-cygwin
#REPO_BRANCH    ?= newlib-4.1.0
#REPO_TYPE      ?= git
#REPO_URL       ?= https://sourceware.org/git/$(REPO_NAME).git

SRC_NAME       ?= newlib
BUILD_NAME     ?= $(SRC_NAME)
BUILDER_NAME   ?= $(BUILD_NAME).mk
CONFIGURE_NAME ?= configure
MAKEFILE_NAME  ?= Makefile

# Override
BINARY_PATH    ?= FORCE

include common.mk

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

download-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  CFLAGS_FOR_TARGET="-O2 $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-O2 $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-newlib-io-long-double \
	  --enable-newlib-io-long-long \
	  --enable-newlib-io-c99-formats

build-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	$(MAKE) -C $(BUILD_PATH) install

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
