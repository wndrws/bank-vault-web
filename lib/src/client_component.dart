import 'package:angular/angular.dart';
import 'package:bank_vault/src/services/user_service.dart';

@Component(
  selector: 'client-component',
  styleUrls: ['client_component.css'],
  templateUrl: 'client_component.html',
)
class ClientComponent implements OnInit {
  final UserService _userService;

  ClientComponent(this._userService);

  @override
  void ngOnInit() {
    print("current user id = ${_userService.currentUserId}");
  }
}