// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:work_out_app/dump/dayli_detail_page.dart';
// import 'package:work_out_app/screens/plan_screen_widgets.dart/select_work_out_page.dart';
// import 'package:work_out_app/widgets/base_page.dart';
// import 'package:work_out_app/widgets/wide_button.dart';
// import 'package:work_out_app/widgets/widget_box.dart';
// import 'package:work_out_app/palette.dart' as palette;
// import 'package:line_icons/line_icon.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:work_out_app/store.dart' as provider;

// import 'package:work_out_app/make_program.dart' as maked;

// class DayliPage extends StatefulWidget {
//   final maked.Week weekInstance;
//   final Function changedListner;

//   const DayliPage({
//     super.key,
//     required this.weekInstance,
//     required this.changedListner,
//   });

//   @override
//   State<DayliPage> createState() => _DayliPageState();
// }

// class _DayliPageState extends State<DayliPage> {
//   late List<maked.Day>? days = widget.weekInstance.days;

//   void addDay(int index) {
//     setState(() {
//       maked.Day newDay = maked.Day(
//         dayIndex: index,
//       );
//       widget.weekInstance.addDay(newDay);
//       print("추가된 일차는 : ${newDay.dayIndex + 1}일차");
//       print("총 일차는 : ${days!.length}일");
//       widget.changedListner();
//     });
//   }

//   void deleteDay(maked.Day day) {
//     if (days!.isNotEmpty) {
//       setState(() {
//         int deleteIndex = day.dayIndex;
//         widget.weekInstance.removeDay(day);
//         print("삭제된 일차는 : ${day.dayIndex + 1}일차");

//         //삭제되면 인스턴스 내 dayIndex를 다시 설정
//         for (int i = 0; i < days!.length; i++) {
//           if (days![i].dayIndex > deleteIndex) {
//             days![i].dayIndex--;
//           }
//         }
//         print("총 일차는 : ${days!.length}일");
//         widget.changedListner();
//       });
//     }
//   }

//   void changedListner() {
//     setState(() {
//       days;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       children: [
//         WidgetsBox(
//           backgroundColor: palette.bgColor,
//           height: 60,
//           inputContent: [
//             Text(
//               "${widget.weekInstance.weekIndex + 1} 주차",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 34,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: days!.length,
//             itemBuilder: (BuildContext context, int index) {
//               return LayoutBuilder(
//                 builder: (context, constraints) {
//                   /// 일차 인스턴스
//                   maked.Day day = widget.weekInstance.days![index];

//                   ///일차인스턴스 안 운동 목록
//                   List<maked.Workout>? workouts = day.workouts;

//                   return WidgetsBox(
//                     margin: const EdgeInsets.only(
//                       bottom: 20,
//                     ),
//                     backgroundColor: palette.bgColor,
//                     border: Border.all(
//                       color: palette.cardColorGray,
//                     ),
//                     inputContent: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   "${day.dayIndex + 1}일차",
//                                   style: TextStyle(
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold,
//                                     color: palette.cardColorWhite,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 IconButton(
//                                   onPressed: () => deleteDay(day),
//                                   icon: const Icon(
//                                     LineIcons.trash,
//                                   ),
//                                   color: Colors.red,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             SizedBox(
//                               width: constraints.maxWidth,
//                               child: workouts!.isEmpty
//                                   ? TextButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: ((context) {
//                                               return SelectWorkOut(
//                                                 changedListner: changedListner,
//                                                 dayInstance: day,
//                                                 addFunction: day.addWorkout,
//                                               );
//                                             }),
//                                           ),
//                                         );
//                                       },
//                                       child: Text(
//                                         "여기를 눌러서 운동을 추가하세요!",
//                                         style: TextStyle(
//                                           color: palette.cardColorWhite,
//                                         ),
//                                       ),
//                                     )
//                                   : Column(
//                                       children: List.generate(workouts.length,
//                                           (index) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     DailyDetail(
//                                                   changedListner:
//                                                       changedListner,
//                                                   dayNum: day.dayIndex,
//                                                   workouts: workouts,
//                                                   callPlace: 0,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           child: Column(
//                                             children: [
//                                               const SizedBox(
//                                                 height: 20,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   const SizedBox(
//                                                     width: 8,
//                                                   ),
//                                                   Text(
//                                                     "${index + 1}.",
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: palette
//                                                           .cardColorWhite,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Text(
//                                                     "${workouts[index].name} | ",
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: palette
//                                                           .cardColorWhite,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     workouts[index]
//                                                             .sets!
//                                                             .isEmpty
//                                                         ? "세부 설정 없음"
//                                                         : "${workouts[index].sets!.length} ${workouts[index].sets!.length == 1 ? "Set" : "Sets"}",
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: palette
//                                                           .cardColorWhite,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     workouts[index].targetRpe ==
//                                                                 null ||
//                                                             workouts[index]
//                                                                 .targetRpe!
//                                                                 .isNaN
//                                                         ? ""
//                                                         : " | 타겟 RPE ${workouts[index].targetRpe}",
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: palette
//                                                           .cardColorWhite,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         WideButton(
//           onTapUpFunction: () {
//             addDay(days!.length);
//           },
//           inputContent: const [
//             Text("일차 추가하기"),
//           ],
//         ),
//       ],
//     );
//   }
// }
