LOCAL_PATH := vendor/aw/public/prebuild/lib/librild

# 3G Data Card Packages
PRODUCT_PACKAGES += \
	android.hardware.radio@1.1 \
	android.hardware.radio.config@1.0-service \
	android.hardware.radio.config@1.0 \
	pppd_vendor \
	rild \
	chat \
	radio_monitor

DISABLE_RILD_OEM_HOOK := true

# 3G Data Card Configuration Flie
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/config/data_call/ip-down:$(TARGET_COPY_OUT_VENDOR)/xbin/ppp/ip-down \
	$(LOCAL_PATH)/config/data_call/ip-up:$(TARGET_COPY_OUT_VENDOR)/xbin/ppp/ip-up \
	$(LOCAL_PATH)/config/data_call/3g_dongle.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/3g_dongle.cfg \
	$(LOCAL_PATH)/config/data_call/apns-conf_sdk.xml:system/etc/apns-conf.xml \

# Radio Monitor Configuration Flie
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/config/radio_monitor/usb_modeswitch:$(TARGET_COPY_OUT_VENDOR)/bin/usb_modeswitch \
	$(call find-copy-subdir-files,*,$(LOCAL_PATH)/config/radio_monitor/usb_modeswitch.d,$(TARGET_COPY_OUT_VENDOR)/etc/usb_modeswitch.d)

exsist := $(shell if [ -d $(TOP)/vendor/aw/private/lib/softwinner-ril ]; then echo "true"; fi)
ifeq ($(exsist),true)
# build source code
PRODUCT_PACKAGES += \
	libsoftwinner-ril-9.0
else
# libsoftwinner-ril
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/lib/libsoftwinner-ril-9.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsoftwinner-ril-9.0.so \
	$(LOCAL_PATH)/lib64/libsoftwinner-ril-9.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsoftwinner-ril-9.0.so
endif

# Radio parameter
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.rild.libargs=-d/dev/ttyUSB2 \
	vendor.rild.libpath=libsoftwinner-ril-9.0.so \
	ro.radio.noril=true \
	ro.radio.noawril=false \
	ro.vendor.sw.embeded.telephony=false
