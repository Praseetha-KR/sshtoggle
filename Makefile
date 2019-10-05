INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = sshtoggle

sshtoggle_FILES = Tweak.x
sshtoggle_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += sshtogglepreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
