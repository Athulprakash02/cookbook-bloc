import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("""
          About CookBook App
          
          CookBook is a recipe app designed to help users discover new and delicious recipes to cook at home. Our mission is to make cooking easy and accessible for everyone, whether you're an experienced chef or just starting out in the kitchen.
          
          We believe that cooking is a fun and rewarding activity that can bring people together, and we want to help you create meals that you and your loved ones will enjoy. That's why we provide a wide variety of recipes to suit all tastes and dietary needs, from vegan and vegetarian options to gluten-free and low-carb dishes.
          
          Our team of recipe developers and food enthusiasts are passionate about creating recipes that are not only delicious but also easy to follow, with step-by-step instructions and clear photos to guide you through the cooking process.
          
          We are committed to providing a high-quality user experience, and we are constantly working to improve our app and add new features to make cooking even more enjoyable. We value your feedback and welcome any suggestions or comments you may have.
          
          Thank you for choosing CookBook as your go-to recipe app. We hope you enjoy using our app and discovering new and exciting recipes to cook at home!"""),
          )
        ],
      )),
    );
  }
}
