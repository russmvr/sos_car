import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide State;

import 'model.dart';
import 'controller.dart';

class PageEditAutoInfo extends XPage {
  final AllUserInfoModel userInfo;

  PageEditAutoInfo(this.userInfo);

  @override
  _PageEditAutoInfoState createState() => _PageEditAutoInfoState();
}

class _PageEditAutoInfoState extends XPageState<PageEditAutoInfo, Event, State> {
  _PageEditAutoInfoState() : super(Controller());
  final _carBrendController = TextEditingController();
  final _carModelController = TextEditingController();
  final _yearOfManufactureController = TextEditingController();
  final _numberOfCarController = TextEditingController();
  final _formKeyCarInfo = GlobalKey<FormState>();

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
            Center(child: Text('Данные авто', style: TextStyle(
                color: MyColors.black,
                fontFamily: 'Inter', fontWeight: MyParams.textBold,
                fontSize: 20))),
            SizedBox(height: 80),
            Form(
              key: _formKeyCarInfo,
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
                            'Марка',
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
                              if (value.length == 0) {
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
                            controller: _carBrendController,
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
                            'Модель',
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
                              if (value.length == 0) {
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
                            controller: _carModelController,
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
                            'Год выпуска',
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
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.length != 4) {
                                return 'Должна быть введен корректный год выпуска ';
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
                            controller: _yearOfManufactureController,
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
                            'Гос.номер',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                                fontSize: 13),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            bottom: 35,
                              top: 35,
                              left: MyParams.fieldPadding(context),
                              right: MyParams.fieldPadding(context)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length != 6 ||
                                  double.tryParse(value[0]) != null ||
                                  double.tryParse(value[1]) == null ||
                                  double.tryParse(value[2]) == null ||
                                  double.tryParse(value[3]) == null ||
                                  double.tryParse(value[4]) != null ||
                                  double.tryParse(value[5]) != null) {
                                return 'Должен быть введен корректный Гос.номер(пример: с065мк)';
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
                            controller: _numberOfCarController,
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
            SizedBox(height:90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
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
                          fontSize: 18, fontFamily: 'Inter', fontWeight: MyParams.textBold,),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        if (!_formKeyCarInfo.currentState
                            .validate()) {
                          return;
                        }
                        final int year = int.parse(_yearOfManufactureController.text.trim());
                        final CarSosCar carNewInfo = CarSosCar(
                            carBrend:_carBrendController.text.trim(),
                            carModel:_carModelController.text.trim(),
                            yearOfManufacture: year,
                            stateNumberOfCar:_numberOfCarController.text.trim().toUpperCase());
                        addEvent(UpdateCarInfoEvent(widget.userInfo,carNewInfo));
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
