import 'package:flutter/material.dart';
import 'package:orbit/models/attendance_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<dynamic> employeeData}) {
    _employeeData = employeeData.map<DataGridRow>((e) {
      if (e is TimeSheet) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Check In', value: e.checkIn),
          DataGridCell<String>(columnName: 'Check Out', value: e.checkOut),
          DataGridCell<String>(columnName: 'W/H', value: e.duration),
        ]);
      } else if (e is AttendanceList) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Check In', value: e.checkIn),
          DataGridCell<String>(columnName: 'Check Out', value: e.checkOut),
          DataGridCell<String>(columnName: 'W/H', value: e.duration),
        ]);
      } else {
        throw Exception('Invalid data type');
      }
    }).toList();
  }
  List<DataGridRow> _employeeData = [];
  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        child: Text(e.value ?? ''),
      );
    }).toList());
  }
}
