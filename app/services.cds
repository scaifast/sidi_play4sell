
using {sidi.play4sell as my} from './fatture/annotations';

using from './notaspese/annotations';
using CatalogService as service from '../srv/fatturesd-service'; 




annotate service.ListaProviggioniAgenti with @(
  Aggregation.ApplySupported: {
    Transformations: [
      'aggregate',
      'topcount',
      'bottomcount',
      'identity',
      'concat',
      'groupby',
      'filter',
      'search'      
    ],
    GroupableProperties: [
      Agente.supplier,
      CanaleDistr

    ],
    AggregatableProperties: [{
      $Type : 'Aggregation.AggregatablePropertyType',
      Property: ImpFatturato
    }]
  },
  Analytics.AggregatedProperty #TotaleFatturato: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : ImpFatturato,
    AggregationMethod : 'sum',
    Name : 'TotaleFatturato',
    ![@Common.Label]: 'TotaleFatturato'
  },
);

annotate service.ListaProviggioniAgenti with @(
  UI.Chart: {
    $Type : 'UI.ChartDefinitionType',
    Title: 'Stock',
    ChartType : #Column,
    Dimensions: [
      ClienteInternoEsterno,
      CanaleDistr
    ],
    DimensionAttributes: [{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: ClienteInternoEsterno,
      Role: #Category
    },{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: CanaleDistr,
      Role: #Category2
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#TotaleFatturato]
    ],
    MeasureAttributes: [{
      $Type: 'UI.ChartMeasureAttributeType',
      DynamicMeasure: ![@Analytics.AggregatedProperty#TotaleFatturato],
      Role: #Axis1
    }]
  },
  UI.PresentationVariant: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart',
    ],
  }
);

annotate service.ListaProviggioniAgenti with @(
  UI.Chart #category1: {
    $Type : 'UI.ChartDefinitionType',
    ChartType: #Bar,
    Dimensions: [
      ClienteInternoEsterno
    ],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#TotaleFatturato]
    ]
  },
  UI.PresentationVariant #prevCategory1: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart#category1',
    ],
  }
){
  ClienteInternoEsterno @Common.ValueList #vlCategory1: {
    $Type : 'Common.ValueListType',
    CollectionPath : 'ListaProviggioniAgenti',
    Parameters: [{
      $Type : 'Common.ValueListParameterInOut',
      ValueListProperty : 'ClienteInternoEsterno',
      LocalDataProperty: ClienteInternoEsterno
    }],
    PresentationVariantQualifier: 'prevCategory1'
  }
};
annotate service.ListaProviggioniAgenti with@(
    UI: {
        SelectionFields  : [
            ClienteInternoEsterno,
            CanaleDistr
        ],
        LineItem: [
            {  $Type : 'UI.DataField', Value : ClienteInternoEsterno, },
            {  $Type : 'UI.DataField', Value : CanaleDistr, },
        ],
    }
);



using from './venduto/annotations';