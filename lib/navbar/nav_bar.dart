import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;
  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: BottomAppBar(
        elevation: 0.0,
        child: Container(
          height: 60.0,
          color: Theme.of(context).colorScheme.background,
          child: Row(
            children: [
              navItem(Icons.home, "Home", pageIndex == 0, context,
                  onTap: () => onTap(0)),
              navItem(Icons.swap_horiz, "Transaction", pageIndex == 1, context,
                  onTap: () => onTap(1)),
              const SizedBox(
                width: 64.0,
              ),
              navItem(Icons.pie_chart, "Budget", pageIndex == 2, context,
                  onTap: () => onTap(2)),
              navItem(Icons.person, "Profile", pageIndex == 3, context,
                  onTap: () => onTap(3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(
      IconData icon, String text, bool selected, BuildContext context,
      {Function()? onTap}) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                size: 32.0,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              )),
          Text(text,
              style: TextStyle(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  fontSize: 12)),
        ],
      ),
    );
  }
}
