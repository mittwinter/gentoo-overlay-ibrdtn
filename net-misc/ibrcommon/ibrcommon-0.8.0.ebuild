# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="ibrcommon library for implementation of Delay Tolerant Networks by IBR"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/"
SRC_URI="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lowpan +ssl xml"

DEPEND="dev-libs/pth \
	lowpan? ( dev-libs/libnl:1.1 )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_configure() {
	econf \
		$( use_with lowpan ) \
		$( use_with ssl openssl ) \
		$( use_with xml )
}

