import 'dart:typed_data';

class KycForm {
  final String? nationality;
  final String? verificationMethod;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? idVerificationDocumentIssuer;
  final Uint8List? idCardImageFileFront;
  final Uint8List? idCardImageFileBack;
  final Uint8List? selfieFile;

  KycForm(
      {this.nationality,
      this.verificationMethod,
      this.firstName,
      this.lastName,
      this.email,
      this.idVerificationDocumentIssuer,
      this.idCardImageFileFront,
      this.idCardImageFileBack,
      this.selfieFile});

  KycForm copyWith({
    String? nationality,
    String? verificationMethod,
    String? firstName,
    String? lastName,
    String? email,
    String? idVerificationDocumentIssuer,
    Uint8List? idCardImageFileFront,
    Uint8List? idCardImageFileBack,
    Uint8List? selfieFile,
  }) {
    return KycForm(
      nationality: nationality ?? this.nationality,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      idVerificationDocumentIssuer:
          idVerificationDocumentIssuer ?? this.idVerificationDocumentIssuer,
      idCardImageFileFront: idCardImageFileFront ?? this.idCardImageFileFront,
      idCardImageFileBack: idCardImageFileBack ?? this.idCardImageFileBack,
      selfieFile: selfieFile ?? this.selfieFile,
    );
  }
}
