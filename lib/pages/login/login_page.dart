import 'dart:ui';
import 'package:project_latihan/navigation/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _loginChecker() async {
    final SharedPreferences prefs = await _prefs;
    final bool status = prefs.getBool('login') ?? false;

    if (status == true) {
      _getLogin();
    }
  }

  Future<void> _setLogin() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("login", true);
  }

  @override
  void initState() {
    super.initState();
    _loginChecker();
  }

  void _getLogin() {
    Loader.show(context, progressIndicator: const LinearProgressIndicator());
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const NavigationScreen()));
      Loader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Theme.of(context).colorScheme.secondaryVariant,
                Theme.of(context).colorScheme.primaryVariant
              ], begin: Alignment.topRight, end: Alignment.topLeft),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text("And Watch Movies",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Form(
                      key: formKey,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    hintText: "Username",
                                    hintStyle:
                                        TextStyle(color: Color(0xFF7d7d7d)),
                                    prefixIcon: const Icon(
                                      Icons.account_box,
                                      color: Color(0xFF000000),
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "* Required";
                                  } else if (value.length < 6) {
                                    return "Username should be atleast 6 characters";
                                  } else if (value.length > 24) {
                                    return "Username should not be greater than 24";
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF7d7d7d)),
                                    prefixIcon: const Icon(
                                      Icons.password,
                                      color: Color(0xFF000000),
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "* Required";
                                  } else if (value.length < 6) {
                                    return "Password should be atleast 6 characters";
                                  } else if (value.length > 24) {
                                    return "Password should not be greater than 24";
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      _setLogin();
                                      _getLogin();
                                    }
                                  },
                                  child: const Text("Log In",
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Forgot your login details? Click link below",
                                style: TextStyle(color: Colors.white),
                              ),
                              const Text("Forgot Password",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white54))
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
