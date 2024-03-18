sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sidi/notaspese/test/integration/FirstJourney',
		'sidi/notaspese/test/integration/pages/ListaNotaSpeseList',
		'sidi/notaspese/test/integration/pages/ListaNotaSpeseObjectPage'
    ],
    function(JourneyRunner, opaJourney, ListaNotaSpeseList, ListaNotaSpeseObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sidi/notaspese') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheListaNotaSpeseList: ListaNotaSpeseList,
					onTheListaNotaSpeseObjectPage: ListaNotaSpeseObjectPage
                }
            },
            opaJourney.run
        );
    }
);