import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CarSosCar extends Equatable{
  final String carBrend;
  final String carModel;
  final int yearOfManufacture;
  final String stateNumberOfCar;
  final String frontviewURL;
  final String behindviewURL;
  final String rightviewURL;
  final String leftviewURL;


  File photo1;
  File photo2;
  File photo3;
  File photo4;


  CarSosCar({
      this.carBrend,
      this.carModel,
      this.yearOfManufacture,
      this.stateNumberOfCar,
      this.frontviewURL,
     this.behindviewURL,
     this.rightviewURL,
      this.leftviewURL,
  });


}