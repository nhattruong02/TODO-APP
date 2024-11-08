import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final bool isFirstTimeInstallApp;

  const WelcomePage({super.key, required this.isFirstTimeInstallApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: isFirstTimeInstallApp
            ? IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            _buildTitleAndDesc(),
            const SizedBox(
              height: 370,
            ),
            _buildLoginAndCreateAccountButton()
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDesc() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 58),
          child: Text(
            "Welcome to UpTodo",
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontFamily: "Lato",
                fontSize: 32,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 44),
          child: Text(
            "Please login to your account or create new account to continue",
            style: TextStyle(
                color: Colors.white.withOpacity(0.67),
                fontFamily: "Lato",
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildLoginAndCreateAccountButton() {
    return Column(
      children: [
        _buildLoginButton(),
        const SizedBox(
          height: 28,
        ),
        _buildCreateAccountButton()
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8875FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        child: const Text("LOGIN",
            style: TextStyle(
                fontSize: 16, fontFamily: "Lato", color: Colors.white)),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: Color(0xFF8E7CFF))),
          child: const Text("CREATE ACCOUNT",
              style: TextStyle(
                  fontSize: 16, fontFamily: "Lato", color: Colors.white)),
        ));
  }
}
