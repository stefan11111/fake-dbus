.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -Wall -Wno-pedantic
XLDFLAGS = ${LDFLAGS} -shared -Wl,--version-script Version -Wl

LIBDIR ?= /lib64

all: libdbus-glib-1.so.2 libdbus-1.so.3

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libdbus-glib-1.so.2:
	${CC} ${XCFLAGS} libdbus-glib-1.c -o libdbus-glib-1.so.2 ${XLDFLAGS},-soname,libdbus-glib-1.so.2

libdbus-1.so.3:
	${CC} ${XCFLAGS} libdbus-1.c -o libdbus-1.so.3 ${XLDFLAGS},-soname,libdbus-1.so.3

programs:
	mkdir -p ${DESTDIR}/usr/bin
	touch ${DESTDIR}/usr/bin/dbus-cleanup-sockets
	chmod 755 ${DESTDIR}/usr/bin/dbus-cleanup-sockets
	touch ${DESTDIR}/usr/bin/dbus-daemon
	chmod 755 ${DESTDIR}/usr/bin/dbus-daemon
	touch ${DESTDIR}/usr/bin/dbus-launch
	chmod 755 ${DESTDIR}/usr/bin/dbus-launch
	touch ${DESTDIR}/usr/bin/dbus-monitor
	chmod 755 ${DESTDIR}/usr/bin/dbus-monitor
	touch ${DESTDIR}/usr/bin/dbus-run-session
	chmod 755 ${DESTDIR}/usr/bin/dbus-run-session
	touch ${DESTDIR}/usr/bin/dbus-send
	chmod 755 ${DESTDIR}/usr/bin/dbus-send
	touch ${DESTDIR}/usr/bin/dbus-test-tool
	chmod 755 ${DESTDIR}/usr/bin/dbus-test-tool
	touch ${DESTDIR}/usr/bin/dbus-update-activation-environment
	chmod 755 ${DESTDIR}/usr/bin/dbus-update-activation-environment
	touch ${DESTDIR}/usr/bin/dbus-uuidgen
	chmod 755 ${DESTDIR}/usr/bin/dbus-uuidgen

install: libdbus-1.so.3 programs
	mkdir -p ${DESTDIR}/usr${LIBDIR}
#	cp -f libdbus-glib-1.so.2 ${DESTDIR}/usr${LIBDIR}
	cp -f libdbus-1.so.3 ${DESTDIR}/usr${LIBDIR}
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libdbus-1.so.3 ${DESTDIR}/usr${LIBDIR}/libdbus-1.so
	mkdir -p ${DESTDIR}/usr${LIBDIR}/pkgconfig
	cp -f dbus-1.pc ${DESTDIR}/usr${LIBDIR}/pkgconfig
	mkdir -p ${DESTDIR}/usr/include/dbus-1.0/dbus
	cp -rf headers/* ${DESTDIR}/usr/include/dbus-1.0/dbus

uninstall:
	rm -rf ${DESTDIR}/usr/include/dbus-1.0
#	rm -f ${DESTDIR}/usr${LIBDIR}/libdbus-glib-1.so.2
	rm -f ${DESTDIR}/usr${LIBDIR}/libdbus-1.so.3
	rm -f ${DESTDIR}/usr${LIBDIR}/libdbus-1.so
	rm -f ${DESTDIR}/usr${LIBDIR}/pkgconfig/dbus-1.pc
	rm -f ${DESTDIR}/usr/bin/dbus-cleanup-sockets
	rm -f ${DESTDIR}/usr/bin/dbus-daemon
	rm -f ${DESTDIR}/usr/bin/dbus-launch
	rm -f ${DESTDIR}/usr/bin/dbus-monitor
	rm -f ${DESTDIR}/usr/bin/dbus-run-session
	rm -f ${DESTDIR}/usr/bin/dbus-send
	rm -f ${DESTDIR}/usr/bin/dbus-test-tool
	rm -f ${DESTDIR}/usr/bin/dbus-update-activation-environment
	rm -f ${DESTDIR}/usr/bin/dbus-uuidgen

clean:
	rm -f libdbus-glib-1.so.2 libdbus-1.so.3

.PHONY: all clean install uninstall programs
