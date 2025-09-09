import 'package:flutter/material.dart';
import '../constants.dart';
import 'login.dart';
import 'sign_up.dart'; // Import the next screen

class SlideScreen extends StatefulWidget {
  @override
  _SlideScreenState createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round(); // Update current page index
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildSlide(
                image: 'assets/slide1.png',
                title: 'Buy airtime for yourself and others',
                subtitle: '',
                description:
                    'PAAM is a 30-day training program. It equips you to make a meaningful impact.',
                context: context,
              ),
              _buildSlide(
                image: 'assets/slide1.png',
                title: 'Buy airtime for yourself and others',
                subtitle: '',
                description:
                    'PAAM is a 30-day training program. It equips you to make a meaningful impact.',
                context: context,
              ),
              _buildSlide(
                image: 'assets/slide2.png',
                title: 'From Moses to Messiah',
                subtitle: '',
                description:
                    'Embark on a transformative 30-day Bible journey. Explore key narratives and teachings for deeper understanding.',
                context: context,
              ),
              _buildSlide(
                image: 'assets/slide1.png',
                title: 'Buy airtime for yourself and others',
                subtitle: '',
                description:
                    'PAAM is a 30-day training program. It equips you to make a meaningful impact.',
                context: context,
              ),
            ],
          ),
          
          // Static Footer with Button and Indicator
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
// Dynamic Slide Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 45,
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? primaryColor
                            : Colors.grey,
                        shape: BoxShape.rectangle,
                      ),
                    );
                  }),
                ),
const SizedBox(height: 24),
                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: primaryButtonStyle,
                  child: const Text('Get Started'),
                ),
                const SizedBox(height: 14),

                // I Have an Account Button (Outlined)
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: secondaryButtonStyle,
                  child: const Text('I have an account'),
                ),
                const SizedBox(height: 10),
               Text('v1.32.0 (2100)', style: TextStyle( fontSize: 14, color:Colors.grey),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide({
    required String image,
    required String title,
    required String subtitle,
    required String description,
    required BuildContext context,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
        children: [
          // Image container
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Title text
          Text(
            title,
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              height: 1.0, // Reduce line height
            ),
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 10),

          // Description text
          Text(
            description,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              height: 1.4,
            ),
            textAlign: TextAlign.start,
          ),
           const SizedBox(height: 140),
        ],
      ),
    );
  }
}
