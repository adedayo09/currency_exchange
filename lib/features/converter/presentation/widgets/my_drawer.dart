import 'package:flutter/material.dart';

// import '../screen/history_screen.dart';
// import '../screen/quota_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'Currency App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: const Text('Currency Converter'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: const Text('History'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              title: const Text('Quota (API Key)'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const QuotaScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
