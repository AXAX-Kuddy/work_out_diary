import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/screens/user_info_screen.dart/name_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/sbd_input.dart';
import 'package:work_out_app/screens/user_info_screen.dart/user_info_screen_widgets/input.dart';
import 'package:work_out_app/util/keys.dart';
import 'package:work_out_app/widgets/base_screen/base_page.dart';
import 'package:work_out_app/widgets/drop_downs/drop_down.dart';
import 'package:work_out_app/widgets/router/sliding_builder.dart';
import 'package:work_out_app/widgets/text_field/text_field.dart';
import 'package:work_out_app/util/palette.dart' as palette;
import 'package:work_out_app/provider/store.dart' as provider;

class AgeInput extends StatefulWidget {
  final bool fromDotsScreen;

  const AgeInput({
    super.key,
    this.fromDotsScreen = false,
  });

  @override
  State<AgeInput> createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  late provider.MainStoreProvider mainStoreProvider;
  late provider.UserInfo userInfo;
  late Function({required UserInfoField userInfoField, required dynamic value})
      setUserInfo;

  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> ageKey = GlobalKey<FormState>();
  final FocusNode ageFocusNode = FocusNode();

  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> weightKey = GlobalKey<FormState>();
  final FocusNode weightFocusNode = FocusNode();

  final TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> heightKey = GlobalKey<FormState>();
  final FocusNode heightFocusNode = FocusNode();

  ///현재 선택된 드롭다운 아이템 변수
  ///페이지를 불러올 때 값이 있다면
  String? nowDropDownValue;

  int? userAge;
  String? sex;
  double? weight;
  double? height;

  bool ageValid = false;
  bool sexValid = false;
  bool weightValid = false;
  bool heightValid = false;

