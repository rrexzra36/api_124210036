import 'package:bab7_api/api_data_source.dart';
import 'package:bab7_api/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bab7_api/detail_user.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Users",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder(future: ApiDataSource.instance.loadUsers(), builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text("ADA ERROR!");
        }
        if(snapshot.hasData){
          Users users = Users.fromJson(snapshot.data!);
          return ListView.builder(
            itemCount: users.data!.length,
            itemBuilder: (context, index){
              var user = users.data![index];

              return ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailUser(user), // Mengganti dengan DetailUser(user)
                    ),
                  );
                },
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(user.avatar!),
                  ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text("${user.email}"),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },),
    );
  }
}
