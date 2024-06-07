import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth.dart';
import 'submission.dart';
import 'user.dart';
import 'user_fcm_token.dart';

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

@riverpod
UserFcmTokenQuery userFcmTokenQuery(UserFcmTokenQueryRef _) =>
    UserFcmTokenQuery();

class SubmissionListPage extends ConsumerStatefulWidget {
  const SubmissionListPage({super.key});

  @override
  ConsumerState<SubmissionListPage> createState() => _SubmissionListPageState();
}

class _SubmissionListPageState extends ConsumerState<SubmissionListPage> {
  @override
  void initState() {
    () async {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission();
      print('User granted permission: ${settings.authorizationStatus}');
      FirebaseMessaging.onMessage.listen((message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print(
            'Message also contained a notification: ${message.notification}',
          );
        }
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final submissions = ref.watch(submissionsProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Submission List'),
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
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (ref.watch(authProvider).valueOrNull == null) ...[
                  IconButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signInAnonymously();
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Signed in.')),
                        );
                    },
                    icon: const Icon(Icons.person),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signInWithLine();
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Signed in.')),
                        );
                    },
                    icon: const Icon(Icons.person),
                  ),
                ] else
                  TextButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signOut();
                      if (!context.mounted) {
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
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () async {
                    final apnsToken =
                        await FirebaseMessaging.instance.getAPNSToken();
                    if (apnsToken == null) {
                      return;
                    }
                    final token = await FirebaseMessaging.instance.getToken();
                    if (token == null) {
                      return;
                    }
                    print('token: $token');
                    final userId = ref.read(currentUserIdProvider);
                    if (userId != null) {
                      await ref.read(userFcmTokenQueryProvider).set(
                            userFcmTokenId: userId,
                            createUserFcmTokenData:
                                CreateUserFcmTokenData(token: token),
                          );
                    }
                  },
                  icon: const Icon(Icons.notification_add),
                ),
                IconButton(
                  onPressed: () => ref.read(submissionQueryProvider).add(
                        createSubmissionData: CreateSubmissionData(
                          title: '${DateTime.now()}',
                          submittedByUserId: ref.read(currentUserIdProvider),
                        ),
                      ),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
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
