import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/theme.dart';
import 'package:solbombas/controller/login_controller.dart';
import 'package:solbombas/pages/login/login_page.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();


Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sol Bombas',
      theme: getLightTheme(context),
      darkTheme: getDarkTheme(context),
      home: LoginPage(),
    );
  }
}

// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:nfc_manager/nfc_manager.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> {
//   ValueNotifier<dynamic> result = ValueNotifier(null);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('NfcManager Plugin Example')),
//         body: SafeArea(
//           child: FutureBuilder<bool>(
//             future: NfcManager.instance.isAvailable(),
//             builder: (context, ss) => ss.data != true
//                 ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
//                 : Flex(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               direction: Axis.vertical,
//               children: [
//                 Flexible(
//                   flex: 2,
//                   child: Container(
//                     margin: EdgeInsets.all(4),
//                     constraints: BoxConstraints.expand(),
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: SingleChildScrollView(
//                       child: ValueListenableBuilder<dynamic>(
//                         valueListenable: result,
//                         builder: (context, value, _) =>
//                             Text('${value ?? ''}'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: GridView.count(
//                     padding: EdgeInsets.all(4),
//                     crossAxisCount: 2,
//                     childAspectRatio: 4,
//                     crossAxisSpacing: 4,
//                     mainAxisSpacing: 4,
//                     children: [
//                       ElevatedButton(
//                           child: Text('Tag Read'), onPressed: _tagRead),
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void _tagRead() {
//     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//       var mytag = tag.data["mifareclassic"]["identifier"].map((e) => e.toRadixString(16).padLeft(2, '0')).join(''); ;
//
//       result.value = mytag ;
//
//       NfcManager.instance.stopSession();
//     });
//   }


//}