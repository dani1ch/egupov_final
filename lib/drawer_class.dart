import 'package:flutter/material.dart';
import 'user_view.dart';
import 'authentication_page.dart';

class navDrawer extends StatelessWidget {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    child:
                        Image.asset('assets/logo.png'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.one_k),
            title: const Text("Список пользователей"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.two_k),
              title: const Text("Корзина"),
              onTap: () {
                _messengerKey.currentState!.showSnackBar(
                    const SnackBar(content: Text('Переход в корзину')));
              }),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Настройки"),
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Выход"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }),
        ],
      ),
    );
  }
}
