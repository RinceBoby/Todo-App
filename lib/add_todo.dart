import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/homescreen.dart';
import 'package:hive_db/todo.dart';

// ignore: must_be_immutable
class AddToDO extends StatelessWidget {
  AddToDO({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Box todoBox = Hive.box<ToDo>(boxName); //Box Name "ToDo"//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 4, 90),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 38, 4, 90),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Card(
            child: SizedBox(
              width: 350,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: ((value) {
                          if (value == "") {
                            return "Field is required";
                          }
                          return null;
                        }),
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Todo Title",
                          hintText: "Todo",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.note_add_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 64, 20, 129),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate() == true) {}

                            ToDo newTodo = ToDo(
                              title: titleController.text.capitalise(),
                              isCompleted: false,
                            );
                            todoBox.add(newTodo);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Todo Added Successfully",
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 64, 20, 129),
                              ),
                            );
                          },
                          child: const Text(
                            "Add Todo",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
