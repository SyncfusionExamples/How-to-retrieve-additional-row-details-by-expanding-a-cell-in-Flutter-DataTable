# How to retrieve additional row details by expanding a cell in Flutter DataGrid.
 
In this article, we will show you how to retrieve additional row details by expanding a cell in [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. In the [buildRow](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/buildRow.html) method, load the cell value along with the icon button, and call [showDialog](https://api.flutter.dev/flutter/material/showDialog.html). The [onPressed](https://api.flutter.dev/flutter/material/IconButton/onPressed.html) event of the IconButton in the buildRow method is where the dialog is triggered. This dialog displays the expanded details.

```dart
class EmployeeDataSource extends DataGridSource {

…..

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
                      int rowIndex = datagridRows.indexOf(row);
                      return IconButton(
                        hoverColor: Colors.transparent,
                        color: Colors.blue,
                        icon: const Icon(Icons.expand_more),
                        onPressed: (() {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  scrollable: true,
                                  titleTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  title: const Text('Personal Details'),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: const Text('Close'))
                                  ],
                                  content: Container(
                                    margin: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        Text(
                                            'Employee address \n \n${employees[rowIndex].address}'),
                                        const SizedBox(width: 20),
                                        Text(
                                            'City \n \n${employees[rowIndex].city}'),
                                        const SizedBox(width: 20),
                                        Text(
                                            'Country \n \n${employees[rowIndex].country}'),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  )));
                        }),
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
}
```

You can download this example on [GitHub](https://github.com/SyncfusionExamples/How-to-retrieve-additional-row-details-by-expanding-a-cell-in-Flutter-DataTable).