all: build deploy 

build:
	mbt build -t gen --mtar mta.tar

deploy:
	cf deploy gen/mta.tar

dev-job-fatturesd:
	curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST localhost:4004/browse/jobFetchFattureSD

dev-test-connection:
	curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST localhost:4004/browse/testConnection

prd-job-fatturesd:
	curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST  https://sidi-srl-sidi-foundry-llwtncnq-sviluppo-play4sell-srv.cfapps.eu10-004.hana.ondemand.com/browse/jobFetchFattureSD
	# cf run-task play4sell --command "node job-fatturesd.js"

env:
	cf default-env play4sell-srv

reload:
	curl localhost:8887/reload


test-destination:
	curl -v -i "P4S_S60_LOCAL.dest/sap/opu/odata/iwfnd/catalogservice;v=2/ServiceCollection?%24top=1"

watch:
	cds watch --profile hybrid


bind:
	cds bind --to-app-services play4sell-srv
	