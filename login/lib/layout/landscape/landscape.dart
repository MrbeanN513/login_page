import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:login/button/button_login.dart';
import 'package:login/util/screensize.dart';

class MylandscapeHomePage extends StatefulWidget {
  MylandscapeHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MylandscapeHomePageState createState() => _MylandscapeHomePageState();
}

class _MylandscapeHomePageState extends State<MylandscapeHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpeg"), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: scaler.getWidth(4.5),
                  color: Colors.black.withAlpha(225),
                  child: ListTile(
                    trailing: Text("Need Help?",
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    title: Text(
                        "© Copyright 2021 - unlimited \nMade by Goutam & Tapos",
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    // subtitle: Text("  Made by Goutam & Tapos",
                    //     style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                )),
            Loginlayout(),
          ],
        ),
      ),
    );
  }
}

class Loginlayout extends StatefulWidget {
  Loginlayout({Key? key}) : super(key: key);

  @override
  _LoginlayoutState createState() => _LoginlayoutState();
}

class _LoginlayoutState extends State<Loginlayout> {
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  FocusNode currentNode = FocusNode();
  FocusNode nextFocus = FocusNode();
  FocusNode button = FocusNode();

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      child: Center(
        child: Container(
            // color: Colors.orange,
            width: scaler.getWidth(45),
            height: scaler.getHeight(72),
            child: Card(
              color: Colors.black.withAlpha(225),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.orange,
                        width: scaler.getWidth(10),
                        height: scaler.getHeight(10),
                        child: InkWell(
                            child: Image.asset('assets/images/logo.png')),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            scaler.getWidth(2), 0, scaler.getWidth(2), 0),
                        child: TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onFieldSubmitted: (value) {
                            currentNode.unfocus();
                            FocusScope.of(context).requestFocus(nextFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'UserName Required!';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Use Valid Email like-"johndoe@email.com"';
                            }

                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          cursorColor: Colors.redAccent[700],
                          decoration: InputDecoration(
                            fillColor: Colors.redAccent[700],
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffFF0000), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'User Name',
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _formKey.currentState!.reset();
                                  });
                                },
                                child: Icon(
                                  Icons.backspace_outlined,
                                  size: 15,
                                  color: Colors.grey,
                                )),
                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            scaler.getWidth(2), 0, scaler.getWidth(2), 0),
                        child: TextFormField(
                          focusNode: nextFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onFieldSubmitted: (value) {
                            nextFocus.unfocus();
                            FocusScope.of(context).requestFocus(button);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Password Required!';
                            }
                            if (value.length < 6) {
                              return 'Password Must be 6 Digit Long!';
                            }
                            return null;
                          },
                          obscuringCharacter: "*",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          cursorColor: Colors.redAccent[700],
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            fillColor: Colors.redAccent[700],
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffFF0000), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon:
                                Icon(Icons.lock_open, color: Colors.grey),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(scaler.getWidth(2),
                            scaler.getWidth(2), scaler.getWidth(2), 0),
                        child: ElevatedButton(
                          focusNode: button,
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.redAccent[700],
                            onSurface: Colors.grey,
                            side: BorderSide(color: Colors.black, width: 1),
                            elevation: 20,
                            minimumSize: Size(400, 50),
                          ),
                          onPressed: () => _submit(),
                        ),
                      ),
                      TextButton(
                          onPressed: null,
                          child: Text(
                            "Forgot password",
                            style: TextStyle(color: Colors.white60),
                          )),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
