import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_cubit.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/home/home_model.dart';
import '../../data/repositories/home_repository/home_data_repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit():super(IntialState());
  static HomeCubit get(context)=>BlocProvider.of(context);

  final homeRepository =
  HomeRepository(ApiService());
  HomeModel? homeModel;

  void getHomeData(context) async {
    emit(GettingHomeDataLoading());
    try {
      homeModel = await homeRepository.getHomeData();
      for (var element in homeModel!.data!.products) {
       FavouriteCubit.get(context).FavoritesProducts.addAll({element.id!: element.inFavorites!});
      }
      print(FavouriteCubit.get(context).FavoritesProducts.toString());
      emit(GettingHomeDataSuccess());
    } catch (erorr) {
      emit(GettingHomeDataErorr(erorr.toString()));
    }
  }


}