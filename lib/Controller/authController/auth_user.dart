import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String? phone;
  final String? email;
  final String? name;
  final String? imageUrl;
  final String? providerId;
  const AuthUser(
      {required this.id, this.phone, this.email, this.name, this.imageUrl, this.providerId});

  factory AuthUser.fromFirebase(User user) => AuthUser(
      id: user.uid,
      phone: user.phoneNumber,
      email: user.email,
      name: user.displayName,
      imageUrl: user.photoURL,
      providerId: user.providerData.first.providerId);
}
