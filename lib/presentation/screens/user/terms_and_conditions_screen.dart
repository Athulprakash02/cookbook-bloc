import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and conditions'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("""
        Please read these Terms and Conditions ("Terms", "Terms and Conditions") carefully before using the CookBook app (the "App") operated by us.
                
        Your access to and use of the App is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users, and others who access or use the App.
                
        By accessing or using the App, you agree to be bound by these Terms. If you disagree with any part of the terms, then you may not access the App.
                
        Content Ownership and Use:
        All content provided in the App, including recipes, images, and text, are owned by us or licensed to us. You may not use, reproduce, modify, or distribute any of the content without our written permission.
                
        User Accounts
        To access some features of the App, you may be required to register for an account. You must provide accurate and complete information when creating an account and keep your account information up to date. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer or mobile device. You agree to accept responsibility for all activities that occur under your account.
                
        Prohibited Uses
        You may use the App only for lawful purposes and in accordance with these Terms. You agree not to use the App:
                
        In any way that violates any applicable federal, state, local, or international law or regulation.
                To transmit, or procure the sending of, any advertising or promotional material, including any "junk mail," "chain letter," "spam," or any other similar solicitation.
        To impersonate or attempt to impersonate us, our employees, another user, or any other person or entity.
        To engage in any other conduct that restricts or inhibits anyone's use or enjoyment of the App, or which, as determined by us, may harm us or users of the App or expose them to liability.
        Termination
        We may terminate or suspend your access to the App immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these Terms. Upon termination, your right to use the App will immediately cease.
                
        Disclaimer of Warranties
        The App is provided on an "as is" and "as available" basis without any representations or warranties, express or implied. We make no representations or warranties in relation to the App or the information and materials provided on the App.
                
        Limitation of Liability
        To the maximum extent permitted by applicable law, we will not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from your access to or use of or inability to access or use the App.
                
        Changes
        We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.
                
        Contact Us
        If you have any questions about these Terms, please contact us at athulathunjr@gmail.com."""),
          )
        ],
      )),
    );
  }
}
