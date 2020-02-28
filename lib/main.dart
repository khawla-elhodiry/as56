import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app123/new_group.dart';
import 'package:flutter_app123/group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'getdata.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
void main() => runApp(Main());



class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cet',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),

    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  List<Group> list = new List<Group>();
  SharedPreferences sharedPreferences;

  @override
  void initState() {

    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CET Student',
            key: Key('main-app-title'),
          ),
          centerTitle: true,
        ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>goToNewItemView(),
      ),

      body:
        list.isEmpty ? emptyList() : buildListView(),



      drawer: Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('CET Students Manager'),

          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        ListTile(
          title: Text('Groups'),
          leading: Icon(Icons.group),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Notifications' ),
          leading: Icon(Icons.notifications),

          onTap: (
              ) {

          },
        ),
        ListTile(
          title: Text('About App' ),
          leading: Icon(Icons.info),

          onTap: (
              ) {

          },
        ),
      ],
    ),
    ),

    );
  }

  Widget emptyList(){
    return Center(
        child:Column (
          mainAxisAlignment :MainAxisAlignment.center,children: <Widget>[
            Text('No grops yet',
              style:  TextStyle(fontSize: 30),
            ),
          Text('Please add your groups now'),
        ],
        ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return buildItem(list[index], index);
      },
    );
  }

  Widget buildItem(Group item, index){
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.grey),
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(Group item, int index){

    return ListTile(
     // onTap: () => changeItemCompleteness(item),
      onTap: () => goToEditItemView(item),
      title: Text(
        item.title,
        key: Key('item-$index'),

      ),

      );

  }

  void goToNewItemView(){
    // Here we are pushing the new view into the Navigator stack. By using a
    // MaterialPageRoute we get standard behaviour of a Material app, which will
    // show a back button automatically for each platform on the left top corner
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return NewGroupView();
    })).then((title){
      if(title != null) {
        addItem(Group(title: title));
      }
    });
  }

  void addItem(Group item){
    // Insert an item into the top of our list, on index zero
    list.insert(0, item);
    saveData();
  }



  void goToEditItemView(item){
    // We re-use the NewTodoView and push it to the Navigator stack just like
    // before, but now we send the title of the item on the class constructor
    // and expect a new title to be returned so that we can edit the item
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
  }

  void editItem(Group item ,String title){
    item.title = title;
    saveData();
  }

  void removeItem(Group item){
    list.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if(listString != null){
      list = listString.map(
              (item) => Group.fromMap(json.decode(item))
      ).toList();
      setState((){});
    }
  }

  void saveData(){
    List<String> stringList = list.map(
            (item) => json.encode(item.toMap()
        )).toList();
    sharedPreferences.setStringList('list', stringList);
  }


}