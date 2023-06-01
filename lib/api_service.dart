import 'package:http/http.dart' as http;
import 'dart:convert';

// class APIService {
//   static const String baseURL = 'https://api.example.com';

//   Future<dynamic> fetchData() async {
//     final response = await http.get(Uri.parse('$baseURL/endpoint'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }


class APIService {
  Future<dynamic> fetchRandomMeme() async {
    final response = await http.get(Uri.parse('https://meme-api.com/gimme'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      // Extract the required fields from the API response
      final title = decodedResponse['title'];
      final url = decodedResponse['url'];
      final author = decodedResponse['author'];
      
      // Create a map to return the required fields
      final memeData = {
        'title': title,
        'url': url,
        'author': author,
      };
      
      return memeData;
    } else {
      throw Exception('Failed to load meme');
    }
  }


  Future<dynamic> fetchHindiMeme() async {
    final response = await http.get(Uri.parse('https://meme-api.com/gimme/IndianDankMemes'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      // Extract the required fields from the API response
      final title = decodedResponse['title'];
      final url = decodedResponse['url'];
      final author = decodedResponse['author'];
      
      // Create a map to return the required fields
      final memeData = {
        'title': title,
        'url': url,
        'author': author,
      };
      
      return memeData;
    } else {
      throw Exception('Failed to load meme');
    }
  }

  Future<dynamic> fetchDankMeme() async {
    final response = await http.get(Uri.parse('https://meme-api.com/gimme/Memes_Of_The_Dank'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      // Extract the required fields from the API response
      final title = decodedResponse['title'];
      final url = decodedResponse['url'];
      final author = decodedResponse['author'];
      
      // Create a map to return the required fields
      final memeData = {
        'title': title,
        'url': url,
        'author': author,
      };
      
      return memeData;
    } else {
      throw Exception('Failed to load meme');
    }
  }


}
