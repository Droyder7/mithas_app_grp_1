import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mithas/cake_tile_view.dart';
import 'package:mithas/home_page_app_drawer_view.dart';
import 'package:mithas/view_model.dart';

class HomePageView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userEmail = user!.email;
    final viewModelProvider = ref.watch(viewModel);
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(82, 4, 2, 1),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('cake_details').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((BuildContext context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return CakeTile(
                    name: documentSnapshot['name'],
                    image: documentSnapshot['image'],
                    price: documentSnapshot['price'],
                    flavor: documentSnapshot['flavour'],
                  );
                }),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
        ),
      ),
    );
  }
}
