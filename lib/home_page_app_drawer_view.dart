import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mithas/user_profile_page_view.dart';
import 'package:mithas/view_model.dart';
import 'package:mithas/your_order_page_view.dart';

class AppDrawer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    Logger logger = Logger();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user!.uid;
    final drawerWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFE8E6E5),
            height: 150,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    color: const Color(0xFF7D4D40),
                    iconSize: 80,
                    onPressed: () async {
                      await viewModelProvider
                          .getCustomerDetailsByUserId(userId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          viewModelProvider.customerName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF7D4D40),
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          user.email.toString(),
                          style: const TextStyle(
                            color: const Color(0xFF7D4D40),
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          viewModelProvider.customerContactNo.toString(),
                          style: const TextStyle(
                            color: const Color(0xFF7D4D40),
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/mithas_logo.png',
                    width: 250,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 0.8 * drawerWidth,
                    margin: EdgeInsets.symmetric(horizontal: 0.1 * drawerWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewYourOrdersPage(userId),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFC4292A),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Your Orders',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 0.8 * drawerWidth,
                    margin: EdgeInsets.symmetric(horizontal: 0.1 * drawerWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Logout'),
                              content: Text('Do you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context, true);
                                    await viewModelProvider.logout();
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFC4292A),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
