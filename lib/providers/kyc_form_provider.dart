import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/kyc_form_model.dart';

final kycFormProvider = StateProvider<KycForm>((ref) => KycForm());
