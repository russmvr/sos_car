import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
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

class PageEditManipulatorEvacuator extends XPage {
  final AllUserInfoModel allInfo;
  PageEditManipulatorEvacuator(this.allInfo);

  @override
  _PageEditManipulatorEvacuatorState createState() => _PageEditManipulatorEvacuatorState();
}

class _PageEditManipulatorEvacuatorState extends XPageState<PageEditManipulatorEvacuator, Event, State> {
  _PageEditManipulatorEvacuatorState() : super(Controller());
  final _lengthController = TextEditingController(); //int
  final _platformWidthController = TextEditingController(); //int
  final _carryingController = TextEditingController(); //int
  final _boomLengthController = TextEditingController();
  final _formKeyManipulatorInfo = GlobalKey<FormState>();//int
  String valueVehicleCategoryChoose;
  List vehicleCategoryList = ['B','C'];//string
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String titleValue;



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
            Center(child: Text('Манипулятор', style: TextStyle(
                color: MyColors.black,
                fontFamily: 'Inter', fontWeight: MyParams.textBold,
                fontSize: 20))),
            SizedBox(height: 60),
            Form(
              key: _formKeyManipulatorInfo,
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
                            'Длина платформы (м)',
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
                              if (value.length == 0 || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть корректно заполнено';
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
                            controller: _lengthController,
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
                            'Ширина платформы (м)',
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
                              if (value.length == 0 || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть корректно заполнено';
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
                            controller: _platformWidthController,
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
                            'Грузоподъемность (кг)',
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
                              if (value.length == 0 || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть корректно заполнено';
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
                            controller: _carryingController,
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
                            'Категория ТС',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                                fontSize: 13),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 35,
                            right: MyParams.fieldPadding(context),
                            left: MyParams.fieldPadding(context)),
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
                            value: valueVehicleCategoryChoose,
                            onChanged: (newValue) {
                              setState(() {
                                FocusScope.of(context).requestFocus(FocusNode());
                                valueVehicleCategoryChoose = newValue;
                                print(valueVehicleCategoryChoose);
                              });
                            },
                            items: vehicleCategoryList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              left: MyParams.textLeftPadding(context),
                              top: 10),
                          child: Text(
                            'Длина стрелы (м)',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily: 'Inter',
                                fontWeight: MyParams.textBold,
                                fontSize: 13),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                              top: 35,
                              bottom: 70,
                              left: MyParams.fieldPadding(context),
                              right: MyParams.fieldPadding(context)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.length == 0 || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                                return 'Данное поле должно быть корректно заполнено';
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
                            controller: _boomLengthController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                          fontWeight: MyParams.textBold,),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        if (!_formKeyManipulatorInfo.currentState.validate()){
                          return;
                        }
                        final int lenght = int.parse(
                            _lengthController.text.trim());
                        final int plWidth = int.parse(
                            _platformWidthController.text.trim());
                        final int carrying = int.parse(
                            _carryingController.text.trim());
                        final int boomLength = int.parse(
                            _boomLengthController.text.trim());
                        final Evacuator evacuatorManipulatorNewInfo = Evacuator(evacuatorType: 'Cargo',
                          lengthOfPlatform: lenght,
                          platformWidth: plWidth,
                          carrying: carrying,
                          boomLength: boomLength,
                          vehicleCategory: valueVehicleCategoryChoose,
                          platformType: null,);

                        addEvent(UpdateEvacuatorManipulatorInfoEvent(widget.allInfo,
                            evacuatorManipulatorNewInfo));
                      },
                    )),
              ],
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

}


