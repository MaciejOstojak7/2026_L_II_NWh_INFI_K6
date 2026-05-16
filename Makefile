.PHONY: deps lint test run docker_build docker_run docker_push

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	python -m flake8 hello_world test

test:
	PYTHONPATH=. python -m pytest --verbose -s

run:
	python main.py

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run --name hello-world-printer-dev -p 5000:5000 -d hello-world-printer

docker_push: docker_build
	echo "$$DOCKERHUB_TOKEN" | docker login --username "$$DOCKERHUB_USERNAME" --password-stdin
	docker tag hello-world-printer "$$DOCKERHUB_USERNAME/hello-world-printer-k7-2026"
	docker push "$$DOCKERHUB_USERNAME/hello-world-printer-k7-2026"
	docker logout