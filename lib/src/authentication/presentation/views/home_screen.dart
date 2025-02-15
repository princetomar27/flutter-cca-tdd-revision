import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddtut/src/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tddtut/src/authentication/presentation/views/widgets/loader.dart';

import 'widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthCubit>().fetchUsers();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
              ),
            ),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const Loader(
                  text: "Fetching users...",
                )
              : state is UserCreating
                  ? const Loader(text: "Creating user...")
                  : state is UsersFetched
                      ? Center(
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      child: Image.network(user.avatar)),
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt),
                                );
                              }),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => SizedBox(
                        height: 400,
                        width: 200,
                        child: AddUserDialog(
                          nameController: nameController,
                        ),
                      ));
            },
            icon: const Icon(Icons.add),
            label: const Text(
              "Add User",
            ),
          ),
        );
      },
    );
  }
}
