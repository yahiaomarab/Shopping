import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/models/userlogin.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class homescreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<shopcubit,shopappstate>(
        listener: (context,state){
        // if(state is favoritessucessstate)
          //             {
          //              if(!state.changefavmodel.status!)
          //                 {
          //                   toastmassage(massege: state.changefavmodel.message!, state: ToastState.Erorr);
          //                 }
          //             }
        },
        builder:(context,state)=>ConditionalBuilder
          (
            condition:shopcubit.get(context).homeee!=null&&shopcubit.get(context).catmodel!=null,
            builder: (context)=>productsbuilder(shopcubit.get(context).homeee!,context,shopcubit.get(context).catmodel!),
            fallback:(context)=> Center(child: CircularProgressIndicator(),),
        ),
      );
  }
Widget productsbuilder (HomeModel model,context,CategoriesModel modil)
{
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model.data!.banners.map((e) =>
                Image(
              image:
            NetworkImage(
              '${e.image}',
            ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            ).toList() ,
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildcategories(modil.data!.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 10,),
                  itemCount: modil.data!.data.length,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1/1.7,
            children:
              List.generate(
                  model.data!.products.length,
                      (index) => buildgridproduct(model.data!.products[index],context),
              ),

          ),
        ),
      ],
    ),
  );
}
Widget buildgridproduct (ProductModel model,context)
{
  return  ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image(image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),

                Row(children: [
                  if(model.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red[300],
                      child: Text(
                        'OFFER !',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  Spacer(),
                  IconButton(onPressed: (){
                    shopcubit.get(context).changeFav(model.id);
                    print(model.id);
                  },
                      icon: Icon(
                        shopcubit.get(context).favorites[model.id]! ? Icons.favorite :Icons.favorite_border,
                        color: shopcubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                      ))
                ],)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(children: [
                    Spacer(),
                    if(model.discount != 0)
                      Text(
                        '\$ ${model.oldPrice}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough

                        ),
                      ),
                    if(model.discount ==0)
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough

                        ),
                      )
                  ],),
                  Row(children: [
                    Text(
                      'Price',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16,color: Colors.grey[600]),
                    ),
                    Spacer(),
                    Text(
                      '\$ ${model.price}',
                      style: TextStyle(
                          fontSize: 16,
                          color: defaultcolor

                      ),
                    )
                  ],),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
Widget buildcategories(DataModel model,)
{
  return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: 100,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
}
}
//shopcubit.get(context).favorites[model.id]! ?  dafultcolor:

