import 'dart:async';
import 'dart:io';

import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'model.dart';
import 'controller.dart';

class PageTestLogIn extends XPage {
  @override
  _PageTestLogInState createState() => _PageTestLogInState();
}

class _PageTestLogInState extends XPageState<PageTestLogIn, Event, State> {
  _PageTestLogInState() : super(Controller());
  final _auth = FirebaseAuth.instance;
  final _phoneSignUpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  String textNum = '';
  FirebaseAuth auth1 = FirebaseAuth.instance;

  Future<void> logOut() async{
    User user = auth1.signOut() as User;
  }

  // void _submitAuthForm(
  //     String email, String password, bool isLogin, BuildContext ctx) async {
  //   UserCredential authResult;
  //   try {
  //     if (isLogin) {
  //       authResult = await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //     } else {
  //       authResult = await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //     }
  //   } on PlatformException catch (e) {
  //     var message = 'Поймана ошибка';
  //     if (e.message != null) {
  //       message = e.message;
  //     }
  //
  //     Scaffold.of(ctx).showSnackBar(SnackBar(
  //       content: Text(message),
  //       backgroundColor: Theme.of(ctx).errorColor,
  //     ));
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  Future<bool> authMethod(String phoneNumber, BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 30),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.pop(context);
          // UserCredential result = await _auth.signInWithCredential(credential);
          UserCredential result =
              await _auth.currentUser.linkWithCredential(credential);
          User user = result.user;
          if (user != null) {
//            addEvent(GoToTestPageEvent());
          } else
            print('Error value');
          print('CREDENTIAL - $credential');
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, int forceResendingToken) {
          addEvent(GoToTestPageEvent(
              phoneNumber, verificationId, forceResendingToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream:
            FirebaseFirestore.instance.doc('users/performers').snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView(
                  children: [
                    SizedBox(height: 10),
                    Center(
                        child: Text('Регистрация',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                                fontSize: 20))),
                    SizedBox(height: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 55, top: 10),
                                child: Text(
                                  'ТЕЛЕФОН',
                                  style: TextStyle(
                                      color: MyColors.black,
                                      fontFamily: 'Inter',
                                      fontWeight: MyParams.textBold,
                                      fontSize: 13),
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 35, horizontal: 50),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    validator: (String value) {
                                      if (value.contains('+') == false) {
                                        return 'Номер телефона должен начинаться с "+" и иметь 11 цифр';
                                      }
                                      return null;
                                    },
                                    cursorColor: MyColors.black,
                                    style: TextStyle(
                                      color: MyColors.black,
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: MyParams.textBold,
                                    ),
                                    controller: _phoneSignUpController,
                                    decoration: InputDecoration(
                                      errorMaxLines: 2,
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.grayBorder,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.grayBorder,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      filled: true,
                                      fillColor: MyColors.grayTextField,
                                      alignLabelWithHint: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.grayBorder,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.grayBorder,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                                  'Зарегистрироваться',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: MyParams.textBold,
                                  ),
                                ),
                                textColor: Colors.white,
                                onPressed: () async {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    final phone =
                                        _phoneSignUpController.text.trim();
                                    // await doesNameAlreadyExist(phone);
                                    authMethod(phone, context);
                                })),
                      ],
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Уже есть аккаунт? ',
                              style: TextStyle(
                                  color: MyColors.grayText,
                                  fontWeight: MyParams.textNormal,
                                  fontSize: 15,
                                  fontFamily: 'Inter'),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      addEvent(LogInPageEvent());
                                    },
                                  text: 'Авторизуйтесь',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: MyColors.blue,
                                    fontWeight: MyParams.textNormal,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                  ),
                                )
                              ])),
                    ),
                    RaisedButton(child: Text('Go back'), onPressed: () async {
                      await logOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PageLogIn()));
                    },),
                  ],
                );
              }
              return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
            }));
  }

  final String _collection = 'collectionName';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Widget signInFirstScreen(context) {
  //   return Scaffold(
  //       body: StreamBuilder(
  //           stream:
  //               FirebaseFirestore.instance.doc('users/performers').snapshots(),
  //           builder: (context, streamSnapshot) {
  //             if (streamSnapshot.hasData) {
  //               return ListView(
  //                 children: [
  //                   SizedBox(height: 10),
  //                   Center(
  //                       child: Text('Регистрация',
  //                           style: TextStyle(
  //                               color: MyColors.black,
  //                               fontFamily: 'Inter',
  //                               fontWeight: MyParams.textBold,
  //                               fontSize: 20))),
  //                   SizedBox(height: 100),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Stack(
  //                         children: [
  //                           Container(
  //                               padding: EdgeInsets.only(left: 55, top: 10),
  //                               child: Text(
  //                                 'E-MAIL',
  //                                 style: TextStyle(
  //                                     color: MyColors.black,
  //                                     fontFamily: 'Inter',
  //                                     fontWeight: MyParams.textBold,
  //                                     fontSize: 13),
  //                               )),
  //                           Container(
  //                               padding: EdgeInsets.symmetric(
  //                                   vertical: 35, horizontal: 50),
  //                               child: Form(
  //                                 key: _formKey,
  //                                 child: TextFormField(
  //                                   validator: (String value) {
  //                                     if (value.contains('@') == false) {
  //                                       return 'E-mail должен содержать "@" и иметь более 4 символов';
  //                                     }
  //                                     return null;
  //                                   },
  //                                   cursorColor: MyColors.black,
  //                                   style: TextStyle(
  //                                     color: MyColors.black,
  //                                     fontSize: 18,
  //                                     fontFamily: 'Inter',
  //                                     fontWeight: MyParams.textBold,
  //                                   ),
  //                                   controller: _emailSignUpController,
  //                                   decoration: InputDecoration(
  //                                     errorMaxLines: 2,
  //                                     focusedErrorBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     errorBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     contentPadding: EdgeInsets.symmetric(
  //                                         vertical: 5, horizontal: 15),
  //                                     filled: true,
  //                                     fillColor: MyColors.grayTextField,
  //                                     alignLabelWithHint: true,
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     focusedBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                   ),
  //                                 ),
  //                               )),
  //                         ],
  //                       ),
  //                       Stack(
  //                         children: [
  //                           Container(
  //                               padding: EdgeInsets.only(left: 55, top: 10),
  //                               child: Text(
  //                                 'ПАРОЛЬ',
  //                                 style: TextStyle(
  //                                     color: MyColors.black,
  //                                     fontFamily: 'Inter',
  //                                     fontWeight: MyParams.textBold,
  //                                     fontSize: 13),
  //                               )),
  //                           Container(
  //                               padding: EdgeInsets.symmetric(
  //                                   vertical: 35, horizontal: 50),
  //                               child: Form(
  //                                 key: _formKeyPassword,
  //                                 child: TextFormField(
  //                                   validator: (String value) {
  //                                     if (value.length != 4) {
  //                                       return 'Пароль должен содержать более 4 символов';
  //                                     }
  //                                     return null;
  //                                   },
  //                                   cursorColor: MyColors.black,
  //                                   style: TextStyle(
  //                                     color: MyColors.black,
  //                                     fontSize: 18,
  //                                     fontFamily: 'Inter',
  //                                     fontWeight: MyParams.textBold,
  //                                   ),
  //                                   controller: _passwordSignUpController,
  //                                   decoration: InputDecoration(
  //                                     errorMaxLines: 2,
  //                                     focusedErrorBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     errorBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     contentPadding: EdgeInsets.symmetric(
  //                                         vertical: 5, horizontal: 15),
  //                                     filled: true,
  //                                     fillColor: MyColors.grayTextField,
  //                                     alignLabelWithHint: true,
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                     focusedBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide(
  //                                             color: MyColors.grayBorder,
  //                                             width: 1),
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(15))),
  //                                   ),
  //                                 ),
  //                               )),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 20),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                           width: MediaQuery.of(context).size.width,
  //                           height: 50 * AppSize.rWidth(context),
  //                           padding: EdgeInsets.symmetric(horizontal: 50),
  //                           child: RaisedButton(
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(MyParams.rounding),
  //                               ),
  //                               color: MyColors.blue,
  //                               child: Text(
  //                                 'Зарегистрироваться',
  //                                 style: TextStyle(
  //                                   fontSize: 18,
  //                                   fontFamily: 'Inter',
  //                                   fontWeight: MyParams.textBold,
  //                                 ),
  //                               ),
  //                               textColor: Colors.white,
  //                               onPressed: () async {
  //                                 final email =
  //                                     _emailSignUpController.text.trim();
  //                                 final password =
  //                                     _passwordSignUpController.text.trim();
  //                                 _submitAuthForm(
  //                                     email, password, false, context);
  //
  //                                 //   if (!_formKey.currentState.validate()) {
  //                                 //     return;
  //                                 //   }
  //                                 //   final phone =
  //                                 //       _emailSignUpController.text.trim();
  //                                 //   await doesNameAlreadyExist(phone);
  //                                 //   authMethod(phone, context);
  //                               })),
  //                     ],
  //                   ),
  //                   SizedBox(height: 40),
  //                   Center(
  //                     child: RichText(
  //                         text: TextSpan(
  //                             text: 'Уже есть аккаунт? ',
  //                             style: TextStyle(
  //                                 color: MyColors.grayText,
  //                                 fontWeight: MyParams.textNormal,
  //                                 fontSize: 15,
  //                                 fontFamily: 'Inter'),
  //                             children: [
  //                           TextSpan(
  //                             recognizer: TapGestureRecognizer()
  //                               ..onTap = () {
  //                                 addEvent(LogInPageEvent());
  //                               },
  //                             text: 'Авторизуйтесь',
  //                             style: TextStyle(
  //                               decoration: TextDecoration.underline,
  //                               color: MyColors.blue,
  //                               fontWeight: MyParams.textNormal,
  //                               fontSize: 15,
  //                               fontFamily: 'Inter',
  //                             ),
  //                           )
  //                         ])),
  //                   )
  //                 ],
  //               );
  //             }
  //             return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
  //           }));
  // }

  Future<bool> doesNameAlreadyExist(String phone) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('$phone', isEqualTo: phone)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }
}
