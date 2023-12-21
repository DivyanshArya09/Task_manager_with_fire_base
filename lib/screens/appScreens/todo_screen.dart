import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';
import 'package:todo_app_with_firebase/screens/appScreens/addTodo.dart';
import 'package:todo_app_with_firebase/screens/appScreens/update_todo.dart';
import 'package:todo_app_with_firebase/screens/appScreens/widgets/list_tile.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';
import 'package:todo_app_with_firebase/utils/utils_toast.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  int duration = 800;
  TextStyle styles = const TextStyle(
    color: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    // TodosServices.createTodoDoc(TodosServices.CategoryId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final myProvider = Provider.of<TodosServices>(context, listen: false);
      myProvider.getSpecificTodo(TodosServices.CategoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        backgroundColor: AppColors.text,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          // color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Image(
              image: AssetImage('assets/check.png'),
              height: 100,
            ),
            Consumer<TodosServices>(
              builder: (context, value, child) {
                duration += 200;
                return value.todos.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.todos.length,
                        itemBuilder: (context, index) {
                          return TodoTile(
                            onDelete: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      content: Center(
                                        child: CircularProgressIndicator(),
                                      ));
                                },
                              );
                              value.deleteTodoDoc(value.todos[index].id).then(
                                (val) {
                                  value.getSpecificTodo(
                                      TodosServices.CategoryId);
                                  Navigator.pop(context);
                                  Utils().toastMessage(
                                      'Deleted successfully', false);
                                },
                              ).onError(
                                (error, stackTrace) {
                                  Navigator.pop(context);
                                  Utils().toastMessage(error.toString(), true);
                                },
                              );
                            },
                            onUpdate: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateTodo(
                                    id: value.todos[index].id,
                                    title: value.todos[index].title,
                                    description: value.todos[index].subtitle,
                                  ),
                                ),
                              );
                            },
                            onChange: (val) {
                              value.updateTodo(value.todos[index].id, {
                                'completed': val,
                              }).then((val) {
                                value.getSpecificTodo(TodosServices.CategoryId);
                              });
                            },
                            value: value.todos[index].completed,
                            description: value.todos[index].subtitle.toString(),
                            title: value.todos[index].title.toString(),
                          );
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