  @override
  void initState() {
    mainStoreProvider = context.read<provider.MainStoreProvider>();
    userInfo = context.read<provider.MainStoreProvider>().userInfo;
    setUserInfo = context.read<provider.MainStoreProvider>().setUserInfo;

    /// 사용자가 나이 및 성별을 기입했는지 여부
    if (userInfo[UserInfoField.age] != null) {
      ageController.text = userInfo[UserInfoField.age].toString();

      setState(() {
        ageValid = true;
      });
    }

    if (userInfo[UserInfoField.weight] != null) {
      weightController.text = userInfo[UserInfoField.weight].toString();
      setState(() {
        weightValid = true;
      });
    }

    if (userInfo[UserInfoField.height] != null) {
      heightController.text = userInfo[UserInfoField.height].toString();
      setState(() {
        heightValid = true;
      });
    }

    /// 유저 성별 파악
    if (userInfo[UserInfoField.sex] != SexType.nonSelect) {
      if (userInfo[UserInfoField.sex] == SexType.male) {
        setState(() {
          sexValid = true;
          sex = userInfo[UserInfoField.sex];
          nowDropDownValue = userInfo[UserInfoField.sex];
        });
      } else if (userInfo[UserInfoField.sex] == SexType.female) {
        setState(() {
          sexValid = true;
          sex = userInfo[UserInfoField.sex];
          nowDropDownValue = userInfo[UserInfoField.sex];
        });
      }
    } else {
      setState(() {
        sexValid = false;
        sex = null;
        nowDropDownValue = null;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: widget.fromDotsScreen
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                ),
                color: palette.cardColorWhite,
              ),
            )
          : null,
      mainAxisAlignment: MainAxisAlignment.center,
      children: InputField.mainInput(
        context: context,
        backButton: !widget.fromDotsScreen,
        escapeButton: !widget.fromDotsScreen,
        endButton: widget.fromDotsScreen,
        backTo: const NameInput(),
        title: widget.fromDotsScreen
            ? "세부적인 정보도 알고 싶어요!"
            : "조금 더 세부적인 정보도 알고 싶어요!",
        subtitle: "신장 단위는 cm, 체중 단위는 kg이에요.",
        childrenWidth: 300,
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    /// 나이 입력란
                    Expanded(
                      child: CustomTextField(
                        formKey: ageKey,
                        focusNode: ageFocusNode,
                        controller: ageController,
                        hintText: "나이",
                        hintStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textInputType: TextInputType.number,
                        isValid: ageValid,
                        validator: (value) {
                          /// 값이 null이 아닐 때
                          if (value != null) {
                            /// 값이 비어있다면
                            if (value.isEmpty) {
                              setState(() {
                                ageValid = false;
                              });
                              return "값을 입력해주세요!";
                            }

                            /// 값이 숫자가 아니라면
                            if (int.tryParse(value) == null) {
                              setState(() {
                                ageValid = false;
                              });
                              return "숫자만 입력해주세요!";
                            }

                            /// 값이 숫자일 때
                            if (int.tryParse(value) != null) {
                              // 비정상적인 값을 입력했을 경우
                              if (int.parse(value) > 118 ||
                                  int.parse(value) <= 0) {
                                setState(() {
                                  ageValid = false;
                                });
                                return "장난금지!";
                              }
                            }
                          }

                          /// 모든 예외를 통과했다면
                          setState(() {
                            ageValid = true;
                            userAge = int.parse(value!);
                          });
                          return null;
                        },
                        onFocusout: () {
                          CustomTextField.submit(ageKey);
                        },
                        onFieldSubmitted: (value) {
                          CustomTextField.submit(ageKey);
                        },
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    /// 성별 입력란
                    Expanded(
                      child: CustomDropDownButton(
                        hint: "성별",
                        textStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        itemTextStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        width: null,
                        height: 55,
                        itemList: [
                          SexType.male,
                          SexType.female,
                        ],
                        nowValue: nowDropDownValue,
                        enabledValid: sexValid,
                        onChanged: (value) {
                          if (value == SexType.male) {
                            setState(() {
                              sexValid = true;
                              sex = SexType.male;
                            });
                          } else {
                            setState(() {
                              sexValid = true;
                              sex = SexType.female;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "신장cm",
                        hintStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textInputType: TextInputType.number,
                        isValid: heightValid,
                        focusNode: heightFocusNode,
                        formKey: heightKey,
                        controller: heightController,
                        validator: (String? value) {
                          /// 값이 null이 아닐 때
                          if (value != null) {
                            /// 값이 비어있다면
                            if (value.isEmpty) {
                              setState(() {
                                heightValid = false;
                                height = null;
                              });
                              return "값이 비었어요!";
                            }

                            /// 값이 숫자가 아니라면
                            if (double.tryParse(value) == null) {
                              setState(() {
                                heightValid = false;
                                height = null;
                              });
                              return "숫자만 입력해주세요!";
                            }

                            /// 값이 숫자일 때
                            if (double.tryParse(value) != null) {
                              /// 비정상적인 값을 입력했을 경우
                              if (double.parse(value) >= 300 ||
                                  double.parse(value) < 0) {
                                setState(() {
                                  heightValid = false;
                                  height = null;
                                });
                                return "장난금지!";
                              }

                              /// 값이 0일 경우
                              if (double.parse(value) == 0) {
                                setState(() {
                                  heightValid = false;
                                  height = null;
                                });
                                return "0 이상으로 입력해주세요!";
                              }
                            }
                          }

                          /// 모든 예외를 통과했다면
                          setState(() {
                            heightValid = true;
                            height = double.parse(value!);
                          });

                          return null;
                        },
                        onFocusout: () {
                          CustomTextField.submit(heightKey);
                        },
                        onFieldSubmitted: (String value) {
                          CustomTextField.submit(heightKey);
                        },
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    /// 몸무게 입력란
                    Expanded(
                      child: CustomTextField(
                        hintText: "체중kg",
                        hintStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textStyle: const TextStyle(
                          color: palette.cardColorWhite,
                        ),
                        textInputType: TextInputType.number,
                        isValid: weightValid,
                        focusNode: weightFocusNode,
                        formKey: weightKey,
                        controller: weightController,
                        validator: (String? value) {
                          /// 값이 null이 아닐 때
                          if (value != null) {
                            /// 값이 비어있다면
                            if (value.isEmpty) {
                              setState(() {
                                weightValid = false;
                                weight = null;
                              });
                              return "값이 비었어요!";
                            }

                            /// 값이 숫자가 아니라면
                            if (double.tryParse(value) == null) {
                              setState(() {
                                weightValid = false;
                                weight = null;
                              });
                              return "숫자만 입력해주세요!";
                            }

                            /// 값이 숫자일 때
                            if (double.tryParse(value) != null) {
                              /// 비정상적인 값을 입력했을 경우
                              if (double.parse(value) >= 635 ||
                                  double.parse(value) < 0) {
                                setState(() {
                                  weightValid = false;
                                  weight = null;
                                });
                                return "장난금지!";
                              }

                              /// 값이 0일 경우
                              if (double.parse(value) == 0) {
                                setState(() {
                                  weightValid = false;
                                  weight = null;
                                });
                                return "0 이상으로 입력해주세요!";
                              }
                            }
                          }

                          /// 모든 예외를 통과했다면
                          setState(() {
                            weightValid = true;
                            weight = double.parse(value!);
                          });

                          return null;
                        },
                        onFocusout: () {
                          CustomTextField.submit(weightKey);
                        },
                        onFieldSubmitted: (String value) {
                          CustomTextField.submit(weightKey);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        onTapUp: () {
          /// 다음페이지로 넘어가기 전 검사
          CustomTextField.submit(ageKey);
          CustomTextField.submit(weightKey);
          CustomTextField.submit(heightKey);

          ///모든 입력을 완료했을 때
          if (ageValid && sexValid && weightValid && heightValid) {
            setUserInfo(
              userInfoField: UserInfoField.age,
              value: userAge,
            );

            setUserInfo(
              userInfoField: UserInfoField.weight,
              value: weight,
            );

            setUserInfo(
              userInfoField: UserInfoField.height,
              value: height,
            );

            setUserInfo(
              userInfoField: UserInfoField.sex,
              value: sex,
            );

            if (widget.fromDotsScreen) {
              mainStoreProvider.savePreferencesOnly(
                UserInfoField.age,
                userAge,
              );
              mainStoreProvider.savePreferencesOnly(
                UserInfoField.weight,
                weight,
              );
              mainStoreProvider.savePreferencesOnly(
                UserInfoField.height,
                height,
              );
              mainStoreProvider.savePreferencesOnly(
                UserInfoField.sex,
                sex,
              );
              Navigator.pop(context);
            } else {
              SlidePage.goto(
                context: context,
                page: const SBDInput(),
              );
            }
          }
        },
      ),
    );
  }
}
