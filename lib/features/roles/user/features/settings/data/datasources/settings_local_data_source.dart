import '../../domain/entities/faq_entity.dart';
import '../../domain/entities/policy_entity.dart';

abstract class SettingsLocalDataSource {
  Future<List<FaqEntity>> getMockFaqs();
  Future<List<PolicyEntity>> getMockPolicy(String policyType);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  @override
  Future<List<FaqEntity>> getMockFaqs() async {
    return const [
      FaqEntity(
        id: 'faq1',
        question: 'What is Riddim Africa?',
        answer: 'Riddim Africa is a homegrown platform where you can buy original merchandise, music and digital products from African creators, stream music, and listen to our online radio — all in one app.',
      ),
      FaqEntity(
        id: 'faq2',
        question: 'How do I create an account?',
        answer: 'To create an account, tap the \'Sign Up\' button on the welcome screen. Follow the instructions to enter your email, create a username, set up your password, choose your user role, and verify your details.',
      ),
      FaqEntity(
        id: 'faq3',
        question: 'How do I buy a product?',
        answer: 'Browse the Market tab, tap on any product to view its details, and select \'Add to Cart\' or \'Buy Now\'. When you are ready, navigate to your Cart, tap \'Checkout\', enter your payment details, and confirm the order.',
      ),
      FaqEntity(
        id: 'faq4',
        question: 'What payment methods can I use?',
        answer: 'We accept Mobile Money (MTN Mobile Money and Airtel Money) as well as credit/debit card payments through our secure payment gateway.',
      ),
      FaqEntity(
        id: 'faq5',
        question: 'Is my payment secure?',
        answer: 'Yes, all transaction data is processed by our licensed, payment-card industry certified payment partner using state-of-the-art encryption. We do not store your full card numbers.',
      ),
      FaqEntity(
        id: 'faq6',
        question: 'How is delivery handled for physical items?',
        answer: 'Physical goods are dispatched from the nearest Riddim Africa hub through our dedicated delivery network. You will receive real-time notifications on the status of your delivery.',
      ),
      FaqEntity(
        id: 'faq7',
        question: 'How do I receive a digital product or photo I bought?',
        answer: 'Once your payment is confirmed, a secure download link will be sent to your registered email address and will also be accessible directly from your account profile under \'My Downloads\' or \'My Orders\'.',
      ),
      FaqEntity(
        id: 'faq8',
        question: 'What if my download link expires before I use it?',
        answer: 'If a download link expires, you can request a link renewal by contacting customer support at admin@riddimafrica.com or opening a support ticket in the app. Link validity is typically 7 days.',
      ),
    ];
  }

