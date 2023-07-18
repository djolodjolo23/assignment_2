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
      bool isItemAlreadyInTheList = listWithItems.contains(textFieldText);
      if (isItemAlreadyInTheList) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Duplicate item'),
                content: const Text(
                    'This item is already in the list. Are you sure you want to add it again?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          listWithItems.add(textFieldText);
                          textEditingController.clear();
                          textFieldText = '';
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No',
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              );
            });
      } else {
        setState(() {
          listWithItems.add(textFieldText);
          textEditingController.clear();
          textFieldText = '';
        });
      }
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeItemFromList(item);
                      textEditingController.text = item;
                      textFieldText = item;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
