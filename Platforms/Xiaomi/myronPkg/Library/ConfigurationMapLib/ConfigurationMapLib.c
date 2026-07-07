#include <Library/ConfigurationMapLib.h>

STATIC
EFI_CONFIGURATION_ENTRY_DESCRIPTOR
gConfigurationDescriptor[] = {
  {"EnableShell", 0x1},
  {"SecPagePoolCount", 0x800},
  {"SharedIMEMBaseAddr", 0x14680000},
  {"DloadCookieAddr", 0x01FD9000},
  {"DloadCookieValue", 0x10},
  {"SkipDBISetup", 0x0},
  {"NumCpus", 8},
  {"NumActiveCores", 8},
  {"MaxLogFileSize", 0x400000},
  {"UefiMemUseThreshold", 0xE1},
  {"USBHS1_Config", 0x0},
  {"UsbFnIoRevNum", 0x00010001},
  {"PwrBtnShutdownFlag", 0x0},
  {"Sdc1GpioConfigOn", 0x1E92},
  {"Sdc2GpioConfigOn", 0x1E92},
  {"Sdc1GpioConfigOff", 0xA00},
  {"Sdc2GpioConfigOff", 0xA00},
  {"EnableSDHCSwitch", 0x1},
  {"EnableUfsIOC", 1},
  {"UfsSmmuConfigForOtherBootDev", 1},
  {"SecurityFlag", 0xC4},
  {"EnableMultiThreading", 1},
  {"EarlyInitCoreCnt", 2},
  {"EnableDisplayThread", 0x1},
  {"EnableDisplayImageFv", 0x1},
  {"EnableMultiCoreFvDecompression", 1},
  {"EnableVariablePolicyEngine", 0},
  {"DRAM_CLK_PERIOD_ADDR", 0x240BA050}
};

VOID
GetConfigurationMap (
  OUT EFI_CONFIGURATION_ENTRY_DESCRIPTOR **ConfigurationDescriptor,
  OUT UINT8                               *ConfigurationDescriptorCount)
{
  *ConfigurationDescriptor      = gConfigurationDescriptor;
  *ConfigurationDescriptorCount = ARRAY_SIZE (gConfigurationDescriptor);
}
