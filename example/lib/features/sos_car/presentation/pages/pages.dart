import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/login_signin/page.dart'  as login;
import 'package:example/features/sos_car/presentation/pages/authentification/user_info_adding/page.dart'  as userInfo;
import 'package:example/features/sos_car/presentation/pages/authentification/confirmation_code/page.dart'  as confirmationCode;
import 'package:example/features/sos_car/presentation/pages/authentification/car_info_adding/page.dart'  as carInfo;
import 'package:example/features/sos_car/presentation/pages/authentification/car_photos_adding/page.dart'  as carPhoto;
import 'package:example/features/sos_car/presentation/pages/authentification/docs_photos_adding/page.dart'  as docsPhoto;

import 'package:example/features/sos_car/presentation/pages/evacuator/type_of_evacuator/page.dart'  as typeEvacuator;
import 'package:example/features/sos_car/presentation/pages/evacuator/manipulator_evacuator/page.dart'  as manipulatorEvacuator;
import 'package:example/features/sos_car/presentation/pages/evacuator/easy_evacuator/page.dart'  as easyEvacuator;
import 'package:example/features/sos_car/presentation/pages/evacuator/cargo_evacuator/page.dart'  as cargoEvacuator;
import 'package:example/features/sos_car/presentation/pages/authentification/license_agreement/page.dart'  as licenseAgreement;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/main/page.dart'  as afterLog;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/profile_user/page.dart'  as profileUser;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/page.dart'  as edit;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/selection_services/page.dart'  as selectionServices;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/edit_car_info/page.dart'  as editCarInfo;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/edit_evacuator/type_of_evacuator/page.dart'  as editEvacType;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/edit_evacuator/cargo_evacuator/page.dart'  as cargoEvacuatorEdit;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/edit_evacuator/easy_evacuator/page.dart'  as easyEvacuatorEdit;
import 'package:example/features/sos_car/presentation/pages/main_sos_car/edit/edit_evacuator/manipulator_evacuator/page.dart'  as manipulatorEvacuatorEdit;








class Pages {
  static login.PageLogIn get counterPage => login.PageLogIn();
  static confirmationCode.Page1 confirmationCodePage([phoneNumber,verificationId,forceResendingToken, isLogin, email]) =>
      confirmationCode.Page1(phoneNumber,verificationId, forceResendingToken, isLogin, email);
  static userInfo.PageUserInfo infoUserPage(idUser, code, email) => userInfo.PageUserInfo(phone: idUser, code: code, email: email,);
  static carInfo.Page carInfoPage(userInfo) => carInfo.Page(userInfo);
  static carPhoto.PageCarPhotos carPhotoPage(userInfo, carInfo) =>  carPhoto.PageCarPhotos(userInfo, carInfo);
  static docsPhoto.PageDocsPhoto docsPhotoPage(userInfo, carInfo) => docsPhoto.PageDocsPhoto(userInfo, carInfo);
  static licenseAgreement.PageLicenseAgreement licenseAgreementPageFromShowDialog(allUserInfo) => licenseAgreement.PageLicenseAgreement(allUserInfo: allUserInfo);
  static licenseAgreement.PageLicenseAgreement licenseAgreementPageFromAnyEvacuator(allUserInfo) => licenseAgreement.PageLicenseAgreement(allUserInfo: allUserInfo);
  static afterLog.PageAfterLog afterLogPage() => afterLog.PageAfterLog();
  static edit.EditPage editPage(AllUserInfoModel allInfo) => edit.EditPage(allInfo);
  static selectionServices.SelectionServicesPage selectionServicesPage(AllUserInfoModel infoAll)
  => selectionServices.SelectionServicesPage(infoAll);
  static editCarInfo.PageEditAutoInfo editCarInfoPage(AllUserInfoModel allInfo)
  => editCarInfo.PageEditAutoInfo(allInfo);

  static editEvacType.PageEditTypeEvacuator editEvacTypePage(AllUserInfoModel allInfo) => editEvacType.PageEditTypeEvacuator(allInfo);
  static cargoEvacuatorEdit.PageEditCargoEvacuator cargoEvacuatorEditPage(AllUserInfoModel allInfo) => cargoEvacuatorEdit.PageEditCargoEvacuator(allInfo);
  static easyEvacuatorEdit.PageEditEasyEvacuator easyEvacuatorEditPage(AllUserInfoModel allInfo) => easyEvacuatorEdit.PageEditEasyEvacuator(allInfo);
  static manipulatorEvacuatorEdit.PageEditManipulatorEvacuator manipulatorEvacuatorEditPage(AllUserInfoModel allInfo) => manipulatorEvacuatorEdit.PageEditManipulatorEvacuator(allInfo);


  static typeEvacuator.PageTypeEvacuator typeEvacuatorPage(userInfo, carInfo) => typeEvacuator.PageTypeEvacuator(userInfo, carInfo);
  static manipulatorEvacuator.PageManipulatorEvacuator manipulatorEvacuatorPage(userInfo, carInfo) => manipulatorEvacuator.PageManipulatorEvacuator(userInfo, carInfo);
  static easyEvacuator.PageEasyEvacuator easyEvacuatorPage(userInfo, carInfo) => easyEvacuator.PageEasyEvacuator(userInfo, carInfo);
  static cargoEvacuator.PageCargoEvacuator cargoEvacuatorPaeg(userInfo, carInfo) => cargoEvacuator.PageCargoEvacuator(userInfo, carInfo);

  static profileUser.PageProfileUser profileUserPage(AllUserInfoModel info) =>
      profileUser.PageProfileUser(info);











}
