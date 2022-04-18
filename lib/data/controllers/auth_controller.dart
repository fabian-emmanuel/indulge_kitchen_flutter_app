import 'package:get/get.dart';
import 'package:indulge_kitchen/data/models/response_model.dart';
import 'package:indulge_kitchen/data/models/sign_up_model.dart';
import 'package:indulge_kitchen/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpModel model) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(model);
    late ResponseModel responseModel;
    print(response.statusCode);
    (response.statusCode == 200)
        ? {
            print('got here'),
            authRepo.saveUserToken(response.body['token']),
            responseModel = ResponseModel(true, response.body['token'])
          }
        : {responseModel = ResponseModel(false, response.statusText!)};
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserEmailAndPassword(String email, String password) async {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    (response.statusCode == 200)
        ? {
            authRepo.saveUserToken(response.body['token']),
            responseModel = ResponseModel(true, response.body['token'])
          }
        : {responseModel = ResponseModel(false, response.statusText!)};
    _isLoading = false;
    update();
    return responseModel;
  }
}
