import 'package:fooddeliveryapp/features/catalog/data/models/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];
  BurgerModel burgerModel = BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger1.png";
  burgerModel.price = "450";
  burgerModel.description =
  "A delicious juicy burger loaded with melted cheese, fresh lettuce, tomatoes, onions, and our special creamy sauce. Served in a soft toasted bun for a rich and cheesy taste in every bite.";
  burger.add(burgerModel);

  burgerModel = BurgerModel();

  burgerModel.name = "Zinger Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "350";
  burgerModel.description =
  "A crispy and spicy chicken fillet burger prepared with fresh lettuce, creamy mayonnaise, and our signature sauce. Packed inside a soft toasted bun for the perfect crunchy and flavorful experience.";
  burger.add(burgerModel);

  burgerModel = BurgerModel();

  burgerModel.name = "Beef Burger";
  burgerModel.image = "images/burger3.png";
  burgerModel.price = "250";
  burgerModel.description =
  "A tender and juicy beef patty seasoned with flavorful spices, topped with fresh lettuce, tomatoes, onions, and delicious burger sauce. Served in a soft bun for a satisfying and meaty taste.";
  burger.add(burgerModel);

  burgerModel = BurgerModel();

  burgerModel.name = "Chicken Burger";
  burgerModel.image = "images/burger4.png";
  burgerModel.price = "150";
  burgerModel.description =
  "A perfectly cooked chicken patty combined with fresh vegetables, creamy mayonnaise, and special burger sauce. Served in a soft toasted bun for a simple, fresh, and delicious meal.";
  burger.add(burgerModel);

  return burger;
}