all: clean build deploy 

clean:
	rm -f srv/external/API_BILLING_DOCUMENT_SRV.csn

build:
	mbt build -t gen --mtar mta.tar

deploy:
	cf deploy  gen/mta.tar

dev-job-fatturesd:
	curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST localhost:4004/browse/jobFetchFattureSD

dev-job-products:
	curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST localhost:4004/browse/jobFetchProducts

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
	curl -v -i "P4S_S60.dest/sap/opu/odata/iwfnd/catalogservice;v=2/ServiceCollection?%24top=1"

watch:
	cds watch --profile hybrid


bind:
	cds bind --to-app-services play4sell-srv

tunnel: 
	cf ssh -L localhost:9999:postgres-4cc6222e-a8dd-43f4-8a32-09d21ce89a5e.ce4jcviyvogb.eu-central-1.rds.amazonaws.com:6307 ssh-tunnel -N
	
deploy-db:
	cds deploy --profile postgres-production
	
# List recent deployment processes using the cf mta-ops --all command and note the mta id or operation id.
# Download the logs of the deployment operation based on operation id of mta id as per the following examples:
# cf dmol -i <operation id>


# collegarsi a ssh dal pc: cf ssh -L localhost:9999:postgres-4cc6222e-a8dd-43f4-8a32-09d21ce89a5e.ce4jcviyvogb.eu-central-1.rds.amazonaws.com:6307 ssh-tunnel -N