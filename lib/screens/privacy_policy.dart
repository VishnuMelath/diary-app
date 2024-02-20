import 'package:diaryapp/themes/themes.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children:  const[
            Center(child: Text('Privacy Policy\n',style: head1,)),
            Text('Effective Date: 13/02/2024\n',style: head3,),
             Text(
                '         we respects your privacy and is committed to protecting the personal information you provide to us. This Privacy Policy outlines how we collect, use, disclose, and store your personal information when you use our Android application, Diary app.\n'),
            Text('1.Information Collection and Use',style: head3),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('''1.1 Personal Information: 
              The App collects and stores the following personal information locally on your device:Name: We collect your name to personalize your experience within the App.Date of Birth: We collect your date of birth to provide age-appropriate features and content within the App.\n1.2 Non-Personal Information:
              The App may also collect non-personal information, such as device information and usage statistics, to improve the App's performance and user experience. This information does not directly identify you and is used solely for analytical purposes.'''),
            ),
            Text('2.Information Storage',style: head3),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('''2.1 Local Storage: 
                All personal information collected by the App is stored locally on your device. We do not store any personal information on external servers or transmit it over the internet.\n2.2 Security: 
                We implement reasonable security measures to protect the personal information stored within the App, including encryption and access controls, to prevent unauthorized access, disclosure, alteration, or destruction of your information.'''),
            ),
             Text('3.Information Sharing',style: head3),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('''3.1 Third-Party Services: 
            The App does not share your personal information with any third-party services or vendors.\n3.2 Legal Requirements:
             We may disclose your personal information if required to do so by law or in response to valid legal requests from government authorities or law enforcement agencies.'''),
            ),
            Text('4.Children\'s Privacy',style: head3),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('''
            The App is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us immediately, and we will take steps to remove such information from our records.'''),
            ),
            Text('5.Changes to this Privacy Policy',style: head3),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('''
              We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the revised Privacy Policy within the App. Your continued use of the App after the posting of any changes constitutes acceptance of those changes.'''),
            ),
            Text('6.Contact us',style: head3),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at vishnumeloth13@gmail.com.'),
            ),
            Text('By using the App, you agree to the terms and conditions of this Privacy Policy. If you do not agree with any part of this Privacy Policy, please do not use the App.')
          ],
        ),
      )),
    );
  }
}