  @override
  Future<List<PolicyEntity>> getMockPolicy(String policyType) async {
    if (policyType == 'privacy') {
      return const [
        PolicyEntity(
          id: 'p_p1',
          title: '1. Who we are',
          content: 'Riddim Africa Limited ("Riddim Africa", "we", "us", "our"), a company incorporated in Uganda (Registration No. 80034768813841), operates the Riddim Africa platform: a digital music, merchandise and entertainment service. We are the data controller responsible for your personal data under the Data Protection and Privacy Act, 2019 of Uganda. Contact: admin@riddimafrica.com. We are registered with the Personal Data Protection Office (PDPO) of Uganda as a data controller.',
        ),
        PolicyEntity(
          id: 'p_p2',
          title: '2. The data we collect',
          content: 'We collect the following categories of personal data: • Account data — your name, username, email address, phone number. • Identity verification (KYC) data — for Artists and Sellers, government identification (e.g. National ID, passport or driving license) and related details, to verify identity and prevent fraud. • Delivery data — your delivery location (map pin / GPS coordinates), landmark description, and contact phone number, captured to enable delivery. • Transaction data — orders, purchases, prices, and records of payments and settlements. • Payment data — Mobile Money numbers and payment confirmations. Card payments are processed by our licensed payment partner; we do not store full card numbers. • Usage and device data — app interactions, device type, and technical logs used to operate and improve the service. • Communications — messages you send us (e.g. support requests).',
        ),
        PolicyEntity(
          id: 'p_p3',
          title: '3. How we use your data',
          content: 'We use personal data to: create and manage your account; process orders, payments and settlements; arrange and complete delivery; verify identity and prevent fraud; provide customer support; send service communications; operate, secure and improve the platform; and comply with legal obligations. Our legal bases include your consent, performance of our contract with you, our legitimate interests in operating a safe platform, and compliance with law.',
        ),
      ];
    } else if (policyType == 'refund') {
      return const [
        PolicyEntity(
          id: 'rf1',
          title: '1. Overview',
          content: 'This policy explains when and how you can return an item or receive a refund for marketplace purchases on Riddim Africa. It forms part of our Terms of Service. It applies to physical merchandise purchased through the platform.',
        ),
        PolicyEntity(
          id: 'rf2',
          title: '2. Our delivery and inspection model',
          content: 'Orders are dispatched from the nearest Riddim Africa office through our delivery network. Because the seller\'s payment is settled on confirmed delivery, you are encouraged to check your item on delivery. This model is designed to protect buyers and support our verified-authentic guarantee.',
        ),
        PolicyEntity(
          id: 'rf3',
          title: '3. When you can return an item',
          content: 'You may request a return or refund if the item is: • Not as described in the listing; • Damaged, defective or faulty; • The wrong item, size or variant; or • Counterfeit or not genuine. Please report the issue at the time of delivery with supporting photos or details.',
        ),
        PolicyEntity(
          id: 'rf4',
          title: '4. Items that may not be returnable',
          content: 'Certain items may not be eligible for return for hygiene, safety or customization reasons (for example, personalized or made-to-order items), unless they are faulty or not as described.',
        ),
        PolicyEntity(
          id: 'rf5',
          title: '5. How to request a return or refund',
          content: 'Contact us [via the app / admin@riddimafrica.com] with your order number and details of the issue. Our team will review the request and may ask for photos or the return of the item. We aim to resolve requests within 7 business days.',
        ),
        PolicyEntity(
          id: 'rf6',
          title: '6. Refunds',
          content: 'Approved refunds are issued to your original payment method (e.g. the Mobile Money account used). Refund timing depends on the payment provider but we will process approved refunds promptly. Where a return is required, refunds may be completed after the item is received and checked.',
        ),
      ];
    } else if (policyType == 'cookie') {
      return const [
        PolicyEntity(
          id: 'ck1',
          title: '1. What this covers',
          content: 'This notice explains how Riddim Africa uses cookies and similar technologies (such as local storage and software development kits) on our website and app. It should be read together with our Privacy Policy.',
        ),
        PolicyEntity(
          id: 'ck2',
          title: '2. What cookies and similar technologies are',
          content: 'Cookies are small files stored on your device. Similar technologies perform comparable functions. Together they help the service work, remember your preferences, keep you signed in, and help us understand how the platform is used.',
        ),
        PolicyEntity(
          id: 'ck3',
          title: '3. Types we use',
          content: '• Essential — required for the platform to function (e.g. signing in, security, completing a purchase). These cannot be switched off.\n• Preferences — remember choices such as language or settings.\n• Analytics / performance — help us understand usage and improve the service [e.g. product analytics and error monitoring tools].',
        ),
        PolicyEntity(
          id: 'ck4',
          title: '4. Third-party tools',
          content: 'We use trusted third-party analytics and security tools that may set their own cookies or identifiers to provide their services to us. These providers process data on our behalf.',
        ),
        PolicyEntity(
          id: 'ck5',
          title: '5. No advertising sale',
          content: 'We do not use cookies to sell your data to advertisers or to let advertisers target you within Riddim Africa.',
        ),
      ];
    } else if (policyType == 'community') {
      return const [
        PolicyEntity(
          id: 'cm1',
          title: '1. Our community',
          content: 'Riddim Africa is a home for African music, artists, creators and fans. These Guidelines apply to everyone on the platform — Users, Artists and Sellers — and form part of our Terms of Service. Our goal is a space that is authentic, respectful and safe.',
        ),
        PolicyEntity(
          id: 'cm2',
          title: '2. Respect others',
          content: 'Treat others with respect. The following are not allowed: • Hate speech, discrimination or harassment based on race, ethnicity, religion, gender, sexual orientation, disability or other protected characteristics. • Bullying, threats, intimidation, or incitement of violence. • Sharing others\' private information without consent.',
        ),
        PolicyEntity(
          id: 'cm3',
          title: '3. Keep it lawful and safe',
          content: 'Do not post or sell anything illegal, dangerous or harmful, including: • Illegal goods, counterfeit products, or items you do not have the right to sell. • Fraud, scams, or attempts to deceive buyers or other users. • Content that promotes violence, self-harm, or illegal activity.',
        ),
        PolicyEntity(
          id: 'cm4',
          title: '4. Protecting minors',
          content: 'We have zero tolerance for any content or behavior that sexualizes, endangers or exploits children. Such content will be removed, the account terminated, and the matter reported to the appropriate authorities. The platform is intended for adults [18+].',
        ),
        PolicyEntity(
          id: 'cm5',
          title: '5. Authenticity',
          content: 'Riddim Africa is built on trust. List real products with honest descriptions and genuine images. Do not misrepresent items, impersonate artists, or sell counterfeit goods. Artists must only submit original work they have the right to distribute.',
        ),
        PolicyEntity(
          id: 'cm6',
          title: '6. Respect intellectual property',
          content: 'Do not upload, sell or distribute music, images or merchandise that infringe someone else\'s copyright, trademark or likeness. Only submit content you own or are licensed to use.',
        ),
      ];
    }
    return const [];
  }
}
