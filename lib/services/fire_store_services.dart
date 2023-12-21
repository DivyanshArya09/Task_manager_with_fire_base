import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';

import '../screens/appScreens/model/fire_store_model.dart';

class FireStoreServices with ChangeNotifier {
  List<categoryModel> categories = [];
  bool loading = false;
  static bool addcategoryList = false;

  static Future<void> addData(
      Map<String, dynamic> data, String collectionId, String collection) async {
    return await FirebaseFirestore.instance
        .collection('customers')
        .doc(collection)
        .collection('category')
        .doc(collectionId)
        .set(data);
  }

  Future<void> deleteData(String collectionId) async {
    return await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email.toString())
        .collection('category')
        .doc(collectionId)
        .delete();
  }

  Future<void> updateData(
      String collectionId, Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email.toString())
        .collection('category')
        .doc(collectionId)
        .update(data);
  }

  Future<void> getCategories() async {
    // loading = true;
    var records = await FirebaseFirestore.instance
        .collection('customers')
        .doc(categoryModel.email.toString())
        .collection('category')
        .get();
    mapRecords(records);
    // loading = false;
    notifyListeners();
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((e) => categoryModel(title: e['title'], id: e.id))
        .toList();
    categories = _list;
    notifyListeners();
  }

  void isLoading() {
    loading = !loading;
    notifyListeners();
  }

  static void dummyData(String collection) {
    List<Map<String, dynamic>> dataList = [
      {
        'id': 1,
        'title': 'Work',
      },
      {
        'id': 2,
        'title': 'Personal',
      },
      {
        'id': 3,
        'title': 'Shopping',
      },
    ];
    for (var i in dataList) {
      // String id = DateTime.now().microsecond.toString();
      FireStoreServices.addData(i, i['id'].toString(), collection);
      TodosServices.createTodoDoc(i['id'].toString());
    }
  }
}
