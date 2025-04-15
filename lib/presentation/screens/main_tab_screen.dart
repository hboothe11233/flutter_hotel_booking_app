// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
//
//
// class MainTabScreen extends StatelessWidget {
//   const MainTabScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AutoTabsRouter.tabBar(
//       routes: [
//         OverviewRoute(),
//         HotelsRoute(),
//         FavoritesRoute(),
//         AccountRoute(),
//       ],
//       builder: (context, child, animation) {
//         final tabsRouter = AutoTabsRouter.of(context);
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Hotel Booking App'),
//           ),
//           body: child,
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(color: Colors.grey.shade300, width: 1),
//               ),
//             ),
//             child: BottomNavigationBar(
//               currentIndex: tabsRouter.activeIndex,
//               onTap: tabsRouter.setActiveIndex,
//               type: BottomNavigationBarType.fixed,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home_outlined),
//                   label: 'Overview',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search),
//                   label: 'Hotels',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.favorite_border),
//                   label: 'Favorites',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle_outlined),
//                   label: 'Account',
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
