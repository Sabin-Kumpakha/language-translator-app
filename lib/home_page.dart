import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String translatedText = " ";

  //inputController is used to get the text entered by the user
  TextEditingController inputController = TextEditingController();
  //outputController is used to print the translated text
  TextEditingController outputController = TextEditingController();

  //For default dropdown value
  String dropdownValueForTranslateFrom = "English";
  String dropdownValueForTranslateTo = "Nepali";

  //Package //Translate Function
  void translate(String translateTo, translateFrom) {
    final translator = GoogleTranslator();
    final input = inputController.text;

    if (input.isNotEmpty) {
      translator.translate(input, from: translateFrom, to: translateTo).then(
        (value) {
          setState(
            () {
              outputController.text = value.text;
            },
          );
        },
      );
    }
  }

  Map<String, String> countryLanguage = {
    "English": "en",
    "Hindi": "hi",
    "Nepali": "ne",
    "Japanese": "ja",
    "Korean": "ko",
    "Spanish": "es",
    "French": "fr",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Translator App "),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //From
                    const Text("From:",
                        style: TextStyle(fontWeight: FontWeight.bold)),

                    //DropDownButton
                    DropdownButton(
                      value: dropdownValueForTranslateFrom,
                      underline: Container(
                        height: 2,
                        color: Colors.teal,
                      ),
                      items: countryLanguage.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValueForTranslateFrom = value!;
                        });
                      },
                    ),

                    //To
                    const Text("To:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),

                    //DropDownButton
                    DropdownButton(
                      value: dropdownValueForTranslateTo,
                      underline: Container(
                        height: 2,
                        color: Colors.teal,
                      ),
                      items: countryLanguage.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValueForTranslateTo = value!;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),

                //TextFormField
                TextFormField(
                  controller: inputController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Enter  $dropdownValueForTranslateFrom Text",
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10.0),
                //TextFormField //prints the translated text
                // Text(translatedText, style: TextStyle(fontSize: 30.0)),

                //Translated Text //prints the translated text
                TextField(
                  controller: outputController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: "Translated text",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10.0),
                //Button
                MaterialButton(
                    color: Colors.teal,
                    onPressed: () {
                      String to = countryLanguage[dropdownValueForTranslateTo]!;
                      String from =
                          countryLanguage[dropdownValueForTranslateFrom]!;
                      translate(to, from);
                    },
                    child: const Text(
                      "Translate",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
