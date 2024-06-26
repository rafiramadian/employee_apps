import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/ui/home/widgets/loading_tile.dart';
import 'package:employee_apps/ui/home/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NonSelectedUserList extends StatelessWidget {
  const NonSelectedUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const LoadingTile();
        } else if (state is UserLoading) {
          return const LoadingTile();
        } else if (state is UserError) {
          return RefreshIndicator(
            onRefresh: () async =>
                getIt.get<UserBloc>().add(const FetchUserList()),
            child: SingleChildScrollView(
              child: Center(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state is UserLoaded) {
          return UserList(
            totalUser: state.totalUser,
            users: state.users,
            hasReachedMax: state.hasReachedMax,
          );
        }

        return Container();
      },
    );
  }
}
