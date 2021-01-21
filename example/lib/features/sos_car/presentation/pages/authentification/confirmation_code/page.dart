import 'dart:async';

import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'model.dart';
import 'controller.dart';

class Page1 extends XPage {
  final String phoneNumber;
  final String verificationId;
  final int forceResendingToken;
  final bool isLogin;
  final String email;

  Page1([this.phoneNumber, this.verificationId, this.forceResendingToken, this.isLogin, this.email]);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends XPageState<Page1, Event, State> {
  _Page1State() : super(Controller());
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  int _counter = 30;
  Timer _timer;

  // void _startTimer(){
  //   _counter = 30;
  //   if(_timer != null){
  //     _timer.cancel();
  //   }
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if(_counter>0){
  //         _counter --;
  //       } else{
  //         _timer.cancel();
  //       }
  //     });
  //   });
  //
  // }

  @override
  void initState() {
    // _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            SizedBox(height: 10),
            Center(
                child: Text('Код подтверждения',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 20))),
            SizedBox(height: 70),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Center(
                  child: Text(
                'Код подтверждения был отправлен на номер ${widget.phoneNumber}',
                style: TextStyle(
                    color: MyColors.grayText,
                    fontWeight: MyParams.textNormal,
                    fontSize: 15,
                    fontFamily: 'Inter'),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(height: 40),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Пин-код:',
                      style: TextStyle(
                          color: MyColors.black,
                          fontFamily: 'Inter', fontWeight: MyParams.textBold,
                          fontSize: 15),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 35, horizontal: 138),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: MyColors.black,
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize: 21,
                        fontFamily: 'Inter', fontWeight: MyParams.textBold,),
                      controller: _phoneController,
                      decoration: InputDecoration(
                        focusedErrorBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.grayBorder, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.grayBorder, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
                // Container(padding: EdgeInsets.only(top: 100),alignment: Alignment.center,child: (_counter>0) ? Text('Отправить повторно (0:$_counter)', style: TextStyle(
                //   decoration: TextDecoration.underline,
                //   color: MyColors.blue,
                //   fontWeight: MyParams.textNormal,
                //   fontSize: 12,
                //   fontFamily: 'Inter',),) : Text('Отправить повторно', style: TextStyle(
                //   decoration: TextDecoration.underline,
                //   color: MyColors.blue,
                //   fontWeight: MyParams.textNormal,
                //   fontSize: 12,
                //   fontFamily: 'Inter',),)),
              ],
            ),
            SizedBox(height: 260),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 1.1,
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
                      onPressed: () async {
                        final code = _phoneController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId, smsCode: code);
                        // UserCredential result =
                        //     await _auth.signInWithCredential(credential);
                        if(widget.isLogin==true){
                          UserCredential result =
                              await _auth.signInWithCredential(credential);
                          User user = result.user;
                          if (user != null) {
                            print('НОМЕР ТЕЛЕФОНА???! - ${user.phoneNumber}');
                            addEvent(PageAfterEvent());
                          } else
                            print('Error value');
                        } else {
                          UserCredential result =
                          await _auth.currentUser.linkWithCredential(credential);
                          User user = result.user;
                          if (user != null) {
                            print('НОМЕР ТЕЛЕФОНА???! - ${user.phoneNumber}');
                            addEvent(InfoUserScreenEvent(phoneNumber: user.phoneNumber,
                                code: code, email: widget.email ));
                          } else
                            print('Error value');
                        }

                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
