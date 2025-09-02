import 'package:eto_pay/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateProvider<UserModel>((ref) {
  return UserModel(
    id: '1',
    name: 'John Doe',
  );
});
