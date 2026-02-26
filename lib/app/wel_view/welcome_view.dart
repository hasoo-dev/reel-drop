import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_downloder/core/componenet/text_action.dart';
import 'package:video_downloder/core/routes/routes_name.dart';
import 'package:video_downloder/core/utils/responsive_extensions.dart';
import 'package:video_downloder/services/session_manager/session_controller.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final List<String> images = [
    "assets/images/ic_back.png",
    "assets/images/ic_insta.png",
    "assets/images/ic_facebook.png",
  ];

  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: "image$index",
                              child: Image.asset(
                                images[index],
                                height: context.mqHeight(0.3),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: images.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 13,
                            activeDotColor: Colors.deepOrange,
                            dotColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 23.heightBox,
                      Image.asset(
                        "assets/icons/ic_library.png",
                        height: context.mqHeight(0.12),
                        width: context.mqHeight(0.12),
                      ),
                      12.heightBox,
                      Text(
                        "Welcome To ReelDrop",
                        style: theme.textTheme.headlineLarge,
                      ),
                      12.heightBox,
                      Text(
                        "Reel Drop helps you collect, organize, and manage your favorite public content links in one place.Create categories, add notes, and build your personal content library easily.",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                      22.heightBox,
                      TextAction(
                        text: "Get Started",
                        height: context.mqHeight(0.07),
                        onPressed: () {
                          SessionController().setFirstRunComplete();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.home,
                            (route) => false,
                          );
                        },
                        backGrounColor: Colors.deepOrangeAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_downloder/bloc/library_bloc/library_bloc.dart';
// import 'package:video_downloder/bloc/library_bloc/library_event.dart';
// import 'package:video_downloder/bloc/library_bloc/library_state.dart';
// import 'package:video_downloder/core/componenet/app_text_field.dart';
// import 'package:video_downloder/core/componenet/text_action.dart';
// import 'package:video_downloder/core/utils/responsive_extensions.dart';
// import 'package:video_downloder/core/utils/validation_extensions.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final TextEditingController urlController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String selectedPlatform = "Instagram";

//   final List<Map<String, dynamic>> platforms = [
//     {
//       "name": "Instagram",
//       "icon": Icons.camera_alt_outlined,
//       "color": Colors.pinkAccent,
//     },
//     {"name": "Facebook", "icon": Icons.facebook, "color": Colors.blueAccent},
//     {"name": "TikTok", "icon": Icons.music_note, "color": Colors.black},
//     {"name": "Pinterest", "icon": Icons.pin_drop, "color": Colors.redAccent},
//   ];

//   String? _validateUrl(String? value) =>
//       value.validateSocialUrl(selectedPlatform);

//   @override
//   void dispose() {
//     urlController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return BlocListener<LibraryBloc, LibraryState>(
//       listener: (context, state) {
//         if (state is LibrarySuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } else if (state is LibraryError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.error),
//               backgroundColor: Colors.redAccent,
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: theme.colorScheme.background,
//         appBar: AppBar(
//           leading: Image.asset(
//             "assets/icons/ic_reel.png",
//           ).paddingAll(8).h(23).w(23),
//           title: Text(
//             "ReelDrop",
//             style: theme.textTheme.headlineLarge?.copyWith(fontSize: 24),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     20.heightBox,
//                     FadeInDown(
//                       child: Text(
//                         "Choose Platform",
//                         style: theme.textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'lufga',
//                         ),
//                       ),
//                     ),
//                     16.heightBox,
//                     SizedBox(
//                       height: context.mqHeight(0.12),
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: platforms.length,
//                         itemBuilder: (context, index) {
//                           final platform = platforms[index];
//                           final isSelected =
//                               selectedPlatform == platform["name"];

//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedPlatform = platform["name"];
//                                 _formKey.currentState?.validate();
//                               });
//                             },
//                             child: FadeInRight(
//                               delay: Duration(milliseconds: index * 100),
//                               child: Container(
//                                 width: context.mqWidth(0.2),
//                                 margin: const EdgeInsets.only(right: 12),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? platform["color"]
//                                       : theme.colorScheme.surface,
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? Colors.transparent
//                                         : theme.colorScheme.onSurface
//                                               .withOpacity(0.05),
//                                   ),
//                                   boxShadow: isSelected
//                                       ? [
//                                           BoxShadow(
//                                             color: (platform["color"] as Color)
//                                                 .withOpacity(0.3),
//                                             blurRadius: 10,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ]
//                                       : [],
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       platform["icon"],
//                                       color: isSelected
//                                           ? Colors.white
//                                           : platform["color"],
//                                       size: 28,
//                                     ),
//                                     8.heightBox,
//                                     Text(
//                                       platform["name"],
//                                       style: theme.textTheme.bodySmall
//                                           ?.copyWith(
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : theme.colorScheme.onSurface,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     32.heightBox,
//                     FadeInUp(
//                       child: Text(
//                         "Paste Video Link",
//                         style: theme.textTheme.headlineSmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'lufga',
//                         ),
//                       ),
//                     ),
//                     16.heightBox,
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 200),
//                       child: AppTextField(
//                         controller: urlController,
//                         hintText: "https://$selectedPlatform.com/...",
//                         validator: _validateUrl,
//                         prefixIcon: Icon(
//                           Icons.link,
//                           color: theme.colorScheme.primary,
//                         ),
//                         suffixIcon: TextButton(
//                           onPressed: () {
//                             // Placeholder for paste functionality
//                           },
//                           child: const Text("Paste"),
//                         ),
//                       ),
//                     ),
//                     24.heightBox,
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 400),
//                       child: TextAction(
//                         text: "Download Now",
//                         backGrounColor: theme.colorScheme.primary,
//                         height: 56,
//                         onPressed: () {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             context.read<LibraryBloc>().add(
//                               StartDownload(
//                                 url: urlController.text,
//                                 platform: selectedPlatform,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                     40.heightBox,
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 600),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.amber.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.amber.withOpacity(0.2),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.info_outline,
//                                   color: Colors.amber,
//                                 ),
//                                 8.widthBox,
//                                 Text(
//                                   "How to download?",
//                                   style: theme.textTheme.titleMedium?.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.amber.shade900,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             12.heightBox,
//                             Text(
//                               "1. Open $selectedPlatform application\n"
//                               "2. Copy the link of the video/reel\n"
//                               "3. Paste it here and click download!",
//                               style: theme.textTheme.bodyMedium?.copyWith(
//                                 color: Colors.amber.shade900.withOpacity(0.8),
//                                 height: 1.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     40.heightBox,
//                   ],
//                 ),
//               ),
//             ),
//             BlocBuilder<LibraryBloc, LibraryState>(
//               builder: (context, state) {
//                 if (state is LibraryLoading) {
//                   return Container(
//                     color: Colors.black.withOpacity(0.5),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CircularProgressIndicator(
//                             value: state.progress > 0 ? state.progress : null,
//                             color: Colors.white,
//                           ),
//                           16.heightBox,
//                           Text(
//                             state.progress > 0
//                                 ? "Downloading... ${(state.progress * 100).toInt()}%"
//                                 : "Processing...",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
