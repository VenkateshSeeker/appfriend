// Imports
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../login/login.dart';

// ===================== Onboarding Screen =====================
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1833), // Deep night sky blue
      body: SafeArea(
        child: Stack(
          children: [
            const AnimatedStarField(), // Animated star field background
            Column(
              children: [
                const Spacer(flex: 2),
                // Onboarding pages
                Expanded(
                  flex: 14,
                  child: PageView.builder(
                    itemCount: demoData.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) => OnboardContent(
                      illustration: demoData[index]["illustration"],
                      title: demoData[index]["title"],
                      text: demoData[index]["text"],
                    ),
                  ),
                ),
                const Spacer(),
                // Page indicator dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    demoData.length,
                    (index) => DotIndicator(isActive: index == currentPage),
                  ),
                ),
                const Spacer(flex: 2),
                // Get Started button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22A45D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Get Started".toUpperCase()),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== Onboarding Page Content =====================
class OnboardContent extends StatefulWidget {
  const OnboardContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.text,
  });

  final String? illustration, title, text;

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine which onboarding page this is
    final isFirst =
        widget.illustration != null &&
        widget.illustration!.contains('onboarding1');
    Widget imageWidget =
        widget.illustration != null &&
            widget.illustration!.startsWith('assets/')
        ? Image.asset(widget.illustration!, fit: BoxFit.contain)
        : Image.network(widget.illustration ?? '', fit: BoxFit.contain);

    // Onboarding 1: Rotating image (anticlockwise)
    if (isFirst) {
      imageWidget = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: -_controller.value * 2 * 3.1415926535,
            child: child,
          );
        },
        child: imageWidget,
      );
    }
    // Onboarding 2: Static image with bottom fade
    else if (widget.illustration != null &&
        widget.illustration!.contains('onboarding2')) {
      imageWidget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.7),
              const Color(0xFF0A1833).withOpacity(0.8),
              const Color(0xFF0A1833),
            ],
            stops: [0.0, 0.6, 0.82, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: imageWidget,
      );
    }
    // Onboarding 3: Static image with padding
    else if (widget.illustration != null &&
        widget.illustration!.contains('onboarding3')) {
      imageWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Image.asset(widget.illustration!, fit: BoxFit.contain),
      );
    }

    return Column(
      children: [
        Expanded(child: AspectRatio(aspectRatio: 1, child: imageWidget)),
        const SizedBox(height: 16),
        Text(
          widget.title ?? '',
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ) ??
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          widget.text ?? '',
          style:
              Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white) ??
              const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ===================== Dot Indicator =====================
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = const Color(0xFF22A45D),
    this.inActiveColor = const Color(0xFF868686),
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

// ===================== Onboarding Data =====================
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "assets/images/onboarding1.png",
    "title": "Discover Travel Buddies",
    "text":
        "Connect with like-minded travelers nearby and \nturn every trip into a shared adventure.",
  },
  {
    "illustration": "assets/images/onboarding2.png",
    "title": "Meet New Friends On the Go",
    "text":
        "Find people traveling to the same destinations and\ncreate unforgettable memories together.",
  },
  {
    "illustration": "assets/images/onboarding3.png",
    "title": "Plan & Explore Together",
    "text":
        "Share itineraries, plan meetups, and discover local\nspots with your new travel friends.",
  },
];

// ===================== Splash Screen (Minimal) =====================
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Minimal splash: just a background color and quick transition
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: Center(), // Blank or minimal
    );
  }
}

// ===================== Animated Star Field with Shooting Star Effect =====================
class AnimatedStarField extends StatefulWidget {
  const AnimatedStarField({super.key});

  @override
  State<AnimatedStarField> createState() => _AnimatedStarFieldState();
}

class _AnimatedStarFieldState extends State<AnimatedStarField>
    with SingleTickerProviderStateMixin {
  // --- Star Field Properties ---
  static const int starCount = 40;
  late final List<_Star> _stars;
  late final AnimationController _controller;

  // --- Shooting Star State ---
  double? shootingStartX;
  double? shootingStartY;
  double? shootingEndX;
  double? shootingEndY;
  double shootingProgress = 0;
  double shootingOpacity = 0;
  int shootingCooldown = 0;

  @override
  void initState() {
    super.initState();
    final random = math.Random(UniqueKey().hashCode);
    _stars = List.generate(starCount, (i) => _Star.random(random));
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(_maybeTriggerShootingStar)
          ..repeat();
  }

  // Randomly trigger a shooting star if not already animating and cooldown is over
  void _maybeTriggerShootingStar() {
    if (shootingOpacity == 0 && shootingCooldown <= 0) {
      final random = math.Random();
      if (random.nextDouble() < 0.01) {
        // ~1% chance per frame
        shootingStartX = random.nextDouble() * 0.7 + 0.1; // avoid edges
        shootingStartY = random.nextDouble() * 0.3 + 0.05; // upper part
        shootingEndX = shootingStartX! + 0.25 + random.nextDouble() * 0.2;
        shootingEndY = shootingStartY! + 0.12 + random.nextDouble() * 0.1;
        shootingProgress = 0;
        shootingOpacity = 1;
        shootingCooldown = 120; // frames to wait before next
      }
    }
    // Animate shooting star if active
    if (shootingOpacity > 0) {
      setState(() {
        shootingProgress += 0.025;
        if (shootingProgress >= 1) {
          shootingOpacity = 0;
        }
      });
    } else if (shootingCooldown > 0) {
      shootingCooldown--;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // --- Draw twinkling stars ---
        List<Widget> children = _stars.map((star) {
          final t = (_controller.value + star.phase) % 1.0;
          final opacity =
              0.5 +
              0.5 * (0.5 + 0.5 * math.sin((star.phase + t * 2) * math.pi));
          return Positioned(
            left: star.dx * size.width,
            top: star.dy * size.height,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: star.size,
                height: star.size,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }).toList();

        // --- Draw shooting star if active ---
        if (shootingOpacity > 0 &&
            shootingStartX != null &&
            shootingEndX != null) {
          final x =
              lerpDouble(shootingStartX!, shootingEndX!, shootingProgress)! *
              size.width;
          final y =
              lerpDouble(shootingStartY!, shootingEndY!, shootingProgress)! *
              size.height;
          final trailLength = 60.0;
          final trailAngle = math.atan2(
            (shootingEndY! - shootingStartY!) * size.height,
            (shootingEndX! - shootingStartX!) * size.width,
          );
          children.add(
            Positioned(
              left: x,
              top: y,
              child: Opacity(
                opacity: shootingOpacity * (1 - shootingProgress),
                child: Transform.rotate(
                  angle: trailAngle,
                  child: Container(
                    width: trailLength,
                    height: 2.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.white, Colors.white.withOpacity(0.0)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // --- Stack all stars and shooting star ---
        return IgnorePointer(child: Stack(children: children));
      },
    );
  }
}

// ===================== Utility: Linear interpolation for doubles =====================
double? lerpDouble(num a, num b, double t) {
  return a + (b - a) * t;
}

// ===================== Star Data Class =====================
class _Star {
  final double dx, dy, size, phase;
  _Star(this.dx, this.dy, this.size, this.phase);
  factory _Star.random(math.Random random) {
    final dx = random.nextDouble();
    final dy = random.nextDouble();
    final size = 1.5 + random.nextDouble() * 2.5;
    final phase = random.nextDouble();
    return _Star(dx, dy, size, phase);
  }
}
