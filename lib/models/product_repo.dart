import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsRepo {
  var url = "http://makeup-api.herokuapp.com/api/v1/products.json?brand=l'oreal";

  loadProductsFromApi() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
}