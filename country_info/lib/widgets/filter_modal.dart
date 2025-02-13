import 'package:flutter/material.dart';

void showFilterModal(BuildContext context, Function(List<String>, List<String>) onFilterApply) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      List<String> continents = [
        "Africa", "Antarctica", "Asia", "Australia",
        "Europe", "North America", "South America"
      ];
      List<String> timeZones = [
        "GMT+1:00", "GMT+2:00", "GMT+3:00", "GMT+4:00", "GMT+5:00", "GMT+6:00"
      ];

      Map<String, bool> selectedContinents = {};
      Map<String, bool> selectedTimeZones = {};

      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            bool hasSelection = selectedContinents.containsValue(true) || selectedTimeZones.containsValue(true);

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Filter",
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
                              icon: const Icon(Icons.close, color: Colors.black),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: const Text("Continent", style: TextStyle(fontSize: 14)),
                        children: continents.map((continent) {
                          return CheckboxListTile(
                            title: Text(continent),
                            value: selectedContinents[continent] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedContinents[continent] = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: const Text("Time Zone", style: TextStyle(fontSize: 14)),
                        children: timeZones.map((zone) {
                          return CheckboxListTile(
                            title: Text(zone),
                            value: selectedTimeZones[zone] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedTimeZones[zone] = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedContinents.clear();
                                selectedTimeZones.clear();
                              });
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 220,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              backgroundColor: hasSelection ? Colors.orange : Colors.grey,
                              side: BorderSide.none,
                              elevation: 0,
                            ),
                            onPressed: hasSelection
                                ? () {
                                    List<String> selectedContinentsList = selectedContinents.keys
                                        .where((key) => selectedContinents[key] == true)
                                        .toList();
                                    List<String> selectedTimeZonesList = selectedTimeZones.keys
                                        .where((key) => selectedTimeZones[key] == true)
                                        .toList();
                                    onFilterApply(selectedContinentsList, selectedTimeZonesList);
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text(
                              "Show results",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
