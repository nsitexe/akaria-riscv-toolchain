
#REPO_NAME      ?= glibc-2.36.tar.xz
#REPO_ORG       ?= glibc-2.36
#REPO_TYPE      ?= tar
#REPO_URL       ?= https://ftp.gnu.org/gnu/glibc/$(REPO_NAME)

REPO_NAME      ?= glibc
REPO_BRANCH    ?= glibc-2.36
REPO_TYPE      ?= git
REPO_URL       ?= https://sourceware.org/git/$(REPO_NAME).git

SRC_NAME       ?= glibc
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

MARCH_LIST   ?= rv64gc rv64imac rv32gc rv32imac
MABI_LIST    ?= lp64d lp64 ilp32d ilp32

#MARCH_EXT    ?= _zicsr_zifencei
MARCH_EXT    ?=

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	mkdir -p $(BUILD_PATH)_$(MARCH) && cd $(BUILD_PATH)_$(MARCH) && \
	$(SRC_PATH)/configure \
	  CC="$(CROSS_ARCH)-gcc -march=$(MARCH) -mabi=$(MABI)" \
	  CFLAGS="-O2 $(ARCH_CFLAGS_FOR_TARGET)" \
	  --host=$(CROSS_ARCH) \
	  --prefix=/usr \
	  --disable-multilib \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST))$(MARCH_EXT))
	$(MAKE) -C $(BUILD_PATH)_$(MARCH) $(1) \
	  LINKS_DSO_PROGRAM=
endef

define install_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
	$(MAKE) -C $(BUILD_PATH)_$(MARCH) install \
	  LINKS_DSO_PROGRAM= \
	  install_root=$(SYSROOT)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
	rm -rf $(BUILD_PATH)_$(MARCH)
endef

download-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	$(call configure_macro, 1)
	$(call configure_macro, 2)
	$(call configure_macro, 3)
	$(call configure_macro, 4)

build-body:
	$(call build_macro, all, 1)
	$(call build_macro, all, 2)
	$(call build_macro, all, 3)
	$(call build_macro, all, 4)

install-body:
	$(call install_macro, 1)
	$(call install_macro, 2)
	$(call install_macro, 3)
	$(call install_macro, 4)

clean-body:
	$(call build_macro, clean, 1)
	$(call build_macro, clean, 2)
	$(call build_macro, clean, 3)
	$(call build_macro, clean, 4)

distclean-body:
	$(call build_macro, distclean, 1)
	$(call build_macro, distclean, 2)
	$(call build_macro, distclean, 3)
	$(call build_macro, distclean, 4)

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
	$(call allclean_macro, 1)
	$(call allclean_macro, 2)
	$(call allclean_macro, 3)
	$(call allclean_macro, 4)
