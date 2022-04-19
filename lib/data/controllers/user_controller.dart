import 'package:get/get.dart';
import 'package:indulge_kitchen/data/models/response_model.dart';
import 'package:indulge_kitchen/data/models/user_model.dart';
import 'package:indulge_kitchen/data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    (response.statusCode == 200)
        ? {
            _userModel = UserModel.fromJson(response.body),
            _isLoading = true,
            responseModel = ResponseModel(true, 'Success')
          }
        : {responseModel = ResponseModel(false, response.statusText!)};
    update();
    return responseModel;
  }
}
