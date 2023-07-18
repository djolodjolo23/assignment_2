import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo List App',
      home: ScrollableListScreen(),
    );
  }
}

class ScrollableListScreen extends StatefulWidget {
  const ScrollableListScreen({super.key});
  @override
  createState() => _ScrollableListScreenState();
}

class _ScrollableListScreenState extends State<ScrollableListScreen> {
  List<String> listWithItems = [];
  String textFieldText = '';
  TextEditingController textEditingController = TextEditingController();

  void addItemToList() {
    if (textFieldText.isNotEmpty) {
      setState(() {
        listWithItems.add(textFieldText);
        textEditingController.clear();
        textFieldText = '';
      });
    }
  }

  void removeItemFromList(String item) {
    setState(() {
      listWithItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add item to the ToDo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                textFieldText = value;
              });
            },
            onSubmitted: (value) {
              addItemToList();
            },
            decoration: const InputDecoration(
              labelText: 'Enter ToDo Item',
              hintText: 'Enter text',
              contentPadding: EdgeInsets.all(10),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addItemToList,
            child: const Text('Add item'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listWithItems.length,
              itemBuilder: (context, index) {
                final item = listWithItems[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    removeItemFromList(item);
                    textEditingController.text = item;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
