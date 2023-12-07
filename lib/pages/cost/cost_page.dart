import 'package:flutter/material.dart';
import 'package:pocket_book/db/table/cost_table.dart';
import 'package:pocket_book/pages/cost/cost_detail_page.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/create_tables.dart';

//收支详细界面
class CostPage extends StatefulWidget {
  // const CostPage({super.key});
  const CostPage({
    super.key,
    required this.keyValue,
  });
  final GlobalKey keyValue;

  @override
  CostPageState createState() => CostPageState();
}

class CostPageState extends State<CostPage> {
  List<Map> costInfo = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Center(
                    child: Text(
                      '收支详细',
                    ),
                  )),
              body: Column(
                children: costInfoList(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CostDetailPage.tag);
                },
                child: const Text('添加'),
              ));
        });
  }

  Future<void> initData() async {
    Database db = await CreateTables().init();
    costInfo = await CostInfoTable().queryList(db);
  }

  List<Widget> costInfoList() {
    String category = '';
    Color? color = Colors.black;

    List<Widget> costInfoList = [];
    costInfoList.add(Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5), // 边色与边宽度
          color: const Color(0xFF9E9E9E), // 底色
          //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
          // borderRadius: new BorderRadius.vertical(top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
        ),
        child: Container(
          key: widget.keyValue,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text('收支分类', 20, color),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text('金额', 20, color),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text('时间', 20, color),
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: text('备注', 20, color),
                ),
              )
            ],
          ),
        )));
    if (costInfo.isNotEmpty) {
      for (var item in costInfo) {
        if (item['category'] == 1) {
          category = '收入';
          color = Colors.red;
        } else if (item['category'] == 2) {
          category = '支出';
          color = Colors.green;
        } else if (item['category'] == 3) {
          category = '代付款项';
          color = Colors.blue;
        }
        costInfoList.add(Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5), // 边色与边宽度
            borderRadius: BorderRadius.circular((20.0)),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text(category, 15, color),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text(item['count'], 15, color),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: text(item['date'], 15, color),
                  )),
              Expanded(
                flex: 1,
                child: text(item['tips'], 15, color),
              ),
            ],
          ),
        ));
      }
    } else {
      costInfoList.add(const SizedBox(
        child: Text('未查找到收支记录，请点击下方按钮添加。'),
      ));
    }
    return costInfoList;
  }

  text(String index, double size, Color? color) {
    return Center(
      child: Text(
        index,
        style: TextStyle(fontSize: size, height: 1.5, color: color),
      ),
    );
  }
}
