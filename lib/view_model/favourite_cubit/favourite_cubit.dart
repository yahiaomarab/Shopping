import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/favourite/change_favourite_model.dart';
import '../../data/models/favourite/favourite_model.dart';
import '../../data/repositories/favourite_repository/favourite_repository.dart';

class FavouriteCubit extends Cubit<FavouriteStates>
{
  FavouriteCubit():super(IntialState());
  static FavouriteCubit get(context)=>BlocProvider.of(context);

  ChangingProductFavouriteModel? _changingProductFavouriteModel;
  Map<int, bool> FavoritesProducts = {};
  final favouriteRopsitory =
  FavouriteRepository(ApiService());
  FavouriteModel? favouriteModel;

  void getFavouriteProductData() async {
    emit(GettingFavouriteProductDataLoading());
    try {
      favouriteModel = await favouriteRopsitory.getFavouriteData();
      emit(GettingFavouriteProductDataSuccess());
    } catch (error) {
      emit(GettingFavouriteProductDataErorr(error.toString()));
    }
  }

  changeProductFavourite(int ProductId) {
    emit(ChangingProductFavouriteLoading());
    checkProductFavourite(ProductId);
    try {
      _changingProductFavouriteModel =
          favouriteRopsitory.changeFavouriteData(ProductId);
      if (_changingProductFavouriteModel!.status == false) {
        checkProductFavourite(ProductId);
      } else {
        getFavouriteProductData();
      }
    } catch (error) {
      checkProductFavourite(ProductId);
      emit(ChangingProductFavouriteErorr(error.toString()));
    }
  }

  void checkProductFavourite(int ProductId) {
    if (FavoritesProducts[ProductId] == true) {
      FavoritesProducts[ProductId] = false;
      emit(ChangingProductFavouriteSuccess());
    } else {
      FavoritesProducts[ProductId] = true;
      emit(ChangingProductFavouriteSuccess());
    }
  }
}