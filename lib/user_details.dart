import 'user_tasks.dart';
import 'drawer_class.dart';
import 'package:flutter/material.dart';
import 'user_data.dart';

class UserViewPage extends StatelessWidget {
  final User user;

  UserViewPage({required this.user});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("${user.name}"),
          actions: <Widget> [
            IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.access_alarm)),
          ],

        ),
        drawer: navDrawer(),
        body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 50),
            child: Column(
                children: [
              const SizedBox(
                height: 12,
              ),
              Text('user name: ${user.username}',
                  style: const TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 60))),
              const SizedBox(
                height: 12,
              ),
              Text('email: ${user.email}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('phone: ${user.phone}',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('website: ${user.website}',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('address: \n ${user.address?.street} '
                  '\n${user.address?.suite} \n ${user.address?.city}\n ${user.address?.zipcode}',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),
              Text('geo: lat: ${user.address?.geo?.lat},  \nlng: ${user.address?.geo?.lng}',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),
                  Text('company: \n  ${user.company?.name}  \n catch phrase: ${user.company?.catchPhrase}  \n bs: ${user.company?.bs}',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 0, 0, 60))),

              const SizedBox(
                height: 12,
              ),

              SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TasksPage(user.id);
                          },
                        ),
                      );
                    },
                    child: Text('Tasks',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0079D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  )),
            ])));
  }
}
