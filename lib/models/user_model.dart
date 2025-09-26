import 'package:eto_pay/models/network_model.dart';

class UserModel {
  final String id;
  final String name;
  final NetworksModel networks;
  final String avatar;
  final String? preferredNetwork;
  final int unreadNotifications;
  final String pin;

  UserModel({
    required this.id,
    required this.name,
    NetworksModel? networks,
    String? avatar,
    this.preferredNetwork,
    this.unreadNotifications = 0,
    this.pin = "444444", // temporary
  })  : networks = networks ?? NetworksModel(),
        avatar = avatar ?? 'assets/images/avatar.png';

  UserModel copyWith({
    String? id,
    String? name,
    NetworksModel? networks,
    String? avatar,
    String? preferredNetwork,
    int? unreadNotifications,
    String? pin,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      networks: networks ?? this.networks,
      avatar: avatar ?? this.avatar,
      preferredNetwork: preferredNetwork ?? this.preferredNetwork,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      pin: pin ?? this.pin,
    );
  }
}
