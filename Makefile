
include config.mk

DPKG_DEB := dpkg-deb
MV := mv

PACKAGE_BASENAME := $(PACKAGE_NAME)_$(VERSION)_$(ARCHITECTURE)

all: $(PACKAGE_BASENAME).deb

DEB_INPUTS := \
	unbindgpu/DEBIAN/control \
	unbindgpu/DEBIAN/postinst \
	unbindgpu/DEBIAN/prerm \
	unbindgpu/lib/systemd/system/unbindgpu.service \
	unbindgpu/usr/local/bin/unbind_gpu

$(PACKAGE_BASENAME).deb: $(DEB_INPUTS)
	$(DPKG_DEB) --build unbindgpu
	$(MV) unbindgpu.deb $(PACKAGE_BASENAME).deb

unbindgpu/DEBIAN/control: config.mk Makefile
	@echo "Package: $(PACKAGE_NAME)" > $@
	@echo "Version: $(VERSION)" >> $@
	@echo "Section: utils" >> $@
	@echo "Priority: optional" >> $@
	@echo "Architecture: $(ARCHITECTURE)" >> $@
	@echo "Depends: $(DEPENDS)" >> $@
	@echo 'Maintainer: Doug Gale <doug16kpkg@gmail.com>' >> $@
	@echo "Description: $(DESCRIPTION)" >> $@

unbindgpu/DEBIAN/postinst: config.mk Makefile
	@echo "#!/bin/sh" > $@
	@echo "set -e" >> $@
	@echo "" >> $@
	@echo "# Enable the service" >> $@
	@echo "systemctl enable unbindgpu.service" >> $@

unbindgpu/DEBIAN/prerm: config.mk Makefile
	@echo "#!/bin/sh" > $@
	@echo "set -e" >> $@
	@echo "" >> $@
	@echo "# Disable the service" >> $@
	@echo "systemctl disable unbindgpu.service" >> $@

clean:
	rm $(PACKAGE_BASENAME).deb
