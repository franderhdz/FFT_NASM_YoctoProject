# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be ful$
# (Feel free to remove these comments when editing.)

# Unable to find any files that looked like license statements. Check the accom$
# documentation and source headers and set LICENSE and LIC_FILES_CHKSUM accordi$
#
# NOTE: LICENSE is being set to "CLOSED" to allow you to at least start buildin$
# this is not accurate with respect to the licensing of the software being buil$
# will not be in most cases) you must specify the correct value before using th$
# recipe for anything other than initial testing/development!
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

# No information for SRC_URI yet (only an external source tree was specified)
SRC_URI = "file://programa.asm"

# NOTE: no Makefile found, unable to determine what needs to be done

S = "${WORKDIR}"

#S = "~/poky-warrior/meta-linker/recipes-gcclinker/gcclinker-1.0"
#FILES_${PN} += "${libdir} \
#		${libdir}/bin \"

TARGET_CC_ARCH += "${LDFLAGS}"

do_configure () {
    	# Specify any needed configure commands here
    	nasm -f elf32 -o programa.o programa.asm
	${LD} programa.o -o programa		
}

#do_compile () {
#    	nasm -f elf32 -o progra.o progra.asm
#}

do_install () {
    	install -d ${D}${bindir}/package/usr
    	install -m 0755 programa ${D}${bindir}
#	install -d ~/poky-warrior/meta-linker/recipes-gcclinker/gcclinker-1.0
}

FILES_${PN} += "${libdir}/*"
FILES_${PN}-dev = "${libdir}/* ${includedir}"

EXTRA_AUTORECONF += "--exclude=aclocal"

BBCLASSEXTEND = "native"

DEPENDS = "nasm-native"

CVE_PRODUCT = "netwide_assembler"














#DESCRIPTION = "General-purpose x86 assembler"
#SECTION = "devel"
#LICENSE = "GPL"
#COMPATIBLE_HOST = '(x86_64|i.86).*-(linux|freebsd.*)'
#PR = "r1"

#SRC_URI = "file://progra.asm" 
#"${SOURCEFORGE_MIRROR}/nasm/nasm-${PV}.tar.bz2"
#make -j 1
# NOTE: no Makefile found, unable to determine what needs to be done
#S="${WORKDIR}"
#inherit autotools
#inherit autotools-brokensep

#EXTRA_AUTORECONF += "--exclude=aclocal"

#BBCLASSEXTEND = "native"

#DEPENDS = "groff-native"

#CVE_PRODUCT = "netwide_assembler"

#do_compile () {
#:

#}

#do_install() {
#	install -d ${D}${bindir}
#	install -d ${D}${mandir}/man1

#	oe_runmake 'INSTALLROOT=${D}' install
#}

#SRC_URI[md5sum] = "9f682490c132b070d54e395cb6ee145e"
#SRC_URI[sha256sum] = "87e64eff736196862ed46c04a3dffa612d765df980fa974fc65e026d811bd9d0"
#PARALLEL_MAKE = ""
