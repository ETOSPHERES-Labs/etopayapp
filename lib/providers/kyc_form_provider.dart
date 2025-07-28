import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kyc_form_model.dart';

final kycFormProvider = StateNotifierProvider<KycFormNotifier, KycForm>((ref) {
  return KycFormNotifier();
});

class KycFormNotifier extends StateNotifier<KycForm> {
  KycFormNotifier() : super(KycForm());

  void updateFirstName(String value) {
    state = state.copyWith(firstName: value.trim());
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value.trim());
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value.trim());
  }

  void updateTermsAccepted(bool value) {
    state = state.copyWith(termsAccepted: value);
  }

  void updateIssuer(String issuer) {
    state = state.copyWith(idVerificationDocumentIssuer: issuer);
  }

  void updateIdCardImage({
    required bool isFront,
    required Uint8List? webBytes,
    required File? phoneFile,
  }) {
    final currentIdCard = state.idCard ??
        VerificationDocument(
          front: Photo(web: null, phone: null),
          back: Photo(web: null, phone: null),
        );

    final updated = isFront
        ? VerificationDocument(
            front: Photo(web: webBytes, phone: phoneFile),
            back: currentIdCard.back,
          )
        : VerificationDocument(
            front: currentIdCard.front,
            back: Photo(web: webBytes, phone: phoneFile),
          );

    state = state.copyWith(idCard: updated);
  }

  void updateDrivingLicenseImage({
    required bool isFront,
    required Uint8List? webBytes,
    required File? phoneFile,
  }) {
    final currentDrivingLicense = state.drivingLicense ??
        VerificationDocument(
          front: Photo(web: null, phone: null),
          back: Photo(web: null, phone: null),
        );

    VerificationDocument updated;
    if (isFront) {
      updated = VerificationDocument(
        front: Photo(web: webBytes, phone: phoneFile),
        back: currentDrivingLicense.back,
      );
    } else {
      updated = VerificationDocument(
        front: currentDrivingLicense.front,
        back: Photo(web: webBytes, phone: phoneFile),
      );
    }

    state = state.copyWith(drivingLicense: updated);
  }

  void updatePassportImage({
    required bool isFront,
    required Uint8List? webBytes,
    required File? phoneFile,
  }) {
    final currentPassport = state.passport ??
        VerificationDocument(
          front: Photo(web: null, phone: null),
          back: Photo(web: null, phone: null),
        );

    VerificationDocument updated;
    if (isFront) {
      updated = VerificationDocument(
        front: Photo(web: webBytes, phone: phoneFile),
        back: currentPassport.back,
      );
    } else {
      updated = VerificationDocument(
        front: currentPassport.front,
        back: Photo(web: webBytes, phone: phoneFile),
      );
    }

    state = state.copyWith(passport: updated);
  }

  void updateSelfie({Uint8List? webBytes, File? phoneFile}) {
    final updatedPhoto = Photo(web: webBytes, phone: phoneFile);
    state = state.copyWith(selfie: updatedPhoto);
  }

  void updateNationality(String nationality) {
    state = state.copyWith(nationality: nationality);
  }

  void updateVerificationMethod(String method) {
    state = state.copyWith(verificationMethod: method);
  }
}
