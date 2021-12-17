import 'package:example/widget/my_app_bar.dart';
import 'package:example/widget/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:flutter_pickers/utils/check.dart';

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  String stateText = '';
  var selectData = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };

  final divider = Divider(height: 1, indent: 20);
  final rightIcon = Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '时间选择器'),
      body: ListView(
        children: [_item('年月日', DateMode.YMD), demo(), SizedBox(height: 80)],
      ),
    );
  }

  Widget demo() {
    return TextButton(
      onPressed: () {
        Pickers.showDatePicker(
          context,
          onConfirm: (p) {
            print('longer >>> 返回数据：$p');
          },
          // onChanged: (p) => print(p),
        );
      },
      child: Text('Demo'),
    );
  }

  Widget _item(title, model) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(title),
            onTap: () {
              if ('仿计时器' == title) {
                _onClickItem2();
              } else {
                _onClickItem(model);
              }
            },
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              MyText(
                  PicketUtil.strEmpty(selectData[model])
                      ? '暂无'
                      : selectData[model],
                  color: Colors.grey,
                  rightpadding: 18),
              rightIcon
            ]),
          ),
        ),
        divider,
      ],
    );
  }

  void _onClickItem(model) {
    Pickers.showDatePicker(
      context,
      suffix: Suffix(years: '', month: ''),
      pickerStyle: PickerStyle(
        pickerHeight: 266,
        pickerTitleHeight: 60,
        pickerItemHeight: 80,
        // menuHeight: 40,
        textColor: Color(0xFF8F9BA0),
        headDecoration: const BoxDecoration(
          color:Color(0xFFffffff),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        cancelButton: Padding(
          padding: const EdgeInsets.only(left: 14, top: 15),
          child: Text(
            '取消',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF999999),
            ),
          ),
        ),
        commitButton: Padding(
          padding: const EdgeInsets.only(right: 14, top: 15),
          child: Text(
            '确定',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0BC5A5),
            ),
          ),
        ),
        itemOverlay: Container(
          decoration:  BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Color(0xFFBCE7E0),
                width: 1,
              ),
            ),
          ),
        ),
      ),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
      },
      // onChanged: (p) => print(p),
    );
  }

  void _onClickItem2() {
    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: MyText('取消', color: Colors.white, size: 14),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4)),
      child: MyText('确认', color: Colors.white, size: 14),
    );

    // 头部样式
    Decoration headDecoration = BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)));

    Widget title = Center(child: MyText('倒计时', color: Colors.white, size: 14));

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal:
                BorderSide(color: Colors.cyan.withOpacity(0.3), width: 0.7)),
      ),
    );

    var pickerStyle = PickerStyle(
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      title: title,
      textColor: Colors.white,
      backgroundColor: Colors.grey[800],
      itemOverlay: itemOverlay,
    );

    Pickers.showDatePicker(
      context,
      mode: DateMode.HMS,
      suffix: Suffix(hours: ' 小时', minutes: ' 分钟', seconds: ' 秒'),
      pickerStyle: pickerStyle,
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
      },
      // onChanged: (p) => print(p),
    );
  }
}
