import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_book/pages/login/login_page.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/create_tables.dart';
import '../../db/table/user_table.dart';
import '../../model/user_info.dart';

//登录界面
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});
  static String tag = 'login-page';
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  var usernameControll = TextEditingController();
  var passwordControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      //飞行动画
      tag: 'hero',
      child: CircleAvatar(
        //圆形图片组件
        backgroundColor: Colors.transparent, //透明
        radius: 48.0, //半径
        child: Image.asset("assets/logo.png"), //图片
      ),
    );
    final username = TextFormField(
      //用户名
      controller: usernameControll,
      keyboardType: TextInputType.emailAddress,
      autofocus: false, //是否自动对焦
      decoration: InputDecoration(
          hintText: '请输入用户名', //提示内容
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), //上下左右边距设置
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0) //设置圆角大小
              )),
    );
    final password = TextFormField(
      //密码
      controller: passwordControll,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '请输入密码',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButton = Padding(
      padding: const EdgeInsets.all(0), //上下各添加16像素补白
      child: Material(
        borderRadius: BorderRadius.circular(30.0), // 圆角度
        shadowColor: Colors.lightBlueAccent.shade100, //阴影颜色
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            if (passwordControll.text.isNotEmpty && usernameControll.text.isNotEmpty) {
              if (await checkAccount()) {
                Fluttertoast.showToast(
                    msg: "该用户名已被使用",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Database db = await CreateTables().init();
                UserInfo userInfo = UserInfo(password: passwordControll.text, username: usernameControll.text);
                UserInfoTable().insertData(db, userInfo);
                if (mounted) {
                  Navigator.of(context).pushNamed(LoginPage.tag); //点击跳转界面
                }
              }
            } else {
              Fluttertoast.showToast(
                  msg: "用户名和密码不能为空",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          color: Colors.green, //按钮颜色
          child: const Text(
            '注 册',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          //将这些组件全部放置在ListView中
          shrinkWrap: true, //内容适配
          padding: const EdgeInsets.only(left: 24.0, right: 24.0), //左右填充24个像素块
          children: <Widget>[
            logo,
            const SizedBox(
              height: 48.0,
            ), //用来设置两个控件之间的间距
            username,
            const SizedBox(
              height: 8.0,
            ),
            password,
            const SizedBox(
              height: 24.0,
            ),
            registerButton,
          ],
        ),
      ),
    );
  }

  checkAccount() async {
    bool flag = false;
    Database db = await CreateTables().init();
    List<Map> loginInfo = await UserInfoTable().queryList(db);
    if (loginInfo.isNotEmpty) {
      for (var item in loginInfo) {
        if (item['username'] == usernameControll.text) {
          flag = true;
        }
      }
    }
    return flag;
  }
}
