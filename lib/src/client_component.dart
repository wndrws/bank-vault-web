import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:bank_vault/src/routing/route_paths.dart';
import 'package:bank_vault/src/services/user_service.dart';

@Component(
  selector: 'client-component',
  styleUrls: ['client_component.css'],
  templateUrl: 'client_component.html',
)
class ClientComponent implements OnInit {
  final UserService _userService;
  final Router _router;

  ClientComponent(this._userService, this._router);

  @override
  void ngOnInit() {
    print("current user id = ${_userService.currentUserId}");
  }

  void logout() {
    print("LOGGED OUT");
    _userService.reset();
  }
}