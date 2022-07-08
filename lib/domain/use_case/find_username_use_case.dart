import 'package:chess_flutter/domain/repo/user_repo.dart';
import 'package:chess_flutter/models/user.dart';

class FindUsernameUseCase {
  final UserRepo userRepo;
  FindUsernameUseCase(this.userRepo);

  Future<List<User>> execute(String searchFeed) async {
    return userRepo.findUserById(searchFeed);
  }
}
