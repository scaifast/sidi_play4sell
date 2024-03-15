sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sidi/fatture/test/integration/FirstJourney',
		'sidi/fatture/test/integration/pages/ListaFattureSDList',
		'sidi/fatture/test/integration/pages/ListaFattureSDObjectPage'
    ],
    function(JourneyRunner, opaJourney, ListaFattureSDList, ListaFattureSDObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sidi/fatture') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheListaFattureSDList: ListaFattureSDList,
					onTheListaFattureSDObjectPage: ListaFattureSDObjectPage
                }
            },
            opaJourney.run
        );
    }
);