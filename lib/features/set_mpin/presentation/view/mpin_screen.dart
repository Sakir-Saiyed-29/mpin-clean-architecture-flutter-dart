import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpin_demo/core/font_manager.dart';
import 'package:mpin_demo/core/utils/image_manager.dart';
import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_event.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_state.dart';
import 'package:mpin_demo/utils/basic_utility.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpinScreen extends StatefulWidget {
  const MpinScreen({Key? key}) : super(key: key);

  @override
  State<MpinScreen> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<MpinScreen> {
  final pinController1 = TextEditingController();
  final pinController2 = TextEditingController();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String msgErrorPin1 = '';
  String msgErrorPin2 = '';
  bool _isPin1ErroVisible = false;
  bool _isPin2ErroVisible = false;
  List<MpinEntity> arrStoredPins = [];
  late SharedPreferences sharedPreferences;
  final defaultPinTheme = PinTheme(
    width: 70,
    height: 70,
    margin: const EdgeInsets.all(8),
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kGreyBorderColor),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadMpinData();
  }

  _loadMpinData() async {
    debugPrint('_loadMpinData called...');
    context.read<MpinBloc>().add(const LoadInitialMpinEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MpinBloc, MpinState>(
      listener: (context, state) {
        if (state is MpinInitialState) {
          debugPrint('MpinInitialState');
        }
        if (state is MpinGetSuccessState) {
          debugPrint('MpinGetSuccessState');
          arrStoredPins = state.pins;
          for (var pin in arrStoredPins) {
            debugPrint('last saved pins: $pin');
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/back_arrow.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/trailing-icon.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
              ],
              title: Text(
                'Set MPIN',
                style: TextStyle(
                  fontFamily: 'Georama',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: kGray202020,
                  height:
                      FontHeight.calFontHeight(fontSize: 15, lineHeight: 15),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: Colors.redAccent,
                  height: 1.0,
                ),
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Text(
                        'Set your MPIN for further login.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Georama',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: kGray202020,
                          height: FontHeight.calFontHeight(
                              fontSize: 16, lineHeight: 19.5),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Enter MPIN',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Georama',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: kGray202020,
                              height: FontHeight.calFontHeight(
                                  fontSize: 14, lineHeight: 16.5),
                            ),
                          ),
                        ),
                        Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            controller: pinController1,
                            key: const Key('enter_mpin'),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            focusNode: focusNode1,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            obscureText: false,
                            obscuringWidget: SvgPicture.asset(
                              ImageAssets.obscureTextIcon,
                              height: 10,
                              width: 10,
                            ),
                            onCompleted: (pinNumber) {
                              debugPrint('onCompleted pin1: $pinNumber');
                              if (BasicUtility()
                                  .isMPinAlreadyExist(pinNumber)) {
                                setState(() {
                                  _isPin1ErroVisible = true;
                                  msgErrorPin1 =
                                      "MPIN should not match last 3 PIN.";
                                });
                              } else {
                                debugPrint('does not contain: $pinNumber');
                                setState(() {
                                  _isPin1ErroVisible = false;
                                });
                              }
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                              if (value.length != 4) {
                                setState(() {
                                  _isPin1ErroVisible = false;
                                  _isPin2ErroVisible = false;
                                });
                              }
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                setState(() {
                                  _isPin1ErroVisible = true;
                                  msgErrorPin1 = "MPIN should not be empty.";
                                });
                              } else if (value!.length < 4) {
                                setState(() {
                                  _isPin1ErroVisible = true;
                                  msgErrorPin1 =
                                      "MPIN should not be less than 4 characters.";
                                });
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _isPin1ErroVisible,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                ImageAssets.alertIcon,
                                colorFilter: const ColorFilter.mode(
                                    Colors.red, BlendMode.srcIn),
                                height: 10,
                                width: 10,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                msgErrorPin1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Georama',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: redfontColor,
                                  height: FontHeight.calFontHeight(
                                      fontSize: 15, lineHeight: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Confirm MPIN',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Georama',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: kGray202020,
                              height: FontHeight.calFontHeight(
                                  fontSize: 14, lineHeight: 16.5),
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            controller: pinController2,
                            key: const Key('confirm_mpin'),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            focusNode: focusNode2,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.none,
                            listenForMultipleSmsOnAndroid: true,
                            defaultPinTheme: defaultPinTheme,
                            obscureText: false,
                            obscuringWidget: SvgPicture.asset(
                              ImageAssets.obscureTextIcon,
                              height: 10,
                              width: 10,
                            ),
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            onCompleted: (pin) {
                              debugPrint('onCompleted pin2: $pin');
                              if (pin != pinController1.text) {
                                setState(() {
                                  _isPin2ErroVisible = true;
                                  msgErrorPin2 =
                                      'MPIN and confirm MPIN does not match';
                                });
                              } else {
                                setState(() {
                                  _isPin2ErroVisible = false;
                                });
                              }
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                              if (value.length != 4) {
                                setState(() {
                                  _isPin2ErroVisible = false;
                                });
                              }
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                setState(() {
                                  _isPin2ErroVisible = true;
                                  msgErrorPin2 =
                                      "Confirm MPIN should not be empty.";
                                });
                              } else if (value!.length < 4) {
                                setState(() {
                                  _isPin2ErroVisible = true;
                                  msgErrorPin2 =
                                      "Confirm PIN should not be less than 4 characters.";
                                });
                              } else if (pinController1.text !=
                                  pinController2.text) {
                                setState(() {
                                  _isPin2ErroVisible = true;
                                  msgErrorPin2 =
                                      'MPIN and confirm MPIN does not match';
                                });
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _isPin2ErroVisible,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                ImageAssets.alertIcon,
                                colorFilter: const ColorFilter.mode(
                                    Colors.red, BlendMode.srcIn),
                                height: 10,
                                width: 10,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                msgErrorPin2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Georama',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: redfontColor,
                                  height: FontHeight.calFontHeight(
                                      fontSize: 15, lineHeight: 15),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        'Please ensure MPIN needs to be as per follow Policies:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Georama',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: kGray202020,
                          height: FontHeight.calFontHeight(
                              fontSize: 14, lineHeight: 16.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "\u2022",
                              style: TextStyle(fontSize: 20),
                            ), //bullet text
                            const SizedBox(
                              width: 4,
                            ), //space between bullet and text
                            Text(
                              'MPIN should be 4 digits in length.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georama',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: kGray202020,
                                height: FontHeight.calFontHeight(
                                    fontSize: 12, lineHeight: 14.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "\u2022",
                              style: TextStyle(fontSize: 20),
                            ), //bullet text
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '3 consecutive numbers cannot be same',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georama',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: kGray202020,
                                height: FontHeight.calFontHeight(
                                    fontSize: 12, lineHeight: 14.5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "\u2022",
                              style: TextStyle(fontSize: 20),
                            ), //bullet text
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '3 consecutive numbers cannot be in sequence.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Georama',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: kGray202020,
                                height: FontHeight.calFontHeight(
                                    fontSize: 12, lineHeight: 14.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        key: const Key('setMpin_btn'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kRedButtonColor,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Georama',
                            fontWeight: FontWeight.w600,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          shadowColor: Colors.lightBlue,
                        ),
                        onPressed: () =>
                            _onSetMpin(context, pinController1.text),
                        child: const Text('Set MPIN'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSetMpin(BuildContext context, String pin) {
    debugPrint('_onSetMpin pressed');

    if (_formKey.currentState!.validate()) {
      if (pinController1.text == pinController2.text &&
          pinController1.text.isNotEmpty &&
          pinController2.text.isNotEmpty) {
        debugPrint('store this pin');

        context.read<MpinBloc>().add(SetMpinEvent(MpinEntity(pin: pin)));
        showSuccessAlert(context);
      }
    }
  }

  Future<void> showSuccessAlert(BuildContext innerContext) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Mpin saved successfully."),
            actions: [
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(innerContext).pop();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    pinController1.dispose();
    pinController2.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }
}
