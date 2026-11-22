import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/catalog_provider.dart';
import 'package:fooddeliveryapp/features/catalog/data/models/burger_model.dart';
import 'package:fooddeliveryapp/features/catalog/data/models/category_model.dart';
import 'package:fooddeliveryapp/features/catalog/data/models/chinese_model.dart';
import 'package:fooddeliveryapp/features/catalog/data/models/mexican_model.dart';
import 'package:fooddeliveryapp/features/catalog/data/models/pizza_model.dart';
import 'package:fooddeliveryapp/features/catalog/screens/detail_page.dart';
import 'package:fooddeliveryapp/features/catalog/data/sources/burger_data.dart';
import 'package:fooddeliveryapp/features/catalog/data/sources/category_data.dart';
import 'package:fooddeliveryapp/features/catalog/data/sources/chinese_data.dart';
import 'package:fooddeliveryapp/features/catalog/data/sources/mexican_data.dart';
import 'package:fooddeliveryapp/features/catalog/data/sources/pizza_data.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';


class Home extends StatefulWidget {
  const Home ({super.key});
  @override
  State<Home> createState() => _HomeState();

}
class _HomeState extends State<Home> {
  final CatalogProvider _catalogProvider = CatalogProvider();


  List<CategoryModel> categories=[];
  List<PizzaModel> pizza=[];
  List<BurgerModel> burger=[];
  List<ChineseModel> chinese = [];
  List<MexicanModel> mexican = [];


  TextEditingController searchController=TextEditingController();




  @override
  void initState () {
    super.initState();
    categories=getCategories();

    pizza=getPizza();
    burger=getBurger();
    chinese=getChinese();
    mexican=getMexican();
  }





  void searchFood(String query) {
    _catalogProvider.search(query, [...pizza, ...burger, ...chinese, ...mexican]);
  }

  @override
  void dispose() {
    searchController.dispose();
    _catalogProvider.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    return ChangeNotifierProvider<CatalogProvider>.value(
      value: _catalogProvider,
      child: Consumer<CatalogProvider>(
        builder: (context, catalogState, child) {
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
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: HotFlavourColors.softRed),
                  boxShadow: [
                    BoxShadow(
                      color: HotFlavourColors.deepRed.withOpacity(0.07),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: HotFlavourColors.primary, size: 26),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: searchFood,
                        textInputAction: TextInputAction.search,
                        style: const TextStyle(fontSize: 15, color: HotFlavourColors.ink),
                        decoration: const InputDecoration(
                          hintText: 'What are you craving?',
                          hintStyle: TextStyle(color: HotFlavourColors.muted),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    if (catalogState.isSearching)
                      IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(Icons.close_rounded, color: HotFlavourColors.primary),
                        onPressed: () {
                          searchController.clear();
                          searchFood('');
                        },
                      ),
                  ],
                ),
              ),
        //search logic

     if(   catalogState.isSearching)
       Expanded(


         child: catalogState.results.isEmpty
           ? const Center(
               child: Text("No matching food found",
                 style: TextStyle(color: HotFlavourColors.muted, fontSize: 16)),
             )
           : ListView.builder(

           itemCount: catalogState.results.length,
           itemBuilder: (context, index) {
             final item = catalogState.results[index];
             return Container(
               margin: const EdgeInsets.only(right: 20, bottom: 12),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(18),
                 border: Border.all(color: HotFlavourColors.softRed),
                 boxShadow: [
                   BoxShadow(
                     color: HotFlavourColors.deepRed.withOpacity(0.05),
                     blurRadius: 12,
                     offset: const Offset(0, 4),
                   ),
                 ],
               ),
               child: InkWell(
                 borderRadius: BorderRadius.circular(18),
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     DetailPage(image: item.image, name: item.name,
                       price: item.price, description: item.description)));
                 },
                 child: Padding(
                   padding: const EdgeInsets.all(12),
                   child: Row(
                     children: [
                       Container(
                         height: 74,
                         width: 74,
                         padding: const EdgeInsets.all(6),
                         decoration: BoxDecoration(
                           color: HotFlavourColors.cream,
                           borderRadius: BorderRadius.circular(14),
                         ),
                         child: Image.asset(item.image, fit: BoxFit.contain),
                       ),
                       const SizedBox(width: 12),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(item.name ?? '',
                               maxLines: 2, overflow: TextOverflow.ellipsis,
                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                 color: HotFlavourColors.ink)),
                             const SizedBox(height: 7),
                             Text('\$${item.price}',
                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                                 color: HotFlavourColors.primary)),
                           ],
                         ),
                       ),
                       const SizedBox(width: 8),
                       const CircleAvatar(
                         radius: 17,
                         backgroundColor: HotFlavourColors.primary,
                         child: Icon(Icons.arrow_forward_ios_rounded,
                           color: Colors.white, size: 15),
                       ),
                     ],
                   ),
                 ),
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
       catalogState.selectedCategory == '0' ? Expanded(
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
       ) : catalogState.selectedCategory == '1' ? Expanded(
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

       ) : catalogState.selectedCategory =='2'  ? Expanded(
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
       ):catalogState.selectedCategory =='3'  ? Expanded(
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
                decoration: BoxDecoration(color: HotFlavourColors.primary,
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
        _catalogProvider.selectCategory(categoryindex);

      },
      child: _catalogProvider.selectedCategory ==categoryindex ?
      Container(

        margin: EdgeInsets.only(right:20.0, bottom: 10.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(30),

          child: Container(
            padding: EdgeInsets.only(left: 20.0, right:20.0),

            decoration: BoxDecoration(color:HotFlavourColors.primary,borderRadius: BorderRadius.circular(30.0)),
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
            color: HotFlavourColors.cream,
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



