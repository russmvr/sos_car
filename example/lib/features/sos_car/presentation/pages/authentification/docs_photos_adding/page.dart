import 'dart:ffi';
import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart' hide State;
import 'package:image_picker/image_picker.dart';

import 'model.dart';
import 'controller.dart';

class PageDocsPhoto extends XPage {
  final UserInfoSosCar userInfo;
  final CarSosCar carInfo;
  PageDocsPhoto([this.userInfo, this.carInfo]);

  @override
  _PageDocsPhotoState createState() => _PageDocsPhotoState();
}

class _PageDocsPhotoState extends XPageState<PageDocsPhoto, Event, State> {
  _PageDocsPhotoState() : super(Controller());
  File _storedImage1;
  File _storedImage2;
  File _storedImage3;
  File _storedImage4;
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();

  _customShowDialog() {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              insetPadding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return Container(
                    height: height - 475,
                    width: width,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 20),
                            child: Text(
                                'Планируете ли вы оказывать услуги эвакуации автомобилей?',
                                style: TextStyle(
                                    height: 1.5,
                                    color: MyColors.black,
                                    fontFamily: 'Inter',
                                    fontWeight: MyParams.textBold,
                                    fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 75),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(MyParams.rounding),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.shadow,
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                width: 145 * AppSize.rWidth(context),
                                height: 50 * AppSize.rWidth(context),
                                // padding: EdgeInsets.symmetric(horizontal: 50),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(MyParams.rounding),
                                  ),
                                  color: MyColors.blue,
                                  child: Text(
                                    'Да',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: MyParams.textBold,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    widget.userInfo.photo1 = _storedImage1;
                                    widget.userInfo.photo2 = _storedImage2;
                                    widget.userInfo.photo3 = _storedImage3;
                                    widget.userInfo.photo4 = _storedImage4;
                                    addEvent(TypeOfEvacuator(
                                        widget.userInfo, widget.carInfo));
                                  },
                                )),
                            SizedBox(width: 20),
                            Container(
                                width: 145 * AppSize.rWidth(context),
                                height: 50 * AppSize.rWidth(context),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(MyParams.rounding),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.shadow,
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 50),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(MyParams.rounding),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    'Нет',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: MyParams.textBold,
                                        color: MyColors.black),
                                  ),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    widget.userInfo.photo1 = _storedImage1;
                                    widget.userInfo.photo2 = _storedImage2;
                                    widget.userInfo.photo3 = _storedImage3;
                                    widget.userInfo.photo4 = _storedImage4;
                                    Evacuator evacuator = Evacuator(
                                        platformType: null,
                                        lengthOfPlatform: null,
                                        platformWidth: null,
                                        carrying: null,
                                        boomLength: null,
                                        vehicleCategory: null,
                                        evacuatorType: null);
                                    UserSosCar allUserInfo = UserSosCar(
                                        userBasicInfo: widget.userInfo,
                                        carBasicInfo: widget.carInfo,
                                        evacuatorBasicInfo: evacuator);
                                    addEvent(LicenseAgreement(allUserInfo));
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  _onPhotoPressed(int number) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 115,
            child: Container(
              child: _buildBottomNavigationMenu(number),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12))),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu(int number) {
    return Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.image, color: MyColors.black),
            title: Text('Выбрать фото с галереи'),
            onTap: () {
              _takePicture('gallery', number);
              Navigator.pop(context);
            }),
        ListTile(
            leading: Icon(Icons.camera, color: MyColors.black),
            title: Text('Сделать фото с камеры'),
            onTap: () {
              _takePicture('camera', number);
              Navigator.pop(context);
            }),
      ],
    );
  }

  Future<void> _takePicture(String name, int number) async {
    final _picker = ImagePicker();
    final PickedFile image = (name == 'gallery')
        ? await _picker.getImage(source: ImageSource.gallery)
        : await _picker.getImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      if (number == 1) _storedImage1 = File(image.path);
      if (number == 2) _storedImage2 = File(image.path);
      if (number == 3) _storedImage3 = File(image.path);
      if (number == 4) _storedImage4 = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      body: ListView(
        children: [
          SizedBox(height: 10),
          Center(
              child: Text('Фото документов',
                  style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'Inter',
                      fontWeight: MyParams.textBold,
                      fontSize: 20))),
          SizedBox(height: 80),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onPhotoPressed(1);
                    },
                    child: Container(
                      width: MyImagesSize.widthFrame(context),
                      height: MyImagesSize.heightFrame(context),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 4, color: MyColors.frameColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: _storedImage1 != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.5)),
                              child: Image.file(
                                _storedImage1,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            )
                          : Image.asset(
                              'assets/images/docs_images/doc1.png',
                              width: MyImagesSize.widthImageDoc134(context),
                              height: MyImagesSize.heightImageDoc134(context),
                            ),
                      alignment: Alignment.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onPhotoPressed(2);
                    },
                    child: Container(
                      width: MyImagesSize.widthFrame(context),
                      height: MyImagesSize.heightFrame(context),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 4, color: MyColors.frameColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: _storedImage2 != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.5)),
                              child: Image.file(
                                _storedImage2,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            )
                          : Image.asset(
                              'assets/images/docs_images/doc2.png',
                              width: MyImagesSize.widthImageDoc2(context),
                              height: MyImagesSize.heightImageDoc2(context),
                            ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Паспорт',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 13)),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Удостоверение',
                      style: TextStyle(
                          color: MyColors.black,
                          fontFamily: 'Inter',
                          fontWeight: MyParams.textBold,
                          fontSize: 13)),
                )
              ],
            ),
          ),
          SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _onPhotoPressed(3);
                },
                child: Container(
                  width: MyImagesSize.widthFrame(context),
                  height: MyImagesSize.heightFrame(context),
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: _storedImage3 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.file(
                            _storedImage3,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        )
                      : Image.asset(
                          'assets/images/docs_images/doc3.png',
                          width: MyImagesSize.widthImageDoc134(context),
                          height: MyImagesSize.heightImageDoc134(context),
                        ),
                  alignment: Alignment.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onPhotoPressed(4);
                },
                child: Container(
                  width: MyImagesSize.widthFrame(context),
                  height: MyImagesSize.heightFrame(context),
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: _storedImage4 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.file(
                            _storedImage4,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        )
                      : Image.asset(
                          'assets/images/docs_images/doc4.png',
                          width: MyImagesSize.widthImageDoc134(context),
                          height: MyImagesSize.heightImageDoc134(context),
                        ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(right: 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('СТС спереди',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 13)),
                Text('СТС сзади',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 13))
              ],
            ),
          ),
          SizedBox(height: 75),
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
                      'Далее',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      if(_storedImage1 == null ||
                          _storedImage2 == null ||
                          _storedImage3 == null ||
                          _storedImage4 == null){
                        _scaffoldKey1.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Необходимо загрузить все фотографии'),
                        ));
                        return;
                      }
                      _customShowDialog();
                    },
                  )),
            ],
          ),
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
