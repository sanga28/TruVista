import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  final PageController controller = PageController();

  final List<String> images = [
    "assets/images/case1.jpg",
    "assets/images/case2.jpg",
    "assets/images/case3.jpg",
    "assets/images/case4.jpg",
  ];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    autoSlide();
  }

  void autoSlide() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));

      currentPage++;
      if (currentPage >= images.length) {
        currentPage = 0;
      }

      if (controller.hasClients) {
        controller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        /// Image Slider
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox(
            height: 180,
            child: PageView.builder(
              controller: controller,
              itemCount: images.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (context, index) {
                return Stack(
                  children: [

                    Image.asset(
                      images[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    /// Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    const Positioned(
                      bottom: 15,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Active Investigation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Swipe to view cases",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 12 : 8,
              height: currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? Colors.blueAccent
                    : Colors.white30,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}