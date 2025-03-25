import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });
}

final slides = <SlideInfo>[
  SlideInfo(
    title: 'Busca la comida',
    caption:
        'Excepteur eu aliquip amet irure dolor aliquip commodo incididunt consectetur magna reprehenderit.',
    imageUrl: 'assets/images/1.png',
  ),
  SlideInfo(
    title: 'Entrega rápida',
    caption: 'Ad ut voluptate id nisi aliqua ex cupidatat.',
    imageUrl: 'assets/images/2.png',
  ),
  SlideInfo(
    title: 'Disfruta la comida',
    caption:
        'Lorem fugiat aliqua id do nostrud mollit ullamco nulla consequat exercitation Lorem reprehenderit quis do.',
    imageUrl: 'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'app_tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  late PageController pageViewController;
  bool finalPageReached = false;

  @override
  void initState() {
    pageViewController = PageController();

    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;

      if (!finalPageReached && page >= (slides.length - 1.5)) {
        setState(() {
          finalPageReached = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
              controller: pageViewController,
              children: slides
                  .map(
                    (slide) => _Slide(info: slide),
                  )
                  .toList()),
          Positioned(
            right: 20.0,
            top: 50.0,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir'),
            ),
          ),
          if (finalPageReached)
            Positioned(
              bottom: 30.0,
              right: 30.0,
              child: FadeInRight(
                from: 15.0,
                delay: const Duration(seconds: 1),
                child: FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Comenzar'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final SlideInfo info;

  const _Slide({required this.info});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(info.imageUrl)),
            const SizedBox(height: 20.0),
            Text(info.title, style: titleStyle),
            const SizedBox(height: 20.0),
            Text(info.caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
