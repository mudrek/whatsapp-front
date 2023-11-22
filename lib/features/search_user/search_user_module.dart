import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/search_user/data/datasources/search_user_datasource.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/usecases/search_user_usecases.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/reducers/search_user_reducer.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/search_user_page.dart';

class SearchUserModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<SearchUserDatasource>(SearchUserDatasourceImpl.new);
    i.addSingleton<SearchUserUsecases>(SearchUserUsecasesImpl.new);
    i.addSingleton<SearchUserReducer>(SearchUserReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SearchUserPage(),
      transition: TransitionType.downToUp,
    );
  }
}
