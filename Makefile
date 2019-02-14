
IMAGE_NAME = s2i-wildfly-galleon

build:
	docker build -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	#docker run -it --rm -v "$(pwd)/test/test-app-maven":"/tmp/src" --entrypoint bash s2i-galleon-candidate
