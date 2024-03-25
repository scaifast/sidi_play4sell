using {
    Currency,
    managed,
    cuid,
    User,
    sap,
    sap.common.CodeList
} from '@sap/cds/common';

namespace sidi.play4sell;

entity FattureSD : managed {
    key ID       : Integer;
        quantita : Integer;
}

type TipoDocComm   : String enum {
    SalesOrder = 'C';
    Invoice    = 'M';
}

type Percentage    : Decimal(11, 2);
type Value         : Decimal(15, 3);
type Amount        : Decimal(15, 3);

entity UnitOfMeasures : CodeList {
    key code : String(3)
}

type UnitOfMeasure : Association to UnitOfMeasures;

entity Company : managed {
    key Company  : String;
        Name     : String;

        @readonly
        Currency : Currency;
}

entity Agenti : managed {
    key utente : User;
    supplier   : String;
	name : String;
}

type Agente : Association to Agenti;

/** Documenti Vendita con provvigione calcolata da ProAge */
entity ProviggioniAgenti : managed {
    key NumDocProvv           : String not null;
        NumPosProvv           : String not null;
        RigaProv              : Integer not null;
        TipoDocComm           : TipoDocComm not null;
        TipoCond              : String;
        Societa               : Association to Company;
        NumeroContoForn       : String;
        TipoRappAgenzia       : String;
        Agente             : Agente;
        CatPosDocComm         : String;
        DocVend               : String;
        PosDocVend            : Integer;
        DataDoc               : Date;
        Committente           : String;
        EsecutorePag          : String;
        TipoFattura           : String;
        DataDocFattura        : Date;
        TipoDocVendita        : String;
        OrgComm               : String;
        CanaleDistr           : String;
        SettMerc              : String;
        CodMateriale          : String;

        @sap.unit                     : 'UdMVendita.code'
        @Semantics.amount.currencyCode: 'UdMVendita.code'
        @Measures.Unit                : UdMVendita.code
        QtaEffettFatturate    : Value;
        UdMVendita            : UnitOfMeasure;

        @sap.unit                     : 'UdMCond'
        @Semantics.amount.currencyCode: 'UdMCond'
        @Measures.Unit                : UdMCond
        PercProvv             : Percentage;
        UdMCond               : String;

        @sap.unit                     : 'UdMCond'
        @Semantics.amount.currencyCode: 'UdMCond'
        @Measures.Unit                : UdMCond
        ProvvValore           : Value;

        Divisa                : Currency;

        @sap.unit                     : 'Societa.Currency.code'
        @Semantics.amount.currencyCode: 'Societa.Currency.code'
        @Measures.Unit                : Societa.Currency.code
        ImpFatturato          : Value;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa.code'
        @Measures.Unit                : Divisa.code
        ValNettoDivisaDoc     : Value;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa.code'
        @Measures.Unit                : Divisa.code
        MaturatoProvvigione   : Value;
        DivisaDocComm         : String;
        ModAcquisizione       : String;
        ProvvStornata         : String;
        ProvvRif              : String;
        AgenteInternoEsterno                : String;
        ClienteInternoEsterno               : String;
        DestMerci             : String;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa.code'
        @Measures.Unit                : Divisa.code
        PrezzoListinoUnitario : Value;
        PercSconto            : Percentage;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa.code'
        @Measures.Unit                : Divisa.code
        PrezzoVendUnitario    : Value;
        DataRegDoc            : Date;
        Contratto             : String;
        IndiceContratto       : String;
        NumeroAmbito          : Integer;
        CodiceDestMerce       : String;
        CentroCosto           : String;

        @sap.unit                     : 'UdM.code'
        @Semantics.amount.currencyCode: 'UdM.code'
        @Measures.Unit                : UdM.code
        PesoNetto             : Amount;
        UdM                   : UnitOfMeasure;
        GerarchiaProdotti     : String;
        GruppoMerci2          : String;
        GruppoMerci3          : String;
        GruppoMerci4          : String;
}

entity NotaSpese @(restrict: [
    { grant: ['READ','WRITE'], where: 'Agente = $user' },
  ]) : managed, cuid {
//    key IDNotaSpese  : String;
    key Agente       : User @cds.on.insert : $user;
        Data         : Date;
        Rimborso     : Value;
        Descrizione  : String;
        DescRimborso : String;
        RimborsoKM   : String;
        WBS          : String;

        Divisa       : Currency;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa'
//        @Measures.Unit                : Divisa.code
        Importo      : Value;
}

entity Products     : managed{
    Key CodProduct  : String;
        DescProduct : String;
        Img         : String;                   //todo 
        UoM         : UnitOfMeasure;
        Divisa       : Currency;

        @sap.unit                     : 'Divisa.code'
        @Semantics.amount.currencyCode: 'Divisa.code'
        @Measures.Unit                : Divisa.code
        UnitPrice   : Value;
        Origin      : String;
        FlagPromo   : Boolean;
        FlagDiscount: Boolean;

        @sap.unit                     : 'UoM.code'
        @Semantics.amount.currencyCode: 'UoM.code'
        @Measures.Unit                : UoM.code
        Stock       : Amount;

}
