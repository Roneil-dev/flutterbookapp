import 'package:book_shelf/model/books.dart';
import 'package:book_shelf/service/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:native_progress_hud/native_progress_hud.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String searchString = "";
  List<Book> bookList = new List<Book>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchNow() async {
    setState(() {
      bookList.clear();
    });

    if(searchString.trim().length>0)
    {
      NativeProgressHud.showWaitingWithText("Please wait",
      backgroundColor: "#000000", textColor: "#FFFFFF");
      dynamic result = await AppController().getBooks(searchString, bookList);
      NativeProgressHud.hideWaiting(); // hide hud

      if(result['Status'] == "Success")
      {

      }
      else
      {

      }
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'GOOGLE BOOKS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto-Bold',
              fontSize: 18),
          ),
        ),
        //backgroundColor: Colors.blue,
        body: Column(
          children: [
            Container(
              height: 60,
              child: TextField(
                onChanged: (value){
                  searchString = value;
                },
                onSubmitted: (val){
                  searchNow();
                },
                keyboardType: TextInputType.text,
                autofocus: false,
                style: TextStyle(
                    color: Colors.black, decorationColor: Colors.white),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search Books or Authors'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Search Results',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Roboto-Bold',
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: new ListView.builder
              (
                itemCount: bookList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return bookCell(bookList[index]);
                }
              )
            )

          ],
        ),
      ),
    );
  }

  Widget bookCell(Book book){
    return  Container(
      child: Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          height: 100,
          child : Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: Colors.blue,
                  child: Image(image:CachedNetworkImageProvider(book.image)),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  height: 100,
                  color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${book.title}",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                Row(
                children: <Widget>[
                  Icon(Icons.account_circle, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(child: Text("${book.author}", maxLines: 1 ,style: TextStyle(color: Colors.white)))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Publish Date : ${book.publishDate}", style: TextStyle(color: Colors.white))
                ],
              ),
                ],
              )
              
            ),

                    ],
                  ),
                ),
              )
            ],
          )

   /*       
          decoration: BoxDecoration(color: Colors.blue),
            child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            leading: Container(
              
              color: Colors.red,
              height: 100,
              child: Image(image:CachedNetworkImageProvider(book.image),height: 90, width: 90,),
            ),
            title: Text(
              "${book.title}",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                Row(
                children: <Widget>[
                  Icon(Icons.account_circle, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${book.author}", style: TextStyle(color: Colors.white))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Publish Date : ${book.publishDate}", style: TextStyle(color: Colors.white))
                ],
              ),
                ],
              )
              
            ),
        ),
        */
      )
      ),
    );
  }
}