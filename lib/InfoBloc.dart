import 'package:hedy/BlocProvider.dart';
import 'package:hedy/Models/UserModel.dart';

class InfoBloc extends BlocBase {
  UserModel currentUser;

  String oneSignalUid;

  @override
  void dispose() {}
}
