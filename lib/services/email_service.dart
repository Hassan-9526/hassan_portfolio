import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class EmailService {
  // Your email address where you want to receive contact form messages
  static const String _recipientEmail =
      'ha4383731@gmail.com'; // Replace with your actual email

  // EmailJS Configuration - Replace these with your actual values from EmailJS dashboard
  static const String _emailjsServiceId =
      'service_xxxxxxx'; // Replace with your EmailJS service ID (e.g., service_abc123)
  static const String _emailjsTemplateId =
      'template_xxxxxxx'; // Replace with your EmailJS template ID (e.g., template_xyz789)
  static const String _emailjsPublicKey =
      'public_key_xxxxxxx'; // Replace with your EmailJS public key (e.g., user_abc123)

  static Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      if (kIsWeb) {
        // Use EmailJS for web platforms
        return await _sendEmailViaEmailJS(
          name: name,
          email: email,
          message: message,
        );
      } else {
        // Use URL launcher for mobile platforms
        return await _sendEmailViaUrl(
          name: name,
          email: email,
          message: message,
        );
      }
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  // EmailJS method for web platforms
  static Future<bool> _sendEmailViaEmailJS({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      // Check if EmailJS is available
      if (js.context.hasProperty('emailjs')) {
        // Initialize EmailJS
        js.context.callMethod('eval', ['emailjs.init("$_emailjsPublicKey");']);

        // Create a promise-based email sending function
        final result = js.context.callMethod('eval', [
          '''
          new Promise((resolve, reject) => {
            emailjs.send("$_emailjsServiceId", "$_emailjsTemplateId", {
              to_name: "Hassan Amir",
              from_name: "$name",
              from_email: "$email",
              to_email: "$_recipientEmail",
              message: "$message",
              subject: "New Contact Message from Portfolio - $name",
              reply_to: "$email"
            })
            .then(function(response) {
              console.log("SUCCESS", response);
              resolve(true);
            }, function(error) {
              console.log("FAILED", error);
              reject(error);
            });
          })
          '''
        ]);

        print('EmailJS email sent successfully');
        return true;
      } else {
        print('EmailJS not available');
        return false;
      }
    } catch (e) {
      print('Error sending email via EmailJS: $e');
      return false;
    }
  }

  // URL launcher method for mobile platforms
  static Future<bool> _sendEmailViaUrl({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final subject =
          Uri.encodeComponent('New Contact Message from Portfolio - $name');
      final body = Uri.encodeComponent('''
Name: $name
Email: $email

Message:
$message

---
Sent from your portfolio contact form.
      ''');

      final mailtoUrl = 'mailto:$_recipientEmail?subject=$subject&body=$body';

      // Open the default email client
      final uri = Uri.parse(mailtoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      } else {
        print('Could not launch email client');
        return false;
      }
    } catch (e) {
      print('Error opening email client: $e');
      return false;
    }
  }

  // Alternative method for web platforms that opens in a new tab
  static Future<bool> sendContactEmailWeb({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final subject =
          Uri.encodeComponent('New Contact Message from Portfolio - $name');
      final body = Uri.encodeComponent('''
Name: $name
Email: $email

Message:
$message

---
Sent from your portfolio contact form.
      ''');

      final mailtoUrl = 'mailto:$_recipientEmail?subject=$subject&body=$body';

      final uri = Uri.parse(mailtoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      } else {
        print('Could not launch email client');
        return false;
      }
    } catch (e) {
      print('Error opening email client: $e');
      return false;
    }
  }
}
