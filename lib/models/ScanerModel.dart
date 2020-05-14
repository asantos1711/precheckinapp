
import 'dart:convert';

ScanerModel scanerModelFromJson(String str) => ScanerModel.fromJson(json.decode(str));

String scanerModelToJson(ScanerModel data) => json.encode(data.toJson());

class ScanerModel {
    String documentTypeRaw;
    String documentTypeReadable;
    String issuingCountry;
    String surname;
    String documentNumber;
    String documentNumberWithCheckDigit;
    String documentNumberCheckDigit;
    String nationality;
    String dobRaw;
    String dobWithCheckDigit;
    String dobCheckDigit;
    String dobReadable;
    String sex;
    String estIssuingDateRaw;
    String estIssuingDateReadable;
    String expirationDateRaw;
    String expirationDateWithCheckDigit;
    String expirationDateCheckDigit;
    String expirationDateReadable;
    String masterCheckDigit;
    String givenNamesReadable;
    String optionals;
    String portrait;
    String signature;
    String full_image;

    ScanerModel({
        this.documentTypeRaw,
        this.documentTypeReadable,
        this.issuingCountry,
        this.surname,
        this.documentNumber,
        this.documentNumberWithCheckDigit,
        this.documentNumberCheckDigit,
        this.nationality,
        this.dobRaw,
        this.dobWithCheckDigit,
        this.dobCheckDigit,
        this.dobReadable,
        this.sex,
        this.estIssuingDateRaw,
        this.estIssuingDateReadable,
        this.expirationDateRaw,
        this.expirationDateWithCheckDigit,
        this.expirationDateCheckDigit,
        this.expirationDateReadable,
        this.masterCheckDigit,
        this.givenNamesReadable,
        this.optionals,
        this.portrait,
        this.signature,
        this.full_image
    });

    factory ScanerModel.fromJson(Map<String, dynamic> json) => ScanerModel(
        documentTypeRaw: json["document_type_raw"] == null ? null : json["document_type_raw"],
        documentTypeReadable: json["document_type_readable"] == null ? null : json["document_type_readable"],
        issuingCountry: json["issuing_country"] == null ? null : json["issuing_country"],
        surname: json["surname"] == null ? null : json["surname"],
        documentNumber: json["document_number"] == null ? null : json["document_number"],
        documentNumberWithCheckDigit: json["document_number_with_check_digit"] == null ? null : json["document_number_with_check_digit"],
        documentNumberCheckDigit: json["document_number_check_digit"] == null ? null : json["document_number_check_digit"],
        nationality: json["nationality"] == null ? null : json["nationality"],
        dobRaw: json["dob_raw"] == null ? null : json["dob_raw"],
        dobWithCheckDigit: json["dob_with_check_digit"] == null ? null : json["dob_with_check_digit"],
        dobCheckDigit: json["dob_check_digit"] == null ? null : json["dob_check_digit"],
        dobReadable: json["dob_readable"] == null ? null : json["dob_readable"],
        sex: json["sex"] == null ? null : json["sex"],
        estIssuingDateRaw: json["est_issuing_date_raw"] == null ? null : json["est_issuing_date_raw"],
        estIssuingDateReadable: json["est_issuing_date_readable"] == null ? null : json["est_issuing_date_readable"],
        expirationDateRaw: json["expiration_date_raw"] == null ? null : json["expiration_date_raw"],
        expirationDateWithCheckDigit: json["expiration_date_with_check_digit"] == null ? null : json["expiration_date_with_check_digit"],
        expirationDateCheckDigit: json["expiration_date_check_digit"] == null ? null : json["expiration_date_check_digit"],
        expirationDateReadable: json["expiration_date_readable"] == null ? null : json["expiration_date_readable"],
        masterCheckDigit: json["master_check_digit"] == null ? null : json["master_check_digit"],
        givenNamesReadable: json["given_names_readable"] == null ? null : json["given_names_readable"],
        optionals: json["optionals"] == null ? null : json["optionals"],
        portrait: json["portrait"] == null ? null : json["portrait"],
        signature: json["signature"] == null ? null : json["signature"],
        full_image: json["full_image"] == null ? null : json["full_image"],
    );

    Map<String, dynamic> toJson() => {
        "document_type_raw": documentTypeRaw == null ? null : documentTypeRaw,
        "document_type_readable": documentTypeReadable == null ? null : documentTypeReadable,
        "issuing_country": issuingCountry == null ? null : issuingCountry,
        "surname": surname == null ? null : surname,
        "document_number": documentNumber == null ? null : documentNumber,
        "document_number_with_check_digit": documentNumberWithCheckDigit == null ? null : documentNumberWithCheckDigit,
        "document_number_check_digit": documentNumberCheckDigit == null ? null : documentNumberCheckDigit,
        "nationality": nationality == null ? null : nationality,
        "dob_raw": dobRaw == null ? null : dobRaw,
        "dob_with_check_digit": dobWithCheckDigit == null ? null : dobWithCheckDigit,
        "dob_check_digit": dobCheckDigit == null ? null : dobCheckDigit,
        "dob_readable": dobReadable == null ? null : dobReadable,
        "sex": sex == null ? null : sex,
        "est_issuing_date_raw": estIssuingDateRaw == null ? null : estIssuingDateRaw,
        "est_issuing_date_readable": estIssuingDateReadable == null ? null : estIssuingDateReadable,
        "expiration_date_raw": expirationDateRaw == null ? null : expirationDateRaw,
        "expiration_date_with_check_digit": expirationDateWithCheckDigit == null ? null : expirationDateWithCheckDigit,
        "expiration_date_check_digit": expirationDateCheckDigit == null ? null : expirationDateCheckDigit,
        "expiration_date_readable": expirationDateReadable == null ? null : expirationDateReadable,
        "master_check_digit": masterCheckDigit == null ? null : masterCheckDigit,
        "given_names_readable": givenNamesReadable == null ? null : givenNamesReadable,
        "optionals": optionals == null ? null : optionals,
        "portrait": portrait == null ? null : portrait,
        "signature": signature == null ? null : signature,
        "full_image": full_image == null ? null : full_image,
    };
}