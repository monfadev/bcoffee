import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bcoffee/bloc/products_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/blocs.dart';
import 'services/services.dart';
import 'ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageBloc()),
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(create: (context) => ThemeBloc()),
            BlocProvider(create: (context) => ProductsBloc()..add(FetchProducts())),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => MaterialApp(
                    theme: themeState.themeData,
                    debugShowCheckedModeBanner: false,
                    home: Wrapper(),
                  ))),
    );
  }
}
