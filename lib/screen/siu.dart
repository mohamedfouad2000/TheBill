import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> _options = <String>[
  'aardvark',
  'bobcat',
  'chameleon',
];

class RawAutocompleteSplit extends StatelessWidget {
  const RawAutocompleteSplit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode nameNode = FocusNode();
    final GlobalKey nameKey = GlobalKey();
    // var nameofproduectController = TextEditingController();
    var NameController = TextEditingController();
    const List<String> options = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: NameController,
            focusNode: nameNode,
            decoration: const InputDecoration(
              hintText: 'Split RawAutocomplete App',
            ),
            onFieldSubmitted: (String value) {
              RawAutocomplete.onFieldSubmitted<String>(nameKey);
            },
          ),
          RawAutocomplete<String>(
            key: nameKey,
            focusNode: nameNode,
            textEditingController: NameController,
            optionsBuilder: (TextEditingValue textEditingValue) {
              return options.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              }).toList();
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options) {
              return Material(
                textStyle: const TextStyle(
                    color: Colors.black, backgroundColor: Colors.amber),
                // color: Colors.red,

                // color: Colors.grey[300],
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  children: options
                      .map((String option) => GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(
                                option,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
