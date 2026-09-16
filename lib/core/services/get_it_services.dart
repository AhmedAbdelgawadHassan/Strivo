import 'package:get_it/get_it.dart';
import 'package:strivo/core/services/firebase_auth_services.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/data/repos/auth_repo_impl.dart';

final getIt = GetIt.instance;

void setup() {
getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
getIt.registerSingleton<AuthRepo>(AuthRepoImpl(firebaseAuthServices: FirebaseAuthServices()));
}