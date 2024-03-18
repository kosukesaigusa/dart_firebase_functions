import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth.dart';
import 'submission.dart';
import 'user.dart';

part 'submission_list.g.dart';

@riverpod
SubmissionQuery submissionQuery(SubmissionQueryRef _) => SubmissionQuery();

@riverpod
Stream<List<Submission>> submissions(SubmissionsRef ref) =>
    ref.watch(submissionQueryProvider).subscribeDocuments(
          queryBuilder: (query) => query.orderBy('createdAt', descending: true),
        );

@riverpod
UserQuery userQuery(UserQueryRef _) => UserQuery();

@riverpod
Stream<User?> user(UserRef ref, String userId) =>
    ref.watch(userQueryProvider).subscribeDocument(userId: userId);

class SubmissionListPage extends ConsumerStatefulWidget {
  const SubmissionListPage({super.key});

  @override
  ConsumerState<SubmissionListPage> createState() => _SubmissionListPageState();
}

class _SubmissionListPageState extends ConsumerState<SubmissionListPage> {
  @override
  Widget build(BuildContext context) {
    final submissions = ref.watch(submissionsProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Submission List'),
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
          body: submissions.when(
            data: (submissions) => RefreshIndicator(
              onRefresh: () => ref.refresh(submissionsProvider.future),
              child: ListView.builder(
                itemCount: submissions.length,
                itemBuilder: (context, index) {
                  final submission = submissions[index];
                  final submittedByUserId = submission.submittedByUserId;
                  final submittedByUser = submittedByUserId != null
                      ? ref.watch(userProvider(submittedByUserId)).valueOrNull
                      : null;
                  return ListTile(
                    key: ValueKey(submission.submissionId),
                    title: Text(submission.title),
                    subtitle: submittedByUser != null
                        ? Row(
                            children: [
                              if (submittedByUser.imageUrl != null) ...[
                                CircleAvatar(
                                  maxRadius: 12,
                                  backgroundImage:
                                      NetworkImage(submittedByUser.imageUrl!),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Text(submittedByUser.displayName),
                            ],
                          )
                        : const Text('Anonymous user'),
                    leading: submission.isVerified
                        ? const Badge(
                            label: Text('verified'),
                            backgroundColor: Colors.green,
                          )
                        : const Badge(
                            label: Text('unverified'),
                            backgroundColor: Colors.red,
                          ),
                    trailing: IconButton(
                      onPressed: () => ref
                          .read(submissionQueryProvider)
                          .delete(submissionId: submission.submissionId),
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(e.toString())),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  final token = await FirebaseMessaging.instance.getToken();
                  print('token: $token');
                },
                child: const Icon(Icons.notification_important_rounded),
              ),
              const SizedBox(height: 4),
              FloatingActionButton(
                onPressed: () => ref.read(submissionQueryProvider).add(
                      createSubmissionData: CreateSubmissionData(
                        title: '${DateTime.now()}',
                        submittedByUserId: ref.read(currentUserIdProvider),
                      ),
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
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
