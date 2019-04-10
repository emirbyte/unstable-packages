TERMUX_PKG_HOMEPAGE=https://www.qemu.org
TERMUX_PKG_DESCRIPTION="A set common files for the QEMU emulators"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=3.1.0
TERMUX_PKG_REVISION=8
TERMUX_PKG_SRCURL=https://download.qemu.org/qemu-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=6a0508df079a0a33c2487ca936a56c12122f105b8a96a44374704bef6c69abfc
TERMUX_PKG_DEPENDS="capstone, glib, libandroid-shmem, libc++, libcap, libgnutls, libnettle"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	local ENABLED_TARGETS

	# System emulators.
	ENABLED_TARGETS+="aarch64-softmmu,"
	ENABLED_TARGETS+="arm-softmmu,"
	ENABLED_TARGETS+="i386-softmmu,"
	ENABLED_TARGETS+="riscv32-softmmu,"
	ENABLED_TARGETS+="riscv64-softmmu,"
	ENABLED_TARGETS+="x86_64-softmmu,"

	# Usermode emulators.
	ENABLED_TARGETS+="aarch64-linux-user,"
	ENABLED_TARGETS+="arm-linux-user,"
	ENABLED_TARGETS+="i386-linux-user,"
	ENABLED_TARGETS+="riscv32-linux-user,"
	ENABLED_TARGETS+="riscv64-linux-user,"
	ENABLED_TARGETS+="x86_64-linux-user"

	# Force-link with liblog and libandroid-shmem.
	LDFLAGS+=" -landroid-shmem -llog"

	./configure \
		--prefix="$TERMUX_PREFIX" \
		--host-cc="gcc" \
		--cross-prefix="${CC//clang}" \
		--cc="$CC" \
		--cxx="$CXX" \
		--objcc="$CC" \
		--extra-cflags="$CFLAGS" \
		--extra-cxxflags="$CXXFLAGS" \
		--extra-ldflags="$LDFLAGS" \
		--enable-pie \
		--target-list="$ENABLED_TARGETS" \
		--interp-prefix="$TERMUX_PREFIX/gnemul" \
		--smbd="$TERMUX_PREFIX/bin/smbd" \
		--enable-tools \
		--disable-guest-agent \
		--enable-capstone \
		--enable-coroutine-pool \
		--disable-avx2 \
		--disable-jemalloc \
		--disable-tcmalloc \
		--disable-membarrier \
		--disable-seccomp \
		--disable-linux-aio \
		--disable-numa \
		--disable-brlapi \
		--disable-bluez \
		--disable-netmap \
		--disable-usb-redir \
		--disable-vde \
		--disable-vhost-crypto \
		--disable-vhost-net \
		--disable-vhost-user \
		--disable-vhost-vsock \
		--disable-hax \
		--disable-hvf \
		--disable-kvm \
		--disable-whpx \
		--disable-xen \
		--disable-virglrenderer \
		--enable-curses \
		--disable-gtk \
		--disable-opengl \
		--disable-sdl \
		--disable-vte \
		--enable-vnc \
		--enable-vnc-jpeg \
		--enable-vnc-png \
		--enable-vnc-sasl \
		--disable-spice \
		--disable-crypto-afalg \
		--enable-gnutls \
		--enable-nettle \
		--disable-gcrypt \
		--enable-curl \
		--enable-libnfs \
		--enable-libssh2 \
		--enable-bzip2 \
		--enable-lzo \
		--disable-snappy \
		--disable-glusterfs \
		--disable-libiscsi \
		--disable-libusb \
		--disable-mpath \
		--disable-rbd \
		--enable-virtfs \
		--disable-xfsctl \
		--disable-libpmem \
		--enable-bochs \
		--enable-cloop \
		--enable-dmg \
		--enable-parallels \
		--enable-qcow1 \
		--enable-qed \
		--enable-sheepdog \
		--enable-vdi \
		--enable-vvfat \
		--disable-vxhs \
		--enable-fdt \
		--enable-tpm \
		--disable-smartcard \
		--enable-attr \
		--disable-cap-ng \
		--enable-libxml2
}

termux_step_post_make_install() {
	for i in aarch64 arm i386 riscv32 riscv64 x86_64; do
		ln -sfr \
			"${TERMUX_PREFIX}"/share/man/man1/qemu.1 \
			"${TERMUX_PREFIX}"/share/man/man1/qemu-system-${i}.1
	done
	unset i
}
