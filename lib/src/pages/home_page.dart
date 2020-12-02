import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users_blocs/users_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsersBloc _usersBloc;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _usersBloc = context.read<UsersBloc>();
    _usersBloc.add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _usersBloc.add(FetchRefreshUsers()),
          ),
        ],
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersLoaded) {}
        },
        builder: (context, state) {
          if (state is UsersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersError) {
            return Center(child: Text(state.error));
          } else if (state is UsersLoaded) {
            if (state.userModel.isEmpty) {
              return Center(
                  child: Text(
                'Empty users!',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ));
            }
            return Column(
              children: [
                RaisedButton(
                  color: Colors.amber,
                  child: const Text('Company Name'),
                  onPressed: () {
                    _usersBloc.userRepository
                        .fetchUsers()
                        .then((value) => print(value[0].company.name));
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: state.userModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('id:\t${state.userModel[index].id}'),
                          Text('userId:\t${state.userModel[index].name}'),
                          Text('email:\t${state.userModel[index].email}'),
                          Text('username:\t${state.userModel[index].username}'),
                          Text('phone:\t${state.userModel[index].phone}'),
                          Text('website:\t${state.userModel[index].website}'),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Container(
            child: Center(
              child: Text(
                'Failed to fetch users!',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}
