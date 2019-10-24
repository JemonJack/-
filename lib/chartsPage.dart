import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:manage/class.dart';

class ShowChart extends StatefulWidget {
  @override
  _ShowChartState createState() => _ShowChartState();
}

class _ShowChartState extends State<ShowChart> {
  List _students = new List<Student>();
  _onSelectChanged(charts.SelectionModel model){
    //final selectedDatum = model.selectedDatum;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    _students = ModalRoute.of(context).settings.arguments;
    if (_students.length < 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('没有数据'),
          centerTitle: true,
        ),
        body: Text('没有相应学生的成绩'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('姓名:${_students[0].name} 的成绩表'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: 400,
          child: charts.BarChart(
            StudentchartData.createSampleData(_students),
            animate: false,
            barGroupingType: charts.BarGroupingType.grouped,
            barRendererDecorator: new charts.BarLabelDecorator<String>(),
            behaviors: [new charts.SeriesLegend()],
            selectionModels: [
              charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectChanged,
              )
            ],
          ),
        ),
      ); 
    }
      
  }
}
