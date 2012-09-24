# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils systemd

DESCRIPTION="Daemon for implementation of Delay Tolerant Networks by IBR"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/"
SRC_URI="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl dtnsec +libdaemon lowpan sqlite systemd tls zlib"
DEPEND="=net-misc/ibrcommon-${PV}[lowpan=]
	=net-misc/ibrdtn-${PV} \
	libdaemon? ( dev-libs/libdaemon ) \
	curl? ( net-misc/curl ) \
	lowpan? ( dev-libs/libnl:1.1 ) \
	sqlite? ( dev-db/sqlite ) \
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

pkg_setup() {
	enewgroup dtnd
	enewuser dtnd -1 -1 /var/spool/ibrdtn dtnd
}

src_prepare() {
	epatch "${FILESDIR}/ibrdtn.conf-${PV}.patch"
}

src_configure() {
	econf \
		$( use_with curl ) \
		$( use_with dtnsec ) \
		$( use_with lowpan ) \
		$( use_with sqlite ) \
		$( use_with tls ) \
		$( use_with zlib compression ) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# Extra doc:
	insinto /usr/share/doc/${PN}/
	doins COPYING
	# init script:
	if use libdaemon; then
		newinitd "${FILESDIR}/dtnd.initd" dtnd
		newconfd "${FILESDIR}/dtnd.confd" dtnd
	fi
	# systemd unit:
	if use systemd; then
		systemd_dounit "${FILESDIR}/dtnd.service"
	fi
	# Storage directory:
	diropts -m 0750 -g dtnd -o dtnd
	keepdir /var/spool/ibrdtn
	# Log directory:
	diropts -m 0750 -g dtnd -o dtnd
	keepdir /var/log/ibrdtn
}

