import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pokedex/Screens/app_Details_screen.dart';
import 'package:pokedex/Screens/faq_screen.dart';
import 'package:pokedex/Screens/login_screen.dart';
import 'package:pokedex/utils/context_extension.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wiredash/wiredash.dart';
import '../riverpod/auth_pod.dart';
import 'home_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class DrawerScreen extends ConsumerStatefulWidget {
  DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  String appVersion = "";
  String appBuildNumber = '';

  _DrawerScreenState() {
    initAppVersion();
  }

  Future<void> openExternalBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('could not launch url $url');
    }
  }

  void share() {
    String appLink = "";
    if (Platform.isAndroid) {
      appLink = "https://play.google.com/store/apps/details?id=com.jagadish.pokedex";
    } else {
      // appLink = "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8";
      appLink = "https://play.google.com/store/apps/details?id=com.jagadish.pokedex"; // beta enroll link
    }
    Share.share("Check out the Pokédex App at: $appLink", subject: "DexMaster");
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('App Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Icon
               const Image(image: AssetImage('assets/images/Angry Pikachu.png'),width: 180,height: 180,),
              const SizedBox(height: 16),
              // App Name
              const Text(
                'Pokédex',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                appVersion,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Build version: ${appBuildNumber}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _feedBackDialog(BuildContext context) {
    Wiredash.of(context).show(inheritMaterialTheme: true);
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await ref.read(authProvider).logoutUser();
                context.navigateToScreen(isReplace: true, child: LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user1 = ref.watch(authProvider).user;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Trainer Name: ${user1?.name}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            accountEmail: Text(
              "Trainer Id: ${user1?.email}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Pikachu Smiling.png'),
            ),
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background.png'),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                    Colors.deepPurpleAccent.withOpacity(0.8), BlendMode.modulate),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              context.navigateToScreen(
                  isReplace: true, child: const HomeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.details),
            title: const Text("Details"),
            onTap: () {
              context.navigateToScreen(child: const AppDetailsScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.safety_check),
            title: const Text("Data Safety and Privacy"),
            onTap: () {
              openExternalBrowser(
                  'https://sites.google.com/view/pokedex-jagadish/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text("FAQ"),
            onTap: () {
              context.navigateToScreen(child: const FaqScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("FeedBack"),
            onTap: () {
              _feedBackDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () {
              share();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text("About"),
            onTap: () {
              _showAppInfoDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
  void initAppVersion() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appVersion = "v${packageInfo.version}";
        appBuildNumber = 'v${packageInfo.buildNumber}';
      });
    });
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pokedex/Screens/login_screen.dart';
// import 'package:pokedex/utils/context_extension.dart';
// import '../riverpod/auth_pod.dart';
// import 'home_screen.dart';
//
// class DrawerScreen extends ConsumerWidget {
//   const DrawerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user1 = ref.watch(authProvider).user;
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(
//               "Trainer Name: ${user1?.name}",
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18),
//             ),
//             accountEmail: Text(
//               "Trainer Id: ${user1?.email}",
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14),
//             ),
//             currentAccountPicture: const CircleAvatar(
//               backgroundImage:
//               AssetImage('assets/images/Pikachu Smiling.png'),
//             ),
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/profile_background.png'),
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text("Home"),
//             onTap: () {
//               context.navigateToScreen(
//                   isReplace: true, child: const HomeScreen());
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.safety_check),
//             title: const Text("Data Safety"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.details),
//             title: const Text("App details"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.account_box),
//             title: const Text("About"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.question_answer),
//             title: const Text("FAQ"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("Logout"),
//             onTap: () {
//               context.navigateToScreen(child: LoginScreen());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
