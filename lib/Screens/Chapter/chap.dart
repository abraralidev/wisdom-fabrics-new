// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class topic1 extends StatefulWidget {
  const topic1({
    super.key,
    required this.id,
    required this.index,
  });
  final String id;
  final int index;

  @override
  State<topic1> createState() => _topic1State();
}

class _topic1State extends State<topic1> {
  final List<bool> _selections = List.generate(2, (_) => false);
  var TxtBold = FontWeight.normal;
  var TxtItalic = FontStyle.normal;

  double fs = 12;
  double increasefs() {
    fs = fs + 1;
    setState(() {});
    return fs;
  }

  final CollectionReference _book =
      FirebaseFirestore.instance.collection('books');
  double subincreasefs() {
    fs = fs - 1;
    setState(() {});
    return fs;
  }

  final FirebaseFirestore _story = FirebaseFirestore.instance;
  bool visi = false;
  bool darkode = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkode ? Colors.black54 : HexColor('#F5F2DA'),
        body: StreamBuilder(
          stream: _book
              .doc(widget.id)
              .collection('chap')
              .orderBy('num', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return PageView.builder(
                pageSnapping: true,
                controller: PageController(
                    initialPage: widget.index,
                    keepPage: false,
                    viewportFraction: 1),
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: streamSnapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            visi = !visi;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      documentSnapshot['title'],
                                      style: GoogleFonts.notoNastaliqUrdu(
                                        fontSize: 26,
                                        color:
                                            darkode ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      documentSnapshot['desc'],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.notoNastaliqUrdu(
                                        fontSize: fs,
                                        fontWeight: TxtBold,
                                        color: darkode
                                            ? Colors.white
                                            : HexColor('#313131'),
                                        fontStyle: TxtItalic,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 45,
                        child: Visibility(
                          maintainState: true,
                          maintainAnimation: true,
                          visible: visi,
                          child: Center(
                            child: Card(
                              color: const Color.fromARGB(234, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                              ),
                              elevation: 7,
                              child: SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width - 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Chapter:${documentSnapshot['num']}/36',
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ToggleButtons(
                                          // ignore: sort_child_properties_last
                                          children: const <Widget>[
                                            Icon(Icons.format_bold),
                                            Icon(Icons.format_italic),
                                          ],
                                          isSelected: _selections,
                                          onPressed: (index) {
                                            setState(() {
                                              _selections[index] =
                                                  !_selections[index];
                                              if (index == 0 &&
                                                  _selections[index]) {
                                                TxtBold = FontWeight.bold;
                                              } else if (index == 0 &&
                                                  !_selections[index]) {
                                                TxtBold = FontWeight.normal;
                                              }
                                              if (index == 1 &&
                                                  _selections[index]) {
                                                TxtItalic = FontStyle.italic;
                                              } else if (index == 1 &&
                                                  !_selections[index]) {
                                                TxtItalic = FontStyle.normal;
                                              }
                                            });
                                          },
                                          color: Colors.black,
                                          fillColor: HexColor('C9EEFF'),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              darkode = !darkode;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.sunny,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            increasefs();
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.text_increase,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            subincreasefs();
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.text_decrease,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 10,
                        child: Visibility(
                          maintainState: true,
                          maintainAnimation: true,
                          visible: visi,
                          child: FloatingActionButton.small(
                            onPressed: () {
                              Get.back();
                            },
                            heroTag: null,
                            backgroundColor:
                                darkode ? Colors.grey : Colors.white,
                            foregroundColor:
                                darkode ? Colors.white : Colors.black,
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 10,
                        child: Visibility(
                          maintainState: true,
                          maintainAnimation: true,
                          visible: visi,
                          child: FloatingActionButton.small(
                            onPressed: () {},
                            heroTag: null,
                            backgroundColor:
                                darkode ? Colors.grey : Colors.white,
                            foregroundColor:
                                darkode ? Colors.white :HexColor('62CDFF'),
                            child: const Icon(
                              Icons.bookmark_add_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: Image.asset(
                'assets/g.gif',
              ),
            );
          },
        ),
      ),
    );
  }
}
