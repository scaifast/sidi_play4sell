const cds = require('@sap/cds')


module.exports = async function CatalogService() {

    const { BillingDocuments } = this.entities;
    const service = await cds.connect.to('API_BILLING_DOCUMENT_SRV');
    this.on('READ', BillingDocuments, request => {
        return service.tx(request).run(request.query);
    });

    this.on('jobFetchFattureSD', async ({ data: { } }) => {
        console.log("a");
        const LOG = cds.log('a');
        LOG.info('whatever like...');

        const bildoc = await cds.connect.to('API_BILLING_DOCUMENT_SRV');
        bildoc.foreach(SELECT(BillingDocuments).limit(10), doc =>
            console.log(doc)
        );


        return "f"
    })



    this.on('testConnection', async ({ data: { } }) => {
        console.log("step 1");
        const httpClient = require('@sap-cloud-sdk/http-client');
        const connectivity = require('@sap-cloud-sdk/connectivity');

        const destinations = await connectivity.getAllDestinationsFromDestinationService();
        console.log(destinations);
        console.log("step 2");

        const destination = await connectivity.getDestinationFromDestinationService({
            destinationName: "P4S_S60_LOCAL"
        });

        console.log("step 3");

        if (destination) {
            destination.authTokens?.forEach(authToken => {
                if (authToken.error) {
                    throw new Error(`Error in authToken ${authToken.error}`);
                }
                console.log(`auth token: ${authToken}`);
            });
        } else {
            throw new Error('Destination is undefined.');
        }
        console.log('Destination Retrieved.');
        const response = await httpClient.executeHttpRequest(destination, {
            method: 'get',
            url: "/sap/opu/odata/iwfnd/catalogservice;v=2/ServiceCollection?%24top=1"
        });
        if (!response.data) {
            throw new Error('No data returned');
        }
        console.log('Data Retrieved.');

        return "a";
    })

}
