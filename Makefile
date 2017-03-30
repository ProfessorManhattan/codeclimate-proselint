.PHONY: image

IMAGE_NAME ?= codeclimate/codeclimate-proselint

image:
	docker build --rm --tag $(IMAGE_NAME) .
