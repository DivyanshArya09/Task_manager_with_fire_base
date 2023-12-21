import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';
import 'package:todo_app_with_firebase/utils/utils_toast.dart';

class UpdateTodo extends StatefulWidget {
  final String id, title, description;
  const UpdateTodo(
      {super.key,
      required this.id,
      required this.title,
      required this.description});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  TextEditingController todoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    todoController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          'Update your todo and make it happen.',
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
                            return 'Please enter new title of your todo';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: AppColors.text),
                        decoration: const InputDecoration(
                          fillColor: AppColors.text,
                          hintText: 'Update your todo...',
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
                            return 'Please enter your new description';
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
                      Consumer<TodosServices>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                value.updateLoading();
                                value.updateTodo(
                                  widget.id,
                                  {
                                    'title': todoController.text.toString(),
                                    'description':
                                        descriptionController.text.toString(),
                                    'completed': false,
                                    'updatedAt': DateTime.now().toString(),
                                    'id': widget.id
                                  },
                                ).then(
                                  (val) {
                                    value
                                        .getSpecificTodo(
                                            TodosServices.CategoryId)
                                        .then((val) {
                                      value.updateLoading();
                                      Utils().toastMessage(
                                          'Updated Successfully', false);
                                      Navigator.pop(context);
                                    });
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    value.isLoading();
                                    Utils()
                                        .toastMessage(error.toString(), false);
                                  },
                                );
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
                                child: value.updateloading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.primary,
                                      )
                                    : const Text(
                                        'Update todo',
                                      ),
                              ),
                            ),
                          );
                        },
                      )
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
