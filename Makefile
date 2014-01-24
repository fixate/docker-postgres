all: build

.PHONY: all build push

build:
	docker build -rm -t fixate/postgres:12.04 .

push:
	docker push fixate/postgres
