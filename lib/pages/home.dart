import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/ui_refresh_provider.dart';
import 'package:fooddeliveryapp/model/burger_model.dart';
import 'package:fooddeliveryapp/model/category_model.dart';
import 'package:fooddeliveryapp/model/chinese_model.dart';
import 'package:fooddeliveryapp/model/mexican_model.dart';
import 'package:fooddeliveryapp/model/pizza_model.dart';
import 'package:fooddeliveryapp/pages/detail_page.dart';
import 'package:fooddeliveryapp/services/burger_data.dart';
import 'package:fooddeliveryapp/services/category_data.dart';
import 'package:fooddeliveryapp/services/chinese_data.dart';
import 'package:fooddeliveryapp/services/mexican_data.dart';
import 'package:fooddeliveryapp/services/pizza_data.dart';
import 'package:fooddeliveryapp/services/widget_support.dart';


class Home extends StatefulWidget {
  const Home ({super.key});
  @override
  State<Home> createState() => _HomeState();

}
class _HomeState extends State<Home> {
  final UiRefreshProvider _uiRefreshProvider = UiRefreshProvider();


  String track='0';
  List<CategoryModel> categories=[];
  List<PizzaModel> pizza=[];
  List<BurgerModel> burger=[];
  List<ChineseModel> chinese = [];
  List<MexicanModel> mexican = [];


  TextEditingController searchController=TextEditingController();
  List<dynamic>  searchresults=[];




  @override
  void initState () {
    super.initState();
    categories=getCategories();

    pizza=getPizza();
    burger=getBurger();
    chinese=getChinese();
    mexican=getMexican();
    searchresults=[...pizza,...burger,...chinese, ...mexican];
  }





  void searchFood(String query) {

    if(query.isEmpty){

      searchresults=[];
      _uiRefreshProvider.refresh();

      return;
    }


    final allFoods = [
      ...pizza,
      ...burger,
      ...chinese,
      ...mexican
    ];




    final suggestions = allFoods.where((item){


      String foodName="";


      if(item is PizzaModel){

        foodName=item.name ?? "";

      }

      else if(item is BurgerModel){

        foodName=item.name ?? "";

      }

      else if(item is ChineseModel){

        foodName=item.name ?? "";

      }

      else if(item is MexicanModel){

        foodName=item.name ?? "";

      }






      return foodName
          .toLowerCase()
          .contains(query.toLowerCase());


    }).toList();



    searchresults=suggestions;
    _uiRefreshProvider.refresh();


  }




  @override
  Widget build (BuildContext context) {
    return ChangeNotifierProvider<UiRefreshProvider>.value(
      value: _uiRefreshProvider,
      child: Consumer<UiRefreshProvider>(
        builder: (context, refreshProvider, child) {
          return Scaffold(
      body: SafeArea(
        child: Container(
        margin: EdgeInsets.only(left: 10.0,top: 40.0),
          child:Column(
            children :[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Image.asset(
                      "images/logo1.png",
                      height:70,
                      width:130,
                        fit:BoxFit.contain,
                    ),
                      Text('Order your favourite food', style:AppWidget.SimpleTextField()),
                      
                    ],
                  ),
                  Padding(
                    padding:EdgeInsets.only(right:20.0),
                    child: ClipRRect (
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset (
                      "images/Hat.png",
                        height:90,
                        width:90,
                        fit: BoxFit.contain,


                    ),
                  ),
                  ),
        ],
      ),
              SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(

                      padding: EdgeInsets.only(left:10.0),
                      margin: EdgeInsets.only(right:20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: searchFood,
                        decoration: InputDecoration(border:InputBorder.none,
                          hintText: "Search Food Items",

                        ),
                      ),
                    ),
                  ),


                  searchController.text.isEmpty?Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                          Icons.search, color: Colors.white, size: 30.0),
                    ): GestureDetector(
                    onTap: (){
                      searchController.clear();
                      searchresults=[];
                      _uiRefreshProvider.refresh();

    },
                      child: Container(
                      margin: EdgeInsets.only(right: 20.0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                          Icons.close, color: Colors.white, size: 30.0),

    ),

                    )],
              ),
        //search logic

     if(   searchController.text.isNotEmpty)
       Expanded(


         child: ListView.builder(

           itemCount: searchresults.length,
           itemBuilder: (context, index) {
             final item = searchresults[index];
             return Container(
               margin: EdgeInsets.only(bottom: 15),
             child:  ListTile(
               leading: CircleAvatar(
                 child: Image.asset(item.image,fit: BoxFit.contain,),
               ),
               title: Text(item.name),
               subtitle: Text("Price, \$${item.price}"),
               onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     DetailPage(image: item.image,
                         name: item.name,
                         price: item.price,
                         description: item.description)));
               },
             ),
             


             );
           }


       ),


       )


