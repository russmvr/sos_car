import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/core/appSize.dart';
import 'package:example/core/ui_kit.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart' hide State;
import 'model.dart';
import 'controller.dart';

// ignore: must_be_immutable
class PageProfileUser extends XPage {
  final AllUserInfoModel info;
  PageProfileUser(this.info);
  @override
  _PageProfileUserState createState() => _PageProfileUserState();
}

class _PageProfileUserState extends XPageState<PageProfileUser, Event, State> {
  _PageProfileUserState() : super(Controller());
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _user = FirebaseFirestore.instance;
  GlobalKey key = GlobalKey();
  File _storedImage1;

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
    UserInfoSosCar user = widget.info.userBasicInfo;
    CarSosCar car = widget.info.carBasicInfo;
    Evacuator evac = widget.info.evacuatorBasicInfo;
    return stateBuilder((state) {
      if (state is UpdateAvatarState) {
        UserInfoSosCar user = state.info;
        return mainProfilePage(context, user, car, evac);
      }
      if (state is StartState) {
        return mainProfilePage(context, user, car, evac);
      } else {
        return Scaffold(
          backgroundColor: MyColors.white,
          body: Center(
              child: Center(
                  child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1152FD)),
          ))),
        );
      }
    });
  }

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

    addEvent(UpdateAvatarEvent(_storedImage1));
  }

  Widget mainProfilePage(
      context, UserInfoSosCar infoUser, CarSosCar infoCar, Evacuator infoEvac) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () async {
                    addEvent(MainPageEvent());
                  },
                  child: Image.asset(
                    'assets/icons/arrow_back.png',
                    height: 60,
                    width: 60,
                  )),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text('Мой профиль',
                    style: TextStyle(
                        color: MyColors.black,
                        fontFamily: 'Inter',
                        fontWeight: MyParams.textBold,
                        fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5, top: 5),
                child: GestureDetector(
                    onTap: () async {
                      AllUserInfoModel infoAll = AllUserInfoModel(userBasicInfo: infoUser, carBasicInfo: infoCar, evacuatorBasicInfo: infoEvac);
                      addEvent(GoToEditPage(infoAll));
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/icons/setting.png',
                          height: 25,
                          width: 25,
                        ),
                        Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Image.asset(
                            'assets/icons/setting.png',
                            height: 35,
                            width: 35,
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _onPhotoPressed(1);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16.5),
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                              backgroundColor:
                                  MyColors.grayCircleAvatar.withOpacity(0.2),
                              radius: 40,
                              child: infoUser.avatarPhoto == null
                                  ? Image(
                                      image: AssetImage(
                                          'assets/images/user_info.png'),
                                      height: 140,
                                      width: 140,
                                    )
                                  : Container()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: infoUser.avatarPhoto == null
                                ? Container()
                                : CircleAvatar(
                                    radius: MediaQuery.of(context).size.width *
                                        0.106,
                                    backgroundImage:
                                        NetworkImage(infoUser.avatarPhoto)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 53, left: 65),
                          child: Image.asset(
                            'assets/icons/edit.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ]),
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${infoUser.name} ${infoUser.surnames}',
                            style: TextStyle(
                                color: MyColors.black,
                                fontFamily:
                                    'Inter', // ВОТ ТУТ ВСЕ ЗАГЛУШКИ МЕНЯЕМ
                                fontWeight: MyParams.textBold,
                                fontSize: 19)),
                        Text('${infoCar.carBrend} ${infoCar.carModel}'),
                        Text('${infoCar.stateNumberOfCar}')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Container(
                    key: key,
                    width: MediaQuery.of(context).size.width * 0.205,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.25,
                        color: MyColors.frameColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        // showDialog(barrierColor: Colors.black.withOpacity(0.25),context: context, builder: (_){
                        //   RenderBox box = key.currentContext.findRenderObject();
                        //   Offset position = box.localToGlobal(Offset.zero);
                        //   double y = position.dy;
                        //   double x = position.dx;
                        //   print("$x, $y");
                        //   return Container(
                        //     height: AppSize.height(context)*0.12,
                        //       width:MediaQuery.of(context).size.width*0.52,
                        //     child: SingleChildScrollView(
                        //       child: Container(
                        //         height: AppSize.height(context)*0.12,
                        //         width:MediaQuery.of(context).size.width*0.52 ,
                        //         child: Stack(
                        //           children: [Positioned(
                        //             top: y, left: x,
                        //             child: Dialog(
                        //               insetPadding: EdgeInsets.all(80),
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(19),
                        //                       bottomLeft: Radius.circular(19), topRight: Radius.circular(19))),
                        //               child: Builder(builder: (context){
                        //                 var height = MediaQuery.of(context).size.height;
                        //                 var width = MediaQuery.of(context).size.width;
                        //                 return Container(
                        //                   height: AppSize.height(context)*0.12,
                        //                   width: width*0.52, child: Text('hhhhh'),);
                        //               },),),
                        //           ),]
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // });
                        RenderBox box = key.currentContext.findRenderObject();
                        Offset position = box.localToGlobal(Offset.zero);
                        double y = position.dy;
                        double x = position.dx;
                        BotToast.showAttachedWidget(
                            attachedBuilder: (_) => Container(
                                  margin: EdgeInsets.only(left: 30),
                                  padding: EdgeInsets.symmetric(horizontal: 55),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    elevation: 8,
                                    child: Container(
                                        padding: EdgeInsets.all(9),
                                        child: Text(
                                          'Ваша комиссия сервису составляет: 15%. '
                                          'Выполните еще 14 заказов до получения статуса Planitum.',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Inter'),
                                        )),
                                  ),
                                ),
                            duration: Duration(seconds: 10),
                            target: Offset(x, y + 10));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, left: 2.5),
                                child: Image.asset(
                                  'assets/icons/star.png',
                                  height: 28.5,
                                  width: 28.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 32),
                                child: Text(
                                  'Gold',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.205,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.25,
                        color: MyColors.frameColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              child: Image.asset(
                                'assets/icons/like.png',
                                height: 26.6,
                                width: 24.8,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 32, left: 12.5),
                              child: Text(
                                '5',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.205,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.25,
                        color: MyColors.frameColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 6.5),
                              child: Image.asset(
                                'assets/icons/dislike.png',
                                height: 26.6,
                                width: 24.8,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, left: 12.5),
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.205,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.25,
                        color: MyColors.frameColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 5.5),
                              child: Image.asset(
                                'assets/icons/rating.png',
                                height: 26.6,
                                width: 24.8,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, left: 3.5),
                              child: Text(
                                '80%',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(children: [
              Container(
                padding: EdgeInsets.only(top: 17.5, left: 35),
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/icons/icn_doc.png',
                  height: 24,
                  width: 28,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Актуальные документы',
                          style: TextStyle(fontSize: 15)),
                      SizedBox(height: 5),
                      Text('Ежемесячная проверка документов',
                          style: TextStyle(
                              fontSize: 13, color: MyColors.grayText)),
                      SizedBox(height: 10),
                      Text('Подтвердить',
                          style: TextStyle(
                              fontSize: 15,
                              color: MyColors.redText,
                              decoration: TextDecoration.underline))
                    ],
                  )),
            ]),
            SizedBox(height: 5),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: Divider(
                  thickness: 1.5,
                )),
            Stack(children: [
              Container(
                padding: EdgeInsets.only(top: 14, left: 35),
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/icons/icn_photo.png',
                  height: 24,
                  width: 28,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Актуальные фото транспорта',
                          style: TextStyle(fontSize: 15)),
                      SizedBox(height: 5),
                      Text('Ежемесячная проверка транспорта',
                          style: TextStyle(
                              fontSize: 13, color: MyColors.grayText)),
                      SizedBox(height: 10),
                      Text('Подтвердить',
                          style: TextStyle(
                              fontSize: 15,
                              color: MyColors.redText,
                              decoration: TextDecoration.underline))
                    ],
                  )),
            ]),
            SizedBox(height: 5),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: Divider(
                  thickness: 1.5,
                )),
            SizedBox(height: 8),
            Center(
                child: Text(
              'Прошлые фото',
              style: TextStyle(fontSize: 13),
            )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3013,
                  height: AppSize.height(context) * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: infoCar.frontviewURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.network(
                            infoCar.frontviewURL,
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
                SizedBox(width: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3013,
                  height: AppSize.height(context) * 0.149,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: infoCar.behindviewURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.network(
                            infoCar.behindviewURL,
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
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3013,
                  height: AppSize.height(context) * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: infoCar.rightviewURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.network(
                            infoCar.rightviewURL,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        )
                      : Image.asset(
                          'assets/images/car_images/car4.png',
                          width: MyImagesSize.widthImageCar12(context),
                          height: MyImagesSize.heightImageCar12(context),
                        ),
                  alignment: Alignment.center,
                ),
                SizedBox(width: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3013,
                  height: AppSize.height(context) * 0.149,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: MyColors.frameColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: infoCar.leftviewURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          child: Image.network(
                            infoCar.leftviewURL,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        )
                      : Image.asset(
                          'assets/images/car_images/car3.png',
                          width: MyImagesSize.widthImageCar12(context),
                          height: MyImagesSize.heightImageCar12(context),
                        ),
                  alignment: Alignment.center,
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}

//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users/performers/${_auth.currentUser.uid}')
//               .snapshots(),
//           builder: (context, streamSnaphsot) {
//             if (streamSnaphsot.hasData) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 150),
//                   Container(
//                       child: Center(
//                           child: Container(
//                     color: Colors.blue,
//                     height: 90,
//                     width: 90,
//                   ))),
//                   Text(_auth.currentUser.uid),
//                   FutureBuilder(
//                     future: test,
//                     builder: (context, futureSnapshot) {
//                       if (futureSnapshot.hasData) {
//                         return Text(futureSnapshot.data['city']);
//                       }
//                       return Text('хуета');
//                     },
//                   ),
//                   // Text(test),
//                   // Text(streamSnaphsot.data.documents[2]['city']),
//
//                   // Text(_user.collection('users/performers/${_auth.currentUser.uid}').doc('userInformation').get()),
//                   SizedBox(height: 30),
//                 ],
//               );
//             }
//             return Container(child: Text('Польская корова2!'));
//           },
//         ));
//   }
// }
