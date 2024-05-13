import 'package:erp_system/core/utils/methods.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/custom_app_bar.dart';
import 'bottomNavigationBar/presentation/widgets/my_drawer.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: "Email",
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_sharp),
              ),
              Positioned(
                right: 12,
                top: 15,
                child: Icon(
                  Icons.circle,
                  color: AppColors.orange,
                  size: 12,
                ),
              )
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text('Email'),
      ),
    );
  }
}
/*

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
        backgroundColor: Colors.blue,
      ),
      body: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: const Color(0xff009889),
        ),
        child: SfDataGrid(
          source: employeeDataSource,
          columnWidthMode: ColumnWidthMode.auto,
          rowHeight: 35,
          headerRowHeight: 35,
          footerHeight: 60,
          footer: Column(
            children: [
              Text("MOHAMED"),
              Text("MOHAMED"),
              Text("MOHAMED"),
              Text("MOHAMED"),
            ],
          ),
          columns: <GridColumn>[
            GridColumn(
                columnName: 'id',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'ID',
                    ))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Name'))),
            GridColumn(
                columnName: 'designation',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Designation',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'salary',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Salary'))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Name'))),
            GridColumn(
                columnName: 'designation',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Designation',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'salary',
                label: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Salary'))),
          ],
        ),
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'Jamesdfsdfsdfsdfs hjgjhgkjghb bnvgfgj', 'Project Lead',
          20000, 'James', 'Project Lead', 20000),
      Employee(
          10002, 'Kathryn', 'Manager', 30000, 'James', 'Project Lead', 20000),
      Employee(
          10003, 'Lara', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10004, 'Michael', 'Designer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10005, 'Martin', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(10006, 'Newberry', 'Developer', 15000, 'James', 'Project Lead',
          20000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10008, 'Perry', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10010, 'Grimes', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(10006, 'Newberry', 'Developer', 15000, 'James', 'Project Lead',
          20000),
      Employee(
          10007, 'Balnc', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10008, 'Perry', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10009, 'Gable', 'Developer', 15000, 'James', 'Project Lead', 20000),
      Employee(
          10010, 'Grimes', 'Developer', 15000, 'James', 'Project Lead', 20000)
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary, this.name2,
      this.designation2, this.salary2);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;

  /// Name of an employee.
  final String name2;

  /// Designation of an employee.
  final String designation2;

  /// Salary of an employee.
  final int salary2;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
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
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
*/
