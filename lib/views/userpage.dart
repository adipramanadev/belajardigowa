import 'package:belajardigowa/models/usermodel.dart';
import 'package:belajardigowa/services/userService.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late List<UserModel> _users = [];
  late List<UserModel> _filteredUsers = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    List<UserModel> users = await UserService().getUsers();
    setState(() {
      _users = users;
      _filteredUsers = users;
    });
  }

  void _filterUsers(String query) {
    List<UserModel> filteredList = _users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredUsers = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Belajar Di goWa Via ZOOM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterUsers('');
                  },
                ),
              ),
              onChanged: (value) {
                _filterUsers(value);
              },
            ),
          ),
          Expanded(
            child: _filteredUsers.isEmpty
                ? const Center(
                    child: Text('No users found.'),
                  )
                : ListView.builder(
                    itemCount: _filteredUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(_filteredUsers[index].name),
                          subtitle: Text(_filteredUsers[index].email),
                          leading: Icon(Icons.person),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