else...{
       SizedBox(height: 20.0,),
       Container(
         height: 70,
         child: ListView.builder(
             shrinkWrap: true,
             scrollDirection: Axis.horizontal,
             itemCount: categories.length,
             itemBuilder: (context, index) {
               return CategoryTile(
                 categories[index].name!,
                 categories[index].image!,
                 index.toString(),
               );
             }
         ),
       ),
       SizedBox(height: 10.0),
       track == '0' ? Expanded(
         child: Container(
           margin: EdgeInsets.only(right: 10.0),
           child: GridView.builder(
               padding: EdgeInsets.zero,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 0.69,
                   mainAxisSpacing: 20.0,
                   crossAxisSpacing: 15.0),
               itemCount: pizza.length,
               itemBuilder: (context, index) {
                 return foodtile(
                   pizza[index].name!,
                   pizza[index].image!,
                   pizza[index].price!,
                   pizza[index].description!,);
               }),
         ),
       ) : track == '1' ? Expanded(
         child: Container(
           margin: EdgeInsets.only(right: 10.0),
           child: GridView.builder(
               padding: EdgeInsets.zero,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 0.69,
                   mainAxisSpacing: 20.0,
                   crossAxisSpacing: 15.0),
               itemCount: burger.length,
               itemBuilder: (context, index) {
                 return foodtile(
                   burger[index].name!,
                   burger[index].image!,
                   burger[index].price!,
                   burger[index].description!,
                 );
               }),
         ),

       ) : track=='2'  ? Expanded(
    child: Container(
    margin: EdgeInsets.only(right: 10.0),
    child: GridView.builder(
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.69,
    mainAxisSpacing: 20.0,
    crossAxisSpacing: 15.0),
    itemCount: chinese.length,
    itemBuilder: (context, index) {
    return foodtile(
    chinese[index].name!,
    chinese[index].image!,
    chinese[index].price!,
    chinese[index].description!,
    );
    }),
    ),
       ):track=='3'  ? Expanded(
    child: Container(
    margin: EdgeInsets.only(right: 10.0),
    child: GridView.builder(
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.69,
    mainAxisSpacing: 20.0,
    crossAxisSpacing: 15.0),
    itemCount: mexican.length,
    itemBuilder: (context, index) {
    return foodtile(
    mexican[index].name!,
    mexican[index].image!,
    mexican[index].price!,
    mexican[index].description!,
    );
    }),
    ),
       ):Container(),
    }
            ],


        ),
      ),
    ),
    );
        },
      ),
    );
  }

  Widget foodtile(String name,String image, String price, String description){
  return Container(
    margin: EdgeInsets.only(right:20.0),
    padding: EdgeInsets.only(left: 10.0,top: 10.0),
    decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Center(
        child:Image.asset(
          image,
          height: 100,
          width:100,
          fit: BoxFit.contain,),
        ),
        Text(name,style: AppWidget.boldTextFieldStyle(),),
        Text("\$" + price,style: AppWidget.priceTextFieldStyle(),),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            GestureDetector(
              onTap: () {

                Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailPage(image: image,name:name, price:price, description: description)));
              },

           child:  Container(
              height: 50,
              width: 80,
                decoration: BoxDecoration(color: Color(0xffef2b39),
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(10.0))),

              child: Icon(
                Icons.arrow_forward,
                color: Colors.white, size:20.0,
              ),
            ),
            ),

          ],
        )



      ],


  ),
    );

  }

  Widget CategoryTile (String name,String image, String categoryindex){

    return GestureDetector(
      onTap: (){
        track=categoryindex.toString();
                _uiRefreshProvider.refresh();

      },
      child: track==categoryindex ?
      Container(

        margin: EdgeInsets.only(right:20.0, bottom: 10.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(30),

          child: Container(
            padding: EdgeInsets.only(left: 20.0, right:20.0),

            decoration: BoxDecoration(color:Color(0xffef2b39),borderRadius: BorderRadius.circular(30.0)),
            child: Row(
              children: [
                Image.asset(image, width:50, height:50, fit:BoxFit.contain),

                // SizedBox(width: 10.0),
                Text(name, style: AppWidget.WhiteTextFieldStyle()),
              ],
            ),
          ),
        ),
      ):
      Container(
          padding: EdgeInsets.only(left: 20.0,right:20.0),
          margin: EdgeInsets.only(right:20.0,bottom: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFFececf8),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row (
            children: [
              Image.asset(image, width:50, height:50, fit:BoxFit.contain),

              //  SizedBox(width: 10.0),
              Text(name, style: AppWidget.SimpleTextField()),


            ],
          )
      ),
    );
  }}



