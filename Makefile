.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -Wall -Wno-pedantic
XLDFLAGS = ${LDFLAGS} -shared -Wl

LIBDIR ?= /lib64

all: libdbus-glib-1.so.2 libdbus-1.so.3

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libdbus-glib-1.so.2:
	${CC} ${XCFLAGS} libdbus-glib-1.c -o libdbus-glib-1.so.2 ${XLDFLAGS},-soname,libdbus-glib-1.so.2

libdbus-1.so.3:
	${CC} ${XCFLAGS} libdbus-1.c -o libdbus-1.so.3 ${XLDFLAGS},-soname,libdbus-1.so.3

install: libdbus-1.so.3
	mkdir -p ${DESTDIR}/usr${LIBDIR}
#	cp -f libdbus-glib-1.so.2 ${DESTDIR}/usr${LIBDIR}
	cp -f libdbus-1.so.3 ${DESTDIR}/usr${LIBDIR}
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libdbus-1.so.3 ${DESTDIR}/usr${LIBDIR}/libdbus-1.so
	mkdir -p ${DESTDIR}/usr${LIBDIR}/pkgconfig
	cp -f dbus-1.pc ${DESTDIR}/usr${LIBDIR}/pkgconfig
	mkdir -p ${DESTDIR}/usr/include/dbus-1.0/dbus
	cp -rf headers/* ${DESTDIR}/usr/include/dbus-1.0/dbus
	mkdir -p ${DESTDIR}/usr/bin

	touch ${DESTDIR}/usr/bin/dbus-cleanup-sockets
	chown 755 ${DESTDIR}/usr/bin/dbus-cleanup-sockets
	touch ${DESTDIR}/usr/bin/dbus-daemon
	chown 755 ${DESTDIR}/usr/bin/dbus-daemon
	touch ${DESTDIR}/usr/bin/dbus-launch
	chown 755 ${DESTDIR}/usr/bin/dbus-launch
	touch ${DESTDIR}/usr/bin/dbus-monitor
	chown 755 ${DESTDIR}/usr/bin/dbus-monitor
	touch ${DESTDIR}/usr/bin/dbus-run-session
	chown 755 ${DESTDIR}/usr/bin/dbus-run-session
	touch ${DESTDIR}/usr/bin/dbus-send
	chown 755 ${DESTDIR}/usr/bin/dbus-send
	touch ${DESTDIR}/usr/bin/dbus-test-tool
	chown 755 ${DESTDIR}/usr/bin/dbus-test-tool
	touch ${DESTDIR}/usr/bin/dbus-update-activation-environment
	chown 755 ${DESTDIR}/usr/bin/dbus-update-activation-environment
	touch ${DESTDIR}/usr/bin/dbus-uuidgen
	chown 755 ${DESTDIR}/usr/bin/dbus-uuidgen

uninstall:
	rm -rf ${DESTDIR}/usr/include/dbus-1.0 ${DESTDIR}/usr${LIBDIR}/libdbus-glib-1.so.2 ${DESTDIR}/usr${LIBDIR}/libdbus-1.so.3 ${DESTDIR}/usr${LIBDIR}/libdbus-1.so ${DESTDIR}/usr${LIBDIR}/pkgconfig/dbus-1.pc

clean:
	rm -f libdbus-glib-1.so.2 libdbus-1.so.3

.PHONY: all clean install uninstall
