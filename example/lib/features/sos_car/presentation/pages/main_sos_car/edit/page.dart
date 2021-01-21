import 'dart:io';
import 'package:bloc_viper/bloc_viper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
class EditPage extends XPage {
  
  final AllUserInfoModel info;
  EditPage(this.info);
  
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends XPageState<EditPage, Event, State> {
  _EditPageState() : super(Controller());
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
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
                    Navigator.of(context).pop();  // вот тут поменять
                  },
                  child: Image.asset(
                    'assets/icons/arrow_back.png',
                    height: 60,
                    width: 60,
                  )),
              Text('Редактировать',
                  style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'Inter',
                      fontWeight: MyParams.textBold,
                      fontSize: 20)),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Данные профиля',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: MyColors.grayText)
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1,color: MyColors.frameColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                addEvent(GoToEditCarInfo(widget.info));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Данные авто',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: MyColors.grayText)
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1,color: MyColors.frameColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                addEvent(GoToEditEvacType(widget.info));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Эвакуатор',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: MyColors.grayText)
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1,color: MyColors.frameColor,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                addEvent(GoToSelectionServicesPage(widget.info));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Выбор услуг',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: MyColors.grayText)
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1,color: MyColors.frameColor,)
                  ],
                ),
              ),
            ),
          ],
        ));

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
