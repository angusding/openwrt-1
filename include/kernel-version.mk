# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .29
LINUX_VERSION-4.1 = .22
LINUX_VERSION-4.3 = .4
LINUX_VERSION-4.4 = .8

LINUX_KERNEL_MD5SUM-3.18.29 = b25737a0bc98e80d12200de93f239c28
LINUX_KERNEL_MD5SUM-4.1.22 = 01274eddfa967e4fb6026bd9c391ed92
LINUX_KERNEL_MD5SUM-4.3.4 = 5275d02132107c28b85f986bad576d91
LINUX_KERNEL_MD5SUM-4.4.8 = d6430ac57c5f1830798095b7147908e4

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM:=$(LINUX_KERNEL_MD5SUM-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_MD5SUM?=x
