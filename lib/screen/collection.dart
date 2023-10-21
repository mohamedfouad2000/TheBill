import 'package:ball/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:ball/appcubit/appcubit.dart';
import 'package:ball/appcubit/appstates.dart';

import 'package:ball/screen/editpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class collection extends StatelessWidget {
  const collection({super.key});

  // const collection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(homeCubit.get(context).ge)
    homeCubit.get(context).getdata(homeCubit.get(context).database);

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return BlocConsumer<homeCubit, HomeStates>(
          builder: (BuildContext context, state) {
            return homeCubit.get(context).pro!.isNotEmpty &&
                    state is! getdataloading
                ? ConditionalBuilder(
                    builder: (BuildContext context) {
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return buldd(
                              homeCubit.get(context).pro![index], context);
                        },
                        itemCount: homeCubit.get(context).pro!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 1,
                            width: double.infinity,
                          );
                        },
                      );
                    },
                    condition: state is! getdataloading,
                    fallback: (BuildContext context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                : Container(
                    child: const Center(
                        child: Text(
                      "لا توجد فواتير لديك ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                  );
          },
          listener: (BuildContext context, Object? state) {},
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget buldd(model, context) => Card(
        elevation: 8,
        // color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text("اسم العميل "),
                const Spacer(),
                Text("${model['name']} "),
                const Spacer(),
                const Text("التاريخ "),
                const Spacer(),
                Text("${model['data']} "),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text("الاجمالي"),
                const Spacer(),
                Text("${model['price']} جنيه"),
                const Spacer(),
                const Text("عدد الاصناف"),
                const Spacer(),
                Text("${model['numberofp']}"),
                const Spacer(),
                // Text("${model['name']} "),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => edituser(
                                        model: model,
                                      )));
                        },
                        child: Text(
                          "تعديل",
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.orange,
                          ),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          homeCubit.get(context).DeleteData(id: model['id']);
                        },
                        child: Text(
                          "حذف",
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.orange,
                          ),
                        ))),
              ],
            )
          ],
        ),
      );
}
