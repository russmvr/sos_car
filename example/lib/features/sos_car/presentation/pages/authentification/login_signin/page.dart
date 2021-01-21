import 'dart:async';
import 'dart:io';

import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/MyKeys.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/myKeys.dart';
import 'package:example/core/ui_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'model.dart';
import 'controller.dart';

class PageLogIn extends XPage {
  @override
  _PageLogInState createState() => _PageLogInState();
}

class _PageLogInState extends XPageState<PageLogIn, Event, State> {
  _PageLogInState() : super(Controller());
  final _auth = FirebaseAuth.instance;
  final _phoneLogInController = TextEditingController();
  final _phoneSignUpController = TextEditingController();
  final _emailSignUpController = TextEditingController();
  final _emailLogInController = TextEditingController();
  final _passwordSignUpController = TextEditingController();
  final _passwordLogInController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeySignUpEmailAndPass = GlobalKey<FormState>();
  final _formKeyLogInEmailAndPass = GlobalKey<FormState>();

  bool isError = false;

  Future<String> _submitAuthForm(
      String email, String password, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } catch (err) {
      switch (err.code) {
        case 'email-already-in-use':
          print('мыло используется');
          return 'Электронная почта уже используется.';
          case "user-not-found":
            print('пользователь с данным e-mail не найден');
            return 'Пользователь с данным e-mail не найден.';
        case "wrong-password":
          print('неправильный пароль');
          return 'Неправильно введен пароль.';
        default:
          break;
      }
    }
    return 'ok';
  }

  Future<bool> authMethod(
      {String phoneNumber, String email, BuildContext context, bool isLogin}) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 30),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.pop(context);
          if (isLogin == true) {
            UserCredential result =
                await _auth.signInWithCredential(credential);
            User user = result.user;
            if (user != null) {
//            addEvent(GoToTestPageEvent());
            } else
              print('Error value');
            print('CREDENTIAL - $credential');
          } else if (isLogin == false) {
            try {
              UserCredential result =
                  await _auth.currentUser.linkWithCredential(credential);
              User user = result.user;
              if (user != null) {
//            addEvent(GoToTestPageEvent());
              } else
                print('Error value');
              print('CREDENTIAL - $credential');
            } catch (err) {
              print('ОШИБОЧКА - ${err.code}');
            }
          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, int forceResendingToken) {
          addEvent(GoToTestPageEvent(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
              forceResendingToken: forceResendingToken,
              isLogin: isLogin,
              email: email));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timeout");
        });
  }

  @override
  Widget build(BuildContext context) {
    return stateBuilder((state) {
      if (state is MainFirstScreenState) {
        print(MediaQuery.of(context).size.width);
        return logInFirstScreen(context);
      }
      if (state is SignInPageState) {
        return signInFirstScreen(context);
      }
      if (state is EmailAndPasswordSignUpState){
        return emailAndPasswordLogIn(context);
      }
      if (state is TestingMultiplyState) {
        return phoneSignUp(context, state.email);
      } else {
        return Container(child: Text('ПОЛЬСКАЯ КОРОВА'));
      }
    });
  }

  final String _collection = 'collectionName';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Widget logInFirstScreen(context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.doc('users/performers').snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView(
                    children: [
                      SizedBox(height: 10),
                      Center(
                          child: Text('Вход',
                              style: TextStyle(
                                  color: MyColors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: MyParams.textBold,
                                  fontSize: 20))),
                      SizedBox(height: 150),
                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: MyParams.textLeftPadding(context),
                                          top: 10),
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
                                          vertical: 35,
                                          horizontal:
                                              MyParams.fieldPadding(context)),
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          validator: (String value) {
                                            if (value.length != 12 ||
                                                value.contains('+') == false) {
                                              return 'Номер телефона должен начинаться с "+7" и иметь 11 цифр';
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
                                          controller: _phoneLogInController,
                                          decoration: InputDecoration(
                                            errorMaxLines: 2,
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            MyColors.grayBorder,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50 * AppSize.rWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.096),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(MyParams.rounding),
                                ),
                                color: MyColors.blue,
                                child: Text(
                                  'Войти',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: MyParams.textBold,
                                  ),
                                ),
                                textColor: Colors.white,
                                onPressed: () async {
                                  final phone = _phoneLogInController.text.trim();
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  var checkNum = await doesNameAlreadyExist(
                                      phone: phone, isPhone: true);
                                  if (!checkNum) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Аккаунт с данным номером телефоном не зарегестрирован'),
                                    ));
                                    return;
                                  } else {
                                    authMethod(
                                        phoneNumber: phone,
                                        context: context,
                                        isLogin: true);
                                  }
                                },
                              )),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50 * AppSize.rWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.width * 0.096),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(MyParams.rounding),
                                ),
                                color: MyColors.grayTextField2Color,
                                child: Text(
                                  'Или войдите по e-mail',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: MyParams.textBold,
                                  ),
                                ),
                                textColor: Colors.white,
                                onPressed: () async {
                                  addEvent(EmailAndPasswordSignUpEvent());
                                },
                              )),
                        ],
                      ),
                      SizedBox(height: 100),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: 'Еще нет аккаунта? ',
                                style: TextStyle(
                                    color: MyColors.grayText,
                                    fontWeight: MyParams.textNormal,
                                    fontSize: 15,
                                    fontFamily: 'Inter'),
                                children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    addEvent(SignInPageEvent());
                                  },
                                text: 'Зарегистрируйтесь',
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
                      SizedBox(height: 55),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        addEvent(PhoneSignUp('asdfksda'));
                                      },
                                    text: 'Политика конфиденциальности',
                                    style: TextStyle(
                                      color: MyColors.blue,
                                      fontWeight: MyParams.textNormal,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                                ])),
                      ),
                    ],
                  );
                }
                return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
              }),
        ));
  }

  Widget signInFirstScreen(context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: StreamBuilder(
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
                      SizedBox(height: 140),
                      Form(
                        key: _formKeySignUpEmailAndPass,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        left: MyParams.textLeftPadding(context),
                                        top: 10),
                                    child: Text(
                                      'E-MAIL',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontFamily: 'Inter',
                                          fontWeight: MyParams.textBold,
                                          fontSize: 13),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: MyParams.fieldPadding(context),
                                        right: MyParams.fieldPadding(context)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String value) {
                                        if (value.contains('@') == false) {
                                          return 'E-mail должен содержать "@" и иметь более 4 символов';
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
                                      controller: _emailSignUpController,
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
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        left: MyParams.textLeftPadding(context),
                                        top: 10),
                                    child: Text(
                                      'ПАРОЛЬ',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontFamily: 'Inter',
                                          fontWeight: MyParams.textBold,
                                          fontSize: 13),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: MyParams.fieldPadding(context),
                                        right: MyParams.fieldPadding(context)),
                                    child: TextFormField(
                                      validator: (String value) {
                                        if (value.length < 4) {
                                          return 'Пароль должен содержать более 4 символов';
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
                                      controller: _passwordSignUpController,
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
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50 * AppSize.rWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: MyParams.fieldPadding(context)),
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
                                    if (!_formKeySignUpEmailAndPass.currentState
                                        .validate()) {
                                      return;
                                    }
                                    final email =
                                        _emailSignUpController.text.trim();
                                    final password =
                                        _passwordSignUpController.text.trim();
                                    String checkValue = await _submitAuthForm(
                                        email, password, false, context);
                                    if (checkValue != 'ok') {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            '$checkValue'),
                                      ));
                                      return;
                                    } else {
                                      addEvent(PhoneSignUp(email));
                                    }
                                  })),
                        ],
                      ),
                      SizedBox(height: 106),
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
                      SizedBox(height: 56),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        addEvent(SignInPageEvent());
                                      },
                                    text: 'Политика конфиденциальности',
                                    style: TextStyle(
                                      color: MyColors.blue,
                                      fontWeight: MyParams.textNormal,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                                ])),
                      ),
                    ],
                  );
                }
                return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
              }),
        ));
  }

  Widget phoneSignUp(context, String email) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: StreamBuilder(
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
                      SizedBox(height: 150),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: MyParams.textLeftPadding(context), top: 10),
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
                                      vertical: 35, horizontal: MyParams.fieldPadding(context)),
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      validator: (String value) {
                                        if (value.length != 12 ||
                                            value.contains('+') == false) {
                                          return 'Номер телефона должен начинаться с "+7" и иметь 11 цифр';
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
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50 * AppSize.rWidth(context),
                          padding: EdgeInsets.symmetric(
                              horizontal: MyParams.fieldPadding(context)),
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
                                var checkValue = await doesNameAlreadyExist(
                                    phone: phone, isPhone: true);
                                if (checkValue) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Аккаунт с данным номером телефоном уже зарегестрирован'),
                                  )); // вот тут добавить bottomsheet
                                  return;
                                } else {
                                  authMethod(
                                      phoneNumber: phone,
                                      email: email,
                                      context: context,
                                      isLogin: false);
                                }
                              }
                              )),
                      SizedBox(height: 253),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        addEvent(LogInPageEvent());
                                      },
                                    text: 'Политика конфиденциальности',
                                    style: TextStyle(
                                      color: MyColors.blue,
                                      fontWeight: MyParams.textNormal,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                                ])),
                      ),
                    ],
                  );
                }
                return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
              }),
        ));
  }

  Widget emailAndPasswordLogIn(context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: StreamBuilder(
              stream:
              FirebaseFirestore.instance.doc('users/performers').snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView(
                    children: [
                      SizedBox(height: 10),
                      Center(
                          child: Text('Вход',
                              style: TextStyle(
                                  color: MyColors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: MyParams.textBold,
                                  fontSize: 20))),
                      SizedBox(height: 140),
                      Form(
                        key: _formKeyLogInEmailAndPass,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        left: MyParams.textLeftPadding(context),
                                        top: 10),
                                    child: Text(
                                      'E-MAIL',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontFamily: 'Inter',
                                          fontWeight: MyParams.textBold,
                                          fontSize: 13),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: MyParams.fieldPadding(context),
                                        right: MyParams.fieldPadding(context)),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String value) {
                                        if (value.contains('@') == false) {
                                          return 'E-mail должен содержать "@"';
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
                                      controller: _emailLogInController,
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
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        left: MyParams.textLeftPadding(context),
                                        top: 10),
                                    child: Text(
                                      'ПАРОЛЬ',
                                      style: TextStyle(
                                          color: MyColors.black,
                                          fontFamily: 'Inter',
                                          fontWeight: MyParams.textBold,
                                          fontSize: 13),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: MyParams.fieldPadding(context),
                                        right: MyParams.fieldPadding(context)),
                                    child: TextFormField(
                                      validator: (String value) {
                                        if (value.length < 4) {
                                          return 'Пароль должен содержать более 4 символов';
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
                                      controller: _passwordLogInController,
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
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50 * AppSize.rWidth(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: MyParams.fieldPadding(context)),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(MyParams.rounding),
                                  ),
                                  color: MyColors.blue,
                                  child: Text(
                                    'Войти',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: MyParams.textBold,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (!_formKeyLogInEmailAndPass.currentState
                                        .validate()) {
                                      return;
                                    }
                                    final email =
                                    _emailLogInController.text.trim();
                                    final password =
                                    _passwordLogInController.text.trim();
                                    String checkValue = await _submitAuthForm(
                                        email, password, true, context);
                                    if (checkValue != 'ok') {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            '$checkValue'),
                                      ));
                                      return;
                                    } else {
                                      addEvent(MainPageEvent());
                                    }
                                  })),
                        ],
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: 'Войти с помощью ',
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
                                    text: 'номера телефона',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: MyColors.blue,
                                      fontWeight: MyParams.textNormal,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                                ])),
                      )
                    ],
                  );
                }
                return Container(child: Text('ПОЛЬСКАЯ КОРОВА 2!'));
              }),
        ));
  }

  Future<bool> doesNameAlreadyExist(
      {String phone, String email, bool isPhone}) async {
    if (isPhone) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('$phone', isEqualTo: phone)
          .limit(1)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      return documents.length == 1;
    } else {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('$email', isEqualTo: email)
          .limit(1)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      return documents.length == 1;
    }
  }

//  Future<String> checkNumber(String phone) async {
//    DocumentSnapshot snapshot = await FirebaseFirestore.instance
//        .collection('users').doc('performers').snapshots().first;
//
//    return snapshot["$phone"];
//  }
//

//  var document = await FirebaseFirestore.instance.doc('users/performers/$phone/userInformation').get().then((value){
//    value.get('idUser');
//  });

}
