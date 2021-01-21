import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart' hide State;
import 'model.dart';
import 'controller.dart';

// ignore: must_be_immutable
class PageAfterLog extends XPage {
  @override
  _PageAfterLogState createState() => _PageAfterLogState();
}

class _PageAfterLogState extends XPageState<PageAfterLog, Event, State> {
  _PageAfterLogState() : super(Controller());
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _user = FirebaseFirestore.instance;


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



  Widget sideMenu(context, AllUserInfoModel infoUSER) {

    _customShowDialog() {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            insetPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                return Container(
                  height: height - 530,
                  width: width-80,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Text(
                              'Вы уверены, что хотите выйти из аккаунта?',
                              style: TextStyle(
                                  height: 1.5,
                                  color: MyColors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: MyParams.textBold,
                                  fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                              width: 130 * AppSize.rWidth(context),
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
                                onPressed: () async {
                                  await logOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PageLogIn()));
                                },
                              )),
                          SizedBox(width: 20),
                          Container(
                              width: 130 * AppSize.rWidth(context),
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
                                  Navigator.pop(context);
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

    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(right: 0.168 * MediaQuery.of(context).size.width),
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.1,
              width: double.infinity,
              padding: EdgeInsets.only(top: 60, left: 50),
              color: MyColors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.95),
                          radius: MediaQuery.of(context).size.width * 0.106,
                          child: infoUSER.userBasicInfo.avatarPhoto == null
                              ? Image(
                                  image:
                                      AssetImage('assets/images/user_info.png'),
                                  height: 120,
                                  width: 120,
                                )
                              : Container()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.106 * 2),
                        child: infoUSER.userBasicInfo.avatarPhoto == null
                            ? Container()
                            : CircleAvatar(radius: MediaQuery.of(context).size.width * 0.106,backgroundImage: NetworkImage(
                            infoUSER.userBasicInfo.avatarPhoto)),
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Text(
                    '${infoUSER.userBasicInfo.name} ${infoUSER.userBasicInfo.surnames}',
                    style: TextStyle(
                        // сюда подключаем БЭК
                        color: MyColors.white,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      '${infoUSER.userBasicInfo.phone}',
                      style: TextStyle(
                          // сюда подключаем БЭК
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: MyParams.textNormal,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 3.1 -
                  60,
              padding: EdgeInsets.only(top: 30, left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text('МОЙ ПРОФИЛЬ',
                        style: TextStyle(
                            color: MyColors.black,
                            fontFamily: 'Inter',
                            fontWeight: MyParams.textBold,
                            fontSize: 14)),
                    onTap: () {
                      addEvent(ProfileUserPageEvent(infoUSER));
                    },
                  ),
                  SizedBox(height: 35),
                  GestureDetector(
                      child: Text('ФИНАНСЫ',
                          style: TextStyle(
                              color: MyColors.black,
                              fontFamily: 'Inter',
                              fontWeight: MyParams.textBold,
                              fontSize: 14))),
                  SizedBox(height: 35),
                  GestureDetector(
                    child: Text('ПОДДЕРЖКА',
                        style: TextStyle(
                            color: MyColors.black,
                            fontFamily: 'Inter',
                            fontWeight: MyParams.textBold,
                            fontSize: 14)),
                  ),
                  SizedBox(height: 35),
                  GestureDetector(
                      child: Text('О ПРИЛОЖЕНИИ',
                          style: TextStyle(
                              color: MyColors.black,
                              fontFamily: 'Inter',
                              fontWeight: MyParams.textBold,
                              fontSize: 14))),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        child: Text('Выход',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: MyColors.blue,
                              fontWeight: MyParams.textNormal,
                              fontSize: 15,
                              fontFamily: 'Inter',
                            )),
                        onTap: () async {
                          _customShowDialog();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return stateBuilder((state) {
      if (state is Loading) {
        return Scaffold(
          backgroundColor: MyColors.white,
          body: Center(
              child: Center(
                  child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1152FD)),
          ))),
        );
      }
      if (state is Loaded) {
        return normalPage(context, state.info);
      }
      if (state is GetUserTestState) {
        return testPage(context, state.info);
      } else {
        return Container(child: Text('ПОЛЬСКАЯ КОРОВА'));
      }
    });

    // Widget build(BuildContext context) {
    //   return stateBuilder((state) {
    //     if (state is MainFirstScreenState) {
    //       print(MediaQuery.of(context).size.width);
    //       return logInFirstScreen(context);
    //     }
    //     if (state is SignInPageState) {
    //       return signInFirstScreen(context);
    //     }
    //     if (state is EmailAndPasswordSignUpState){
    //       return emailAndPasswordLogIn(context);
    //     }
    //     if (state is TestingMultiplyState) {
    //       return phoneSignUp(context, state.email);
    //     } else {
    //       return Container(child: Text('ПОЛЬСКАЯ КОРОВА'));
    //     }
    //   });
    // }
  }

  Widget testPage(context, info) {
    return Scaffold(
      body: ListView(
        children: [Center(child: Text('${info.userBasicInfo.city}'))],
      ),
    );
  }

  Widget normalPage(context, infoUSER) {
    FirebaseStorage _storage = FirebaseStorage.instance;
    // final ref = FirebaseStorage.instance.ref();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        drawer: sideMenu(context, infoUSER),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0x44000000).withOpacity(0.01),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                  builder: (context) => GestureDetector(
                      onTap: () async {
                        print(MediaQuery.of(context).size.height);
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        'assets/icons/left_burger.png',
                        height: 60,
                        width: 60,
                      ))),
              Text('Задания',
                  style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'Inter',
                      fontWeight: MyParams.textBold,
                      fontSize: 20)),
              GestureDetector(
                  onTap: () async {},
                  child: Image.asset(
                    'assets/icons/center_burger.png',
                    height: 60,
                    width: 60,
                  )),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users/performers/${_auth.currentUser.uid}')
              .snapshots(),
          builder: (context, streamSnaphsot) {
            if (streamSnaphsot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  Container(
                      child: Center(
                          child: Container(
                    color: Colors.blue,
                    height: 90,
                    width: 90,
                  ))),
                  Text(_auth.currentUser.uid),
                  FutureBuilder(
                    future: test,
                    builder: (context, futureSnapshot) {
                      if (futureSnapshot.hasData) {
                        return Text(futureSnapshot.data['city']);
                      }
                      return Text('хуета');
                    },
                  ),
                  // Text(test),
                  // Text(streamSnaphsot.data.documents[2]['city']),

                  // Text(_user.collection('users/performers/${_auth.currentUser.uid}').doc('userInformation').get()),
                  SizedBox(height: 30),
                  RaisedButton(
                    child: Text('TEST'),
                    onPressed: () {
                      addEvent(GetUserTestEvent());
                    },
                  ),
                ],
              );
            }
            return Container(child: Text('Польская корова2!'));
          },
        ));
  }
}
