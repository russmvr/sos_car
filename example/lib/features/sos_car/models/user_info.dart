import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoSosCar extends Equatable {
  final String email;
  final String phone;
  final int password;
  final String name;
  final String surnames;
  final String middlename;
  final String city;
  File avatar;
  File photo1;
  File photo2;
  File photo3;
  File photo4;

  final String avatarPhoto;




  UserInfoSosCar({
    this.avatar,
    this.email,
    this.phone,
      this.password,
      this.name,
      this.surnames,
      this.middlename,
      this.city,
    this.avatarPhoto}
      );



}
