ifeq ($(BOARD_HAVE_QCOM_FM),true)
#ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
android_hardware_fm.cpp \
ConfFileParser.cpp \
ConfigFmThs.cpp \
FmIoctlsInterface.cpp \
FmPerformanceParams.cpp

ifeq ($(BOARD_HAS_QCA_FM_SOC), "cherokee")
LOCAL_CFLAGS += -DFM_SOC_TYPE_CHEROKEE
endif
LOCAL_LDLIBS += -ldl
LOCAL_SHARED_LIBRARIES := \
        libandroid_runtime \
        libnativehelper \
        libcutils \
        liblog

ifeq ($(TARGET_COMPILE_WITH_MSM_KERNEL),true)
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
endif

LOCAL_MODULE := libqcomfm_jni
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

ifeq ($(TARGET_FM_LEGACY_PATCHLOADER),true)
    LOCAL_CFLAGS += -DFM_LEGACY_PATCHLOADER
endif

ifeq ($(TARGET_QCOM_NO_FM_FIRMWARE),true)
    LOCAL_CFLAGS += -DQCOM_NO_FM_FIRMWARE
endif

include $(BUILD_SHARED_LIBRARY)
#endif # is-vendor-board-platform
endif # BOARD_HAVE_QCOM_FM
