.PHONY: image test citest

IMAGE_NAME ?= codeclimate/codeclimate-proselint

image:
	docker build --rm -t $(IMAGE_NAME) .

test: image
	docker run \
		--interactive \
		--tty \
		--rm \
		--volume $(PWD):/code \
		--workdir /code \
		$(IMAGE_NAME) npm run $(NPM_TEST_TARGET)
