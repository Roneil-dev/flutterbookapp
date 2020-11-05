import 'dart:convert';
import 'package:book_shelf/model/books.dart';
import 'package:http/http.dart';

class AppController {
  //SIGN IN
  Future getBooks(String searchString, List<Book> bookList) async {
    try {
      String url = "https://www.googleapis.com/books/v1/volumes?q=$searchString&maxResults=40&startIndex=0";
      print(url);
      var encodedUrl = Uri.encodeFull(url);

      Response response = await get(encodedUrl);
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        List books = data['items'];

        for(int i =0; i < books.length; i++)
        {
          Map mainData = books[i]["volumeInfo"];
          Book book = new Book();
          book.title = mainData["title"] == null ? "NA" : mainData["title"];
          if(mainData["authors"] != null)
            book.author = mainData["authors"][0] == null ? 'NA' : mainData["authors"][0];
          else
            book.author = "NA";
          book.publishDate = mainData["publishedDate"] == null ? "NA" :  mainData["publishedDate"];
          dynamic image =mainData["imageLinks"];
          if(image != null)
            book.image = image['thumbnail'] == null ? "" : image['thumbnail'];
          else
             book.image ='https://thumbs.dreamstime.com/b/grunge-textured-not-available-stamp-seal-not-available-stamp-seal-watermark-distress-style-blue-vector-rubber-print-not-138792800.jpg';
          bookList.add(book);
        }
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Status'] = "Success";
        return finalResponse;
      } else {
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] ="No results. Please try again.";
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] ="No results. Please try again.";
        return finalResponse;
    }
  }
}
