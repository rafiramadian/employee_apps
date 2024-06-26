import 'package:employee_apps/blocs/selected_user/selected_user_bloc.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/ui/home/widgets/loading_tile.dart';
import 'package:employee_apps/ui/home/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedUserList extends StatefulWidget {
  const SelectedUserList({super.key});

  @override
  State<SelectedUserList> createState() => _SelectedUserListState();
}

class _SelectedUserListState extends State<SelectedUserList> {
  @override
  void initState() {
    super.initState();
    getIt.get<SelectedUserBloc>().add(FetchSelectedUsers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedUserBloc, SelectedUserState>(
      builder: (context, state) {
        if (state is SelectedUserInitial) {
          return const LoadingTile();
        } else if (state is SelectedUserLoading) {
          return const LoadingTile();
        } else if (state is SelectedUserError) {
          return RefreshIndicator(
            onRefresh: () async =>
                getIt.get<SelectedUserBloc>().add(FetchSelectedUsers()),
            child: SingleChildScrollView(
              child: Center(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state is SelectedUserLoaded) {
          return UserList(
            totalUser: state.users.length,
            users: state.users,
            hasReachedMax: true,
          );
        }

        return Container();
      },
    );
  }
}
