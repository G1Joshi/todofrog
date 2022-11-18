import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/app/app.dart';
import 'package:todofrog_client/data/data.dart';

Future<void> formDialog(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  Priority? pri, {
  int? id,
  bool? isDone,
}) {
  final formKey = GlobalKey<FormState>();
  var priority = pri;
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Add Todo'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) => value == '' ? 'Please enter title' : null,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              validator: (value) =>
                  value == '' ? 'Please enter description' : null,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              validator: (value) =>
                  value == null ? 'Please select priority' : null,
              value: priority,
              items: Priority.priorities
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (Priority? value) => priority = value,
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final todo = Todo(
                id: id,
                title: titleController.text,
                description: descriptionController.text,
                priority: priority?.value ?? 1,
                isDone: null,
              );
              if (id != null) {
                context.read<HomeBloc>().add(UpdateTodo(todo));
              } else {
                context.read<HomeBloc>().add(CreateTodo(todo));
              }
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
              priority = null;
            }
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
