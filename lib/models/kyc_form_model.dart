import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class VerificationDocument {
  final Photo? front;
  final Photo? back;

  VerificationDocument({
    required this.front,
    required this.back,
  });
}

class Photo {
  final Uint8List? web;
  final File? phone;

  Photo({
    required this.web,
    required this.phone,
  });
}

class KycForm {
  final String? nationality;
  final String? verificationMethod;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? termsAccepted;
  final String? idVerificationDocumentIssuer;
  final VerificationDocument? idCard;
  final VerificationDocument? passport;
  final VerificationDocument? drivingLicense;
  final Photo? selfie;

  KycForm({
    this.nationality,
    this.verificationMethod,
    this.firstName,
    this.lastName,
    this.email,
    this.termsAccepted,
    this.idVerificationDocumentIssuer,
    this.idCard,
    this.passport,
    this.drivingLicense,
    this.selfie,
  });

  KycForm copyWith({
    String? nationality,
    String? verificationMethod,
    String? firstName,
    String? lastName,
    String? email,
    bool? termsAccepted,
    String? idVerificationDocumentIssuer,
    VerificationDocument? idCard,
    VerificationDocument? passport,
    VerificationDocument? drivingLicense,
    Photo? selfie,
  }) {
    return KycForm(
      nationality: nationality ?? this.nationality,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      idVerificationDocumentIssuer:
          idVerificationDocumentIssuer ?? this.idVerificationDocumentIssuer,
      idCard: idCard ?? this.idCard,
      passport: passport ?? this.passport,
      drivingLicense: drivingLicense ?? this.drivingLicense,
      selfie: selfie ?? this.selfie,
    );
  }

  bool get isStep1Valid =>
      firstName != null &&
      firstName!.isNotEmpty &&
      lastName != null &&
      lastName!.isNotEmpty &&
      email != null &&
      _isValidEmail(email!) &&
      termsAccepted == true;

  static bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool get isIssuerSet =>
      idVerificationDocumentIssuer != null &&
      idVerificationDocumentIssuer!.isNotEmpty;

  bool _isDocumentComplete(VerificationDocument? doc) {
    if (doc == null) return false;
    if (kIsWeb) {
      return (doc.front?.web != null) && (doc.back?.web != null);
    } else {
      return (doc.front?.phone != null) && (doc.back?.phone != null);
    }
  }

  bool get isStep2IdCardValid => isIssuerSet && _isDocumentComplete(idCard);
  bool get isStep2PassportValid => isIssuerSet && _isDocumentComplete(passport);
  bool get isStep2DrivingLicenseValid =>
      isIssuerSet && _isDocumentComplete(drivingLicense);

  bool get isStep3Valid =>
      idVerificationDocumentIssuer != null && selfie != null;

  bool get isSelfieValid {
    if (selfie == null) return false;
    if (kIsWeb) {
      return selfie!.web != null;
    } else {
      return selfie!.phone != null;
    }
  }

  bool get isStep0Valid {
    return nationality != null && nationality!.isNotEmpty;
  }

  bool get isStep4Valid {
    return isStep0Valid && isStep1Valid && 
      (isStep2DrivingLicenseValid || isStep2PassportValid || isStep2IdCardValid) &&
      isStep3Valid;
  }
}
