
#REPO_NAME      ?= linux-5.10.170.tar.xz
#REPO_ORG       ?= linux-5.10.170
#REPO_TYPE      ?= tar
#REPO_URL       ?= https://cdn.kernel.org/pub/linux/kernel/v5.x/$(REPO_NAME)

REPO_NAME      ?= linux
REPO_BRANCH    ?= v5.10
REPO_TYPE      ?= git
REPO_URL       ?= https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/$(REPO_NAME).git

SRC_NAME       ?= linux
BUILD_NAME     ?= $(SRC_NAME)-headers
BUILDER_NAME   ?= $(BUILD_NAME).mk

### Override
CONFIGURE_PATH ?= $(SRC_PATH)/Makefile
MAKEFILE_PATH  ?= $(SRC_PATH)/.config
BINARY_PATH    ?= FORCE

include common.mk

LINUX_CROSS_ARCH ?= $(LINUX_ARCH)

# Define body targets.

download-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	$(MAKE) -C $(SRC_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) defconfig

build-body:
	#$(MAKE) -C $(SRC_PATH) \
	#  ARCH=$(LINUX_CROSS_ARCH) headers_check

install-body:
	$(MAKE) -C $(SRC_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  INSTALL_HDR_PATH=$(SYSROOT)/usr \
	  headers_install

clean-body:
	$(MAKE) -C $(SRC_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  clean

distclean-body:
	$(MAKE) -C $(SRC_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  distclean

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
