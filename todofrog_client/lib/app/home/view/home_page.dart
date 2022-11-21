import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todofrog_client/app/app.dart';
import 'package:todofrog_client/data/data.dart';
import 'package:todofrog_client/utils/utils.dart';
import 'package:todofrog_client/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const LoadTodo(show: false)),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<HomeView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Priority? priority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const Logout());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoggedOut) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<AuthPage>(
                builder: (context) => const AuthPage(),
              ),
            );
          }
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              final text = state.message;
              if (text != null) {
                final backgroundColor = Colors.red[300]!;
                InfoBanner.showBanner(context, backgroundColor, text);
              }
            } else if (state is HomeLoaded) {
              final text = state.message;
              if (text != null) {
                final backgroundColor = Colors.green[300]!;
                InfoBanner.showBanner(context, backgroundColor, text);
              }
            }
          },
          builder: (context, state) {
            if (state is HomeLoaded) {
              final data = state.todo;
              if (data.isEmpty) {
                return const CenterText(
                  'Todo Empty!!!\nPlease Add Some Todos First.',
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final todo = data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    titleController.text = todo.title;
                                    descriptionController.text =
                                        todo.description;
                                    priority = Priority(
                                      name: getPriority(todo.priority),
                                      value: todo.priority,
                                    );
                                    formDialog(
                                      context,
                                      titleController,
                                      descriptionController,
                                      priority,
                                      id: todo.id,
                                    );
                                  },
                                  backgroundColor:
                                      getShade(Colors.blue, todo.priority),
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (_) {
                                    context
                                        .read<HomeBloc>()
                                        .add(DeleteTodo(todo.id!));
                                  },
                                  backgroundColor:
                                      getShade(Colors.red, todo.priority),
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ColoredBox(
                              color: getShade(
                                todo.isDone ?? false
                                    ? Colors.blueGrey
                                    : Colors.teal,
                                todo.priority,
                              ),
                              child: CheckboxListTile(
                                title: Text(todo.title),
                                subtitle: Text(todo.description),
                                value: todo.isDone,
                                onChanged: (bool? value) {
                                  setState(() {
                                    todo.isDone = !(todo.isDone ?? false);
                                  });
                                  context
                                      .read<HomeBloc>()
                                      .add(UpdateTodo(todo, show: false));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else if (state is HomeError) {
              return const CenterText('Something Went Wrong!!!');
            } else {
              return const Loader();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => formDialog(
          context,
          titleController,
          descriptionController,
          priority,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
