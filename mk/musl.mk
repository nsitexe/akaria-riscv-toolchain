
REPO_NAME      ?= musl-1.2.3.tar.gz
REPO_ORG       ?= musl-1.2.3
REPO_TYPE      ?= tar
REPO_URL       ?= https://git.musl-libc.org/cgit/musl/snapshot/$(REPO_NAME)

#REPO_NAME      ?= musl
#REPO_BRANCH    ?= v1.2.3
#REPO_TYPE      ?= git
#REPO_URL       ?= https://git.musl-libc.org/git/$(REPO_NAME)

SRC_NAME       ?= musl
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
MLIBDIR_LIST ?= lib64 lib64 lib32 lib32

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	$(eval MLIBDIR = $(word $(1),$(MLIBDIR_LIST)))
	mkdir -p $(BUILD_PATH)_$(MARCH) && cd $(BUILD_PATH)_$(MARCH) && \
	$(SRC_PATH)/configure \
	  CFLAGS='-O2 -mcmodel=medany -march=$(MARCH) -mabi=$(MABI)' \
	  --host=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT)/usr \
	  --libdir=$(SYSROOT)/usr/$(MLIBDIR)/$(MABI) \
	  --syslibdir=$(SYSROOT)/lib \
	  --enable-shared
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST)))
	$(MAKE) -C $(BUILD_PATH)_$(MARCH) $(1)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	rm -rf $(BUILD_PATH)_$(MARCH)
endef


download-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	$(call configure_macro, 1)
	$(call configure_macro, 2)

build-body:
	$(call build_macro, all, 1)
	$(call build_macro, all, 2)

install-body:
	$(call build_macro, install, 1)
	$(call build_macro, install, 2)

clean-body:
	$(call build_macro, clean, 1)
	$(call build_macro, clean, 2)

distclean-body:
	$(call build_macro, distclean, 1)
	$(call build_macro, distclean, 2)

allclean-body:
	$(call allclean_macro, 1)
	$(call allclean_macro, 2)
