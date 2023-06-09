import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_stars/bloc/users/detail/user_detail_cubit.dart';
import 'package:flutter_git_stars/bloc/users/detail/user_detail_state.dart';
import 'package:flutter_git_stars/domain/usecase/users_usecase.dart';

import '../../../utils/di/di.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key, required this.login, required this.avatarUrl})
      : super(key: key);

  final String login;
  final String avatarUrl;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailCubit>(
      create: (context) => UserDetailCubit(getIt<UsersUseCase>())
        ..initState(widget.login, widget.avatarUrl)
        ..getUserDetail(widget.login),
      child: BlocBuilder<UserDetailCubit, UserDetailState>(
          builder: (BuildContext context, UserDetailState state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.login),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: CachedNetworkImage(
                  height: 200,
                  width: 200,
                  imageUrl: state.avatarUrl,
                ),
              ),
              Text(state.userInfo?.name ?? widget.login),
              Text(state.userInfo?.email ?? '-'),
              Text('followers: ${state.userInfo?.followers ?? '0'}'),
              Text('following: ${state.userInfo?.following ?? '0'}'),
            ],
          ),
        );
      }),
    );
  }
}
