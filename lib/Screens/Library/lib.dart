import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Description/desc.dart';
import '../SeeAll/see.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _book = FirebaseFirestore.instance
      .collection('Products')
      .where('paid', isEqualTo: true);
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
              title: const Text('All Products'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      autofocus: false,
                      controller: firstnameController,
                      onSaved: (value) {
                        firstnameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search,
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 12, 20, 12),
                        hintText: "Search for title.",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2 / 3.7,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionPage(
                                img: documentSnapshot['images'],
                                price: documentSnapshot['price'],
                                id: documentSnapshot.id,
                                eng: documentSnapshot['title'],
                                desc: documentSnapshot['des'],
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
                                  color: Colors.orange.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 5,
                                    color: Colors.white,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      documentSnapshot['images'],
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
                              height: 20,
                              width: 130,
                              child: Center(
                                child: Text(
                                  documentSnapshot['title'],
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                              height: 32,
                              width: 105,
                              child: Center(
                                child: Text(
                                  'PKR: ${documentSnapshot['price']}/-',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    );
    // return StreamBuilder(
    //   stream: _book.orderBy('tc', descending: true).snapshots(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    //     if (streamSnapshot.hasData) {
    //       return Scaffold(
    //         body: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               GridView.builder(
    //                 shrinkWrap: true,
    //                 gridDelegate:
    //                     const SliverGridDelegateWithMaxCrossAxisExtent(
    //                   maxCrossAxisExtent: 300,
    //                   childAspectRatio: 2 / 3.5,
    //                   crossAxisSpacing: 0,
    //                   mainAxisSpacing: 0,
    //                 ),
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 itemCount: streamSnapshot.data!.docs.length,
    //                 itemBuilder: (BuildContext ctx, index) {
    //                   final DocumentSnapshot documentSnapshot =
    //                       streamSnapshot.data!.docs[index];
    //                   return InkWell(
    //                     onTap: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => DescriptionPage(
    //                             img: documentSnapshot['thumbnail'],
    //                             price: documentSnapshot['price'],
    //                             id: documentSnapshot.id,
    //                             eng: documentSnapshot['eng'],
    //                             author: documentSnapshot['author'],
    //                             urdu: documentSnapshot['urdu'],
    //                             desc: documentSnapshot['desc'],
    //                             tc: documentSnapshot['tc'],
    //                             buy: true,
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Card(
    //                           elevation: 7,
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               color: Colors.orange.shade200,
    //                               borderRadius: BorderRadius.circular(5),
    //                               border: Border.all(
    //                                 width: 5,
    //                                 color: Colors.white,
    //                               ),
    //                               image: DecorationImage(
    //                                 image: NetworkImage(
    //                                   documentSnapshot['thumbnail'],
    //                                 ),
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             ),
    //                             height: 185,
    //                             width: 140,
    //                             child: const SizedBox(),
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           height: 6,
    //                         ),
    //                         SizedBox(
    //                           height: 35,
    //                           width: 130,
    //                           child: Center(
    //                             child: Text(
    //                               documentSnapshot['eng'],
    //                               textAlign: TextAlign.center,
    //                               style: const TextStyle(
    //                                 fontSize: 15,
    //                                 color: Colors.black,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Text(
    //                           documentSnapshot['urdu'],
    //                           style: GoogleFonts.notoNastaliqUrdu(
    //                             textStyle: const TextStyle(
    //                               fontSize: 12,
    //                               color: Colors.black,
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           height: 6,
    //                         ),
    //                         Container(
    //                           decoration: BoxDecoration(
    //                             color: Colors.black,
    //                             borderRadius: BorderRadius.circular(
    //                               14,
    //                             ),
    //                           ),
    //                           height: 32,
    //                           width: 105,
    //                           child: Center(
    //                             child: Text(
    //                               'PKR: ${documentSnapshot['price']}/-',
    //                               style: const TextStyle(
    //                                 fontSize: 16,
    //                                 color: Colors.white,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    //     return const Center(
    //         child: CircularProgressIndicator(
    //       color: Colors.black,
    //     ));
    //   },
    // );
  }
}
