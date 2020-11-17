run: build
	docker run -it --rm mypybin

console: build
	docker run -it --rm mypybin bash

build:
	docker build . -t mypybin

clean:
	docker image rm mypybin
