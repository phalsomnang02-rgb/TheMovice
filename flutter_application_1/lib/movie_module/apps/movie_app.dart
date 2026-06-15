// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/movie_module/logics/movie_theme_logic.dart';
// import '../screens/parent_screen.dart';
// import 'package:provider/provider.dart';

// class MovieApp extends StatelessWidget {
//   const MovieApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool dark = context.watch<MovieThemeLogic>().dark;
//     Color seedColor = Colors.deepOrange;
//     Color secondaryColor = Colors.lime.shade300;
//     Color appBarColor = Colors.deepOrange.shade400;
//     //  double size = context.watch<MovieThemeLogic>().counter.toDouble();


//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ParentScreen(),
//       themeMode: dark ? ThemeMode.dark : ThemeMode.light,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: secondaryColor,
//           shape: CircleBorder()
//         ),
//         appBarTheme: AppBarTheme(
//           backgroundColor: appBarColor,
//           foregroundColor: Colors.white,
//         ),
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: seedColor,
//           brightness: Brightness.dark,
//         ),
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: secondaryColor.withAlpha(96), //0 dark -> 255 light
//           shape: CircleBorder()
//         ),
//         //  appBarTheme: AppBarTheme(
//         //   backgroundColor: appBarColor.withAlpha(180),
//         //   foregroundColor: Colors.white,
//         // ),
//       ),
//     );
//   }
// }

// of this file is moved to movie_provider.dart to make it more organized and clean. The MovieSplashScreen is also created to handle the loading of theme and grid style before showing the ParentScreen.