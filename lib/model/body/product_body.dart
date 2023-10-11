class ProductBody {
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? images;

  ProductBody({
    this.title,
    this.price,
    this.description,
    this.categoryId,
    this.images,
  });

  factory ProductBody.fromJson(Map<String, dynamic> json) => ProductBody(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        categoryId: json["categoryId"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}
