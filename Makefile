include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SleekSheets
SleekSheets_FILES = Tweak.xm
SleekSheets_FRAMEWORKS = CoreFoundation Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += sleeksheets
include $(THEOS_MAKE_PATH)/aggregate.mk
