// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/screens/appScreens/model/fire_store_model.dart';
import 'package:todo_app_with_firebase/screens/appScreens/model/todos_model.dart';

class TodosServices with ChangeNotifier {
  static String CategoryId = '';
  int count = 0;
  List<TodosModel> todos = [];
  bool loading = false;
  bool updateloading = false;

  static Future<void> createTodoDoc(String id) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email)
        .collection('todos')
        .doc(id)
        .collection('specificTodo');
  }

  Future<void> deleteTodoDoc(String id) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email)
        .collection('todos')
        .doc(CategoryId)
        .collection('specificTodo')
        .doc(id)
        .delete();
  }

  Future<void> updateTodo(String id, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email)
        .collection('todos')
        .doc(CategoryId)
        .collection('specificTodo')
        .doc(id)
        .update(data);
  }

  Future<void> addTodo(
      String CollectionId, Map<String, dynamic> data, String id) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email)
        .collection('todos')
        .doc(CollectionId)
        .collection('specificTodo')
        .doc(id)
        .set(data);
  }

  Future<void> getSpecificTodo(String id) async {
    var records = await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email.toString())
        .collection('todos')
        .doc(id)
        .collection('specificTodo')
        .get();
    mapRecords(records);
    notifyListeners();
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((e) => (TodosModel(
              subtitle: e['description'],
              title: e['title'],
              id: e['id'],
              createdAt: e['createdAt'],
              completed: e['completed'],
            )))
        .toList();
    todos = _list;
    notifyListeners();
  }

  void isLoading() {
    loading = !loading;
    notifyListeners();
  }

  void updateLoading() {
    updateloading = !updateloading;
    notifyListeners();
  }
}
