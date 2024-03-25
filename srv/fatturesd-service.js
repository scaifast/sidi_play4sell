const cds = require('@sap/cds')
//const {ProviggioniAgenti} = cds.entities('srv.fatturesd-service');

module.exports = async function CatalogService() {

    Date.prototype.addDays = function (days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() + days);
        return date;
    };
    Date.prototype.subtractDays = function (days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() - days);
        return date;
    };
    Date.prototype.getISOStringDate = function () {
        let isoDate = this.toISOString().substring(0, 10);
        return isoDate;
    };

    const { BillingDocuments, ProviggioniAgenti, Products, APIProducts } = this.entities;

    const service = await cds.connect.to('API_BILLING_DOCUMENT_SRV');
    this.on('READ', BillingDocuments, request => {
        return service.tx(request).run(request.query);
    });

    const service_product = await cds.connect.to('OP_API_PRODUCT_SRV_0001');
    this.on('READ', APIProducts, request => {
        return service_product.tx(request).run(request.query);
    });

    this.on('jobFetchProducts', async ({ data: { } }) => {


        const product = await cds.connect.to('OP_API_PRODUCT_SRV_0001');
        let sult = await product.run(
            SELECT(APIProducts)
                .where(
                    `IsMarkedForDeletion=' '`
                )
                .limit(100)
                .orderBy("Product")
        );
        

        let arrayProducts= [];
        for (let element of sult) {
            
            let prod={};
            prod.CodProduct=element.Product;
            arrayProducts.push(prod);

          };
        
        await DELETE.from(Products);           // ripuliamo tabella prima dell'inserimento

        await UPSERT(arrayProducts).into(Products);
        console.log("terminato");


    });


    this.on('jobFetchFattureSD', async ({ data: { } }) => {

        let dataCalcolata = new Date();
        dataCalcolata = dataCalcolata.subtractDays(365);
        let dataFineCalcolo = new Date();
        dataFineCalcolo = dataFineCalcolo.addDays(10);
        console.log(dataCalcolata, dataFineCalcolo);

        const bildoc = await cds.connect.to('API_BILLING_DOCUMENT_SRV');
        let sult = await bildoc.run(
            SELECT(BillingDocuments)
                .where(
                    `CreationDate >= '${dataCalcolata.getISOStringDate()}' and CreationDate <= '${dataFineCalcolo.getISOStringDate()}'`
                )
                .limit(10)
                .orderBy("BillingDocument")
        );
        

        let arrayProvvigioni= [];
        for (let element of sult) {
            
            let prov={};
            prov.NumDocProvv=element.BillingDocument;
            arrayProvvigioni.push(prov);

          };
        
        await DELETE.from(ProviggioniAgenti);           // ripuliamo tabella prima dell'inserimento

        await UPSERT(arrayProvvigioni).into(ProviggioniAgenti);
        console.log("terminato");


    });





    this.on('testConnection', async ({ data: { } }) => {
        console.log("step 1");
        const httpClient = require('@sap-cloud-sdk/http-client');
        const connectivity = require('@sap-cloud-sdk/connectivity');

        const destinations = await connectivity.getAllDestinationsFromDestinationService();
        console.log(destinations);
        console.log("step 2");

        const destination = await connectivity.getDestinationFromDestinationService({
            destinationName: "P4S_S60"
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
