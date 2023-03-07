
# Check environments

ifeq ($(CROSS_ARCH), )
  $(error "CROSS_ARCH is empty.")
endif
ifeq ($(CROSS_ROOT), )
  $(error "CROSS_ROOT is empty.")
endif


define make_macro
	$(eval MAKEFILE = $(1))
	$(eval TARGET   = $(2))

	$(MAKE) -f $(MAKEFILE).mk -C $(TOP_DIR)/mk $(TARGET)
endef


all: build

download extract clean distclean allclean:
	for i in $(SUBMODULES) ; \
	do \
		$(MAKE) -f $${i}.mk -C $(TOP_DIR)/mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done


.PHONY: all download extract build install clean distclean allclean
	build-linux-headers \
	build-binutils \
	build-gcc-stage1-glibc \
	build-gcc-stage1-musl \
	build-glibc \
	build-musl \
	build-gcc-stage2-glibc \
	build-gcc-stage2-musl \
	install-linux-headers \
	install-binutils \
	install-gcc-stage1-glibc \
	install-gcc-stage1-musl \
	install-glibc \
	install-musl \
	install-gcc-stage2-glibc \
	install-gcc-stage2-musl
