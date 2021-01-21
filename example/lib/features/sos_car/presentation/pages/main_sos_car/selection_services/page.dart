import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart' hide State;
import 'model.dart';
import 'controller.dart';

// ignore: must_be_immutable
class SelectionServicesPage extends XPage {
  final AllUserInfoModel allInfo;

  SelectionServicesPage(this.allInfo);
  @override
  _SelectionServicesPageState createState() => _SelectionServicesPageState();
}

class _SelectionServicesPageState
    extends XPageState<SelectionServicesPage, Event, State> {
  _SelectionServicesPageState() : super(Controller());
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _controllerEvacuator = false;
  bool _controllerWheel = false;
  bool _controllerStartingCar = false;
  bool _controllerTowage = false;
  bool _controllerFuel = false;
  bool _controllerOpenCar = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  var test = FirebaseFirestore.instance
      .collection('users/performers/${FirebaseAuth.instance.currentUser.uid}')
      .doc('userInformation')
      .get();

  Future<DocumentSnapshot> getUserInfo() async {
    return await FirebaseFirestore.instance
        .collection('users/performers/${_auth.currentUser.uid}')
        .doc('userInformation')
        .get();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000).withOpacity(0.01),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  'assets/icons/arrow_back.png',
                  height: 60,
                  width: 60,
                )),
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Text('Редактировать',
                  style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'Inter',
                      fontWeight: MyParams.textBold,
                      fontSize: 20)),
            ),
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Image.asset(
                'assets/icons/arrow_back.png',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
      body: ListView(children: [
        SizedBox(height: 15),
        Container(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Прежде, чем выйти на линию, укажите с чем можете помочь',
              style: TextStyle(
                  fontWeight: MyParams.textBold,
                  color: Colors.black,
                  fontSize: 15),
            )),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerEvacuator == false
                    ?
                setState(() {
                  _controllerEvacuator = true;
                      })
                    : setState(() {
                  _controllerEvacuator = false;
                      });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_evacuator.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerEvacuator
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Эвакуация автомобиля',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerWheel == false
                    ?
                setState(() {
                  _controllerWheel = true;
                })
                    : setState(() {
                  _controllerWheel = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_wheel.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerWheel
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Поменять колесо',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerStartingCar == false
                    ?
                setState(() {
                  _controllerStartingCar = true;
                })
                    : setState(() {
                  _controllerStartingCar = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_repair.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerStartingCar
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Не заводиться автомобиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerTowage == false
                    ?
                setState(() {
                  _controllerTowage = true;
                })
                    : setState(() {
                  _controllerTowage = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_towing.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerTowage
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Буксировка автомобиля',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerFuel == false
                    ?
                setState(() {
                  _controllerFuel = true;
                })
                    : setState(() {
                  _controllerFuel = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_fuel.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerFuel
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Заправить автомобиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                _controllerOpenCar == false
                    ?
                setState(() {
                  _controllerOpenCar = true;
                })
                    : setState(() {
                  _controllerOpenCar = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.shadow,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/icons/car_keys.png',
                        height: MediaQuery.of(context).size.width * 0.173,
                        width: MediaQuery.of(context).size.width * 0.173,
                        color: _controllerOpenCar
                            ? MyColors.blue
                            : MyColors.grayCircleAvatar,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'Открыть автомобиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: MyParams.textBold,
                          color: MyColors.grayText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 50 * AppSize.rWidth(context),
                padding: EdgeInsets.symmetric(horizontal: MyParams.fieldPadding(context)),
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
                      fontWeight: MyParams.textBold,),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    if(_controllerOpenCar == false &&
                        _controllerFuel == false &&
                        _controllerTowage == false &&
                        _controllerEvacuator == false &&
                        _controllerStartingCar == false &&
                        _controllerWheel == false){
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'Необходимо выбрать хотя бы 1 оказываемую услугу'),
                      ));
                      return;
                    }
                    final ServicesProvided servicesInfo = ServicesProvided(
                        startingCar: _controllerStartingCar,
                        helpTowage: _controllerTowage,
                        changeWheel: _controllerWheel,
                        helpEvacuator: _controllerEvacuator,
                        helpFuel: _controllerFuel,
                        openCar: _controllerOpenCar);
                    addEvent(SelectableServicesEvent(widget.allInfo, servicesInfo));
                  },
                )),
          ],
        ),
        SizedBox(height: 15),
      ]),
    );

    // return stateBuilder((state) {
    //   if (state is Loading) {
    //     return Scaffold(
    //       backgroundColor: MyColors.white,
    //       body: Center(
    //           child: Center(
    //               child: CircularProgressIndicator(
    //         valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1152FD)),
    //       ))),
    //     );
    //   }
    //   if (state is Loaded) {
    //     return normalPage(context, state.info);
    //   }
    //    else {
    //     return Container(child: Text('ПОЛЬСКАЯ КОРОВА'));
    //   }
    // });
  }
}
