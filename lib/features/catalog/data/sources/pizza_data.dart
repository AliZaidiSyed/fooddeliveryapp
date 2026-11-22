import 'package:fooddeliveryapp/features/catalog/data/models/pizza_model.dart';

List<PizzaModel> getPizza() {
  List<PizzaModel> pizza = [];
  PizzaModel pizzaModel = PizzaModel();

  pizzaModel.name = "Cheese Pizza";
  pizzaModel.image = "images/pizza1.png";
  pizzaModel.price = "50";
  pizzaModel.description =
  "Loaded with extra mozzarella cheese, fresh vegetables, and a perfectly baked crispy crust. Every bite delivers a rich cheesy flavor that makes this pizza a favorite for cheese lovers.";
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = "Tikka Pizza";
  pizzaModel.image = "images/pizza2.png";
  pizzaModel.price = "80";
  pizzaModel.description =
  "Topped with juicy chicken tikka pieces, melted mozzarella cheese, onions, and flavorful spices. This pizza combines traditional tikka taste with a delicious Italian-style crust.";
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = "Creamy Pizza";
  pizzaModel.image = "images/pizza3.png";
  pizzaModel.price = "90";
 pizzaModel.description =
  "Prepared with a rich and creamy sauce, premium cheese, and carefully selected toppings. Its smooth texture and satisfying flavor make it a perfect choice for a hearty meal.";
  pizza.add(pizzaModel);

  pizzaModel = PizzaModel();
  pizzaModel.name = "Beef Pizza";
  pizzaModel.image = "images/pizza4.png";
  pizzaModel.price = "100";
  pizzaModel.description =
 "Made with tender seasoned beef, fresh vegetables, and a generous layer of melted cheese. Baked until golden brown, it offers a bold and savory taste in every slice.";
  pizza.add(pizzaModel);

  return pizza;
}