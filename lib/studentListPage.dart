import 'package:flutter/material.dart';
import 'package:manage/class.dart' as classSd;

class StudentList extends StatefulWidget {
  // List _students = new List<classSd.Student>();
  // StudentList({Key key,@required this._students}):super(key:key);
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
    List students = List<classSd.Student>();
    List<Widget> _list = List();
    // _StudentListState({Key key, @required this.students});  
    Widget buildListData(BuildContext context,int index){
      if(_list.length<0 && students.length < 0){
        return Scaffold(
          appBar: AppBar(
            title: Text('没有添加学生成绩'),
            centerTitle: true,
          ),
          body: Text('没有学生成绩数据'),
        );
      }
      return ListTile(
        isThreeLine: false,
        title: Text('${students[index].name}'),
        trailing: Icon(Icons.keyboard_arrow_right),
        selected: true,
        onTap: (){
          
          Navigator.of(context).pushNamed('StudentChart',arguments: students);
          
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context){
          //     return AlertDialog(
          //       title: Text(
          //         "LsitDemo",
          //         style: TextStyle(color: Colors.black54,fontSize: 18),
          //       ),
          //       content: Text('你选择的内容:${students[index].name}'),
          //     );
          //   }
          // );
        },
      );
    }
  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //获取路由参
    students = ModalRoute.of(context).settings.arguments;
    for (var i = 0; i < students.length; i++) {
      _list.add(buildListData(context,i));
    }
    Widget div1 = Divider(color: Colors.blue,);
    Widget div2 = Divider(color: Colors.green,);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('学生成绩'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(title:Text('学生名字')),
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              //列表构造器
              itemBuilder: (BuildContext context, int index){
                return _list[index];
              },
              //分割器
              separatorBuilder: (BuildContext context, int index){
                return index%2 == 0?div1:div2;
              },
            ),
          )
        ],
      ) 
    );
  }
}