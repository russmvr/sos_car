import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart' hide State;

import 'model.dart';
import 'controller.dart';

class PageCarPhotos extends XPage {
  final UserInfoSosCar userInfo;
  final CarSosCar carInfo;
  PageCarPhotos([this.userInfo, this.carInfo]);

  @override
  _PageCarPhotosState createState() => _PageCarPhotosState();
}

class _PageCarPhotosState extends XPageState<PageCarPhotos, Event, State> {
  _PageCarPhotosState() : super(Controller());
  File _storedImage1;
  File _storedImage2;
  File _storedImage3;
  File _storedImage4;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      body: GestureDetector(
        child: ListView(
          children: [
            SizedBox(height: 10),
            Center(
                child: Text('Фото авто',
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
                                'assets/images/car_images/car1.png',
                                width: MyImagesSize.widthImageCar12(context),
                                height: MyImagesSize.heightImageCar12(context),
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
                                'assets/images/car_images/car2.png',
                                width: MyImagesSize.widthImageCar12(context),
                                height: MyImagesSize.heightImageCar12(context),
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
              padding: EdgeInsets.only(right: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text('Спереди',
                        style: TextStyle(
                            color: MyColors.black,
                            fontFamily: 'Inter',
                            fontWeight: MyParams.textBold,
                            fontSize: 13)),
                  ),
                  Container(
                    child: Text('Сзади',
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
                            'assets/images/car_images/car4.png',
                            width: MyImagesSize.widthImageCar34(context),
                            height: MyImagesSize.heightImageCar34(context),
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
                            'assets/images/car_images/car3.png',
                            width: MyImagesSize.widthImageCar34(context),
                            height: MyImagesSize.heightImageCar34(context),
                          ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Справа',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 13),
                  ),
                  Text(
                    'Слева',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 13),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 75,
            ),
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
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'Необходимо загрузить все фотографии'),
                          ));
                          return;
                        }
                        widget.carInfo.photo1 = _storedImage1;
                        widget.carInfo.photo2 = _storedImage2;
                        widget.carInfo.photo3 = _storedImage3;
                        widget.carInfo.photo4 = _storedImage4;
                        addEvent(
                            DocsPhotosAdding(widget.userInfo, widget.carInfo));
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

