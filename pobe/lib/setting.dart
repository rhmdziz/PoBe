import 'package:flutter/material.dart';
import 'package:pobe/help.dart';
import 'package:pobe/term_and_condition.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: const Color.fromRGBO(31, 54, 113, 1),
                    ),
                    const Text(
                      'Back',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                        fontSize: 18,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HelpPage())),
                    );
                  },
                  icon: const Icon(
                    Icons.help_rounded,
                    color: Color.fromRGBO(31, 54, 113, 1),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(248, 248, 248, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_sharp,
                    color: Color.fromRGBO(162, 174, 205, 1),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Color.fromRGBO(162, 174, 205, 1),
                    ),
                    onPressed: () {},
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset('assets/setting/language.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Language',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset('assets/setting/contrast.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'High Contrast',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            SizedBox(
              height: 35,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => const TermPage())),
                  );
                },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                child: Row(
                  children: [
                    Image.asset('assets/setting/terms.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset('assets/setting/clear.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Clear Cache',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset('assets/setting/delete.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
