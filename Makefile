TARGET := iphone:clang:latest:15.0
ARCHS := arm64 arm64e
THEOS_PACKAGE_SCHEME := roothide
include $(THEOS)/makefiles/common.mk

TWEAK_NAME := AppSplitVPNZH
AppSplitVPNZH_FILES := Tweak.xm
AppSplitVPNZH_CFLAGS := -fobjc-arc
AppSplitVPNZH_FRAMEWORKS := UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
