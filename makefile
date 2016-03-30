IMAGE_NAME_APP := idb_app
IMAGE_NAME_LB := idb_lb
IMAGE_NAME_DB := idb_db
DOCKER_HUB_USERNAME := crakkerjak

docker-build:
	@if [ -z "$$CONTINUE" ]; then \
		read -r -p "Have you sourced the docker.env file for our Carina cluster? (y/n): " CONTINUE; \
	fi ; \
	[ $$CONTINUE = "y" ] || [ $$CONTINUE = "Y" ] || (echo "Exiting."; exit 1;)
	@echo "Building the images..."
	docker login

	docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_APP} app
	docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_APP}

	docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_LB} lb
	docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_LB}

	docker build -t ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_DB} db
	docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME_LB}

docker-push:
	docker-compose --file docker-compose-prod.yml up -d
