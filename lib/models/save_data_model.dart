import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/commons/result_model.dart';
import 'package:precheckin/models/commons/vuelos_model.dart';
import 'package:precheckin/models/commons/acuerdos_model.dart';
import 'package:precheckin/utils/fecha_util.dart' as futil;



class SaveData {
    Dbdatostmp dbdatostmp;
    String iduser;
    String idhotel;
    Rh rh;

    SaveData({
      this.dbdatostmp,
      this.iduser,
      this.idhotel,
      this.rh,
    });

    factory SaveData.fromResult(Result result){
      return new SaveData(
        dbdatostmp : new Dbdatostmp(),
        iduser     : "JDELGADO",
        idhotel    : result.idClub.toString(),
        rh         : Rh.fromResult(result) 
      );
    }

    Map<String, dynamic> toJson() => {
      "dbdatostmp" : dbdatostmp.toJson(),
      "iduser"     : iduser,
      "idhotel"    : idhotel,
      "rh"         : rh.toJson(),
    };
}


class Dbdatostmp {
    Dbdatostmp();
    factory Dbdatostmp.fromJson(Map<String, dynamic> json) => Dbdatostmp();
    Map<String, dynamic> toJson() => {};
}

class Rh {
  int idreserva;
  int idcliente;
  int uclub;
  String idstatus;
  String nombre;
  String direccion;
  String ciudad;
  String telefono;
  String emailhogar;
  String pais;
  String estado;
  String cpsocio;
  String usuarioregistro;
  Acuerdos acuerdos;
  List<Vecaco> vecaco;
  List<Vuelos> vuelos;

  Rh({
      this.idreserva,
      this.idcliente,
      this.uclub,
      this.idstatus,
      this.nombre,
      this.direccion,
      this.ciudad,
      this.telefono,
      this.emailhogar,
      this.pais,
      this.estado,
      this.cpsocio,
      this.usuarioregistro,
      this.acuerdos,
      this.vecaco,
      this.vuelos,
  });

  factory Rh.fromResult(Result result){
    List<Vecaco> vecacos = [Vecaco.fromAcompaniante(result.titular)];

    result.acompaniantes.forEach((acompaniante) { 
      vecacos.add(Vecaco.fromAcompaniante(acompaniante));
    });

    return new Rh(
      idreserva       : result.idReserva,
      idcliente       : result.idCliente,
      uclub           : result.idClub,
      idstatus        : result.status,
      nombre          : result.nombreTitular,
      direccion       : result.direccion,
      ciudad          : result.ciudad,
      telefono        : result.telefono,
      emailhogar      : result.email,
      pais            : result.pais,
      estado          : result.estado,
      cpsocio         : result.codigoPostal,
      usuarioregistro : "JDELGADO",
      acuerdos        : result.acuerdos,
      vecaco          : vecacos,
      vuelos          : result.vuelos,
    );
  }

  Map<String, dynamic> toJson() => {
    "idreserva": idreserva,
    "idcliente": idcliente,
    "uclub": uclub,
    "idstatus": idstatus,
    "nombre": nombre,
    "direccion": direccion,
    "ciudad": ciudad,
    "telefono": telefono,
    "emailhogar": emailhogar,
    "pais": pais,
    "estado": estado,
    "cpsocio": cpsocio,
    "usuarioregistro": usuarioregistro,
    "tarreg": acuerdos.toJson(),
    "vecaco": List<dynamic>.from(vecaco.map((x) => x.toJson())),
    "vuelos": List<dynamic>.from(vuelos.map((v) => v.toJson())),
  };
}

class Vecaco {
    int club;
    int idcliente;
    int idacompaniantes;
    String nombre;
    String fechanac;
    String imagefront;
    String imageback;
    String imagesign;
    String pais;
    String sexo;
    String idcard;
    String documenttype;
    String documentexpdate;
    int istitular;

    Vecaco({
      this.club,
      this.idcliente,
      this.idacompaniantes,
      this.nombre,
      this.fechanac,
      this.imagefront,
      this.imageback,
      this.imagesign,
      this.pais,
      this.sexo,
      this.idcard,
      this.documenttype,
      this.documentexpdate,
      this.istitular,
    });

    factory Vecaco.fromAcompaniante(Acompaniantes acompaniante) {
      return new Vecaco(
        club            : acompaniante.club,
        idcliente       : acompaniante.idcliente,
        idacompaniantes : acompaniante.idacompaniantes,
        nombre          : acompaniante.nombre,
        fechanac        : futil.splitFecha(acompaniante.fechanac),
        imagefront      : acompaniante.imagefront,
        imageback       : acompaniante.imageback,
        imagesign       : acompaniante.imagesign,
        pais            : acompaniante.pais,
        sexo            : acompaniante.sexo,
        idcard          : acompaniante.idcard,
        documenttype    : acompaniante.documenttype,
        documentexpdate : futil.splitFecha(acompaniante.documentexpdate),
        istitular       : acompaniante.istitular ? 1 : 0
      );
    }

    Map<String, dynamic> toJson() => {
      "club"            : club,
      "idcliente"       : idcliente,
      "idacompaniantes" : idacompaniantes,
      "nombre"          : nombre,
      "fechanac"        : fechanac,
      "imagefront"      : imagefront,
      "imageback"       : imageback,
      "imagesign"       : imagesign,
      "pais"            : pais,
      "sexo"            : sexo,
      "idcard"          : idcard,
      "documenttype"    : documenttype,
      "documentexpdate" : documentexpdate,
      "istitular"       : istitular,
  };
}
