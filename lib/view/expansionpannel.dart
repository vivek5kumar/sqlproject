import 'package:flutter/material.dart';

class Expansion extends StatefulWidget {
  const Expansion({super.key});

  @override
  State<Expansion> createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  List<ExpansionItem> items = <ExpansionItem>[
    ExpansionItem(header: "Name1", body: "this is my first description"),
    ExpansionItem(header: "Name2", body: "this is my SECOND description"),
    ExpansionItem(header: "Name3", body: "this is my THIRD description"),
    ExpansionItem(header: "Name4", body: "this is my THIRD description"),
    ExpansionItem(header: "Name5", body: "this is my THIRD description")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
            // ListView.builder(
            //   itemCount: items.length,
            //   itemBuilder: (context, i) {
            //     return ExpansionTile(
            //       // collapsedBackgroundColor: Colors.grey,
            //       title: Text(items[i].header.toString()),
            //       children: [
            //         ListTile(
            //           focusColor: Colors.red,
            //           title: Text(items[i].body.toString()),
            //           subtitle: const Text("this is subtitle"),
            //           leading: const Icon(Icons.people),
            //           trailing: const Icon(Icons.offline_bolt),
            //         ),
            //         const ExpansionTile(title: Text("hello"))
            //       ],
            //     );
            //   },
            // ));

            ListView(children: [
          ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              dividerColor: Colors.amber,
              expansionCallback: (i, isExpanded) {
                setState(() {
                  items[i].isExpanded = !items[i].isExpanded!;
                });
              },
              children: items.map((ExpansionItem item) {
                return ExpansionPanel(
                    backgroundColor: Colors.red,
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        child: Text(item.header.toString()),
                      );
                    },
                    isExpanded: item.isExpanded!,
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(item.body.toString()),
                            InkWell(onTap: () {}, child: Icon(Icons.delete))
                          ],
                        ),
                      ],
                    ));
              }).toList()),
        ]));
  }
}

class ExpansionItem {
  bool? isExpanded;
  String? header;  
  String? body;
  ExpansionItem({this.isExpanded: false, this.header, this.body});
}
