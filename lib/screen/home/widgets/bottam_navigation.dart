import 'package:flutter/material.dart';
import 'package:money_management/screen/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selected_index_notifier,
      builder: (BuildContext context, int updated, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          onTap: (newindex) {
            ScreenHome.selected_index_notifier.value = newindex;
          },
          currentIndex: updated,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            )
          ],
        );
      },
    );
  }
}
