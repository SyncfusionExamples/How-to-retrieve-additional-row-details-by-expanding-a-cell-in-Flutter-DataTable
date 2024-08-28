import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SfDatagridDemo(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class SfDatagridDemo extends StatefulWidget {
  /// Creates the home page.
  const SfDatagridDemo({super.key});

  @override
  SfDatagridDemoState createState() => SfDatagridDemoState();
}

/// A state class of a [MyHomePage] stateful widget.
class SfDatagridDemoState extends State<SfDatagridDemo> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    _employees = _getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: _employeeDataSource,
        columns: getColumns,
      ),
    );
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'ID',
          label: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: const Text('ID'))),
      GridColumn(
          columnName: 'Name',
          label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Name',
              ))),
      GridColumn(
          columnName: 'Designation',
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Designation',
              ))),
      GridColumn(
          columnName: 'Salary',
          label: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Salary',
              ))),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required this.employees}) {
    datagridRows = employees
        .map<DataGridRow>((Employee e) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> datagridRows = <DataGridRow>[];

  List<Employee> employees = [];

  @override
  List<DataGridRow> get rows => datagridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
      return Container(
        alignment: Alignment.center,
        child: cell.columnName == 'Name'
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        cell.value.toString(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Builder(builder: (context) {
                      datagridRows.indexOf(row);
                      return IconButton(
                        hoverColor: Colors.transparent,
                        color: Colors.blue,
                        icon: const Icon(Icons.expand_more),
                        onPressed: () => _showDetailsDialog(context, row),
                      );
                    }),
                  )
                ],
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                alignment:
                    cell.columnName == 'ID' || cell.columnName == 'Salary'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Text(
                  cell.value.toString(),
                ),
              ),
      );
    }).toList());
  }

  void _showDetailsDialog(BuildContext context, DataGridRow row) {
    int rowIndex = datagridRows.indexOf(row);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        title: const Text('Personal Details'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Employee address: ${employees[rowIndex].address}'),
              const SizedBox(height: 10),
              Text('City: ${employees[rowIndex].city}'),
              const SizedBox(height: 10),
              Text('Country: ${employees[rowIndex].country}'),
            ],
          ),
        ),
      ),
    );
  }
}

List<Employee> _getEmployeeData() {
  return <Employee>[
    Employee(10001, 'James', 'Project Lead', 20000, 'Obere Str. 57', 'Berlin',
        'Germany'),
    Employee(10002, 'Kathryn', 'Manager', 30000,
        'Avda. de la Constitución 2222', 'México D.F.', 'Mexico'),
    Employee(
        10003, 'Lara', 'Developer', 15000, '120 Hanover Sq.', 'London', 'UK'),
    Employee(10004, 'Michael', 'Designer', 15000, 'Berguvsvägen  8', 'Luleå',
        'Sweden'),
    Employee(10005, 'Perry', 'Developer', 15000, '24, place Kléber',
        'Strasbourg', 'France'),
  ];
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.address,
      this.city, this.country);
  final int id;
  final String name;
  final String designation;
  final int salary;
  final String address;
  final String city;
  final String country;
}
