import 'package:passify/app/app.locator.dart';
import 'package:passify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUPViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void goToHomePage() {
    _navigationService.clearStackAndShow(Routes.homePage);
  }
}
