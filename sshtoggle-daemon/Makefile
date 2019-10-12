ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = sshtoggled

sshtoggled_FILES = main.m
sshtoggled_CFLAGS = -fobjc-arc
sshtoggled_CODESIGN_FLAGS = -Splatform.xml

include $(THEOS_MAKE_PATH)/tool.mk
