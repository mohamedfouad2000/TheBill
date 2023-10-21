import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ball/appcubit/appcubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

bool dark = false;

Widget TextForm({
  // ignore: non_constant_identifier_names
  required var Con,
  var type = TextInputType.text,
  var lable,
  var prefixIcon,
  @required var val,
  var obscureText = false,
  var suffixIcon,
  var fun_su,
  var ontap,
  var onchange,
  var onsubmit,
  var Key,
  var enable = true,
  var s = "null",
}) =>
    TextFormField(
      enabled: enable,
      onFieldSubmitted: (x) {
        RawAutocomplete.onFieldSubmitted<String>(Key);
      },
      onTap: ontap,
      controller: Con,
      onChanged: onchange,
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: lable,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        iconColor: Colors.orange,
        fillColor: Colors.orange,
        // filled: true,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: fun_su, icon: suffixIcon)
            : null,
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return val;
        } else {
          return null;
        }
      },
    );

enum toaststate { error, success, warning }

Color ToastSort(toaststate state) {
  Color color;
  switch (state) {
    case toaststate.success:
      color = Colors.green;
      break;
    case toaststate.error:
      color = Colors.red;
      break;
    case toaststate.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}

void ShowToastFun({required String msg, required toaststate Sort}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ToastSort(Sort),
        textColor: Colors.white,
        fontSize: 16.0);

pdf() async {
  final pdf = pw.Document();
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hello World"),
        ); // Center
      }));
  pdf.save();
  final output = await getTemporaryDirectory();
  var filepath = '${output.path}/siu.pdf';
  final file = File(filepath);
  List<int> bytes = [10];
  await file.writeAsBytes(bytes);
  // await OpenDocument.openDocument(filePath: filepath);
}

Widget textAutocompName({required context}) {
  List<Map>? collection;
  List<String> kOptions = ['aldasld', 'asdjasd', 'asdasd', 'سعيد '];

  for (var element in homeCubit.get(context).pro!) {
    collection!
        .add({'name': '${element["name"]}', 'mobile': '${element["mobile"]}'});
    print(collection[0]['name']);
    // collection!.add({'':''});
  }
  return Container(
    color: Colors.amber,
    child: Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        if (selection == "سعيد ") {
          print("سعيد");
        }
      },
    ),
  );
}

Widget Rawcomplete(
    {required focusNode, required controller, required coll, required key}) {
  return RawAutocomplete<String>(
    key: key,
    focusNode: focusNode,
    textEditingController: controller,
    optionsBuilder: (TextEditingValue textEditingValue) {
      return coll.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      }).toList();
    },
    optionsViewBuilder: (BuildContext context,
        AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
      return Material(
        elevation: 20,
        child: ListView(
          children: options
              .map((String option) => GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  ))
              .toList(),
        ),
      );
    },
  );
}
