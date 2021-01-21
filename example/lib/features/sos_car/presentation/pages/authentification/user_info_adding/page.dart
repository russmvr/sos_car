import 'dart:io';

import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'model.dart';
import 'controller.dart';

class PageUserInfo extends XPage {
  String email;
  String phone;
  final code;
  PageUserInfo({this.email,this.phone, this.code});

  @override
  _PageUserInfoState createState() => _PageUserInfoState();
}

class _PageUserInfoState extends XPageState<PageUserInfo, Event, State> {
  _PageUserInfoState() : super(Controller());
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _middlenameController = TextEditingController();
  final _formKeyUserInfo = GlobalKey<FormState>();
  String valueChoose;
  List cityList = [
    'Москва',
    'Санкт-Петербург',
    'Екатеринбург',
    'Казань',
    'Уфа',
    'Сочи',
    'Волгоград',
  ];
  File _storedImage1;


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
    });
  }

  Future<void> deleteAccount() async {
    FirebaseAuth.instance.currentUser.delete();
    if(FirebaseAuth.instance.currentUser == null){
      print('ага');
    }
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () async {
                    await deleteAccount();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PageLogIn()));
                  },
                      child: Image.asset('assets/icons/arrow_back.png', height: 60, width: 60,)
                  ),
                  Text('Данные профиля',
                      style: TextStyle(
                          color: MyColors.black,
                          fontFamily: 'Inter',
                          fontWeight: MyParams.textBold,
                          fontSize: 20)),
                  Visibility(
                    child: Text("Invisible"),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: (){
                _onPhotoPressed(1);
              },
              child: Stack(
                  alignment: Alignment.bottomCenter,
                children: [
                  Container(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: MyColors.grayCircleAvatar.withOpacity(0.2),
                    radius: 70,
                    child: _storedImage1 == null ? Image(
                      image: AssetImage('assets/images/user_info.png'),
                      height: 140,
                      width: 140,
                    ) : Container()
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: _storedImage1 == null ? Container() :
                      Image.file(_storedImage1, height: 135, width: 135, fit: BoxFit.cover,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Image.asset('assets/icons/plus.png', height: 40, width: 40,),
                  ),
                ]
              ),
            ),
            Form(
              key: _formKeyUserInfo,
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
                            'Имя',
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
                              if (value.length == 0 || RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть заполнено';
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
                            controller: _nameController,
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
                            'Фамилия',
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
                              if (value.length == 0 || RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть заполнено';
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
                            controller: _surnameController,
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
                            'Отчество',
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
                              if (value.length == 0 || RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть заполнено';
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
                            controller: _middlenameController,
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
                          padding: EdgeInsets.only(left: MyParams.textLeftPadding(context), top: 10),
                          child: Text(
                            'Город',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                                fontSize: 13),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 35,
                            horizontal: MyParams.fieldPadding(context)),
                          child: DropdownButtonFormField(
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
                              validator: (value){
                                if(value == null){
                                  return 'Данное поле должно быть заполнено';
                                }
                                return null;
                              },
                              // underline: SizedBox(),
                              dropdownColor: MyColors.grayTextField,
                              style: TextStyle(
                                color: MyColors.black,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                              ),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                              isExpanded: true,
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  valueChoose = newValue;
                                  print(valueChoose);
                                });
                              },
                              items: cityList.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList()),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50 * AppSize.rWidth(context),
                    padding: EdgeInsets.symmetric(horizontal:
                    MyParams.fieldPadding(context)),
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
                        if (!_formKeyUserInfo.currentState
                            .validate()) {
                          return;
                        }
                        final UserInfoSosCar userInfo = UserInfoSosCar(
                            avatar: _storedImage1 == null ? null: _storedImage1,
                            email: FirebaseAuth.instance.currentUser.email,
                            phone: FirebaseAuth.instance.currentUser.phoneNumber,
                            name: _nameController.text.trim(),
                            surnames: _surnameController.text.trim(),
                            middlename: _middlenameController.text.trim(),
                            city: valueChoose.trim());
                        addEvent(CarInfoPage(userInfo));
                      },
                    )),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
