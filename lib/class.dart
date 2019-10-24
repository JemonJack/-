import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Student extends Object{

  String code;        //学号
  String name;        //名字
  int    grade;       //成绩
  String type;
  DateTime time;

  Student ({String code, String name, int grade,DateTime time}){
    //this.id = id;
    this.code = code;
    this.name = name;
    this.grade = grade;
    this.type = type;
  }
}



class StudentchartData {
  static List<charts.Series<OrdinalStudent,String>> createSampleData(List studs){
    List chData = new List<OrdinalStudent>();
    List maData = new List<OrdinalStudent>();
    List enData = new List<OrdinalStudent>();
    if(studs.length>0){
      for (int i = 0; i < studs.length; i++) {
        Student g = studs[i];
        if(g.type == '语文'){
          chData.add(new OrdinalStudent(g.time,g.grade));
        }else if(g.type == '数学'){
          maData.add(new OrdinalStudent(g.time,g.grade));
        }else if(g.type == '英语'){
          enData.add(new OrdinalStudent(g.time,g.grade));
        }
      }
    }else{
      return null;
    }
    // final chineseData = [
    //   new OrdinalStudent(DateTime(2017,6,8), 5),
    //   new OrdinalStudent(DateTime(2017,7,8), 25),
    //   new OrdinalStudent(DateTime(2017,8,8), 100),
    //   new OrdinalStudent(DateTime(2017,9,8), 75),
    // ];

    // final mathData = [
    //   new OrdinalStudent(DateTime(2017,6,8), 56),
    //   new OrdinalStudent(DateTime(2017,7,8), 88),
    //   new OrdinalStudent(DateTime(2017,8,8), 60),
    //   new OrdinalStudent(DateTime(2017,9,8), 79),
    // ];

    // final englishData = [
    //   new OrdinalStudent(DateTime(2017,6,8), 64),
    //   new OrdinalStudent(DateTime(2017,7,8), 60),
    //   new OrdinalStudent(DateTime(2017,8,8), 74),
    //   new OrdinalStudent(DateTime(2017,9,8), 75),
    // ];

    return [
      new charts.Series<OrdinalStudent,String>(
        
      ),
      new charts.Series<OrdinalStudent,String>(
        id: '语文',
        domainFn: (OrdinalStudent nums,_) => DateFormat('yyyy-MM-dd').format(nums.time),
        measureFn: (OrdinalStudent nums,_) => nums.grade,
        measureOffsetFn: (_,__) => 60,
        colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
        //fillColorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault.lighter,
        data: chData,
        labelAccessorFn: (OrdinalStudent nums,_) => '${nums.grade}',
      ),
      new charts.Series<OrdinalStudent,String>(
        id: '数学',
        domainFn: (OrdinalStudent nums,_) => DateFormat('yyyy-MM-dd').format(nums.time),
        measureFn: (OrdinalStudent nums,_) => nums.grade,
        colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault,
        //fillColorFn: (_,__) => charts.MaterialPalette.red.shadeDefault.lighter,
        data: maData,
        labelAccessorFn: (OrdinalStudent nums,_) => '${nums.grade}',
      ),
      new charts.Series<OrdinalStudent,String>(
        id: '英语',
        domainFn: (OrdinalStudent nums,_) => DateFormat('yyyy-MM-dd').format(nums.time),
        measureFn: (OrdinalStudent nums,_) => nums.grade,
        colorFn: (_,__) => charts.MaterialPalette.green.shadeDefault,
        //fillColorFn: (_,__) => charts.MaterialPalette.green.shadeDefault.lighter,
        data: enData,
        labelAccessorFn: (OrdinalStudent nums,_) => '${nums.grade}',
      ),
    ];
  }
}
class OrdinalStudent{
  final DateTime time;
  final int grade;

  OrdinalStudent(this.time, this.grade);
}
