import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:bank_vault/src/routing/routes.dart';
import 'package:bank_vault/src/services/cell_application_service.dart';
import 'package:bank_vault/src/services/cell_table_service.dart';
import 'package:bank_vault/src/services/local_user_storage.dart';
import 'package:bank_vault/src/services/manager_service.dart';
import 'package:bank_vault/src/services/modal_forms_service.dart';
import 'package:bank_vault/src/services/payment_service.dart';
import 'package:bank_vault/src/services/precious_manipulation_service.dart';
import 'package:bank_vault/src/services/user_service.dart';
import 'package:bank_vault/src/services/web_time_service.dart';

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [routerDirectives],
    providers: [
      ClassProvider(UserService),
      ClassProvider(LocalUserStorage),
      ClassProvider(WebTimeService),
      ClassProvider(CellTableService),
      ClassProvider(CellApplicationService),
      ClassProvider(ModalFormsService),
      ClassProvider(PaymentService),
      ClassProvider(PreciousManipulationService),
      ClassProvider(ManagerService)
    ],
    exports: [Routes])
class AppComponent {
      // AngularDart info: https://webdev.dartlang.org/angular
      // Components info: https://webdev.dartlang.org/components
}
