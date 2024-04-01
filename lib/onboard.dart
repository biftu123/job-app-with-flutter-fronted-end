import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:jobapp/controller/onbordnotifier.dart';
import 'package:jobapp/page1.dart';
import 'package:jobapp/page2.dart';
import 'package:jobapp/page3.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<OnbordNotifier>(
        builder: (context, onbordnotifier, child) {
          return Stack(
            children: [
              PageView(
                physics: onbordnotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller: controller,
                children: const [page1(), page2(), page3()],
                onPageChanged: (page) {
                  onbordnotifier.isLastPage = page == 2;
                },
              ),
              Positioned(
                bottom: size.height * 0.02,
                left: 0,
                right: 0,
                child: onbordnotifier.isLastPage
                    ? const SizedBox.shrink()
                    : Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: const WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            spacing: 10,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.blue,
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: size.height * 0.13,
                left: 0,
                right: 0,
                child: onbordnotifier.isLastPage
                    ? SizedBox.shrink()
                    : Center(
                        child: GestureDetector(
                          child: Text('skip',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          onTap: () {
                            controller.jumpToPage(2);
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
