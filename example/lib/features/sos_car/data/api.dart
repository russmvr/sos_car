import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/params/empty_params.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Api {

  static Future<ServicesProvided> setServices(ServicesProvided services) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'changeWheel': services.changeWheel});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'helpEvacuator': services.helpEvacuator});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'helpFuel': services.helpFuel});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'helpTowage': services.helpTowage});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'openCar': services.openCar});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .update({'startingCar': services.startingCar});

    var servInfoFromBack = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .get();

    final ServicesProvided evacResult = ServicesProvided(
      changeWheel: servInfoFromBack.data()['changeWheel'],
      helpEvacuator: servInfoFromBack.data()['helpEvacuator'],
      openCar: servInfoFromBack.data()['openCar'],
      helpFuel: servInfoFromBack.data()['helpFuel'],
      helpTowage: servInfoFromBack.data()['helpTowage'],
      startingCar: servInfoFromBack.data()['startingCar'],
    );

    return evacResult;

  }



  static Future<Evacuator> updateInfoEvacuator(Evacuator newEvacInfo) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'evacuatorType': '${newEvacInfo.evacuatorType}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'carrying': newEvacInfo.carrying});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'lengthOfPlatform': newEvacInfo.lengthOfPlatform});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'platformType': newEvacInfo.platformType == null ? null : '${newEvacInfo.platformType}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'platformWidth': newEvacInfo.platformWidth});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'vehicleCategory': '${newEvacInfo.vehicleCategory}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .update({'boomLength': newEvacInfo.boomLength == null ? null : newEvacInfo.boomLength});

    var evacInfoFromBack = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .get();

    final Evacuator evacResult = Evacuator(
      boomLength: evacInfoFromBack.data()['boomLength'],
      evacuatorType: evacInfoFromBack.data()['evacuatorType'],
      platformWidth: evacInfoFromBack.data()['platformWidth'],
      platformType: evacInfoFromBack.data()['platformType'],
      lengthOfPlatform: evacInfoFromBack.data()['lengthOfPlatform'],
      carrying: evacInfoFromBack.data()['carrying'],
      vehicleCategory: evacInfoFromBack.data()['vehicleCategory'],

    );
    return evacResult;

  }
  static Future<CarSosCar> updateInfoCar(CarSosCar newInfoCar) async {

    FirebaseAuth _auth = FirebaseAuth.instance;

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .update({'carBrend': '${newInfoCar.carBrend}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .update({'carModel': '${newInfoCar.carModel}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .update({'stateNumberOfCar': '${newInfoCar.stateNumberOfCar}'});

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .update({'yearOfManufacture': newInfoCar.yearOfManufacture});

    var carInfoFromBack = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .get();

    final CarSosCar carResult = CarSosCar(
      carBrend: carInfoFromBack.data()['carBrend'],
      carModel: carInfoFromBack.data()['carModel'],
      stateNumberOfCar: carInfoFromBack.data()['stateNumberOfCar'],
      yearOfManufacture: carInfoFromBack.data()['yearOfManufacture'],
      frontviewURL: carInfoFromBack.data()['frontviewURL'],
      behindviewURL: carInfoFromBack.data()['behindviewURL'],
      rightviewURL: carInfoFromBack.data()['rightviewURL'],
      leftviewURL: carInfoFromBack.data()['leftviewURL'],
    );
    return carResult;


  }

  static Future<UserInfoSosCar> updateAvatar(File newAvatar) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    var userInfo = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('userInformation')
        .get();

    final photoAvatarUserPath = FirebaseStorage.instance
        .ref()
        .child('user_images/${_auth.currentUser.uid}/userInfo/0.jpg');

    Future<String> validateAvatar(photoUserPath) async {
      try {
        final photoAvatar = await photoUserPath.getDownloadURL();
        return photoAvatar;
      } catch (e) {
        return null;
      }
    }

    final userDocsPath = FirebaseStorage.instance
        .ref()
        .child('user_images/${_auth.currentUser.uid}/userInfo');
    await userDocsPath
        .child('0' + '.jpg')
        .putFile(newAvatar)
        .whenComplete(() => print('0st photo updated'));

    var checkAvatar = await validateAvatar(photoAvatarUserPath);

    await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('userInformation')
        .update({'avatarPhoto': checkAvatar == null ? null : '$checkAvatar'});

    final UserInfoSosCar userInfoResult = UserInfoSosCar(
      email: userInfo.data()['email'],
      phone: userInfo.data()['phone'],
      city: userInfo.data()['city'],
      middlename: userInfo.data()['middlename'],
      name: userInfo.data()['name'],
      surnames: userInfo.data()['surnames'],
      avatarPhoto: userInfo.data()['avatarPhoto'],
    );

    return userInfoResult;
  }


  static Future<AllUserInfoModel> getInfoProfile() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    var userInfo = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('userInformation')
        .get();

    var carInfo = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('carInformation')
        .get();

    var evacInfo = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('evacuatorInformation')
        .get();

    var servicesInfo = await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('servicesProvidedInformation')
        .get();

    // #### ТЕСТ ЗОНА
    // final photoUserPath =  FirebaseStorage.instance.ref().child('user_images/${_auth.currentUser.uid}/userInfo/0.jpg');
    //
    // Future<List<String>> getCarPhotos() async {
    //   List<String> res=[];
    //   for(int i=1;i<5;i++){
    //     final carUserPath =  FirebaseStorage.instance.ref().child('user_images/${_auth.currentUser.uid}/userInfo/$i.jpg');
    //     res.add(await carUserPath.getDownloadURL());
    //   }
    //   return res;
    // }
    //
    // Future<String> validateAvatar(photoUserPath) async {
    //   try{
    //     final photoAvatar = await photoUserPath.getDownloadURL();
    //     return photoAvatar;
    //   } catch(e){
    //     return null;
    //   }
    // }

    /// #####

    final UserInfoSosCar userInfoResult = UserInfoSosCar(
      email: userInfo.data()['email'],
      phone: userInfo.data()['phone'],
      city: userInfo.data()['city'],
      middlename: userInfo.data()['middlename'],
      name: userInfo.data()['name'],
      surnames: userInfo.data()['surnames'],
      avatarPhoto: await userInfo.data()['avatarPhoto'],
    );

    final CarSosCar carInfoResult = CarSosCar(
      carBrend: carInfo.data()['carBrend'],
      carModel: carInfo.data()['carModel'],
      stateNumberOfCar: carInfo.data()['stateNumberOfCar'],
      yearOfManufacture: carInfo.data()['yearOfManufacture'],
      frontviewURL: await carInfo.data()['frontviewURL'],
      behindviewURL: await carInfo.data()['behindviewURL'],
      rightviewURL: await carInfo.data()['rightviewURL'],
      leftviewURL: await carInfo.data()['leftviewURL'],
    );

    final Evacuator evacInfoResult = Evacuator(
        boomLength: evacInfo.data()['boomLength'],
        carrying: evacInfo.data()['carrying'],
        lengthOfPlatform: evacInfo.data()['lengthOfPlatform'],
        platformType: evacInfo.data()['platformType'],
        platformWidth: evacInfo.data()['platformWidth'],
        vehicleCategory: evacInfo.data()['vehicleCategory'],
        evacuatorType: evacInfo.data()['evacuatorType']);

    final ServicesProvided servicesInfoResult = ServicesProvided(
      changeWheel: servicesInfo.data()['changeWheel'],
      helpEvacuator: servicesInfo.data()['helpEvacuator'],
      helpFuel: servicesInfo.data()['helpFuel'],
      helpTowage: servicesInfo.data()['helpTowage'],
      openCar: servicesInfo.data()['openCar'],
      startingCar: servicesInfo.data()['startingCar']);


    final AllUserInfoModel allUserInfo = AllUserInfoModel(
        userBasicInfo: userInfoResult,
        carBasicInfo: carInfoResult,
        evacuatorBasicInfo: evacInfoResult,
        servicesInfo: servicesInfoResult );
    return allUserInfo;
    // await user.doc('userInformation').get();
  }
}
