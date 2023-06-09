import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_stars/bloc/users/users_state.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';
import 'package:flutter_git_stars/presentation/utils/di/di.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/users/users_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  bool listenerAdded = false;

  void _initListeners(BuildContext context, UsersState state) {
    if (!listenerAdded) {
      _textEditingController.addListener(() {
        String text = _textEditingController.text;
        if (text.isNotEmpty) {
          context.read<UsersCubit>().searchUsers(text);
        }
      });
      _scrollController.addListener(() {
        ScrollPosition scrollPosition = _scrollController.position;
        if (scrollPosition.pixels > scrollPosition.maxScrollExtent - 1000 &&
            !state.isScrollToLoading) {
          context.read<UsersCubit>().loadMoreUsers();
        }
      });
      listenerAdded = true;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (context) => UsersCubit(getIt<UsersUseCase>())..initState(),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (BuildContext context, UsersState state) {
          _initListeners(context, state);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title ?? ''),
              ),
              body: Stack(
                children: <Widget>[
                  const SizedBox(height: 10),
                  ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 90),
                      itemCount: state.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.users.length) {
                          context.read<UsersCubit>().scrollToLoadCompleted();
                        }
                        return GestureDetector(
                          child: Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                height: 90,
                                width: 90,
                                imageUrl: state.users[index].avatarUrl,
                              ),
                              Text(state.users[index].login),
                            ],
                          ),
                          onTap: () {
                            context.go('/users/detail', extra: {
                              'login': state.users[index].login,
                              'avatarUrl': state.users[index].avatarUrl
                            });
                          },
                        );
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: SearchBar(
                      controller: _textEditingController,
                      hintText: 'Search users',
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
