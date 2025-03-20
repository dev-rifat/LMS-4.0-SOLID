import 'package:get/get.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../global/view/widget/success_message.dart';
import '../../../global/view/widget/warning_message.dart';
import 'package:hive/hive.dart';
import '../hive/hive_object.dart';




class WishlistController extends GetxController {
  late Box<AddToCartItem> wishlistBox;

  @override
  void onInit() async {
    super.onInit();
    // Ensure the box is opened before accessing it
    try {
      wishlistBox = await Hive.openBox<AddToCartItem>(wishListTableKey);
    } catch (e) {
      print('Error opening wishlist box: $e');
    }
  }

  void addItem({
    required int id,
    required String name,
    required String rent,
    required String bedroom,
    required String img,
  }) {
    try {
      // Check if an item with the same id already exists
      final exists = wishlistBox.values.any((item) => item.id == id);
      if (exists) {
        print('Item with id $id already exists in the wishlist');
        showWarningMessage(message: "Already exists in the cart");
        return;
      }

      final item = AddToCartItem(id: id, name: name, price: rent,time:bedroom ,img: img);
      wishlistBox.add(item);
      update(); // Notify listeners
      print('Item added: ${item.name}');
      showSuccessMessage(message: "Added Successfully");
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  void deleteItem(int id) {
    try {
      final index = wishlistBox.values.toList().indexWhere((item) => item.id == id);
      if (index != -1) {
        wishlistBox.deleteAt(index);
        update(); // Notify listeners
        print('Item deleted with id: $id');
        showSuccessMessage(message: "Wishlist Remove Successfully");

      } else {
        print('Item with id $id not found');
      }
    } catch (e) {
      print('Error deleting item with id $id: $e');
    }
  }

  void clearStorage() {
    try {
      wishlistBox.clear();
      update(); // Notify listeners
      print('All wishlist items cleared');
    } catch (e) {
      print('Error clearing wishlist: $e');
    }
  }

}







