build:
	docker build -t odc:local .

build-jupyter:
	docker build -t odc-jupyter:local --file DockerfileJupyter .

up:
	docker-compose up

createdb:
	docker-compose exec postgres createdb -U postgres agdcintegration

integration:
	docker-compose exec jupyter bash -c "cd /opt/opendatacube/ && ./check-code.sh integration_tests/"
