# EmailJS Setup Guide for Portfolio Contact Form

This guide will help you set up EmailJS so that contact form messages from your portfolio are delivered to your email.

## Step 1: Create EmailJS Account

1. Go to [EmailJS.com](https://www.emailjs.com/)
2. Click "Sign Up" and create a free account
3. Verify your email address

## Step 2: Set Up Email Service

1. **Add New Service**
   - Click "Add New Service" in your dashboard
   - Choose your email provider (Gmail, Outlook, etc.)
   - Follow the authentication steps
   - Give your service a name (e.g., "Gmail")

2. **Get Service ID**
   - After setup, you'll see a Service ID
   - Copy this ID (format: `service_xxxxxxx`)

## Step 3: Create Email Template

1. **Add New Template**
   - Click "Add New Template"
   - Choose "Blank Template"

2. **Configure Template**
   - **Template Name**: "Portfolio Contact Form"
   - **Subject**: `New Contact Message from Portfolio - {{from_name}}`
   - **Content**:
   ```
   Hello {{to_name}},
   
   You have received a new message from your portfolio contact form:
   
   **Name:** {{from_name}}
   **Email:** {{from_email}}
   **Message:**
   {{message}}
   
   ---
   This message was sent from your portfolio website.
   ```

3. **Get Template ID**
   - Save the template
   - Copy the Template ID (format: `template_xxxxxxx`)

## Step 4: Get Your Public Key

1. Go to "Account" → "API Keys"
2. Copy your Public Key (format: `user_xxxxxxx`)

## Step 5: Update Your Code

### Update EmailService Configuration

In `lib/services/email_service.dart`, replace the placeholder values:

```dart
// EmailJS Configuration - Replace these with your actual values from EmailJS dashboard
static const String _emailjsServiceId = 'service_xxxxxxx'; // Your actual service ID
static const String _emailjsTemplateId = 'template_xxxxxxx'; // Your actual template ID
static const String _emailjsPublicKey = 'public_key_xxxxxxx'; // Your actual public key
```

### Update HTML File

In `web/index.html`, replace the placeholder public key:

```html
<script type="text/javascript">
  (function() {
    // Replace "YOUR_PUBLIC_KEY" with your actual EmailJS public key
    emailjs.init("user_xxxxxxx"); // Your actual public key
  })();
</script>
```

## Step 6: Test the Setup

1. Run your Flutter app in web mode: `flutter run -d chrome`
2. Navigate to the contact section
3. Fill out the contact form
4. Submit the form
5. Check your email for the message

## Troubleshooting

### Common Issues:

1. **"EmailJS not loaded" error**
   - Make sure the EmailJS script is loaded in your HTML
   - Check browser console for any JavaScript errors

2. **"Service not found" error**
   - Verify your Service ID is correct
   - Make sure the service is active in your EmailJS dashboard

3. **"Template not found" error**
   - Verify your Template ID is correct
   - Make sure the template is published

4. **Emails not being received**
   - Check your spam folder
   - Verify your email service is properly configured
   - Check EmailJS dashboard for any error logs

### Debug Steps:

1. Open browser developer tools (F12)
2. Go to Console tab
3. Submit the contact form
4. Look for any error messages or success confirmations

## EmailJS Limits (Free Plan)

- **200 emails per month**
- **2 email services**
- **5 email templates**

## Security Notes

- Your public key is safe to expose in client-side code
- Never expose your private keys or service secrets
- EmailJS handles the security of your email credentials

## Alternative Solutions

If you need more emails or want a different solution:

1. **Upgrade EmailJS plan** for more emails
2. **Use a backend service** (Firebase Functions, AWS Lambda)
3. **Use a form service** (Formspree, Netlify Forms)

## Support

- [EmailJS Documentation](https://www.emailjs.com/docs/)
- [EmailJS Community](https://community.emailjs.com/)
- [Flutter Web Documentation](https://flutter.dev/web) 