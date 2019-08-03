obj-m := acpi_call.o

KERNELRELEASE := $(shell uname -r)
KDIR := /lib/modules/$(KERNELRELEASE)/build
PWD := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

install:
	$(MAKE) -C $(KDIR) M=$(PWD) modules_install

load:
	-/sbin/rmmod acpi_call
	/sbin/insmod acpi_call.ko

dkms-add:
	/usr/sbin/dkms add $(PWD)
	/usr/sbin/dkms build -m acpi_call -v 1.0
	/usr/sbin/dkms install -m acpi_call -v 1.0

dkms-remove:
	/usr/sbin/dkms remove -m acpi_call -v 1.0 --all
