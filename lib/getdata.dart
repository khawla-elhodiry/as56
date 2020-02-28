import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<String> groups = [];
  final controller = TextEditingController();

  Widget build(context) => Scaffold(
      appBar: AppBar(
        actions: <Widget>[

          InkWell(
              onTap: () {},
              child: Center(
                  child: Text('Edit')
              )
          )
        ],
        backgroundColor: Colors.blueGrey,
        title: Text("Students"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,

        onPressed: onPressed,
        child: Icon(Icons.add),
      ),
      body: groups.isEmpty
          ? Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('No Students Yet'),
              Text('Please add your Students now')
            ]),
      )
          : GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 8.0 / 10.0,
          crossAxisCount: 2,
        ),
        children: [
          ...groups.map( (group) => Card(  elevation: 3,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => info())),
                      child: Column(
                        children: <Widget>[
                          //Image.asset('assets/01.jpg'),
                          Text(
                            group,
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )
        ],
      ));

  void onPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Insert Students"),
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Student Name",
            ),
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text("create"),
            color: Colors.blueGrey,
            onPressed: () {
              setState(() => groups.add(controller.text));
              controller.clear();
              Navigator.of(context).maybePop();
            },
          ),

        ],
      ),
    );
  }
}

class info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('infopage'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,

              onPressed: () {
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}