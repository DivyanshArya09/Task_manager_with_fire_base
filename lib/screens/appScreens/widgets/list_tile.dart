import 'package:flutter/material.dart';

import '../../../consts/colors.dart';

class TodoTile extends StatelessWidget {
  final bool value;
  final VoidCallback onDelete, onUpdate;
  final String title, description;
  final Function(bool?) onChange;
  const TodoTile(
      {super.key,
      required this.onDelete,
      required this.onUpdate,
      required this.value,
      required this.onChange,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(8),
          tileColor: AppColors.primary,
          leading: Checkbox(
            side: const BorderSide(color: Colors.white),
            activeColor: Colors.white,
            checkColor: AppColors.primary,
            value: value,
            onChanged: onChange,
          ),
          title: Text(
            title,
            style: const TextStyle(color: AppColors.text),
          ),
          subtitle: Text(description,
              style: const TextStyle(color: AppColors.unHighlight)),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  onTap: onDelete,
                  leading: const Icon(Icons.delete),
                  trailing: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: onUpdate,
                  leading: const Icon(Icons.update, color: AppColors.primary),
                  trailing: const Text('update'),
                ),
              ),
            ],
          )),
    );
  }
}
