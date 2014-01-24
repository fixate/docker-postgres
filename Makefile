all: build

.PHONY: all build push

build:
	docker build -t -rm fixate/ruby-mri:12.04 .

push:
	docker push fixate/ruby-mri
