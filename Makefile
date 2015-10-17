include theos/makefiles/common.mk

TWEAK_NAME = MapsAllCountries
MapsAllCountries_FILES = Tweak.xm

MapsAllCountries_FRAMEWORKS = UIKit
TARGET := iphone:7.0:5.0
export SDKVERSION = 7.0
export ARCHS = arm64 armv7 armv7s

include $(THEOS_MAKE_PATH)/tweak.mk


