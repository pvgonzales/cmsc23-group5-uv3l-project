import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF212738),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Organizations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Donations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Donors',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color.fromARGB(255, 243, 164, 160),
      onTap: onTap,
      unselectedItemColor: Colors.white,
    );
  }
}
