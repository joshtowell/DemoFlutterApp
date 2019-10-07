import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Profile extends StatefulWidget {
  final username;

  Profile({this.username});

  @override
  _ProfileState createState() => _ProfileState(username: username);
}

class _ProfileState extends State<Profile> {
  _ProfileState({this.username});
  final username;
  final apiKey = "https://api.github.com/users/";
  String avatar = "";
  String pubRepos = "";
  String followers = "";
  String following = "";
  String dateCreated = "";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    Response response = await get(apiKey + username);
    print(response.body);

    final profileDetails = json.decode(response.body);

    avatar = profileDetails["avatar_url"];
    pubRepos = profileDetails["public_repos"].toString();
    followers = profileDetails["followers"].toString();
    following = profileDetails["following"].toString();
    dateCreated = profileDetails["created_at"].toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                  ),
                ),
              ),
              Text(
                "Username: " + username,
              ),
              Text("Public Repositories: " + pubRepos),
              Row(
                children: <Widget>[
                  Text("Followers: " + followers),
                  Text("              Following: " + following),
                ],
              ),
              Text("Date Joined: " + dateCreated),
              Text("Profile URL: " + apiKey + username),
            ]),
      ),
    );
  }
}
