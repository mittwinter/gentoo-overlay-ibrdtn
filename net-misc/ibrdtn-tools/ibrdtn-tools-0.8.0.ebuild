# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Tools for ibrdtn, the implementation of Delay Tolerant Networks by IBR"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/"
SRC_URI="http://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+zlib"
DEPEND="=net-misc/ibrdtn-${PV}"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

