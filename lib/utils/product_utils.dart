class ProductUtils {
  static String getProductImage(String productName) {
    final images = {
      'Tomato': 'assets/tomato.jpg',
      'Carrot': 'assets/productImages/carrots.jpg',
      'Brinjal': 'assets/productImages/brinjal.jpg',
      'Potato': 'assets/productImages/potatoes.jpg',
      'Onion': 'assets/productImages/red_onions.jpg',
      'Avocado': 'assets/productImages/avocado.jpg',
      'Banana': 'assets/productImages/bananas.jpg',
      'Guava': 'assets/productImages/guava.jpg',
      'Mango': 'assets/productImages/mango.jpg',
      'Papaya': 'assets/productImages/papaya.jpg',
      'Watermelon': 'assets/productImages/watermelon.jpg',
      'Pineapple': 'assets/productImages/pineapple.jpg',
    };
    
    for (final key in images.keys) {
      if (productName.toLowerCase().contains(key.toLowerCase())) {
        return images[key]!;
      }
    }
    
    return 'assets/productImages/default_product.png';
  }
}