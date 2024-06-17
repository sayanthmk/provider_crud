import 'dart:io';
import 'package:crud_provider/changenotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridList extends StatelessWidget {
  const GridList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, studentProvider, child) {
        if (studentProvider.students.isEmpty) {
          return const Center(
            child: Text('List is empty'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: studentProvider.students.length,
          itemBuilder: (ctx, index) {
            final student = studentProvider.students[index];
            return Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(File(student.selectimage)),
                    ),
                    Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      student.age,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => EditStudent(student: student),
                            //   ),
                            // );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                    'Do you want to delete this student?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<StudentProvider>(context,
                                              listen: false)
                                          .deleteStudent(student.id!);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
