all: build

.PHONY: all build push

build:
	docker build -rm -t fixate/postgresql:9.3 .

push:
	docker push fixate/postgresql
