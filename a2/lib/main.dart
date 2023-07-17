import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Scrollable List App',
      home: ScrollableListScreen(),
    );
  }
}

class ScrollableListScreen extends StatefulWidget {
  const ScrollableListScreen({super.key});
  @override
  _ScrollableListScreenState createState() => _ScrollableListScreenState();
}

class _ScrollableListScreenState extends State<ScrollableListScreen> {
  List<String> itemList = [];
  String textFieldText = '';

  void addItemToList() {
    if (textFieldText.isNotEmpty) {
      setState(() {
        itemList.add(textFieldText);
        textFieldText = '';
      });
    }
  }

  void removeItemFromList(String item) {
    setState(() {
      itemList.remove(item);
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
            onChanged: (value) {
              setState(() {
                textFieldText = value;
              });
            },
            onSubmitted: (value) {
              addItemToList();
              setState(() {
                textFieldText = ''; // Reset the text field after submitting
              });
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
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    removeItemFromList(item);
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
