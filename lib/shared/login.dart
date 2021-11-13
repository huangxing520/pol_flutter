import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:pol_flutter/common/common.dart';
import 'package:pol_flutter/common/http.dart';
import 'package:pol_flutter/store/Store.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  bool isLogin = false;
  String pwd = "";

  githubLogin() async {
    BotToast.showText(text: "not support yet");
  }

  googleLogin() async {
    BotToast.showText(text: "not support yet");
    // try {
    //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    //   BotToast.showText(text: googleSignInAccount.toString());

    // } catch (error) {
    // }
  }

  login(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    var formData = FormData.fromMap({"name": username, "password": pwd});
    Response response =
    await HttpUtil.instance.dio.post(Common.login, data: formData);
    var data = response.data;
    if (data['code'] != 201) {
      BotToast.showText(text: data['msg']);
    } else {
      //收起键盘
      SpUtil.putString('email', data['data']['email']);
      SpUtil.putString('username', username);
      SpUtil.putString("auth", data['data']['token']);

      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("登录"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            key: UniqueKey(),
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("images/login.jpg"),
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(child: Text('POL')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: '账号',
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: Icon(Icons.person)),
                onChanged: (String value) {
                  this.username = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: '密码',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
                onChanged: (String value) {
                  this.pwd = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  width: 320.0,
                  height: 44.0,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                    BorderRadius.all(const Radius.circular(22.0)),
                  ),
                  child: const Text(
                    "登 陆",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                onTap: () => login(context),
              ),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
