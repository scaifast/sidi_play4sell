using CatalogService as service from '../../srv/fatturesd-service';
annotate service.ListaNotaSpese with @odata.draft.enabled;
annotate service.ListaNotaSpese with @(
    UI.SelectionFields : [
        Agente,
    ]
);


//annotate service.ListaNotaSpese with {
//    Agente @Common.Label : 'IDAgente'
//};

annotate service.ListaNotaSpese with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : Agente,
        },
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'IDNotaSpese',
        },
        {
            $Type : 'UI.DataField',
            Value : Agente,
            Label : 'Agente_utente',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : Data,
        },
        {
            $Type : 'UI.DataField',
            Value : DescRimborso,
            Label : 'DescRimborso',
        },
        {
            $Type : 'UI.DataField',
            Value : Descrizione,
            Label : 'Descrizione',
        },
        {
            $Type : 'UI.DataField',
            Value : Divisa_code,
        },
        {
            $Type : 'UI.DataField',
            Value : Importo,
            Label : 'Importo',
        },
        {
            $Type : 'UI.DataField',
            Value : Rimborso,
            Label : 'Rimborso',
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
            $Type : 'UI.DataField',
            Value : Divisa.code,
        },
        {
            $Type : 'UI.DataField',
            Value : Divisa.descr,
        },
        {
            $Type : 'UI.DataField',
            Value : Divisa.minorUnit,
        },
        {
            $Type : 'UI.DataField',
            Value : Divisa.name,
        },
        {
            $Type : 'UI.DataField',
            Value : Divisa.symbol,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedBy,
        },
    ]
);
annotate service.ListaNotaSpese with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Nota Spesa',
            ID : 'NotaSpesa',
            Target : '@UI.FieldGroup#NotaSpesa',
        },
    ],
    UI.FieldGroup #NotaSpesa : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : '{i18n>IDNotaspese}',
            },
            {
                $Type : 'UI.DataField',
                Value : Agente,
            },
            {
                $Type : 'UI.DataField',
                Value : Data,
                Label : '{i18n>Data}',
            },
            {
                $Type : 'UI.DataField',
                Value : Importo,
                Label : '{i18n>Importo}',
            },
            {
                $Type : 'UI.DataField',
                Value : Descrizione,
                Label : '{i18n>Descrizione}',
            }
        ],
    }
);

annotate service.ListaNotaSpese with {
    Data @Common.Label : 'Data';
 //   Divisa @Common.ValueList.CollectionPath : 'Currencies';
};
annotate service.ListaNotaSpese with {
    Divisa @Common.ValueList : {
        $Type : 'Common.ValueListType',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                ValueListProperty : 'code',
                LocalDataProperty : Divisa_code,
            },
        ],
        CollectionPath : 'Currencies',
        SearchSupported : true,
    }
};

annotate service.ListaNotaSpese with {
    Importo @Measures.ISOCurrency : Divisa_code
};
annotate service.ListaNotaSpese with @(
    UI.UpdateHidden : true
);
annotate service.ListaNotaSpese with @(
    UI.DeleteHidden : true
);
