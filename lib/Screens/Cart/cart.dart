import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Page/page.dart';
import 'package:wisdomfabrics/Screens/Checkout/checkout.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  int total = 0;

  final List cartname = <String>[];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  int calculateTotalPrice(List<QueryDocumentSnapshot> docs) {
    int totalPrice = 0;
    for (var doc in docs) {
      totalPrice += int.parse(doc['pic'] as String);
    }
    return totalPrice;
  }

  UserModel loggedinUser = UserModel();
  final CollectionReference _cart =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _cart.doc(loggedinUser.uid).collection('cart').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return streamSnapshot.data!.docs.isEmpty
              ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    title: const Text(
                      'Cart',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Cart Is Empty !',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Material(
                          color: HexColor('62CDFF'),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.6,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Pagescreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'continue shopping',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Cart',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          var collection = FirebaseFirestore.instance
                              .collection('users')
                              .doc(loggedinUser.uid)
                              .collection('cart');
                          var snapshots = await collection.get();
                          for (var doc in snapshots.docs) {
                            await doc.reference.delete();
                          }
                          Fluttertoast.showToast(
                              msg: 'Cart Cleared Successfully');
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  body: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 8),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 8, left: 8, top: 5, bottom: 8),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        documentSnapshot['img'],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 100,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 8, top: 4),
                                          child: Text(
                                            documentSnapshot['name'],
                                            maxLines: 2,
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "PKR:${documentSnapshot['pic']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                FirebaseFirestore firebaseFirestore =
                                    FirebaseFirestore.instance;
                                firebaseFirestore
                                    .collection('users')
                                    .doc(loggedinUser.uid)
                                    .collection('cart')
                                    .doc(documentSnapshot.id)
                                    .delete();
                                Fluttertoast.showToast(msg: 'Product deleted');
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(right: 10, top: 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: Colors.red),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  bottomSheet: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total: PKR:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              calculateTotalPrice(streamSnapshot.data!.docs)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                            color: HexColor('62CDFF'),
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Get.to(
                                const CheckOut(),
                              );
                            },
                            child: const Text(
                              'Check Out',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      },
    );
  }
}
