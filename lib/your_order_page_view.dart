import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewYourOrdersPage extends HookConsumerWidget {
  final userId;

  ViewYourOrdersPage(this.userId);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('order_details')
            .where("userid", isEqualTo: userId)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((BuildContext context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () async {
                    // await viewModelProvider
                    //     .getCustomerDetailsByUserId(documentSnapshot['userid']);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return OrderStatusUpdatePage(
                    //         documentSnapshot['orderid']);
                    //   }),
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Order ID: ${documentSnapshot.id}'),
                        Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            color: (documentSnapshot['order_received'] == true)
                                ? Colors.green
                                : Color(0xFFA28C8C),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            color: (documentSnapshot['preparing'] == true)
                                ? Colors.green
                                : Color(0xFFA28C8C),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            color:
                                (documentSnapshot['out_for_delivery'] == true)
                                    ? Colors.green
                                    : Color(0xFFA28C8C),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            color: (documentSnapshot['order_delivered'] == true)
                                ? Colors.green
                                : Color(0xFFA28C8C),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        }),
      ),
    );
  }
}
