import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/SeeAll/see.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Catscreen extends StatefulWidget {
  const Catscreen({super.key});

  @override
  State<Catscreen> createState() => _CatscreenState();
}

class _CatscreenState extends State<Catscreen> {
  final CollectionReference _book =
      FirebaseFirestore.instance.collection('category');
  final TextEditingController firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _book.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              title: const Text('Paid Book Categories'),
            ),
            body: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 2 / 2.7,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => paidSeeAll(
                          title: documentSnapshot['name'],
                          buy: true,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor('C9EEFF'),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                documentSnapshot['icon'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 185,
                          width: 140,
                          child: const SizedBox(),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 35,
                        width: 130,
                        child: Center(
                          child: Text(
                            documentSnapshot['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    );
  }
}
