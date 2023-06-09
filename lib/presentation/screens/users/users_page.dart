import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_stars/bloc/users/users_state.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';
import 'package:flutter_git_stars/presentation/utils/di/di.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../bloc/users/users_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late TextEditingController _textEditingController;
  bool listenerAdded = false;

  void _initListeners(BuildContext context, UsersState state) {
    if (!listenerAdded) {
      _textEditingController.addListener(() {
        String text = _textEditingController.text;
        if (text.isNotEmpty) {
          context.read<UsersCubit>().searchUsers(text);
        }
      });
      listenerAdded = true;
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
                      padding: const EdgeInsets.only(top: 90),
                      itemCount: state.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            CachedNetworkImage(
                              height: 90,
                              width: 90,
                              imageUrl: state.users[index].avatarUrl,
                            ),
                            Text(state.users[index].login),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
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
