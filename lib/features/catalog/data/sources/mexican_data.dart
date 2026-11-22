import 'package:fooddeliveryapp/features/catalog/data/models/mexican_model.dart';

List<MexicanModel> getMexican() {
  List<MexicanModel> mexican = [];
  MexicanModel mexicanModel = MexicanModel();

  mexicanModel.name = "Chicken Tacos";
  mexicanModel.image = "images/tacos1.png";
  mexicanModel.price = "400";
  mexicanModel.description =
  "Soft tortillas filled with juicy chicken, fresh lettuce, cheese, and flavorful Mexican sauce. A perfect combination of taste and texture.";
  mexican.add(mexicanModel);

  mexicanModel = MexicanModel();

  mexicanModel.name = "Beef Burrito";
  mexicanModel.image = "images/tacos2.png";
  mexicanModel.price = "550";
  mexicanModel.description =
  "A large tortilla wrap stuffed with seasoned beef, rice, beans, cheese, and fresh vegetables, offering a rich and satisfying meal.";
  mexican.add(mexicanModel);

  mexicanModel = MexicanModel();

  mexicanModel.name = "Chicken Quesadilla";
  mexicanModel.image = "images/tacos3.png";
  mexicanModel.price = "500";
  mexicanModel.description =
  "Grilled tortilla filled with tender chicken and melted cheese, served crispy on the outside and deliciously cheesy on the inside.";
  mexican.add(mexicanModel);

  mexicanModel = MexicanModel();

  mexicanModel.name = "Nachos Supreme";
  mexicanModel.image = "images/tacos4.png";
  mexicanModel.price = "450";
  mexicanModel.description =
  "Crunchy nachos topped with melted cheese, jalapeños, fresh vegetables, and special Mexican sauce for a bold and flavorful taste.";
  mexican.add(mexicanModel);

  return mexican;
}