import 'package:get/get.dart';
import 'package:indulge_kitchen/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
}
