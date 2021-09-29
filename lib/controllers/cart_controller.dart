import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:getxfire/getxfire.dart';

class CartController extends GetxController {
  final dynamic index;

  CartController({
    this.index,
  });

  ProductController _productController = Get.put(
    ProductController(),
  );
  UserInfoFirebase _userInfoFirebase = Get.put(UserInfoFirebase());

  bool isSelected = false;
  bool hasCheckout = false;
  late final int productIndex = index;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectItem() {
    isSelected = !isSelected;
  }

  void checkoutItem() {
    hasCheckout = true;
  }

  void createOrder() {
    Stream<QuerySnapshot> snapshot = _userInfoFirebase.orderDone;
    int count = 0;

    snapshot.forEach((item) {
      int cartLength = item.docs.length;

      item.docs.forEach((doc) {
        final isSelected = doc.get('is_selected');

        final category = doc.get('category');
        final id = doc.get('id');
        final image = doc.get('image');
        final name = doc.get('name');
        final price = doc.get('price');
        final quantity = doc.get('quantity');

        if (isSelected == true) {
          count++;

          if (count - 1 <= cartLength) {
            _userInfoFirebase.orderData.doc().set({
              'id': id,
              'category': category,
              'name': name,
              'price': price,
              'image': image,
              'quantity': quantity,
              'order_created': DateTime.now()
            });

            removeFromCart(id);
          }
        }
      });
    });
  }

  Future removeFromCart(String pId) {
    return _userInfoFirebase.cartData.doc(pId).delete();
  }

  Future modifyItemQuantity(String productId, int quantity) async {
    return await _userInfoFirebase.cartData.doc(productId).set(
      {
        'quantity': quantity,
      },
      SetOptions(merge: true),
    );
  }

  void hasItemCheckout(String productId) async {
    checkoutItem();
    return await _userInfoFirebase.cartData.doc(productId).set(
      {
        'has_checkout': hasCheckout,
      },
      SetOptions(merge: true),
    );
  }

  Future isItemSelected(String productId) async {
    return await _userInfoFirebase.cartData.doc(productId).set(
      {
        'is_selected': isSelected,
      },
      SetOptions(merge: true),
    );
  }

  Future addToCart(int productNumber, int quantity) async {
    return await _userInfoFirebase.cartData
        .doc(_productController.productList[productNumber]['id'].toString())
        .set(
      {
        'id': _productController.productList[productNumber]['id'].toString(),
        'name': _productController.productList[productNumber]['product_type'],
        'price': double.parse(
            _productController.productList[productNumber]['price']),
        'category': _productController.productList[productNumber]['category'],
        'image': _productController.productList[productNumber]['image_link'],
        'quantity': quantity,
        'is_selected': isSelected,
        'timestamp': Timestamp.now()
      },
      SetOptions(merge: true),
    );
  }
}
