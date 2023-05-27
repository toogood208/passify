import 'package:passify/core/services/password_service.dart';
import 'package:passify/ui/views/add_password/add_password.dart';
import 'package:passify/ui/views/category/category.dart';
import 'package:passify/ui/views/home_view/home.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
@StackedApp(
  routes: [
    AdaptiveRoute(page: HomePage),
    AdaptiveRoute(page: CategoryView),
    AdaptiveRoute(page: AddNewPassword),
  ],
  dependencies: [
    LazySingleton(classType: PasswordService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService)
  ],
  logger: StackedLogger(),

)
class App{}