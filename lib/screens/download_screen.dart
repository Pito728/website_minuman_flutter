import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../widgets/custom_navbar.dart';
import '../utils/responsive.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
      'assets/videos/kopi.mp4',
    )..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _launchAppStore() async {
    final Uri url = Uri.parse(
      'https://apps.apple.com/app/do-and-drinks/id123456789',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchGooglePlay() async {
    final Uri url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.doanddrinks',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const CustomNavbar(
            currentPage: "Download App",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) 
                      ? 20 
                      : 40,
                    vertical: 60,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool mobile = Responsive.isMobile(context);

                  return mobile
                      ? Column(
                        children: [
                          _buildPhoneMockup(),

                          const SizedBox(height: 40),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: _buildAppContent(context),
                          ),
                        ],
                      )
                        : Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildPhoneMockup(),
                              ),
                              const SizedBox(width: 80),
                              Expanded(
                                child: _buildAppContent(context),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneMockup() {
  final bool mobile = Responsive.isMobile(context);

  return Center(
    child: Container(
      width: mobile ? 220 : 320,
      height: mobile ? 450 : 650,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: const Color(0xFFC00A27),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC00A27).withOpacity(0.25),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Stack(
            children: [
              Positioned.fill(
                child: _videoController.value.isInitialized
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFC00A27),
                        ),
                      ),
              ),

              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 110,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildAppContent(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          "DO AND DRINKS APP",
          style: TextStyle(
            color: Color(0xFFC00A27),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          "Discover exclusive deals, skip the line, and enjoy rewards with the Do and Drinks app. Here's how:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        // BULLET POINTS
        const BulletPoint(
          text:
              "Order your favorite drinks for pickup or delivery.",
        ),
        const SizedBox(height: 15),
        const BulletPoint(
          text:
              "Earn points and redeem rewards with every purchase.",
        ),
        const SizedBox(height: 15),
        const BulletPoint(
          text:
              "Access exclusive membership benefits and promos.",
        ),
        const SizedBox(height: 15),
        const BulletPoint(
          text: "Stay updated on new products and events.",
        ),
        const SizedBox(height: 30),
        const Text(
          "Convenience and rewards, all in one app. Download now!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 40),
        // DOWNLOAD BUTTONS
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            GestureDetector(
              onTap: _launchAppStore,
              child: SizedBox(
                width: 180,
                child: Image.asset(
                  'assets/images/app_store.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            GestureDetector(
              onTap: _launchGooglePlay,
              child: SizedBox(
                width: 180,
                child: Image.asset(
                  'assets/images/play_google.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "•",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
