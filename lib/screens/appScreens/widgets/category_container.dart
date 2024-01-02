import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final int index;
  final VoidCallback onDelete, onUpdate;
  const CategoryContainer({
    super.key,
    required this.onDelete,
    required this.onUpdate,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.blue,
      const Color.fromARGB(255, 135, 123, 14),
    ];
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: FadeInDown(
          duration: const Duration(milliseconds: 800),
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: colorList[index].withOpacity(.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/check.png',
                      ),
                      height: 40,
                    ),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 42, 42))),
                    const Text(
                      '3 tasks completed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 17, 16, 16),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [
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
                              leading: const Icon(Icons.update,
                                  color: AppColors.primary),
                              trailing: const Text('update'),
                            ),
                          )
                        ];
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
