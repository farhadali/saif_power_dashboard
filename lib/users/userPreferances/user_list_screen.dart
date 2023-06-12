import 'package:flutter/material.dart';
import 'package:user_login/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isSelected,
  });

  int id;
  String name;
  double price;
  String description;
  bool isSelected;
}

class UserListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListScreenState();
  }
}

class UserListScreenState extends State<UserListScreen> {
  List<Item> _items = [];
  List<User> users = [];
  List<User> _users = [];
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  List<Item> _generateItems() {
    return List.generate(15, (int index) {
      return Item(
        id: index + 1,
        name: 'Item ${index + 1}',
        price: (index + 1) * 1000.00,
        description: 'Details of item ${index + 1}',
        isSelected: false,
      );
    });
  }

  void updateSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: const Text('No'),
        numeric: false, // Deliberately set to false to avoid right alignment.
      ),
      DataColumn(
        label: const Text('Name'),
        numeric: false,
        tooltip: 'Name of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.name.compareTo(item2.name));
          } else {
            _items.sort((item1, item2) => item2.name.compareTo(item1.name));
          }

          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: const Text('Price'),
        numeric: false, // Deliberately set to false to avoid right alignment.
        tooltip: 'Price of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.price.compareTo(item2.price));
          } else {
            _items.sort((item1, item2) => item2.price.compareTo(item1.price));
          }

          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: const Text('Description'),
        numeric: false,
        tooltip: 'Description of the item',
      ),
    ];
  }

  void _showAddUserDialog() {
    String name = '';
    String email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                addUser(name, email);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(API.apiCreate_user),
      body: {'name': name, 'email': email},
    );
    if (response.statusCode == 200) {
      fetchUsers();
    } else {
      // Handle error
    }
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse(API.apiUserList));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        users = (jsonData as List).map((data) => User.fromJson(data)).toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> updateUser(int id, String name, String email) async {
    final response = await http.post(
      Uri.parse(API.apiUpdate_user),
      body: {'id': id.toString(), 'name': name, 'email': email},
    );
    if (response.statusCode == 200) {
      fetchUsers();
    } else {
      // Handle error
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.post(
      Uri.parse(API.apiDelete_user),
      body: {'id': id.toString()},
    );
    if (response.statusCode == 200) {
      fetchUsers();
    } else {
      // Handle error
    }
  }

  DataRow _createRow(Item item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
      selected: item.isSelected,
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          item.isSelected = isSelected;

          setState(() {
            print('ok');
          });
        }
      },
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
          states.contains(MaterialState.selected)
              ? Colors.red
              : Color.fromARGB(100, 215, 217, 219)),
      cells: [
        DataCell(
          Text(item.id.toString()),
        ),
        DataCell(
          Text(item.name),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(Text(item.price.toString())),
        DataCell(
          Text(item.description),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columnSpacing: 0,
            dividerThickness: 5,
            onSelectAll: (bool? isSelected) {
              if (isSelected != null) {
                _items.forEach((item) {
                  item.isSelected = isSelected;
                });

                setState(() {
                  print("on selected");
                });
              }
            },
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 10)),
            dataRowColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.selected)
                        ? Colors.blue
                        : Color.fromARGB(100, 215, 217, 219)),
            dataRowHeight: 80,
            dataTextStyle: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.black),
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.teal),
            headingRowHeight: 80,
            headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            horizontalMargin: 10,
            showBottomBorder: true,
            showCheckboxColumn: false,
            columns: _createColumns(),
            rows: _items.map((item) => _createRow(item)).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddUserDialog(),
      ),
    );
  }
}
