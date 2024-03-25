using CatalogService as service from '../../srv/fatturesd-service';

annotate service.ListaNotaSpese with @odata.draft.enabled;
annotate service.ListaNotaSpese with @(UI.SelectionFields: [Data, ]);


//annotate service.ListaNotaSpese with {
//    Agente @Common.Label : 'IDAgente'
//};

annotate service.ListaNotaSpese with @(
    Capabilities                              : {FilterRestrictions: {FilterExpressionRestrictions: [{
        Property          : 'Data',
        AllowedExpressions: 'SingleRange'
    }]}},

    Capabilities.SearchRestrictions.Searchable: false,
    UI.LineItem                               : [
        {
            $Type: 'UI.DataField',
            Value: Agente,
        },
        {
            $Type: 'UI.DataField',
            Value: ID,
            Label: '{i18n>IDNotaSpese}',
            ![@UI.Hidden],
        },
        {
            $Type: 'UI.DataField',
            Value: Agente,
            Label: '{i18n>Agente_utente}',
            ![@UI.Hidden],
        },
        {
            $Type: 'UI.DataField',
            Value: createdAt,
            ![@UI.Hidden],
        },
        {
            $Type: 'UI.DataField',
            Value: createdBy,
            ![@UI.Hidden],
        },
        //        {
        //            $Type : 'UI.DataField',
        //            Value : Divisa.code,
        //        },
        //        {
        //            $Type : 'UI.DataField',
        //            Value : Divisa.descr,
        //        },
        //        {
        //            $Type : 'UI.DataField',
        //            Value : Divisa.minorUnit,
        //        },
        //        {
        //            $Type : 'UI.DataField',
        //            Value : Divisa.name,
        //        },
        //        {
        //            $Type : 'UI.DataField',
        //            Value : Divisa.symbol,
        //        },
        {
            $Type: 'UI.DataField',
            Value: modifiedAt,
            ![@UI.Hidden],
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedBy,
        },
        {
            $Type: 'UI.DataField',
            Value: Data,
            Label: '{i18n>Data}',
        },
        {
            $Type: 'UI.DataField',
            Value: Rimborso,
            Label: '{i18n>Rimborso}',
        },
        {
            $Type: 'UI.DataField',
            Value: DescRimborso,
            Label: '{i18n>DescRimborso}',
        },
        {
            $Type: 'UI.DataField',
            Value: Descrizione,
            Label: '{i18n>Descrizione}',
            ![@UI.Hidden],
        },
        {
            $Type: 'UI.DataField',
            Value: RimborsoKM,
            Label: '{i18n>RimborsoKM}',
        },
        {
            $Type: 'UI.DataField',
            Value: WBS,
            Label: '{i18n>WBS}',
        },
        {
            $Type: 'UI.DataField',
            Value: Importo,
            Label: '{i18n>Importo}',
        },
        {
            $Type: 'UI.DataField',
            Value: Divisa_code,
            ![@UI.Hidden],
        },
    ]
);

annotate service.ListaNotaSpese with @(
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Nota Spesa',
        ID    : 'NotaSpesa',
        Target: '@UI.FieldGroup#NotaSpesa',
    }, ],
    UI.FieldGroup #NotaSpesa: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
                Label: '{i18n>IDNotaspese}',
                ![@UI.Hidden],
            },
            {
                $Type: 'UI.DataField',
                Value: Agente,
                ![@UI.Hidden],
            },
            {
                $Type: 'UI.DataField',
                Value: Data,
                Label: '{i18n>Data}',
            },
            {
                $Type : 'UI.DataField',
                Value : Rimborso,
                Label : 'Rimborso',
            },
            {
                $Type : 'UI.DataField',
                Value : DescRimborso,
                Label : 'DescRimborso',
            },
            {
                $Type : 'UI.DataField',
                Value : RimborsoKM,
                Label : 'RimborsoKM',
            },
            {
                $Type : 'UI.DataField',
                Value : WBS,
                Label : 'WBS',
            },
            {
                $Type: 'UI.DataField',
                Value: Importo,
                Label: '{i18n>Importo}',
            }
        ],
    }
);

annotate service.ListaNotaSpese with {
    Data @Common.Label: '{i18n>Data}';
//   Divisa @Common.ValueList.CollectionPath : 'Currencies';
};

annotate service.ListaNotaSpese with {
    Divisa @Common.ValueList: {
        $Type          : 'Common.ValueListType',
        Parameters     : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'code',
            LocalDataProperty: Divisa_code,
        }, ],
        CollectionPath : 'Currencies',
        SearchSupported: true,

    };

    Divisa @Common.ValueListWithFixedValues
};

annotate service.ListaNotaSpese with {
    Importo @Measures.ISOCurrency            : Divisa_code;
//    Data    @Consumption.Filter.selectionType: #INTERVAL;

};

annotate service.ListaNotaSpese with @(UI.UpdateHidden: true);
annotate service.ListaNotaSpese with @(UI.DeleteHidden: true);
