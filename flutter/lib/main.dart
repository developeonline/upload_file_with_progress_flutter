import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/util/constants.dart';
import 'core/util/helper_function.dart';
import 'core/util/route_generator.dart';
import 'features/users/presentation/providers/users/users_provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); /* To Fix the Error: Flutter: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse */
  await di.init();
  await storeToken(token: Constants.APP_TOKEN_VALUE);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(
            create: (_) => di.sl<UsersProvider>()
        ),
      ],
      child: MaterialApp(
        title: 'Upload Percentage',
         initialRoute: Constants.HomeRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

}