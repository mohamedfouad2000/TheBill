// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_6/appcubit/appcubit.dart';
// import 'package:flutter_application_6/appcubit/appstates.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class add extends StatelessWidget {
//   // const add({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<homeCubit, HomeStates>(
//       builder: (BuildContext context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.orange,
//           ),
//           body: Text("سي "),
//         );
//       },
//       listener: (BuildContext context, Object? state) {},
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ball/appcubit/appcubit.dart';
import 'package:ball/appcubit/appstates.dart';
import 'package:ball/home.dart';

import 'package:ball/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ball/shared/pdfbill.dart';

// ignore: must_be_immutable
class add extends StatelessWidget {
  // const add({Key? key}) : super(key: key);
  var NameController = TextEditingController();
  var NumberController = TextEditingController();
  var dateController = TextEditingController();
  var addkey = GlobalKey<FormState>();
  var formkey = GlobalKey<FormState>();
  List<String> names = [];
  List<String> phones = [];
  final FocusNode nameNode = FocusNode();
  final GlobalKey nameKey = GlobalKey();

  List<Map>? Collec;

  add({super.key});

  void getsavedata(context) {
    Collec = [];
    for (var element in homeCubit.get(context).pro!) {
      Collec!
          .add({'name': '${element["name"]}', 'phone': '${element["phone"]}'});
      names.add(element["name"]);
      phones.add(element["phone"]);
    }
  }

