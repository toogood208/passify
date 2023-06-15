import 'package:passify/core/services/category_service.dart';
import 'package:passify/core/services/password_service.dart';
import 'package:passify/ui/views/add_password/add_password.dart';
import 'package:passify/ui/views/category/category.dart';
import 'package:passify/ui/views/home_view/home_view.dart';
import 'package:passify/ui/views/start_up/start_up_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
@StackedApp(
  routes: [
    AdaptiveRoute(page: HomePage),
    AdaptiveRoute(page: CategoryView),
    AdaptiveRoute(page: AddNewPassword),
    AdaptiveRoute(page: StartUpView, initial: true)
  ],
  dependencies: [
    LazySingleton(classType: PasswordService),
    LazySingleton(classType: CategoryService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService)
  ],
  logger: StackedLogger(),

)
class App{}