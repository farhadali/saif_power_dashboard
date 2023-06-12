import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String role;

  User({required this.name, required this.email, required this.role});
}

class UserDataSource extends DataTableSource {
  final List<User> users;

  UserDataSource(this.users);

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) {
      return null;
    }

    final user = users[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(Text(user.role)),
      ],
    );
  }

  @override
  int get rowCount => users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class DataTableListScreen extends StatelessWidget {
  final List<User> users = [
    User(name: 'John Doe', email: 'john@example.com', role: 'Admin'),
    User(name: 'Jane Smith', email: 'jane@example.com', role: 'User'),
    User(name: 'Mike Johnson', email: 'mike@example.com', role: 'User'),
  ];

  @override
  Widget build(BuildContext context) {
    final dataSource = UserDataSource(users);

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
            ],
            rows: List<DataRow>.generate(
              users.length,
              (int index) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // All rows will have the same selected color.
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  // Even rows will have a grey color.
                  if (index.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null; // Use default value for other states and odd rows.
                }),
                cells: <DataCell>[
                  DataCell(Text('Row $index')),
                  DataCell(Text('Row $index')),
                  DataCell(Text('Row $index')),
                ],
                onSelectChanged: (bool? value) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
