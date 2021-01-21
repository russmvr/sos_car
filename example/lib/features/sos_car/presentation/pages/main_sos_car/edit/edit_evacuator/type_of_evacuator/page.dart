import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart' hide State;
import 'package:image_picker/image_picker.dart';

import 'model.dart';
import 'controller.dart';

class PageEditTypeEvacuator extends XPage {
  final AllUserInfoModel allInfo;
  PageEditTypeEvacuator(this.allInfo);

  @override
  _PageEditTypeEvacuatorState createState() => _PageEditTypeEvacuatorState();
}

class _PageEditTypeEvacuatorState
    extends XPageState<PageEditTypeEvacuator, Event, State> {
  _PageEditTypeEvacuatorState() : super(Controller());

  final _easyEvacController =
      TextEditingController(text: 'Эвакуатор для легковых автомобилей');
  final _manipulatorEvacController = TextEditingController(
      text: 'Незаменим для погрузки авто при неисправности или из ямы');
  final _cargoEvacController = TextEditingController(
      text:
          'Эвакуатор для перевозки крупногабаритного транспорта или спецтехники.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10),
          Center(
              child: Text('Тип эвакуатора',
                  style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'Inter',
                      fontWeight: MyParams.textBold,
                      fontSize: 20))),
          SizedBox(height: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        // top: 35,
                        left: MyParams.fieldPadding(context),
                        right: MyParams.fieldPadding(context)),
                    child: TextFormField(
                      maxLines: 2,
                      readOnly: true,
                      cursorColor: MyColors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      controller: _easyEvacController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25, top: 30),
                        filled: true,
                        fillColor: Colors.white,
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55 * AppSize.rWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: MyParams.fieldPadding(context)),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MyParams.rounding),
                    ),
                    color: MyColors.blue,
                    child: Text(
                      'Легковой',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      addEvent(EasyEvacuator(widget.allInfo));
                    },
                  )),
              SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: MyParams.fieldPadding(context),
                        right: MyParams.fieldPadding(context)),
                    child: TextFormField(
                      maxLines: 2,
                      readOnly: true,
                      cursorColor: MyColors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      controller: _manipulatorEvacController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25, top: 30),
                        filled: true,
                        fillColor: Colors.white,
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55 * AppSize.rWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: MyParams.fieldPadding(context)),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MyParams.rounding),
                    ),
                    color: MyColors.blue,
                    child: Text(
                      'Манипулятор',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      addEvent(ManipulatorEvacuator(widget.allInfo));
                    },
                  )),
              SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: MyParams.fieldPadding(context),
                        right: MyParams.fieldPadding(context)),
                    child: TextFormField(
                      maxLines: 3,
                      readOnly: true,
                      cursorColor: MyColors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      controller: _cargoEvacController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25, top: 30),
                        filled: true,
                        fillColor: Colors.white,
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.grayBorder, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55 * AppSize.rWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: MyParams.fieldPadding(context)),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MyParams.rounding),
                    ),
                    color: MyColors.blue,
                    child: Text(
                      'Грузовой',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      addEvent(CargoEvacuator(widget.allInfo));
                    },
                  )),


            ],
          )
          // Stack(children: [
          //   Container(
          //     height: 200,
          //     padding: EdgeInsets.symmetric(
          //         vertical: 20, horizontal: 50),
          //     child:
          //     TextFormField(
          //       maxLines: 2,
          //       readOnly: true,
          //       cursorColor: MyColors.black,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15,
          //         fontFamily: 'Inter', fontWeight: FontWeight.w500, ),
          //       controller: _easyEvacController,
          //       decoration: InputDecoration(
          //         contentPadding:
          //         EdgeInsets.only(left: 30, top: 30),
          //         filled: true,
          //         fillColor: Colors.white,
          //         alignLabelWithHint: true,
          //         enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: MyColors.grayBorder,
          //                 width: 1),
          //             borderRadius: BorderRadius.all(
          //                 Radius.circular(15))),
          //         focusedBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: MyColors.grayBorder,
          //                 width: 1),
          //             borderRadius: BorderRadius.all(
          //                 Radius.circular(15))),
          //       ),
          //     ),
          // ),
          //   Container(
          //     padding: EdgeInsets.only(top: 100),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: 50 * AppSize.rWidth(context),
          //             padding: EdgeInsets.symmetric(horizontal: 50),
          //             child: RaisedButton(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               color: MyColors.blue,
          //               child: Text(
          //                 'Легковой',
          //                 style: TextStyle(
          //                   fontSize: 18, fontFamily: 'Inter', fontWeight: MyParams.textBold,),
          //               ),
          //               textColor: Colors.white,
          //               onPressed: () {
          //                 addEvent(EasyEvacuator(widget.userInfo, widget.carInfo));
          //               },
          //             )),
          //       ],
          //     ),
          //   ),
          //   Container(
          //     padding: EdgeInsets.only(top: 160),
          //     child: Stack(children: [Container(
          //         height: 200,
          //         padding: EdgeInsets.symmetric(
          //             vertical: 20, horizontal: 50),
          //         child: TextFormField(
          //           maxLines: 2,
          //           readOnly: true,
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontFamily: 'Inter', fontWeight: FontWeight.w500, ),
          //           controller: _manipulatorEvacController,
          //           decoration: InputDecoration(
          //             contentPadding:
          //             EdgeInsets.only(left: 30, top: 30),
          //             filled: true,
          //             fillColor: Colors.white,
          //             alignLabelWithHint: true,
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: MyColors.grayBorder,
          //                     width: 1),
          //                 borderRadius: BorderRadius.all(
          //                     Radius.circular(15))),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: MyColors.grayBorder,
          //                     width: 1),
          //                 borderRadius: BorderRadius.all(
          //                     Radius.circular(15))),
          //           ),
          //         )),
          //       Container(
          //         padding: EdgeInsets.only(top: 100),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 height: 50 * AppSize.rWidth(context),
          //                 padding: EdgeInsets.symmetric(horizontal: 50),
          //                 child: RaisedButton(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(15),
          //                   ),
          //                   color: MyColors.blue,
          //                   child: Text(
          //                     'Манипулятор',
          //                     style: TextStyle(
          //                       fontSize: 18, fontFamily: 'Inter', fontWeight: MyParams.textBold,),
          //                   ),
          //                   textColor: Colors.white,
          //                   onPressed: () {
          //                     addEvent(ManipulatorEvacuator(widget.userInfo, widget.carInfo));
          //                   },
          //                 )),
          //           ],
          //         ),
          //       ),
          //     ]
          //     ),
          //   ),
          //   Container(
          //     padding: EdgeInsets.only(top: 320),
          //     child: Stack(children: [Container(
          //         height: 200,
          //         padding: EdgeInsets.symmetric(
          //             vertical: 20, horizontal: 50),
          //         child: TextFormField(
          //           maxLines: 3,
          //           readOnly: true,
          //           cursorColor: MyColors.black,
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontFamily: 'Inter', fontWeight: FontWeight.w500, ),
          //           controller: _cargoEvacController,
          //           decoration: InputDecoration(
          //             contentPadding:
          //             EdgeInsets.only(left: 30, top: 30),
          //             filled: true,
          //             fillColor: Colors.white,
          //             alignLabelWithHint: true,
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: MyColors.grayBorder,
          //                     width: 1),
          //                 borderRadius: BorderRadius.all(
          //                     Radius.circular(15))),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: MyColors.grayBorder,
          //                     width: 1),
          //                 borderRadius: BorderRadius.all(
          //                     Radius.circular(15))),
          //           ),
          //         )),
          //       Container(
          //         padding: EdgeInsets.only(top: 120),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 height: 50 * AppSize.rWidth(context),
          //                 padding: EdgeInsets.symmetric(horizontal: 50),
          //                 child: RaisedButton(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(15),
          //                   ),
          //                   color: MyColors.blue,
          //                   child: Text(
          //                     'Грузовой',
          //                     style: TextStyle(
          //                       fontSize: 18, fontFamily: 'Inter', fontWeight: MyParams.textBold,),
          //                   ),
          //                   textColor: Colors.white,
          //                   onPressed: () {
          //                     addEvent(CargoEvacuator(widget.userInfo, widget.carInfo));
          //                   },
          //                 )),
          //           ],
          //         ),
          //       ),
          //     ]
          //     ),
          //   ),
          // ]
          // ),
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
