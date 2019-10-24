import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'studentListPage.dart';
import 'chartsPage.dart';
import 'class.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FromTestRoute(),
      //注册路由
      routes: {
        "StuentList":(context)=>StudentList(),
        'Home':(context)=>FromTestRoute(),
        'StudentChart':(context)=>ShowChart(),
      },
    );
  }
}

class FromTestRoute extends StatefulWidget {
  @override
  _FromTestRouteState createState() => _FromTestRouteState();
}

class _FromTestRouteState extends State<FromTestRoute> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  //StudentSqlite studSqlite = new StudentSqlite();
  
  /*
   *一般程序里的异步操作会先返回一个future,等异步操作执行完之后再返回真正的值。
   *异步方法需要用async标记一下，在方法里面执行异步动作的前面加上await，用来等待异步执行的结果
   *然后把这个结果交给一个变量，在方法的其他地方就可以使用这个异步返回的值了
   */
  //选择日期的方法
  Future<void> _selectDate()async{
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(6600)
    );
    if(date == null) return;
    setState(() {
     selectedDate = date; 
    });
  }
  bool _chinese;
  bool _math;
  bool _english;
  List _students = new List<Student>();
  @override
  void initState() {
    super.initState();
    _chinese = false;
    _math = false;
    _english = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(//添加可以伸缩界面
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 24.0),
          child: Form(
            key: _formKey,//设置globlKey,用于后面获取FromState
            autovalidate: true,//开启自动校验
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '名字',
                    icon: Icon(Icons.person)
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  //校验用户名
                  validator:(v){
                    return v
                        .trim()
                        .length > 0 ? null : '用户名不能为空';
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('语文'),
                        Checkbox(
                          value: _chinese,
                          onChanged: (isChinese){
                            setState(() {
                              if (isChinese) {
                                _chinese = true;
                                _math = false;
                                _english = false;
                              } 
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    Row(
                      children: <Widget>[
                        Text('数学'),
                        Checkbox(
                          value: _math,
                          onChanged: (isMath){
                            setState(() {
                            if(isMath){
                              _chinese = false;
                              _math = true;
                              _english = false;
                            } 
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    Row(
                      children: <Widget>[
                        Text('英语'),
                        Checkbox(
                          value: _english,
                          onChanged: (isEnglish){
                            setState(() {
                            if(isEnglish){
                              _chinese = false;
                              _math = false;
                              _english = true;
                            } 
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
                InkWell(//选择日期
                  onTap: _selectDate,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.date_range),
                      SizedBox(width: 20),
                      Text(DateFormat.yMd().format(selectedDate)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                TextFormField(
                  controller: _gradeController,
                  decoration: InputDecoration(
                    labelText: '成绩',
                    icon: Icon(Icons.grade)
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator:(v){
                    return v 
                            .trim()
                            .length > 0 ? null:'成绩不能为空';
                  }
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.blue,
                          child: Text('新增'),
                          onPressed: () {
                            Student num = new Student();
                            num.name = _nameController.text;
                            if (_chinese) {
                              num.type = '语文';
                            }else if (_math) {
                              num.type = '数学';
                            }else{
                              num.type = '英语';
                            }
                            num.grade = int.parse(_gradeController.text);
                            num.time = selectedDate;
                            _students.add(num);
                            //insert(num);
                            Fluttertoast.showToast(msg: '名字${_nameController.text} 已新增');
                            setState(() {
                              _gradeController.clear();
                              _nameController.clear(); 
                            });
                          },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text('查看成绩'),
                        onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return StudentList(_students: this._students,);
                          // }));

                          if(_students.length > 0){
                            Navigator.of(context).pushNamed("StuentList",arguments: _students);
                          }else{
                            Fluttertoast.showToast(msg: '没有数据');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  // void insert(Student student) async{
  //   await studSqlite.openSqlite();
  //   await studSqlite.insert(student);
  //   await studSqlite.close();
  // }
}