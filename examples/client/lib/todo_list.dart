import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth.dart';
import 'todo.dart';

part 'todo_list.g.dart';

@riverpod
TodoQuery todoQuery(TodoQueryRef _) => TodoQuery();

@riverpod
Stream<List<Todo>> todos(TodosRef ref) =>
    ref.watch(todoQueryProvider).subscribeDocuments();

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
            actions: [
              if (ref.watch(authProvider).valueOrNull == null)
                TextButton(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).signInWithLine();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Signed in.')),
                      );
                  },
                  child: const Text('Sign in'),
                )
              else
                TextButton(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).signOut();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Signed out.')),
                      );
                  },
                  child: const Text('Sign out'),
                ),
            ],
          ),
          body: todos.when(
            data: (todos) => RefreshIndicator(
              onRefresh: () => ref.refresh(todosProvider.future),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    key: ValueKey(todo.todoId),
                    title: Text(todo.title),
                    subtitle: Text(todo.todoId),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) async {
                        if (value == null) {
                          return;
                        }
                        await ref.read(todoQueryProvider).update(
                              todoId: todo.todoId,
                              updateTodoData:
                                  UpdateTodoData(isCompleted: value),
                            );
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () => ref
                          .read(todoQueryProvider)
                          .delete(todoId: todo.todoId),
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text(err.toString())),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  final todoIds = (await ref.read(todosProvider.future))
                      .map((todo) => todo.todoId);
                  await ref.read(todoQueryProvider).batchWrite(
                        todoIds
                            .map(
                              (todoId) => BatchUpdateTodo(
                                todoId: todoId,
                                updateTodoData:
                                    const UpdateTodoData(isCompleted: true),
                              ),
                            )
                            .toList(),
                      );
                },
                child: const Icon(Icons.check),
              ),
              const SizedBox(height: 4),
              FloatingActionButton(
                onPressed: () async {
                  final todoIds = (await ref.read(todosProvider.future))
                      .map((todo) => todo.todoId);
                  await ref.read(todoQueryProvider).batchWrite(
                        todoIds
                            .map((todoId) => BatchDeleteTodo(todoId: todoId))
                            .toList(),
                      );
                },
                child: const Icon(Icons.delete),
              ),
              const SizedBox(height: 4),
              FloatingActionButton(
                onPressed: () async {
                  final count = await ref.read(todoQueryProvider).count(
                        queryBuilder: (query) =>
                            query.where('isCompleted', isNotEqualTo: true),
                      );
                  if (count == null) {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('$count todos left.')),
                    );
                },
                child: const Icon(Icons.onetwothree),
              ),
              const SizedBox(height: 4),
              FloatingActionButton(
                onPressed: () => ref.read(todoQueryProvider).add(
                      createTodoData:
                          CreateTodoData(title: 'Todo ${DateTime.now()}'),
                    ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        if (ref.watch(authProvider).isLoading)
          const SizedBox.expand(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
