using { Currency, managed, sap } from '@sap/cds/common';

namespace sidi.play4sell;

entity FattureSD : managed {
  key ID      : Integer;
  quantita    : Integer;
}

entity ProviggioniAgenti : managed {
  key	NumDocProvv : String;
		NumPosProvv : String;
		RigaProv : Integer;
		TipoDocComm : String;
		TipoCond : String;
		Società : String;
		NumeroContoForn : String;
		TipoRappAgenzia : String;
		CodAgente : String;
		CatPosDocComm : String;
		DocVend : String;
		PosDocVend : Integer;
		DataDoc : Date;
		Committente : String;
		EsecutorePag : String;
		TipoFattura : String;
		DataDocFattura : Date;
		TipoDocVendita : String;
		OrgComm : String;
		CanaleDistr : String;
		SettMerc : String;
		CodMateriale : String;
		QtaEffettFatturate : Integer;
		UdMVendita : Integer; 
		PercProvv : Currency;
		UdMCond : String;
		ProvvValore3Dec : Currency;
		ChiaveDivisa : String; 
		ImpFatturato : Currency;
		ValNettoDivisaDoc : Currency;
		MaturatoProvvigione : Currency;
		DivisaDocComm : String;
		ModAcquisizione : String;
		ProvvStornata : String;
		ProvvRif : String;
		Agente : String;
		Cliente : String;
		DestMerci : String;
		PrezzoListinoUnitario : Currency;
		PercSconto : String;
		PrezzoVendUnitario : Currency;
		DataRegDoc : Date;
		Contratto : String;
		IndiceContratto : String;
		NumeroAmbito : Integer;
		CodiceDestMerce : String;
		CentroCosto : String;
		PesoNetto : Integer;
		UnitaPeso: String;
		GerarchiaProdotti : String;
		GruppoMerci2 : String;
		GruppoMerci3 : String;
		GruppoMerci4 : String;
}