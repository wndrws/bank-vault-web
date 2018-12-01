import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:bank_vault/src/routing/routes.dart';
import 'package:bank_vault/src/services/user_service.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  providers: [ClassProvider(UserService)],
  exports: [Routes]
)
class AppComponent {
  // Nothing here yet.
}
