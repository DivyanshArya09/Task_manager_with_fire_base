import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';
import 'package:todo_app_with_firebase/utils/utils_toast.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    todoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = DateTime.now().microsecond.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage('assets/addtodo.png'),
                    height: size.height * .2,
                  ),
                  SizedBox(
                    width: size.width * .5,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Add your todo and make it happen.',
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 1000),
                      // displayFullTextOnTap: true,
                      // stopPauseOnTap: true,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: size.height * .65,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: todoController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your todo';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: AppColors.text),
                        decoration: const InputDecoration(
                          fillColor: AppColors.text,
                          hintText: 'Add your todo...',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColors.text),
                          ),
                          // Set the text color to white
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your description';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 4,
                        style: const TextStyle(color: AppColors.text),
                        decoration: const InputDecoration(
                          fillColor: AppColors.text,
                          hintText: 'Add Description...',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColors.text),
                          ),
                          // Set the text color to white
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Consumer<TodosServices>(builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            value.isLoading();
                            if (_formKey.currentState!.validate()) {
                              // value.loading;
                              value
                                  .addTodo(
                                TodosServices.CategoryId,
                                {
                                  'id': id,
                                  'title': todoController.text.toString(),
                                  'description':
                                      descriptionController.text.toString(),
                                  'completed': false,
                                  'createdAt': DateTime.now().toString(),
                                },
                                id,
                              )
                                  .then((val) {
                                value
                                    .getSpecificTodo(TodosServices.CategoryId)
                                    .then((val) {
                                  value.isLoading();
                                  Utils().toastMessage(
                                      'Added Successfully', false);
                                });
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                value.isLoading();
                                Utils().toastMessage(error.toString(), false);
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.text,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: value.loading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.primary,
                                    )
                                  : const Text(
                                      'Add todo',
                                    ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
//                           style: ButtonStyle(
//                               minimumSize: MaterialStateProperty.all(
//                                 Size(size.width, 50),
//                               ),
//                               backgroundColor: MaterialStateProperty.all(
//                                 AppColors.text,
//                               )),
//                           onPressed: () {
//                             try {
//                               value.addTodo(
//                                 TodosServices.CategoryId,
//                                 {
//                                   'title': todoController.text.toString(),
//                                   'description':
//                                       descriptionController.text.toString(),
//                                   'completed': false,
//                                   'createdAt': DateTime.now().toString(),
//                                 },
//                               );
//                             } catch (e) {
//                               Utils().toastMessage(e.toString(), true);
//                             }
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Add task',
//                               style: TextStyle(color: AppColors.primary)),
//                         );