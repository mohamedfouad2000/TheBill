import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ball/appcubit/appcubit.dart';
import 'package:ball/appcubit/appstates.dart';
import 'package:ball/home.dart';
import 'package:ball/shared/cashehelber.dart';
import 'package:ball/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class startpage extends StatelessWidget {
  const startpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var NameController = TextEditingController();
    var NumberController = TextEditingController();
    var organController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    // homeCubit()..createData();

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
              // title: Text("مرحبا"),
              ),
          body: SingleChildScrollView(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    const Text(
                      "مرحبا بك برجاء تسجيل بياناتك ",
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextForm(
                        Con: NameController,
                        val: "من فضلك ادخل الاسم الخاص بك  ",
                        lable: "الاسم"),
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
                        Con: organController,
                        type: TextInputType.text,
                        val: "من فضلك ادخل المؤسسه الخاص بك  ",
                        lable: "المؤسسه"),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.background,
                        child: TextButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                homeCubit
                                    .get(context)
                                    .insertuser(
                                        name: NameController.text,
                                        organ: organController.text,
                                        mobile: NumberController.text)
                                    .then((value) {
                                  casheHelber
                                      .putBool(key: "start", value: true)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => const home()),
                                        (route) => false);
                                  });
                                });
                              }
                            },
                            child: const Text(
                              "دخول",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
