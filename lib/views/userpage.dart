import 'package:belajardigowa/models/usermodel.dart';
import 'package:belajardigowa/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserModelPageState();
}

class _UserModelPageState extends State<UserPage> {
  late List<UserModel> _userModels = [];
  late List<UserModel> _filteredUserModels = [];

  TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserModels();
  }

  void _getUserModels() async {
    List<UserModel> userModels = await UserService().getUsers();
    setState(() {
      _userModels = userModels;
      _filteredUserModels = userModels;
      _isLoading = false;
    });
  }

  void _filterUserModels(String query) {
    List<UserModel> filteredList = _userModels.where((userModel) {
      return userModel.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredUserModels = filteredList;
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
                    _filterUserModels('');
                  },
                ),
              ),
              onChanged: (value) {
                _filterUserModels(value);
              },
            ),
          ),
          _isLoading
              ? _buildLoadingWidget()
              : Expanded(
                  child: _filteredUserModels.isEmpty
                      ? const Center(
                          child: Text('No Users found.'),
                        )
                      : ListView.builder(
                          itemCount: _filteredUserModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(_filteredUserModels[index].name),
                                subtitle:
                                    Text(_filteredUserModels[index].email),
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

  Widget _buildLoadingWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                title: Container(
                  height: 15.0,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
