import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBarTitle = new Text("Headlines");
  Icon actionIcon = new Icon(Icons.search);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: appBarTitle,
        actions: [
            IconButton(icon: actionIcon,onPressed:(){
            if(actionIcon==Icon(Icons.send)){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPage()));
              });
            }
            else{setState(() {
              actionIcon=Icon(Icons.send);
              appBarTitle = TextField(
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                    hintText: "enter keyword",
                    hintStyle: new TextStyle(color: Colors.white)
                  ),
              );
            });}
          }
        )]
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NewsData(),
        )
      ),
    );
  }
}

class NewsData extends StatefulWidget {
  @override
  _NewsDataState createState() => _NewsDataState();
}


class _NewsDataState extends State<NewsData> {

  var url="http://newsapi.org/v2/top-headlines?country=in&apiKey=defed58e45374c0bac458be8734b2865";
  var data;

  getData() async{
    var str=await http.get(url);
    data=jsonDecode(str.body);
    data=data['articles'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data==null
      ?Center(child: CircularProgressIndicator())
      :ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Row(children:[
            Image.network(data[index]['urlToImage'],height:70,width:70,fit: BoxFit.cover,),
            SizedBox(width:20),
            Flexible(child: 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(data[index]['title']),
                SizedBox(height:10),
                Text("-${data[index]['source']['name']}",textScaleFactor:0.75)
              ],),
            )),

          ]),
        );
       },
      ),
    );
  }
}


class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2"),
      ),
    );
  }
}