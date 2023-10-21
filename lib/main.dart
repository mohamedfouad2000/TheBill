import 'package:ball/appcubit/appcubit.dart';
import 'package:ball/appcubit/appstates.dart';
import 'package:ball/home.dart';
import 'package:ball/shared/cashehelber.dart';
import 'package:ball/shared/components.dart';
import 'package:ball/start/strat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();
  await casheHelber.init();
  var start = casheHelber.getDataShared(key: 'start') ?? false;
  dark = casheHelber.getDataShared(key: 'dark') ?? false;

  print(start);
  print(dark);

  runApp(MyApp(start: start));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // MyApp({Key? key}) : super(key: key);
  bool start;
  MyApp({
    super.key,
    required this.start,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return homeCubit()..createData();
            },
          ),
        ],
        child: BlocConsumer<homeCubit, HomeStates>(
          builder: (BuildContext context, state) {
            return MaterialApp(
              // ignore: prefer_const_literals_to_create_immutables

              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar', ''), // arabic, no country code
              ],
              debugShowCheckedModeBanner: false,
              home: start ? const home() : const startpage(),
              // home: RawAutocompleteSplit(),
              themeMode: dark ? ThemeMode.dark : ThemeMode.light,

              theme: lightthem,
              darkTheme: ThemeData.dark().copyWith(
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.orange,
                    // ignore: prefer_const_constructors
                    titleTextStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    elevation: 0.0,
                    // ignore: deprecated_member_use
                    // backwardsCompatibility: false,
                    // ignore: prefer_const_constructors
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light,
                    )),
                // primaryColorDark: Colors.amber,
                //  primarySwatch: Colors.green,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,

                  backgroundColor: Colors.grey,
                  // ignore: prefer_const_constructors
                  selectedIconTheme: IconThemeData(color: Colors.black),
                ),
              ),
              locale: const Locale('ar', ''),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }

  ThemeData lightthem = ThemeData(
    primarySwatch: Colors.orange,
    // fontFamily: 'Foush',
    fontFamily: 'siu',
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      bodyLarge: const TextStyle(fontSize: 20, color: Colors.white),
      displayLarge: const TextStyle(fontSize: 15, color: Colors.white),
      labelSmall: const TextStyle(fontSize: 10, color: Colors.white),
    ),
    // ignore: prefer_const_constructors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        elevation: 0.0,
        // ignore: deprecated_member_use
        // backwardsCompatibility: false,
        // ignore: prefer_const_constructors
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        )),
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red),
  );

  ThemeData darkmode = ThemeData(
    // fontFamily: 'Foush',
    fontFamily: 'siu',
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      // ignore: prefer_const_constructors
      bodyLarge: TextStyle(fontSize: 20, color: Colors.white),
      displayLarge: const TextStyle(fontSize: 15, color: Colors.white),
      labelSmall: const TextStyle(fontSize: 10, color: Colors.white),
    ),
    // ignore: prefer_const_constructors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        elevation: 0.0,
        // ignore: deprecated_member_use
        // backwardsCompatibility: false,
        // ignore: prefer_const_constructors
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        )),
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.orange,
      // ignore: prefer_const_constructors
      selectedIconTheme: IconThemeData(color: Colors.orange),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
        .copyWith(background: Colors.orange),
  );
}
