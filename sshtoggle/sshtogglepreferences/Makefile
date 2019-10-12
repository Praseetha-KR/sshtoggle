include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = sshtogglePreferences

sshtogglePreferences_FILES = STPRootListController.m
sshtogglePreferences_INSTALL_PATH = /Library/PreferenceBundles
sshtogglePreferences_FRAMEWORKS = UIKit
sshtogglePreferences_PRIVATE_FRAMEWORKS = Preferences
sshtogglePreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/sshtogglePreferences.plist$(ECHO_END)
