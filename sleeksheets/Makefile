include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SleekSheets
SleekSheets_FILES = SheetsConfigurationController.m SheetsRootListController.m
SleekSheets_INSTALL_PATH = /Library/PreferenceBundles
SleekSheets_FRAMEWORKS = MessageUI UIKit
SleekSheets_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SleekSheets.plist$(ECHO_END)
