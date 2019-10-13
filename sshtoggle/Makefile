ARCHS = armv7 arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = sshtoggle

sshtoggle_FILES = Tweak.xm
sshtoggle_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += sshtoggled
SUBPROJECTS += sshtogglepreferences
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "launchctl unload /Library/LaunchDaemons/in.imagineer.sshtoggled.plist"
	install.exec "launchctl load -w /Library/LaunchDaemons/in.imagineer.sshtoggled.plist"
