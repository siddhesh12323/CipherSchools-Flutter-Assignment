import 'package:cipherschool_assignment_siddhesh/navbar/nav_bar.dart';
import 'package:cipherschool_assignment_siddhesh/navbar/nav_model.dart';
import 'package:cipherschool_assignment_siddhesh/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../utilities/tab_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final transactionNavKey = GlobalKey<NavigatorState>();
  final budgetNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;

  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: HomePage(), navKey: homeNavKey),
      NavModel(page: TabPage(tab: 2), navKey: transactionNavKey),
      NavModel(page: TabPage(tab: 3), navKey: budgetNavKey),
      NavModel(page: TabPage(tab: 4), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () {
          if (items[selectedTab].navKey.currentState!.canPop()) {
            items[selectedTab].navKey.currentState!.pop();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: selectedTab,
            children: items
                .map((e) => Navigator(
                      key: e.navKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => e.page,
                      ),
                    ))
                .toList(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            margin: EdgeInsets.only(top: 25.0),
            height: 64.0,
            width: 64.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              child: const Icon(Icons.add, size: 36.0),
            ),
          ),
          bottomNavigationBar: NavBar(
              pageIndex: selectedTab,
              onTap: (index) {
                if (index == selectedTab) {
                  items[index]
                      .navKey
                      .currentState!
                      .popUntil((route) => route.isFirst);
                } else {
                  setState(() {
                    selectedTab = index;
                  });
                }
              }),
        ));
  }
}


/*
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.background,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Icon(Icons.home)),
                  const Text("Home")
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Icon(Icons.person)),
                  const Text("Profile")
                ],
              ),
            ]),
      ),
    );
*/