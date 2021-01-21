import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart' hide State;
import 'package:image_picker/image_picker.dart';

import 'model.dart';
import 'controller.dart';

// ignore: must_be_immutable
class PageLicenseAgreement<T> extends XPage {
  final UserSosCar allUserInfo;
  PageLicenseAgreement({this.allUserInfo});

  @override
  _PageLicenseAgreementState createState() => _PageLicenseAgreementState();
}

class _PageLicenseAgreementState extends XPageState<PageLicenseAgreement, Event, State> {
  _PageLicenseAgreementState() : super(Controller());
  final _auth = FirebaseAuth.instance;



  Widget build(BuildContext context) {
    //test PART
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 10),
        Center(child: Text('Лицензионный договор', style: TextStyle(
            color: MyColors.black,
            fontFamily: 'Inter', fontWeight: MyParams.textBold,
            fontSize: 20))),
        SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(25),
          child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Phasellus scelerisque lacinia purus, sit amet cursus neque suscipit sed. '
              'Nullam at rhoncus metus, et condimentum orci. Vivamus bibendum tincidunt eleifend. '
              'Integer mattis gravida tortor sed pharetra. Orci varius natoque penatibus et magnis dis parturient montes, '
              'nascetur ridiculus mus. Nullam euismod sit amet ex eget aliquet. Nulla dignissim turpis et justo luctus, '
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Phasellus scelerisque lacinia purus, sit amet cursus neque suscipit sed. '
              'Nullam at rhoncus metus, et condimentum orci. Vivamus bibendum tincidunt eleifend. '
              'Integer mattis gravida tortor sed pharetra. Orci varius natoque penatibus et magnis dis parturient montes, '
              'nascetur ridiculus mus. Nullam euismod sit amet ex eget aliquet. Nulla dignissim turpis et justo luctus, '
              'id aliquam erat auctor. '
              'Nullam at rhoncus metus, et condimentum orci. Vivamus bibendum tincidunt eleifend. '
              'Integer mattis gravida tortor sed pharetra. Orci varius natoque penatibus et magnis dis parturient montes, '
              'nascetur ridiculus mus. Nullam euismod sit amet ex eget aliquet. Nulla dignissim turpis et justo luctus, '
              'Sed semper ante a lorem posuere, eget imperdiet elit mattis. Maecenas ultrices magna leo, in mattis sem tincidunt egestas',
            style: TextStyle(fontSize: 15, fontFamily: 'Inter', fontWeight: FontWeight.w300, color: Colors.black),),
      ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50 * AppSize.rWidth(context),
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MyParams.rounding),
                  ),
                  color: MyColors.blue,
                  child: Text(
                    'Согласен',
                    style: TextStyle(
                      fontSize: 18, fontFamily: 'Inter', fontWeight: MyParams.textBold,),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {

                    final photoAvatarUserPath =  FirebaseStorage.instance.ref().child('user_images/${_auth.currentUser.uid}/userInfo/0.jpg');

                    Future<String> validateAvatar(photoUserPath) async {
                      try{
                        final photoAvatar = await photoUserPath.getDownloadURL();
                        return photoAvatar;
                      } catch(e){
                        return null;
                      }
                    }

                    Future<List<String>> getCarPhotos() async {
                      List<String> res=[];
                      for(int i=1;i<5;i++){
                        final carUserPath =  FirebaseStorage.instance.ref().
                        child('user_images/${_auth.currentUser.uid}/userInfo/$i.jpg');
                        res.add(await carUserPath.getDownloadURL());
                      }
                      return res;
                    }

                    final userDocsPath = FirebaseStorage.instance.ref().child('user_images/${_auth.currentUser.uid}/userInfo');
                    if(widget.allUserInfo.userBasicInfo.avatar == null){
                      await userDocsPath.child('1'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo1).whenComplete(() => print('1st photo added'));
                      await userDocsPath.child('2'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo2).whenComplete(() => print('2 photo added'));
                      await userDocsPath.child('3'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo3).whenComplete(() => print('3 photo added'));
                      await userDocsPath.child('4'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo4).whenComplete(() => print('4nd photo added'));     // CЮДА ДОБАВИТЬ ФУНКЦИЮ. КОД ПОВТОРЯЕТСЯ
                    } else {
                      await userDocsPath.child('0'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.avatar).whenComplete(() => print('0st photo added'));
                      await userDocsPath.child('1'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo1).whenComplete(() => print('1st photo added'));
                      await userDocsPath.child('2'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo2).whenComplete(() => print('2 photo added'));
                      await userDocsPath.child('3'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo3).whenComplete(() => print('3 photo added'));
                      await userDocsPath.child('4'+'.jpg').putFile(widget.allUserInfo.userBasicInfo.photo4).whenComplete(() => print('4nd photo added'));
                    }

                    final carDocsPath = FirebaseStorage.instance.ref().child('user_images/${_auth.currentUser.uid}/carInfo');
                    await carDocsPath.child('1'+'.jpg').putFile(widget.allUserInfo.carBasicInfo.photo1).whenComplete(() => print('1st photo car added'));
                    await carDocsPath.child('2'+'.jpg').putFile(widget.allUserInfo.carBasicInfo.photo2).whenComplete(() => print('2st photo car added'));
                    await carDocsPath.child('3'+'.jpg').putFile(widget.allUserInfo.carBasicInfo.photo3).whenComplete(() => print('3st photo car added'));
                    await carDocsPath.child('4'+'.jpg').putFile(widget.allUserInfo.carBasicInfo.photo4).whenComplete(() => print('4nd photo car added'));

                    var checkAvatar = await validateAvatar(photoAvatarUserPath);
                    List<String> urlPhotosCar = await getCarPhotos();


                    await FirebaseFirestore.instance.doc('users/performers').set({
                      '${widget.allUserInfo.userBasicInfo.email}':'${widget.allUserInfo.userBasicInfo.email}',
                      '${widget.allUserInfo.userBasicInfo.phone}':'${widget.allUserInfo.userBasicInfo.phone}'});
                    // FirebaseFirestore.instance.doc('users/performers').set({'${widget.allUserInfo.userBasicInfo.phone}':'${widget.allUserInfo.userBasicInfo.phone}'});

                    await FirebaseFirestore.instance.collection('users/performers/${_auth.currentUser.uid}').doc('userInformation').set({
                    'avatarPhoto': checkAvatar == null ? null : '$checkAvatar' ,
                    'email': '${widget.allUserInfo.userBasicInfo.email}',
                    'phone': '${widget.allUserInfo.userBasicInfo.phone}',
                    'name': '${widget.allUserInfo.userBasicInfo.name}',
                    'surnames': '${widget.allUserInfo.userBasicInfo.surnames}',
                    'middlename': '${widget.allUserInfo.userBasicInfo.middlename}',
                    'city': '${widget.allUserInfo.userBasicInfo.city}',

                  });
                  await FirebaseFirestore.instance.collection('users/performers/${_auth.currentUser.uid}').doc('carInformation').set({
                    'carBrend': '${widget.allUserInfo.carBasicInfo.carBrend}',
                    'carModel': '${widget.allUserInfo.carBasicInfo.carModel}',
                    'stateNumberOfCar': '${widget.allUserInfo.carBasicInfo.stateNumberOfCar}',
                    'yearOfManufacture': widget.allUserInfo.carBasicInfo.yearOfManufacture,
                    'frontviewURL': '${urlPhotosCar[0]}',
                    'behindviewURL': '${urlPhotosCar[1]}',
                    'rightviewURL': '${urlPhotosCar[2]}',
                    'leftviewURL' :'${urlPhotosCar[3]}',
                  });
                  await FirebaseFirestore.instance.collection('users/performers/${_auth.currentUser.uid}').doc('evacuatorInformation').set({
                    'evacuatorType': (widget.allUserInfo.evacuatorBasicInfo.evacuatorType == null) ? null : '${widget.allUserInfo.evacuatorBasicInfo.evacuatorType}',
                    'lengthOfPlatform': widget.allUserInfo.evacuatorBasicInfo.lengthOfPlatform,
                    'platformWidth': widget.allUserInfo.evacuatorBasicInfo.platformWidth,
                    'carrying': widget.allUserInfo.evacuatorBasicInfo.carrying,
                    'vehicleCategory': (widget.allUserInfo.evacuatorBasicInfo.vehicleCategory == null) ? null : '${widget.allUserInfo.evacuatorBasicInfo.vehicleCategory}',
                    'platformType':  (widget.allUserInfo.evacuatorBasicInfo.platformType == null) ? null : '${widget.allUserInfo.evacuatorBasicInfo.platformType}',
                    'boomLength': widget.allUserInfo.evacuatorBasicInfo.boomLength
                  });

              await FirebaseFirestore.instance.collection('users/performers/${_auth.currentUser.uid}').doc('servicesProvidedInformation').set({
                    'helpEvacuator': false,
                    'changeWheel': false,
                    'startingCar': false,
                    'helpTowage': false,
                    'helpFuel': false,
                    'openCar': false,
              });



                      // services provided


                  addEvent(MainPageEvent());



//                  ref.putFile(widget.allUserInfo.userBasicInfo.photo1).whenComplete(() => print('Done'));

//                  FirebaseFirestore.instance.collection('users/performers/${testUserTEST.userBasicInfo.uid}/').add({
//                    'idUser': '${testUserTEST.userBasicInfo.uid}',
//                    'name': testUserTEST.userBasicInfo.name,
//                    'surnames': testUserTEST.userBasicInfo.surnames,
//                    'middlename': testUserTEST.userBasicInfo.middleName,
//                    'city': testUserTEST.userBasicInfo
//                  }
//                  );
                  print('TEST NAME - ${widget.allUserInfo.userBasicInfo.name}');
                  },
                )),
          ],
        ),
        SizedBox(height: 20),
      ],
      ),
    );
  }





}

