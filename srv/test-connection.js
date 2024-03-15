const executeHttpRequest = require('@sap-cloud-sdk/http-client');
const getDestination  = require('@sap-cloud-sdk/connectivity');

async function minimalTest() {
  const destination = await getDestination({
    destinationName: "P4S_S60_LOCAL"
  });
  if (destination) {
    destination.authTokens?.forEach(authToken => {
      if (authToken.error) {
        throw new Error(`Error in authToken ${authToken.error}`);
      }
    });
  } else {
    throw new Error('Destination is undefined.');
  }
  console.log('Destination Retrieved.');
  const response = await executeHttpRequest(destination, {
    method: 'get',
    url: "/sap/opu/odata/sap/API_BILLING_DOCUMENT_SRV"
  });
  if (!response.data) {
    throw new Error('No data returned');
  }
  console.log('Data Retrieved.');
}
