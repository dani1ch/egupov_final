import 'package:flutter/material.dart';
import 'user_data.dart';
import 'user_details.dart';
import 'dart:convert';
import 'drawer_class.dart';
import 'package:http/http.dart' as http;

Future<List<User>> _fetchUsersList() async {
  final url = "https://jsonplaceholder.typicode.com/users";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Ошибка загрузки списка пользователей');
  }
}

ListView _usersListView(data) {

  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(context, data[index]);
      });
}

ListTile _userListTile(BuildContext context, User user) => ListTile(
  title: Text("${user.name}",
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 22,
      )),
  subtitle: Text("${user.email}"),
  leading: CircleAvatar(
    child: Text((user.name ?? '-')[0]),
  ),
  trailing: const Icon(Icons.supervised_user_circle),
  onTap: () {
  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return UserViewPage(user: user,);
        },
      ),
    );
  },
);

class UserPage extends StatefulWidget {

  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        title: Text('Пользователи'),
          actions: <Widget> [
            IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.access_alarm)),
          ],
    ),
        drawer: navDrawer(),
        body: Center(
        child: FutureBuilder<List<User>>(
            future: futureUsersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                usersListData = snapshot.data!;
                return _usersListView(usersListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    )
    );
  }
}
