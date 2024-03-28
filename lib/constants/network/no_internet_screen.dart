
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatefulWidget {
  static String routeName = 'no-internet';
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animation_ln1khw75.json"),
            const SizedBox(height: 10),
            const Text(
              "No Internet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
                Padding(
              padding:const  EdgeInsets.symmetric(horizontal: 50,vertical: 20),
              child:
               ElevatedButton(
              onPressed: () {
              //  context.read<UserDetailsBloc>().add(UserDetailGetDetailsEvent(context: context));
              },
               style: 
               ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color(0xFFA51C05),
                            ),
              child: const Text("Refresh", style: TextStyle(
                color:Colors.white,


              )),
            )
            )
          ],
        ),
      ),
    );
  }
}
