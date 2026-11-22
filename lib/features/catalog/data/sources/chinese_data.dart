import 'package:fooddeliveryapp/features/catalog/data/models/chinese_model.dart';

List<ChineseModel> getChinese() {
  List<ChineseModel> chinese = [];
  ChineseModel chineseModel = ChineseModel();

  chineseModel.name = "Chicken Manchurian";
  chineseModel.image = "images/Chinese1.png";
  chineseModel.price = "450";
  chineseModel.description =
  "Tender chicken pieces cooked in a rich Manchurian sauce with garlic, ginger, and vegetables. Served hot with a delicious blend of sweet and spicy flavors.";
  chinese.add(chineseModel);

  chineseModel = ChineseModel();

  chineseModel.name = "BBQ Chinese Chicken";
  chineseModel.image = "images/Chinese2.png";
  chineseModel.price = "350";
  chineseModel.description =
  "Juicy BBQ chicken tossed with Chinese-style seasonings and fresh vegetables, offering a smoky and savory taste in every bite.";
  chinese.add(chineseModel);

  chineseModel = ChineseModel();

  chineseModel.name = "Thai Chinese Chicken";
  chineseModel.image = "images/Chinese3.png";
  chineseModel.price = "350";
  chineseModel.description =
  "A flavorful fusion of Thai and Chinese cuisines, prepared with tender chicken, fresh vegetables, and aromatic spices for a unique taste.";
  chinese.add(chineseModel);

  chineseModel = ChineseModel();

  chineseModel.name = "Chicken Shashlik";
  chineseModel.image = "images/Chinese4.png";
  chineseModel.price = "350";
  chineseModel.description =
  "Succulent chicken cubes stir-fried with colorful bell peppers, onions, and tangy shashlik sauce. Perfectly balanced sweet and savory flavors.";
  chinese.add(chineseModel);

  return chinese;
}