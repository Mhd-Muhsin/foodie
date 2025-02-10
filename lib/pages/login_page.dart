import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 200,),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrBwq1RrWCvEBjqWcXcvMGzk_4WBRFx2JRyg&s',
              height: 180,
              width: 100,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.network(
                            'https://cdn3d.iconscout.com/3d/free/thumb/free-google-3d-icon-download-in-png-blend-fbx-gltf-file-formats--social-media-logo-technology-ver-04-pack-logos-icons-10479106.png?f=webp', // Replaced phone icon with network image
                            height: 24,
                          ),
                        ),
                      ),
                      const Text(
                        "Google",
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Implement phone sign-in functionality
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.phone),
                        ),
                      ),
                      Text(
                        "Phone",
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Implement phone sign-in functionality
                  },
                ),
              ],
            ),
            const SizedBox(height: 140,),
          ],
        ),
      ),
    );
  }
}