class Product {
  String id;
  String productName;
  List<dynamic> imageList;
  String category;
  List<dynamic> sizeList;
  List<dynamic> colorList;
  String price;
  String salePrice;
  String quantity;
  String quantityMain;
  String description;
  double rating;
  String image;
  String size;
  int color;
  Product(
      {this.id,
      this.productName,
      this.imageList,
      this.image,
      this.category,
      this.sizeList,
      this.size,
      this.colorList,
      this.color,
      this.price,
      this.salePrice,
      this.quantity,
      this.quantityMain,
      this.description,
      this.rating});
}