  var nameofproduectController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const List<String> options = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];
    return BlocProvider(
      create: (BuildContext context) {
        return homeCubit()
          ..createData()
          ..getdata(homeCubit.get(context).database);
      },
      child: BlocConsumer<homeCubit, HomeStates>(
        builder: (BuildContext context, state) {
          // homeCubit.get(context).products = [];
          var date = DateTime.now().toString();

          var dateParse = DateTime.parse(date);

          var formattedDate =
              "${dateParse.day}-${dateParse.month}-${dateParse.year}";
          dateController.text = formattedDate.toString();

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: const Text("اضافه "),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  TextForm(
                                    Con: NameController,
                                    val: "من فضلك ادخل الاسم الخاص بك  ",
                                    lable: "اسم العميل",
                                  ),
                                  Rawcomplete(
                                      focusNode: nameNode,
                                      controller: NameController,
                                      coll: options,
                                      key: nameKey),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextForm(
                                      Con: NumberController,
                                      type: TextInputType.number,
                                      val: "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                      lable: "رقم الهاتف"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextForm(
                                      Con: dateController,
                                      enable: false,
                                      lable: "تاريخ اليوم",
                                      val: null

                                      // val: "  ",
                                      ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                            elevation: 8,
                            // color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      nameofproduectController.text = "";
                                      amountController.text = "";
                                      priceController.text = "";
                                      var x = AlertDialog(
                                        title: Text(
                                          "  اضافه الصنف",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                        insetPadding: const EdgeInsets.all(20),
                                        content: Form(
                                          key: addkey,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  // insetPadding: EdgeInsets.zero,
                                                  width: 400,
                                                  // height: 400,
                                                  // width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      TextForm(
                                                          Con:
                                                              nameofproduectController,
                                                          // type: TextInputType.number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "اسم الصنف ",
                                                          val:
                                                              "من فضلك ادخل اسم الصنف"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextForm(
                                                          Con: amountController,
                                                          type: TextInputType
                                                              .number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "الكميه ",
                                                          val:
                                                              "من فضلك ادخل الكميه"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextForm(
                                                          Con: priceController,
                                                          type: TextInputType
                                                              .number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "السعر ",
                                                          val:
                                                              "من فضلك ادخل السعر"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        color: Colors.orange,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            if (addkey
                                                                .currentState!
                                                                .validate()) {
                                                              homeCubit
                                                                  .get(context)
                                                                  .addpro(
                                                                      price: priceController
                                                                          .text,
                                                                      name: nameofproduectController
                                                                          .text,
                                                                      amount: amountController
                                                                          .text)
                                                                  .then(
                                                                      (value) {
                                                                homeCubit
                                                                    .get(
                                                                        context)
                                                                    .getprice();
                                                                Navigator.pop(
                                                                    context);
                                                              });

                                                              //     proName: "proName",
                                                              //     number: "12345",
                                                              //     mobile: "020303",
                                                              //     name: "name",
                                                              //     data: "17/6/2000");
                                                              print(
                                                                  priceController
                                                                      .text);
                                                              print(
                                                                  nameofproduectController
                                                                      .text);
                                                              print(
                                                                  amountController
                                                                      .text);
                                                            }
                                                          },
                                                          child: const Text(
                                                            "اضافه",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: x,
                                            );
                                          });
                                    },
                                    child: const Text(
                                      "اضافه صنف",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      if (homeCubit
                                          .get(context)
                                          .products
                                          .isNotEmpty)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: const Text(
                                                    "الصنف",
                                                  )),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: const Text("الكميه")),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child:
                                                      const Text("سعرالوحده")),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Title(
                                                    color: Colors.orange,
                                                    child:
                                                        const Text("الاجمالي")),
                                              ),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: const Text("")),
                                            ),
                                          ],
                                        ),
                                      SingleChildScrollView(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return prod(
                                                homeCubit
                                                    .get(context)
                                                    .products[index],
                                                index,
                                                context);
                                          },
                                          itemCount:
                                              // ignore: unnecessary_null_comparison
                                              homeCubit.get(context).products !=
                                                      null
                                                  ? homeCubit
                                                      .get(context)
                                                      .products
                                                      .length
                                                  : 1,
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Container(
                                              height: 1,
                                              width: double.infinity,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      if (homeCubit.get(context).products.isNotEmpty)
                        Card(
                          elevation: 8,
                          // color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: const Text(
                                          "عدد الاصناف ",
                                        )),
                                  ),
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: Text(
                                            "${homeCubit.get(context).products.length}")),
                                  ),
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: const Text("السعر الاجمالي")),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Title(
                                          color: Colors.orange,
                                          child: Text(
                                              "${homeCubit.get(context).price} جنيه")),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () async {
                                          String s = '';
                                          homeCubit
                                              .get(context)
                                              .products
                                              .forEach((element) {
                                            String x = '';
                                            x = 'المنتج : ${element['"pro"']} : العدد : ${element['"num"']} : سعر القطعه  ${element['"price"']} السعر : ${double.parse('${element['"price"']}') * double.parse('${element['"num"']} ')} ';
                                            s = '$s$x \n';
                                          });
                                          String paragraphText =
                                              'الاسم : ${NameController.text} \n'
                                              'رقم الهاتف  : ${NumberController.text} \n'
                                              'التاريخ   : ${dateController.text} \n'
                                              '$s \n'
                                              'السعر الكلــي : ${homeCubit.get(context).price}';

                                          if (formkey.currentState!
                                              .validate()) {
                                            await Share.share(
                                              paragraphText,
                                              subject: "hewa ",
                                            );
                                          }
                                        },
                                        child: const Text("ارسال")),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            homeCubit
                                                .get(context)
                                                .insertData(
                                                    data: dateController.text,
                                                    mobile:
                                                        NumberController.text,
                                                    name: NameController.text)
                                                .then((value) {
                                              // ShowToastFun(
                                              //     msg: "تم الحفظ",
                                              //     Sort: toaststate.success);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          const home()),
                                                  (route) => false);
                                            });
                                          }
                                        },
                                        child: const Text("حفظ")),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            convertTolist(context,
                                                date: dateController.text,
                                                mobile: NumberController.text,
                                                name: NameController.text);
                                          }
                                        },
                                        child: const Text("اجعله مستند")),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }

  Widget prod(Map model, index, context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
                  "${model['"pro"'].toString().substring(1, model['"pro"'].length - 1)}  ")),
          Expanded(child: Text("${model['"num"']} ")),
          Expanded(child: Text("${model['"price"']} جنيه")),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                    "${int.parse(model['"price"']) * int.parse(model['"num"'])} جنيه")),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    homeCubit.get(context).removeIteam(index: index);
                  },
                  child: const Text("حـذف"))),
        ],
      );

  convertTolist(
    context, {
    required String name,
    required String mobile,
    required String date,
  }) async {
    var data = <Map<String, String>>[
      for (int i = 0; i < homeCubit.get(context).products.length; i++)
        {
          "pro": homeCubit
              .get(context)
              .products[i]['"pro"']
              .toString()
              .substring(
                  1,
                  homeCubit
                          .get(context)
                          .products[i]['"pro"']
                          .toString()
                          .length -
                      1),
          "num": "${homeCubit.get(context).products[i]['"num"']}",
          "price": "${homeCubit.get(context).products[i]['"price"']}",
          "allprice":
              "${double.parse('${homeCubit.get(context).products[i]['"price"']} ') * double.parse('${homeCubit.get(context).products[i]['"num"']} ')}",
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < data.length; i++) {
      listOfPurchases.add(data[i].values.toList());
    }
    print('siu siu siu  $listOfPurchases');
    var pdf = await pdfBill.generatePdf(
        data: listOfPurchases,
        name: name,
        date: date,
        mobile: mobile,
        allprice: homeCubit.get(context).price);
    pdfBill.openfile(pdf);
  }
}
