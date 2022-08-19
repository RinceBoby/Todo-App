import 'package:flutter/material.dart';
import 'package:hive_db/add_todo.dart';
import 'package:hive_db/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //<<<<<FriendsBox>>>>>//
  // Box friendsBox = Hive.box('Friend');
  // String? name;
  // addFriend() async {
  //   await friendsBox.put('name', "Ameen");
  // }
  // getFriend() async {
  //   setState(() {
  //     name = friendsBox.get('name');
  //   });
  // }
  // updateFriend() async {
  //   await friendsBox.put('name', "Absam");
  // }
  // deleteFriend() async {
  //   await friendsBox.delete('name');
  // }
  Box todoBox = Hive.box<ToDo>(boxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 38, 4, 90),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No Todo Available !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          } else {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                ToDo toDo = box.getAt(index);
                return ListTile(
                  leading: Checkbox(
                    value: toDo.isCompleted, 
                    onChanged: (value) {
                      ToDo newToDO = ToDo(
                        title: toDo.title,
                        isCompleted: value!,
                      );
                      box.putAt(index, newToDO);
                    },
                  ),
                  title: Text(
                    toDo.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          toDo.isCompleted ? Colors.yellowAccent : Colors.black,
                      decoration: toDo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          TextEditingController editedText =
                              TextEditingController(text: toDo.title);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: TextFormField(
                                controller: editedText,
                                decoration: const InputDecoration(
                                  labelText: "Edited Text",
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    todoBox.putAt(
                                      index,
                                      ToDo(
                                        title: editedText.text.capitalise(),
                                        isCompleted: false,
                                      ),
                                    );
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Todo Edited Successfully",
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 64, 20, 129),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.blueAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          box.deleteAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Todo Deleted Successfully",
                              ),
                              backgroundColor: Color.fromARGB(255, 64, 20, 129),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),

      //Container(

      //<<<<<FriendsBox>>>>>//
      // width: MediaQuery.of(context).size.width,
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       "$name",
      //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      //     ),
      //     ElevatedButton(
      //       onPressed: addFriend,
      //       child: const Text("Create"),
      //     ),
      //     ElevatedButton(
      //       onPressed: getFriend,
      //       child: const Text("Read"),
      //     ),
      //     ElevatedButton(
      //       onPressed: updateFriend,
      //       child: const Text("Update"),
      //     ),
      //     ElevatedButton(
      //       onPressed: deleteFriend,
      //       child: const Text("Delete"),
      //     ),
      //   ],
      // ),

      //),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 64, 20, 129),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDO(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//<<<<<Capitalize_First_Letter>>>>>//
extension CapitalExtension on String {
  String capitalise() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
