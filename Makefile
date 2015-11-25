include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SleekSheets
SleekSheets_FILES = Tweak.xm
SleekSheets_FRAMEWORKS = Foundation QuartzCore UIKit
SleekSheets_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += sleeksheets
include $(THEOS_MAKE_PATH)/aggregate.mk
