TERMUX_PKG_HOMEPAGE=https://myrepos.branchable.com/
TERMUX_PKG_DESCRIPTION="Tool to manage all your version control repos"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=1.20180726
TERMUX_PKG_SRCURL=https://deb.debian.org/debian/pool/main/m/myrepos/myrepos_$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=9e9e4c114aae22e0aac51ecbc8d84ae617a5e5dfa979fab0d3bc42945f603f1e
TERMUX_PKG_DEPENDS="git, perl"
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
