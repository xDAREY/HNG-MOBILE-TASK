import 'package:flutter/material.dart';

void showLanguageModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      List<String> languages = [
        "Bahasa", "Deutsch", "English", "Español", "Française",
        "Italiano", "Português", "Pycckuu", "Svenska", "Türkçe",
        "普通话", "العربية", "বাংলা"
      ];
      String selectedLanguage = "English";

      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Languages",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 211, 209, 209),
                          ),
                          child: Center(
                            child: IconButton(
                              iconSize: 13,
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.close, color: Colors.black,),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...languages.map((lang) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(lang, style: const TextStyle(fontSize: 16)),
                          Radio<String>(
                            value: lang,
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() => selectedLanguage = value!);
                            },
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
