sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sidi/venduto/test/integration/FirstJourney',
		'sidi/venduto/test/integration/pages/ListaProviggioniAgentiList',
		'sidi/venduto/test/integration/pages/ListaProviggioniAgentiObjectPage'
    ],
    function(JourneyRunner, opaJourney, ListaProviggioniAgentiList, ListaProviggioniAgentiObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sidi/venduto') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheListaProviggioniAgentiList: ListaProviggioniAgentiList,
					onTheListaProviggioniAgentiObjectPage: ListaProviggioniAgentiObjectPage
                }
            },
            opaJourney.run
        );
    }
);