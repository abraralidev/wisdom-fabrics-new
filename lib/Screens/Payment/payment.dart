
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Page/page.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String gender = 'Cash on delivery';

  @override
  Widget build(BuildContext context) {
    return gender == 'Cash on delivery'
        ? Scaffold(
            backgroundColor: HexColor('#F5F2DA'),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15),
                    child: Row(
                      children: [
                        Text(
                          'Select Payment Mode',
                          style: TextStyle(
                            fontSize: 28,
                            color: HexColor('62CDFF'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  RadioListTile(
                    title: const Text("Cash on delivery"),
                    value: "Cash on delivery",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RadioListTile(
                    title: const Text("Advance Payment"),
                    value: "Advance Payment",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15),
                    child: Row(
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: HexColor('62CDFF'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          "کیش آن ڈلیوری",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.notoNastaliqUrdu(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "ڈیئر کسٹمر، کتابوں کے آرڈر کے لیے ادارہ بک کارنر جہلم کا انتخاب کرنے پر ہم آپ کا شکریہ ادا کرتے ہیں۔",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "پہلے کتابیں اور پھر ادائیگی کے لیے آرڈر پلیس کرنے کے بعد فارم میں اپنی مکمل تفصیلات (نام، ولدیت، مکمل پتہ اور رابطہ نمبر) فِل کیجیے۔ آرڈر پلیس کرتے ہی آپ کو 48 گھنٹوں کے دوران کنفرمیشن میسج وصول ہو گا۔ آپ کے پارسل کو ڈلیور ہونےمیں 7 سے 8 دن لگ سکتے ہیں۔ بل کی رقم آپ موقع پر ہی ڈلیوری بوائے کو ادا کریں گے۔ آپ سے گزارش ہے کہ اپنی عدم موجودگی میں دئیے گئے پتے پر وصول کرنے والوں کو اس پارسل سے متعلق ضرور آگاہ رکھیے۔ آپ کے تعاون کا شکریہ!",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "گزارش: جیسا کہ آپ جانتے ہیں کہ لاک ڈاؤن کی وجہ سے آن لائن کے مختلف کاروبار کا رش ہو چکا ہے جس کے باعث اب کسی بھی کورئیر کمپنی کی COD (کیش آن ڈلیوری) گھر تک پہنچانے کی سروس پہلے جیسے نہیں رہی۔ یہ کورئیر کمپنیز بعض اوقات فرضی نوٹ لکھ کر پارسل واپس بھیج دیتے ہیں جس سے ادارے کو نقصان کا سامنا ہوتا ہے۔ ان کورئیر کمپنیز کے رویوں سے ادارہ بک کارنر کا نام خراب ہوتا ہے جبکہ اچھی یا بُری سروس میں مکمل طور پر کردار ان کوریئر کمپنیز کا ہی ہوتا ہے۔",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "لہٰذا اگر آپ چاہتے ہیں کہ آپ کو بہترین سروس ملے تو ایڈوانس رقم کے ذریعے اپنے آرڈر کو یقینی اور محفوظ بنائیے، ادارہ سب سے پہلے آپ کے پارسل کو ترجیح دے گا۔ رقم موصول ہوتے ہی ادارہ آپ کا پارسل فوری اور محفوظ ڈلیور کرنے کی ضمانت دیتا ہے۔ رقم کی ادائیگی کے طریقِ کار Advance Payment کے آپشن میں ملاحظہ کریں۔",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor('62CDFF'),
                      child: MaterialButton(
                        splashColor: Colors.black,
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Pagescreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Order Placed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: HexColor('#F5F2DA'),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15),
                    child: Row(
                      children: [
                        Text(
                          'Select Payment Mode',
                          style: TextStyle(
                            fontSize: 28,
                            color: HexColor('62CDFF'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  RadioListTile(
                    title: const Text("Cash on delivery"),
                    value: "Cash on delivery",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RadioListTile(
                    title: const Text("Advance Payment"),
                    value: "Advance Payment",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 15),
                    child: Row(
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: HexColor('62CDFF'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          "رقم کی ادائیگی کے طریقہ کار",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.notoNastaliqUrdu(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "Online Bank Transfer",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      left: 20,
                      right: 10,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 45,
                          child: Text(
                            "Habib Bank Limited (HBL):\nAccount Title: Book Corner\nAccount Number: 0971-79025183-03\nBank: HBL (Freedom Account)\nBranch: Shandar Chowk Jhelum Pakistan\nIBAN: PK48 HABB 0009 7179 0251 8303",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "Easy Paisa",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      left: 20,
                      right: 10,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 45,
                          child: Text(
                            "Easy Paisa Account Number # 0314-4440882\n(Account Title: Syed Ilamdar Haider)",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      left: 20,
                      right: 10,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 45,
                          child: Text(
                            "As soon as you have sent payment, for confirmation please Call / SMS / WhatsApp on this number: 0314-4440882",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      left: 15,
                      bottom: 25,
                      right: 20,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 38,
                          child: Text(
                            "براہ کرم کسی بھی ذریعے سے رقم بھیجنے کی رسید یا اطلاع اس نمبر پر دیں: 03144440882 آپ کے تعاون کا شکریہ",
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor('62CDFF'),
                      child: MaterialButton(
                        splashColor: Colors.black,
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Pagescreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Order Placed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
