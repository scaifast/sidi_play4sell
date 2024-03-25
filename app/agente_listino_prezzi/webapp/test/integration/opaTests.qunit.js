sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sidi/agentelistinoprezzi/test/integration/FirstJourney',
		'sidi/agentelistinoprezzi/test/integration/pages/ProductsListList',
		'sidi/agentelistinoprezzi/test/integration/pages/ProductsListObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsListList, ProductsListObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sidi/agentelistinoprezzi') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsListList: ProductsListList,
					onTheProductsListObjectPage: ProductsListObjectPage
                }
            },
            opaJourney.run
        );
    }
);