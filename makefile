.PHONY: clean run

kernel/osrm.kernel:
	./scripts/build.sh

osrm.iso:
	./scripts/iso.sh

clean:
	./scripts/clean.sh

run: clean kernel/osrm.kernel osrm.iso
	./scripts/qemu.sh
