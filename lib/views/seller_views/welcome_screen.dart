import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';

class EnhancedWelcomeScreen extends StatefulWidget {
  const EnhancedWelcomeScreen({super.key});

  @override
  _EnhancedWelcomeScreenState createState() => _EnhancedWelcomeScreenState();
}

class _EnhancedWelcomeScreenState extends State<EnhancedWelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Image.asset(
                          'assest/Ecommerce campaign.gif', // Replace with your GIF file path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 80.h,
                      width: double
                          .infinity, // Ensures the container takes full width available
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Center(
                          child: TypeWriter.text(
                            'Welcome to Setup Store', // Remove the newline character
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            duration: const Duration(milliseconds: 50),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // FadeTransition(
                    //   opacity: _fadeInAnimation,
                    //   child: Text(
                    //     'Embark on a journey of knowledge and growth with our innovative learning platform.',
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: Colors.grey[600],
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // const SizedBox(height: 48),
                    ScaleTransition(
                      scale: _fadeInAnimation,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFC8019),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 36.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          // Handle button press
                          Get.toNamed(RouteName.setUpProduct);
                        },
                        child: const Text(
                          'Setup My Store',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
