import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:getxfire/getxfire.dart';

class CartController extends GetxController {
  final dynamic data;
  final dynamic index;
  CartController({
    required this.data,
    required this.index,
  });

  ProductController _productController = Get.put(ProductController());
  UserInfoFirebase _userInfoFirebase = Get.put(UserInfoFirebase());
  late final String productId = data;
  late final int productIndex = index[0];

  Future addToCart() {
    return _userInfoFirebase.cartData.doc(productId).set({
      'name': _productController.productList[productIndex]['product_type'],
      'price': _productController.productList[productIndex]['price'],
      'category': _productController.productList[productIndex]['category'],
      'image': _productController.productList[productIndex]['image_link'],
      'quantity': "1"
    });
  }
}
