import 'package:flutter/material.dart';
import 'package:frontend/views/screens/test/round1.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Stress",
                  style: TextStyle(
                      color: Color(0xff3F414E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset("assets/logo.png"),
                const Text(
                  "Detect",
                  style: TextStyle(
                      color: Color(0xff3F414E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good Night, User!",
                    style: TextStyle(
                        color: Color(0xff3F414E),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "We wish you a good day",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffA1A4B2),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: const Color(0xff8E97FD),
                        height: 210,
                        width: 170,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Image.asset("assets/dashboard.png")],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 10),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                //Get.to(QuizScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "View",
                                        style: TextStyle(
                                          color: Colors.black, // Text color
                                          fontSize: 15.0, // Text size
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xffFFC97E),
                        height: 210,
                        width: 170,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Image.asset("assets/test.png")],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 10),
                                Text(
                                  "Take Test",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(Round1());
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Start",
                                        style: TextStyle(
                                          color: Colors.black, // Text color
                                          fontSize: 15.0, // Text size
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
