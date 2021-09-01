.PHONY: clean build iso run

build:
	./scripts/build.sh

iso:
	./scripts/iso.sh

clean:
	./scripts/clean.sh

run: clean build iso
	./scripts/qemu.sh
