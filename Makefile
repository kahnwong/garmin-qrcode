build:
	./scripts/build.sh

dev: build
	./scripts/push-to-simulator.sh
