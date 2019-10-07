import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';

import 'member.dart';
import 'strings.dart';

class GHFlutterState extends State<GHFlutter> {
  var _members = <Member>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    Response response = await get(dataURL);
    setState(() {
      final membersJSON = json.decode(response.body);
      for (var memberJSON in membersJSON) {
        final member = Member(memberJSON["login"], memberJSON["avatar_url"]);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text("${_members[i].login}", style: _biggerFont),
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            backgroundImage: NetworkImage(_members[i].avatarUrl),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(Strings.appTitle,),
      ),
      body: ListView.builder(
          itemCount: _members.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();
            final index = position ~/ 2;
            return _buildRow(index);
          }),
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}