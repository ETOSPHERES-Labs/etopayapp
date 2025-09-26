import 'package:eto_pay/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  Future<void> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = UserModel(
      id: '1',
      name: 'John Doe',
    );
    state = user;
  }

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  void updatePreferredNetwork(String network) {
    if (state == null) return;
    state = state!.copyWith(preferredNetwork: network);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

final requireUserProvider = Provider<UserModel>((ref) {
  final user = ref.watch(userProvider);
  if (user == null) {
    throw Exception("User is required but not found.");
  }
  return user;
});
