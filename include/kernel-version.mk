# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .26
LINUX_VERSION-4.1 = .18
LINUX_VERSION-4.3 = .4
LINUX_VERSION-4.4 = .2

LINUX_KERNEL_MD5SUM-3.18.26 = fb3ef8da32a25607807887b9567a6927
LINUX_KERNEL_MD5SUM-4.1.18 = f3a44b84122b024b3102ba62a7f26a03
LINUX_KERNEL_MD5SUM-4.3.4 = 5275d02132107c28b85f986bad576d91
LINUX_KERNEL_MD5SUM-4.4.2 = d1b8be99e6c12cbc52b2af0520d550bb

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
