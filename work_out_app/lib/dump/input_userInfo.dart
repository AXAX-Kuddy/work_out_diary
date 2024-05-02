// import 'dart:ffi';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:work_out_app/widgets/base_page.dart';
// import 'package:work_out_app/widgets/wide_button.dart';
// import 'package:work_out_app/widgets/widget_box.dart';
// import 'package:work_out_app/palette.dart' as palette;
// import 'package:line_icons/line_icons.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:work_out_app/widgets/text_field.dart';
// import 'package:work_out_app/widgets/drop_down.dart';
// import 'package:provider/provider.dart';
// import 'package:work_out_app/store.dart' as provider;

// class UserInfoPage extends StatefulWidget {
//   Map<String, dynamic> userInfo;
//   Function(bool) updateInfo;
//   bool notWriteUserInfo;

//   UserInfoPage({
//     super.key,
//     required this.updateInfo,
//     required this.userInfo,
//     required this.notWriteUserInfo,
//   });

//   @override
//   State<UserInfoPage> createState() => _UserInfoPageState();
// }

// class _UserInfoPageState extends State<UserInfoPage> {
//   String calculateResult = "아직 입력하지 않은 값이 존재합니다.";
//   bool dotsCheck = false;
//   bool inputCheck = false;

//   var userName;
//   var age;
//   num bodyWeight = 0;
//   Map<String, String> userSBD = {};
//   var dotsPoint;
//   bool isFemale = false;
//   var itemList = [
//     "남성",
//     "여성",
//   ];
//   late var dotsCal;
//   late var addInfo;

//   final nameFormKey = GlobalKey<FormState>();
//   final _squatFormKey = GlobalKey<FormState>();
//   final _benchFormKey = GlobalKey<FormState>();
//   final _deadFormKey = GlobalKey<FormState>();
//   final _weightFormKey = GlobalKey<FormState>();

//   bool nameFieldValid = false;
//   bool _squatValid = false;
//   bool _benchValid = false;
//   bool _deadValid = false;
//   bool _weightValid = false;

//   bool genderChecker = false;
//   bool ageChecker = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     dotsCal = context.watch<provider.Store>().dotsCal;
//     addInfo = context.watch<provider.Store>().addInfo;
//   }

//   void changedGenderCheckCondition() {
//     setState(() {
//       genderChecker = true;
//     });
//   }

//   void changedAgeCheckerCondition() {
//     setState(() {
//       ageChecker = true;
//     });
//   }

//   bool allInputCheck() {
//     if (nameFieldValid &&
//         _squatValid &&
//         _benchValid &&
//         _deadValid &&
//         _weightValid &&
//         genderChecker &&
//         ageChecker) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void updateCalValue() {
//     final result = calculator(
//       dotsCal: dotsCal,
//       userSBD: userSBD,
//       bodyWeight: bodyWeight,
//       isFemale: isFemale,
//     );
//     setState(() {
//       if (_squatValid &&
//           _benchValid &&
//           _deadValid &&
//           _weightValid &&
//           genderChecker) {
//         dotsCheck = true;
//         calculateResult = result;
//         if (allInputCheck()) {
//           inputCheck = true;
//         }
//       } else {
//         dotsCheck = false;
//         inputCheck = false;
//       }
//     });
//   }

//   dynamic calculator({
//     required Function dotsCal,
//     required Map<String, String> userSBD,
//     required num bodyWeight,
//     required bool isFemale,
//   }) {
//     if (_squatValid &&
//         _benchValid &&
//         _deadValid &&
//         _weightValid &&
//         genderChecker) {
//       num weightLifted = 0;
//       for (var entry in userSBD.entries) {
//         weightLifted += num.parse(entry.value);
//       }
//       return dotsCal(
//         bodyWeight: bodyWeight,
//         weightLifted: weightLifted,
//         isFemale: isFemale,
//       ).toString();
//     } else {
//       return "아직 입력하지 않은 값이 존재합니다.";
//     }
//   }

