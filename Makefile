.PHONY: docker-build docker-server compile

docker-build:
	docker build -t hugo-build-image .

docker-server: docker-build
	docker run \
	 -v ${CURDIR}:/src \
	 -p 1313:1313 \
	 -it hugo-build-image \
	hugo server /src/ --bind=0.0.0.0

compile: docker-build
	docker run \
	 -v ${CURDIR}:/src \
	 -e HUGO_BASEURL=${BASE_URL} \
	 -it hugo-build-image \
	hugo

server:
	hugo server
