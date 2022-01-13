import 'dart:async';
import 'dart:io';
import 'user_view.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: LoginScaffold(storage: LoginStorage()),
    );
  }
}

class LoginStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/login.txt');
  }

  Future<String> readLogin() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeLogin(String login) async {
    final file = await _localFile;


    return file.writeAsString('$login');
  }
}

class LoginScaffold extends StatefulWidget{
    const LoginScaffold({Key? key, required this.storage}) : super(key: key);

    final LoginStorage storage;

    @override
    _LoginScaffoldState createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {
  final String _rightlogin = '+12345678910';
  final String _rightpassword = 'password';
  String _login = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readLogin().then((value) {
      setState(() {
        _login = value;
        loginController.text = _login;
      });
    });
  }

  Future<File> _setLogin() {
    setState(() {
    });

    _login = loginController.text;
    return widget.storage.writeLogin(_login);

  }

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        borderSide: BorderSide(
            color: Color(0xFF89cff0), width: 3));
    const linkTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFf0ffff)
    );

    return Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 100, ),
                const SizedBox(width: 100, height: 100, child:
                Image(image: AssetImage('assets/logo.png')),),
                const SizedBox(height: 60,),
                const Text("Введите номер телефона и пароль",
                    style: TextStyle(fontSize: 17,
                        color: Color.fromRGBO(0, 0, 0, 0.6))),
                const SizedBox(height: 40,),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    filled: true,
                    fillColor: Color(0xFFeceff1),
                    labelText: "Телефон",
                  ),
                  controller: loginController,
                ),
                const SizedBox(height: 20,),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    filled: true,
                    fillColor: Color(0xFFeceff1),
                    labelText: "Пароль",
                  ),
                  controller: passwordController,
                ),
                const SizedBox(height: 40,),
                SizedBox(width: 160, height: 40,
                    child: ElevatedButton(
                      child: const Text('Войти'),
                      onPressed: (){
                        _setLogin();
                        if ((_login == _rightlogin) && (passwordController.text == _rightpassword)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage()),
                          );
                        } else {
                          showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Неверно введен логин или пароль"),
          );}
    );
                        }
                    },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0079D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                      ),
                    )
                ),
                const SizedBox(height: 32,),
                InkWell(child: const Text('Регистрация',
                  style: linkTextStyle,
                ),
                    onTap: () {

                    }),
                const SizedBox(height: 20,),
                InkWell(child: const Text('Забыли пароль?',
                  style: linkTextStyle,
                ), onTap: () {

                }),
              ],),
            )
      ));
  }
}


