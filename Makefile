include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SleekSheets
SleekSheets_FILES = Tweak.xm
SleekSheets_FRAMEWORKS = Foundation QuartzCore UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
