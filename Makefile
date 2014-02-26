all: build

.PHONY: all build push

build:
	docker build -rm -t fixate/postgres:9.3 .

push:
	docker push fixate/postgres
