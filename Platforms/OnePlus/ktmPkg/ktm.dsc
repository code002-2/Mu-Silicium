##
#
#  Copyright (c) 2011 - 2022, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2020, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#  Copyright (c) Microsoft Corporation.
#
#  SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = ktm
  PLATFORM_GUID                  = 138E0757-0D3B-4A8D-946A-9E50F79447F7
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/ktmPkg
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = RELEASE|DEBUG
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = ktmPkg/ktm.fdf
  USE_CUSTOM_DISPLAY_DRIVER      = 0

  #
  # 0 = SM8750-AB
  # 1 = SM8750-3-AB
  # 2 = SM8750-AC
  #
  SOC_TYPE                       = 0

!include PakalaPkg/PakalaPkg.dsc.inc

[PcdsFixedAtBuild]
  #
  # DDR Memory
  #
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000

  #
  # UEFI Stack
  #
  gArmPlatformTokenSpaceGuid.PcdCPUCoresStackBase|0xA760D000
  gArmPlatformTokenSpaceGuid.PcdCPUCorePrimaryStackSize|0x80000

  #
  # SMBIOS
  #
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemManufacturer|"OnePlus"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemModel|"Ace 6"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailModel|"ktm"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemRetailSku|"PLQ110"
  gSiliciumPkgTokenSpaceGuid.PcdSmbiosSystemBoardModel|"24851"

  #
  # Simple Frame Buffer
  #
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferWidth|1272
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferHeight|2800
  gSiliciumPkgTokenSpaceGuid.PcdFrameBufferColorDepth|32

  #
  # Platform PEI
  #
  gQcomPkgTokenSpaceGuid.PcdPlatformType|"LA"

  #
  # Boot manager time-out.  Must be finite: BdsWait() in BdsDxe loops until this
  # reaches zero, and 0xFFFF means "wait forever", so with no hotkey available
  # (the keypad has no SimpleTextInputEx driver on Qualcomm OnePlus platforms)
  # 0xFFFF hangs BDS permanently and the hardware watchdog resets the SoC a few
  # seconds after the logo.  A finite value lets BDS finish waiting, try the
  # boot options and then reach PlatformBootManagerUnableToBoot().
  #
  gEfiMdePkgTokenSpaceGuid.PcdPlatformBootTimeOut|5

[LibraryClasses]
  #
  # ktm: use the NULL DeviceBootManagerLib.  The Qualcomm implementation
  # (QcomPkg/Library/PlatformBootManagerLib) signals a "SD Card Init" event from
  # DeviceBootManagerAfterConsole(), and that hangs on ktm - there is no SD card
  # slot.  The boot log shows the very last line before the reset is
  # "AfterConsole: DeviceBootManagerAfterConsole...", i.e. inside that call.
  #
  DeviceBootManagerLib|SiliciumNullPkg/Library/PlatformBootManagerLibNull/PlatformBootManagerLibNull.inf

  #
  # Memory Libraries
  #
  MemoryMapLib|ktmPkg/Library/MemoryMapLib/MemoryMapLib.inf

  #
  # QCOM Libraries
  #
  ConfigurationMapLib|ktmPkg/Library/ConfigurationMapLib/ConfigurationMapLib.inf

[Components]
  #
  # ACPI Tables
  #
  #ktm/AcpiTables.inf
