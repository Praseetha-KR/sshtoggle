include $(THEOS)/makefiles/common.mk

TOOL_NAME = sshtoggled

sshtoggled_FILES = main.m
sshtoggled_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tool.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

internal-stage::
	ldid -Sent.xml $(THEOS_STAGING_DIR)/usr/bin/sshtoggled
