
import 'package:bloc_viper/bloc_viper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/features/sos_car/presentation/pages/main_sos_car/main/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'features/sos_car/presentation/pages/authentification/login_signin/page.dart';
import 'features/sos_car/presentation/pages/authentification/user_info_adding/page.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,// Status Bar
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Future<bool> checkUID() async {
    try{
      final snapshot = await FirebaseFirestore.instance
          .collection('users/performers/${FirebaseAuth.instance.currentUser.uid}').get();
      if(snapshot.docs.length != 0){
        return true;
      } else{
        return false;
      }
    } catch (err){
      switch(err.runtimeType){
        case NoSuchMethodError:
          return false;
        default:
          print(err);
          break;
      }
    }
    return false;
  }
  runApp(MyApp(checkUID: await checkUID(),));
}

class MyApp extends StatelessWidget {
  final bool checkUID;

  const MyApp({Key key, this.checkUID}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        // home: Page(),
     // home: Page(),
     home: StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (ctx, userSnapshot) {
           if (userSnapshot.hasData && checkUID) {
             return PageAfterLog();
           } else if(userSnapshot.hasData &&
               FirebaseAuth.instance.currentUser.phoneNumber != null &&
               FirebaseAuth.instance.currentUser.email!= null  ){
             print('CHECKUID - ${FirebaseAuth.instance.currentUser.phoneNumber}');
             return PageUserInfo();
           }
           return PageLogIn();
         }),
    );
  }
}



// import 'package:bloc_viper/bloc_viper.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:example/features/sos_car/presentation/pages/authentification/car_photos_adding/page.dart';
// import 'package:example/features/sos_car/presentation/pages/authentification/confirmation_code/page.dart';
// import 'package:example/features/sos_car/presentation/pages/authentification/docs_photos_adding/page.dart';
// import 'package:example/features/sos_car/presentation/pages/authentification/license_agreement/page.dart';
// import 'package:example/features/sos_car/presentation/pages/authentification/test_multiply_providers/page.dart';
// import 'package:example/features/sos_car/presentation/pages/evacuator/cargo_evacuator/page.dart';
// import 'package:example/features/sos_car/presentation/pages/evacuator/easy_evacuator/page.dart';
// import 'package:example/features/sos_car/presentation/pages/evacuator/manipulator_evacuator/page.dart';
// import 'package:example/features/sos_car/presentation/pages/evacuator/type_of_evacuator/page.dart';
// import 'package:example/features/sos_car/presentation/pages/step2/main/page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
//
// import 'features/sos_car/presentation/pages/authentification/login_signin/page.dart';
// import 'features/sos_car/presentation/pages/authentification/user_info_adding/page.dart';
//
//
// Future<void> main() async {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark,// Status Bar
//   ));
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   try{
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('users/performers/${FirebaseAuth.instance.currentUser.uid}').get();
//   } catch(err){
//     print('КОД ОШИБКИ ! - ${err.code}');
//     return false
//   }
//
//
//
//   runApp(MyApp(resultSnapshot: snapshot,));
// }
//
// class MyApp extends StatelessWidget {
//   bool resultSnapshot;
//
//   const MyApp({Key key, this.resultSnapshot}) : super(key: key);
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         fontFamily: 'Inter',
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       // home: Page(),
//       // home: Page(),
//       home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (ctx, userSnapshot) {
//             if (userSnapshot.hasData && snapshot.docs.length != 0) {
//               return PageAfterLog();
//             } else if(userSnapshot.hasData  && snapshot.docs.length == 0){
//               return Page();
//             }
//             return PageLogIn();
//           }),
//     );
//   }
// }
//

