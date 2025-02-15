import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              const avatar =
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwo2WUcswBNMdLmeD_lBqHWz4ZydZ-8qVhpw&s';

              context.read<AuthCubit>().createUser(
                    createdAt: DateTime.now().toIso8601String(),
                    name: name,
                    avatar: avatar,
                  );
              Navigator.pop(context);
            },
            child: const Text('Add User'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ]),
      ),
    );
  }
}
