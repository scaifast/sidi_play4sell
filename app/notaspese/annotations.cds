using CatalogService as service from '../../srv/fatturesd-service';
annotate service.ListaNotaSpese with @odata.draft.enabled;
annotate service.ListaNotaSpese with @(
    UI.SelectionFields : [
        IDAgente,
    ]
);


annotate service.ListaNotaSpese with {
    IDAgente @Common.Label : 'IDAgente'
};
annotate service.ListaNotaSpese with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : IDAgente,
        },
        {
            $Type : 'UI.DataField',
            Value : IDNotaSpese,
            Label : 'IDNotaSpese',
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
                Value : IDNotaSpese,
                Label : 'IDNotaSpese',
            },
            {
                $Type : 'UI.DataField',
                Value : IDAgente,
            },
            {
                $Type : 'UI.DataField',
                Value : Data,
                Label : 'Data',
            },
            {
                $Type : 'UI.DataField',
                Value : Descrizione,
                Label : 'Descrizione',
            },{
                $Type : 'UI.DataField',
                Value : Importo,
                Label : 'Importo',
            },],
    }
);
