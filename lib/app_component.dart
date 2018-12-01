import 'package:angular/angular.dart';
import 'package:bank_vault/src/client_component.dart';
import 'package:bank_vault/src/login_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [ClientComponent, LoginComponent],
)
class AppComponent {
  // Nothing here yet.
}
