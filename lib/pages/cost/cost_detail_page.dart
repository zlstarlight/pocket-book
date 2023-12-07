import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_book/pages/home/home_page.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/create_tables.dart';
import '../../db/table/cost_table.dart';
import '../../model/cost_info.dart';

//收支详细登录界面
class CostDetailPage extends ConsumerStatefulWidget {
  const CostDetailPage({super.key});
  static String tag = 'cost-detail-page';

  @override
  ConsumerState<CostDetailPage> createState() => CostDetailPageState();
}

class CostDetailPageState extends ConsumerState<CostDetailPage> {
  var countControll = TextEditingController();
  var dateControll = TextEditingController();
  var tipsControll = TextEditingController();
  int selectVaue = 1;
  @override
  Widget build(BuildContext context) {
    final dropdownButton = Center(
        child: DropdownButton(
      value: selectVaue,
      items: const [
        DropdownMenuItem(
            value: 1,
            child: Text(
              '收入',
              style: TextStyle(color: Colors.red),
            )),
        DropdownMenuItem(
            value: 2,
            child: Text(
              '支出',
              style: TextStyle(color: Colors.green),
            )),
        DropdownMenuItem(
            value: 3,
            child: Text(
              '代付款项',
              style: TextStyle(color: Colors.blue),
            )),
      ],
      onChanged: (value) {
        setState(() {
          selectVaue = value!;
        });
      },
    ));
    //收支金额
    final count = TextFormField(
      controller: countControll,
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: '请输入收支金额',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    //时间
    final date = TextFormField(
      controller: dateControll,
      keyboardType: TextInputType.datetime,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '请输入时间',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    //备注
    final tips = TextFormField(
      controller: tipsControll,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '请输入备注',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final addButton = Padding(
      padding: const EdgeInsets.all(0), //上下各添加16像素补白
      child: Material(
        borderRadius: BorderRadius.circular(30.0), // 圆角度
        shadowColor: Colors.lightBlueAccent.shade100, //阴影颜色
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            Database db = await CreateTables().init();
            CostInfo costInfo = CostInfo(category: selectVaue, count: countControll.text, date: dateControll.text, tips: tipsControll.text);
            CostInfoTable().insertData(db, costInfo);
            if (mounted) {
              if (countControll.text.isNotEmpty && dateControll.text.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())); //点击跳转界面
              } else {
                Fluttertoast.showToast(
                    msg: "金额或时间不能为空",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          },
          color: Colors.green, //按钮颜色
          child: const Text(
            '添 加',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text(
          '收支详细编辑',
        ),
      )),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          //将这些组件全部放置在ListView中
          shrinkWrap: true, //内容适配
          padding: const EdgeInsets.only(left: 24.0, right: 24.0), //左右填充24个像素块
          children: <Widget>[
            dropdownButton,
            const SizedBox(
              height: 8.0,
            ),
            count,
            const SizedBox(
              height: 8.0,
            ),
            date,
            const SizedBox(
              height: 8.0,
            ),
            tips,
            const SizedBox(
              height: 24.0,
            ),
            addButton,
          ],
        ),
      ),
    );
  }
}