//   void writeInfo() {
//     if (allInputCheck()) {
//       print("완료");
//       setState(() {
//         addInfo(command: "name", value: userName);
//         addInfo(command: "sbd", value: userSBD);
//         addInfo(command: "dots", value: calculateResult);
//         addInfo(command: "age", value: age);
//         addInfo(command: "weight", value: bodyWeight);
//         addInfo(command: "isFemale", value: isFemale);
//         widget.updateInfo(widget.notWriteUserInfo);
//         context.read<provider.Store>().changePage(0);
//         Navigator.pop(context);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       children: [
//         WidgetsBox(
//           backgroundColor: palette.bgColor,
//           verticalAxis: CrossAxisAlignment.center,
//           inputContent: const [
//             Text(
//               "당신의 정보를 입력해주세요",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         WidgetsBox(
//           backgroundColor: palette.bgColor,
//           inputContent: [
//             Form(
//                 key: nameFormKey,
//                 child: CoustomTextField(
//                   width: 300,
//                   hintText: "이름을 입력해주세요",
//                   textStyle: TextStyle(
//                     color: palette.cardColorWhite,
//                     fontSize: 18,
//                   ),
//                   isValid: nameFieldValid,
//                   validator: (value) {
//                     RegExp regex = RegExp(r'^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$');
//                     if (value!.isEmpty) {
//                       setState(() {
//                         nameFieldValid = false;
//                         updateCalValue();
//                       });
//                       return "이름을 입력해주세요!";
//                     } else if (value.length > 10) {
//                       setState(() {
//                         nameFieldValid = false;
//                         updateCalValue();
//                       });
//                       return "이름은 10글자 이하로 해주세요!";
//                     } else if (!regex.hasMatch(value)) {
//                       setState(() {
//                         updateCalValue();
//                       });
//                       return "특수문자를 제외해야해요!";
//                     } else {
//                       setState(() {
//                         nameFieldValid = true;
//                         updateCalValue();
//                       });
//                       return null;
//                     }
//                   },
//                   onSaved: (newValue) {
//                     setState(() {
//                       userName = newValue;
//                       updateCalValue();
//                     });
//                   },
//                   onFieldSubmitted: (String? value) {
//                     final formKeyState = nameFormKey.currentState!;
//                     if (formKeyState.validate()) {
//                       formKeyState.save();
//                     }
//                   },
//                 )),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomDropDownButton(
//               selectChecker: changedGenderCheckCondition,
//               hint: "성별",
//               itemList: itemList,
//               onChanged: (value) {
//                 if (value == "남성") {
//                   isFemale = false;
//                   // print(isFemale);
//                   // print(value);
//                 } else if (value == "여성") {
//                   isFemale = true;
//                   // print(isFemale);
//                   // print(value);
//                 }
//                 updateCalValue();
//               },
//             ),
//             const SizedBox(
//               width: 40,
//             ),
//             CustomDropDownButton(
//               selectChecker: changedAgeCheckerCondition,
//               hint: "나이",
//               itemList: List.generate(100, (index) => "${index + 1}"),
//               onChanged: (value) {
//                 age = value;
//                 // print(value);
//                 updateCalValue();
//               },
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Form(
//           key: _weightFormKey,
//           child: CoustomTextField(
//             width: 300,
//             height: 100,
//             isValid: _weightValid,
//             textInputType: TextInputType.number,
//             hintText: "몸무게 KG",
//             textStyle: TextStyle(
//               fontSize: 18,
//               color: palette.cardColorWhite,
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 setState(() {
//                   _weightValid = false;
//                   updateCalValue();
//                 });
//                 return "값이 비었어요!";
//               } else {
//                 setState(() {
//                   _weightValid = true;
//                   updateCalValue();
//                 });
//                 return null;
//               }
//             },
//             onSaved: (newValue) {
//               setState(() {
//                 bodyWeight = num.parse(newValue!);
//                 updateCalValue();
//               });
//             },
//             onFieldSubmitted: (String? value) {
//               final formKeyState = _weightFormKey.currentState!;
//               if (formKeyState.validate()) {
//                 formKeyState.save();
//               }
//             },
//           ),
//         ),
//         WidgetsBox(
//           backgroundColor: palette.bgColor,
//           inputContent: [
//             Column(
//               children: [
//                 Text(
//                   "PR",
//                   style: TextStyle(
//                     color: palette.cardColorWhite,
//                     fontSize: 30,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         const Text(
//                           "스쿼트",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Form(
//                           key: _squatFormKey,
//                           child: CoustomTextField(
//                             width: 105,
//                             height: 60,
//                             isValid: _squatValid,
//                             textInputType: TextInputType.number,
//                             textStyle: TextStyle(
//                               fontSize: 18,
//                               color: palette.cardColorWhite,
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 setState(() {
//                                   _squatValid = false;
//                                   updateCalValue();
//                                 });
//                                 return "값이 비었어요!";
//                               } else {
//                                 setState(() {
//                                   _squatValid = true;
//                                   updateCalValue();
//                                 });
//                                 return null;
//                               }
//                             },
//                             onSaved: (newValue) {
//                               setState(() {
//                                 userSBD["스쿼트"] = newValue!;
//                                 print(userSBD);
//                                 updateCalValue();
//                               });
//                             },
//                             onFieldSubmitted: (String? value) {
//                               final formKeyState = _squatFormKey.currentState!;
//                               if (formKeyState.validate()) {
//                                 formKeyState.save();
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       children: [
//                         const Text(
//                           "벤치프레스",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Form(
//                           key: _benchFormKey,
//                           child: CoustomTextField(
//                             width: 105,
//                             height: 60,
//                             isValid: _benchValid,
//                             textInputType: TextInputType.number,
//                             textStyle: TextStyle(
//                               fontSize: 18,
//                               color: palette.cardColorWhite,
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 setState(() {
//                                   _benchValid = false;
//                                   updateCalValue();
//                                 });
//                                 return "값이 비었어요!";
//                               } else {
//                                 setState(() {
//                                   _benchValid = true;
//                                   updateCalValue();
//                                 });
//                                 return null;
//                               }
//                             },
//                             onSaved: (newValue) {
//                               setState(() {
//                                 userSBD["벤치프레스"] = newValue!;
//                                 print(userSBD);
//                                 updateCalValue();
//                               });
//                             },
//                             onFieldSubmitted: (String? value) {
//                               final formKeyState = _benchFormKey.currentState!;
//                               if (formKeyState.validate()) {
//                                 formKeyState.save();
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       children: [
//                         const Text(
//                           "데드리프트",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Form(
//                           key: _deadFormKey,
//                           child: CoustomTextField(
//                             width: 105,
//                             height: 60,
//                             isValid: _deadValid,
//                             textInputType: TextInputType.number,
//                             textStyle: TextStyle(
//                               fontSize: 18,
//                               color: palette.cardColorWhite,
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 setState(() {
//                                   _deadValid = false;
//                                   updateCalValue();
//                                 });
//                                 return "값이 비었어요!";
//                               } else {
//                                 setState(() {
//                                   _deadValid = true;
//                                   updateCalValue();
//                                 });
//                                 return null;
//                               }
//                             },
//                             onSaved: (newValue) {
//                               setState(() {
//                                 userSBD["데드리프트"] = newValue!;
//                                 print(userSBD);
//                                 updateCalValue();
//                               });
//                             },
//                             onFieldSubmitted: (String? value) {
//                               final formKeyState = _deadFormKey.currentState!;
//                               if (formKeyState.validate()) {
//                                 formKeyState.save();
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   dotsCheck ? "당신의 DOTS 포인트는 $calculateResult" : "",
//                   style: TextStyle(
//                     color: palette.cardColorWhite,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 Visibility(
//                   visible: inputCheck,
//                   child: WideButton(
//                     width: 200,
//                     onTapUpFunction: () => writeInfo(),
//                     inputContent: const [
//                       Text(
//                         "저장하기",
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
