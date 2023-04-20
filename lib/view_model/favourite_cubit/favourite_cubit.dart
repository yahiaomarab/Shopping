import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/favourite_cubit/favourite_states.dart';
import '../../data/data_resource/api_service.dart';
import '../../data/models/favourite/change_favourite_model.dart';
import '../../data/models/favourite/favourite_model.dart';
import '../../data/repositories/favourite_repository/favourite_repository.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(IntialState());
  static FavouriteCubit get(context) => BlocProvider.of(context);

  ChangingProductFavouriteModel? _changingProductFavouriteModel;
  Map<int, bool> FavoritesProducts = {};
  final favouriteRopsitory = FavouriteRepository(ApiService());
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

  changeProductFavourite(int id) {
    FavoritesProducts[id] = !FavoritesProducts[id]!;
    emit(ChangingProductFavouriteLoading());
    try {
      _changingProductFavouriteModel =
          favouriteRopsitory.changeFavouriteData(id);
      emit(ChangingProductFavouriteSuccess());
      if (_changingProductFavouriteModel!.status == false) {
        FavoritesProducts[id] = !FavoritesProducts[id]!;
      } else {
        getFavouriteProductData();
      }
    } catch (error) {
      emit(ChangingProductFavouriteErorr(error.toString()));
      FavoritesProducts[id] = !FavoritesProducts[id]!;
    }
  }
}
