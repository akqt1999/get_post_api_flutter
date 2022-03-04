import 'package:flutter/material.dart';
import 'package:get_post_api/model/post.dart';

import 'networt/networt_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var posts = List<Post>.empty(growable: true);

//IdUser  PhoneUser  NameUser AddressUser
  TextEditingController textEditingControllerIdUser = TextEditingController();
  TextEditingController textEditingControllerPhoneUser =
      TextEditingController();
  TextEditingController textEditingControllerNameUser = TextEditingController();
  TextEditingController textEditingControllerAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPost().then((value) {
      setState(() {
        posts = value;
      });
    });
  }

  void _onShowBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textEditingControllerAddress,
                decoration: InputDecoration(hintText: "address"),
              ),
              TextField(
                controller: textEditingControllerIdUser,
                decoration: InputDecoration(hintText: "id user"),
              ),
              TextField(
                controller: textEditingControllerNameUser,
                decoration: InputDecoration(hintText: "name user"),
              ),
              TextField(
                controller: textEditingControllerPhoneUser,
                decoration: InputDecoration(hintText: "phone user"),
              ),
              ElevatedButton(
                  onPressed: () {
                    NetworkRequest.postData(
                      PhoneUser: textEditingControllerPhoneUser.text,
                      NameUser: textEditingControllerNameUser.text,
                      AddressUser: textEditingControllerAddress.text,
                      IdUser: textEditingControllerIdUser.text
                    );
                  },
                  child: Text("add data"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: posts.length == 0
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                this._onShowBottomSheet();
                              },
                              child: Text("show form")),
                        ],
                      )),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        padding: EdgeInsets.all(9),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.orange[200],
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${posts[index].NameUser}',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.black),
                                ),
                                Text(
                                  '${posts[index].PhoneUser}\nid user:${posts[index].IdUser}',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
