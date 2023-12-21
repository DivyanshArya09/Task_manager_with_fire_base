// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';
import 'package:todo_app_with_firebase/screens/appScreens/model/fire_store_model.dart';
import 'package:todo_app_with_firebase/screens/appScreens/todo_screen.dart';
import 'package:todo_app_with_firebase/screens/appScreens/widgets/button_widget.dart';
import 'package:todo_app_with_firebase/screens/appScreens/widgets/category_container.dart';
import 'package:todo_app_with_firebase/screens/appScreens/widgets/top_screen.dart';
import 'package:todo_app_with_firebase/services/fire_store_services.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';
import 'package:todo_app_with_firebase/styles/text_button_style.dart';
import 'package:todo_app_with_firebase/utils/utils_toast.dart';

class AppScreen extends StatefulWidget {
  final String? name;
  const AppScreen({super.key, this.name});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final myProvider = Provider.of<FireStoreServices>(context, listen: false);
      myProvider.getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onUpdate(String id, String title) {
      TextEditingController updateController = TextEditingController();
      updateController.text = title;
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Update Category'),
            content: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter title';
                } else {
                  return null;
                }
              },
              controller: updateController,
              decoration: const InputDecoration(
                // prefix: Icon(Icons.add),
                hintText: 'Update categories...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                style: TextButtonStyle.defaultStyle,
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Consumer<FireStoreServices>(
                builder: (context, value, child) {
                  return TextButton(
                    style: TextButtonStyle.defaultStyle,
                    child: value.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () async {
                      value.isLoading();
                      if (updateController.text.toString() == title) {
                        value.isLoading();
                        Navigator.pop(context);
                      } else {
                        value.updateData(
                          id,
                          {
                            'title': updateController.text.toString(),
                          },
                        ).then(
                          (val) {
                            value.getCategories().then(
                              (val) {
                                value.isLoading();
                                Utils().toastMessage('Category Updated', false);
                                Navigator.pop(context);
                              },
                            ).onError(
                              (error, stackTrace) {
                                value.isLoading();
                                Utils().toastMessage(error.toString(), true);
                              },
                            );
                          },
                        ).onError(
                          (error, stackTrace) {
                            value.isLoading();
                            int start = error.toString().indexOf(']');
                            int end = error.toString().length;
                            error = error
                                .toString()
                                .substring(start + 1, end)
                                .trim();
                            Utils().toastMessage(error.toString(), true);
                          },
                        );
                      }
                    },
                  );
                },
              )
            ],
          );
        },
      );
    }

    void addData() {
      final collectionId = DateTime.now().millisecond.toString();
      TextEditingController categoryController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Category'),
            content: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your categories';
                } else {
                  return null;
                }
              },
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: 'Add your own categories...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                  style: TextButtonStyle.defaultStyle,
                  child: const Text(
                    'cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Consumer<FireStoreServices>(
                builder: (context, value, child) {
                  return TextButton(
                    style: TextButtonStyle.defaultStyle,
                    child: value.loading == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                            // value: .,
                          )
                        : const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () async {
                      value.isLoading();
                      await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(categoryModel.email.toString())
                          .collection('category')
                          .doc(collectionId)
                          .set({
                        'title': categoryController.text.toString(),
                        'id': collectionId
                      }).then(
                        (val) {
                          value.isLoading();
                          value.getCategories().then(
                            (val) {
                              Navigator.pop(context);
                              Utils().toastMessage('Added Successfully', true);
                              const SnackBar(content: Text('Added'));
                            },
                          );
                        },
                      ).onError(
                        (error, stackTrace) {
                          value.isLoading();
                          int start = error.toString().indexOf(']');
                          int end = error.toString().length;
                          error =
                              error.toString().substring(start + 1, end).trim();
                          Utils().toastMessage(error.toString(), true);
                        },
                      );
                    },
                  );
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CarouselSliderContainer(),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(
                    height: 30,
                    color: AppColors.primary,
                    thickness: .5,
                    endIndent: 60,
                    indent: 10,
                  ),
                  Consumer<FireStoreServices>(
                    builder: (context, value, child) {
                      return GridView.builder(
                        itemCount: value.categories.length + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.8,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          count = count < 5 ? count + 1 : 0;
                          return value.categories.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : index != value.categories.length
                                  ? GestureDetector(
                                      onTap: () {
                                        TodosServices.CategoryId =
                                            value.categories[index].id;

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const TaskDetail();
                                            },
                                          ),
                                        );
                                      },
                                      child: CategoryContainer(
                                        tasksCompletd: value.,
                                        onDelete: () async {
                                          // Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return const AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                          );
                                          value
                                              .deleteData(
                                                  value.categories[index].id)
                                              .then(
                                            (val) {
                                              Navigator.pop(context);
                                              value.getCategories().then(
                                                (val) {
                                                  Utils().toastMessage(
                                                      'Deleted Successfully',
                                                      false);
                                                  Navigator.pop(context);
                                                },
                                              ).onError(
                                                (error, stackTrace) {
                                                  Navigator.pop(context);
                                                  Utils().toastMessage(
                                                      error.toString(), false);
                                                },
                                              );
                                            },
                                          );
                                        },
                                        onUpdate: () async {
                                          Navigator.pop(context);
                                          onUpdate(value.categories[index].id,
                                              value.categories[index].title);
                                        },
                                        index: count,
                                        title: value.categories[index].title
                                            .toString(),
                                      ),
                                    )
                                  : GridButton(
                                      onTap: addData,
                                    );
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
