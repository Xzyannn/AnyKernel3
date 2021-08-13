DEVICE := $(shell echo ${DEVICE})
BRANCH := $(shell git -C .. rev-parse --abbrev-ref HEAD)

ifeq ($(findstring 10,$(BRANCH)),10)
    ifeq ($(findstring ginkgo,$(DEVICE)),ginkgo)
        NAME := Predator-Kernel-ginkgo-R
    else
        NAME := Predator-Kernel-ginkgo-R
    endif
    DATE := $(shell date "+%Y%m%d")
    ZIP := $(NAME)-$(DATE).zip
else
    ifeq ($(findstring whyred,$(DEVICE)),whyred)
        NAME := Predator-Kernel-ginkgo-Q/10
    else
    ifeq ($(findstring ginkgo,$(DEVICE)),ginkgo)
        NAME := Predator-Kernel-ginkgo-R
    else
        NAME := Predator-Kernel-ginkgo-R
    endif
    endif
    DATE := $(shell date "+%Y%m%d")
    ZIP := $(NAME)-$(DATE).zip
endif

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	sed -i "/^device.name1=/s/=.*/=${DEVICE}/" anykernel.sh
	zip -r9 "$@" . -x $(EXCLUDE)
	echo "Done creating ZIP: $(ZIP)"

clean:
	rm -vf *.zip
	rm -vf *.gz-dtb
	rm -vf modules/vendor/lib/modules/*.ko
	echo "Cleaning done."