//
//import 'package:bloc_viper/bloc_viper.dart';
//import 'package:example/features/sos_car/models/car.dart';
//import 'package:example/features/sos_car/models/user_info.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart' hide State;
//import 'package:image_picker/image_picker.dart';
//
//import 'model.dart';
//import 'controller.dart';
//
//class PageCarPhotos extends XPage {
//  final UserInfoSosCar userInfo;
//  final CarSosCar carInfo;
//  PageCarPhotos([this.userInfo, this.carInfo]);
//
//  @override
//  _PageCarPhotosState createState() => _PageCarPhotosState();
//}
//
//class _PageCarPhotosState extends XPageState<PageCarPhotos, Event, State> {
//  _PageCarPhotosState() : super(Controller());
//  final _carBrendController = TextEditingController();
//  final _carModelController = TextEditingController();
//  final _yearOfManufactureController = TextEditingController();
//  final _numberOfCarController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          title: Text('Фото авто'), automaticallyImplyLeading: false),
//      body: ListView(
//        children: [
//          SizedBox(height: 80,),
//          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: [
//              Container(width: 160, height: 110, color: Colors.blue),
//              Container(width: 160, height: 110, color: Colors.blue)],),
//          SizedBox(height: 75,),
//          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: [
//              Container(width: 160, height: 110, color: Colors.blue),
//              Container(width: 160, height: 110, color: Colors.blue)],),
//          SizedBox(height: 120,),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              RaisedButton(
//                  child: Text('OK'),
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  onPressed: () {
//                    final int year = int.parse(_yearOfManufactureController.text.trim());
//                    final CarSosCar carInfo = CarSosCar(
//                        _carBrendController.text.trim(),
//                        _carModelController.text.trim(),
//                        year,
//                        _numberOfCarController.text.trim());
//                    addEvent(CarInfoPage(carInfo));
//                  })
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}
