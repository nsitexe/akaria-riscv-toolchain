
# Check environments

PWD := $(shell pwd)

define make_macro
	$(eval CROSS    = $(1))
	$(eval MAKEFILE = $(2))
	$(eval TARGET   = $(3))

	PATH=$(PWD)/$(CROSS)/bin:$(PATH) \
	ARCH_CFLAGS_FOR_TARGET=-mcmodel=medany \
	ARCH_CXXFLAGS_FOR_TARGET=-mcmodel=medany \
	CROSS_ARCH=$(CROSS) \
	CROSS_ROOT=$(PWD)/$(CROSS) \
	TOP_DIR=$(PWD) \
	LINUX_ARCH=riscv \
	$(MAKE) -f $(MAKEFILE) -C $(PWD)/mk $(TARGET)
endef

all: install

extract clean distclean allclean:
	$(call make_macro, riscv64-unknown-elf, riscv64-newlib.mk, $@)
	$(call make_macro, riscv64-unknown-linux-gnu, riscv64-linux-glibc.mk, $@)
	$(call make_macro, riscv64-unknown-linux-musl, riscv64-linux-musl.mk, $@)

build install: extract
	$(call make_macro, riscv64-unknown-elf, riscv64-newlib.mk, $@)
	$(call make_macro, riscv64-unknown-linux-gnu, riscv64-linux-glibc.mk, $@)
	$(call make_macro, riscv64-unknown-linux-musl, riscv64-linux-musl.mk, $@)


.PHONY: all download extract build install clean distclean allclean
