import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_utils.dart';
import '../../data/portfolio_data.dart';
import '../../services/firebase_service.dart';
import '../widgets/buttons.dart';
import '../widgets/glow_blob.dart';
import '../widgets/hover_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_container.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.sectionKey});
  final Key sectionKey;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final info = Reveal(
      offset: const Offset(-40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Let's build something great", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 14),
          Text(
            'Whether you need a senior Flutter engineer to own a product end-to-end, untangle a native '
            'integration, or ship to both stores, I would love to hear from you.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
          _ContactRow(
            icon: FontAwesomeIcons.envelope.data,
            label: 'Email',
            value: PortfolioData.email,
            onTap: () => UrlUtils.email(PortfolioData.email),
          ),
          _ContactRow(
            icon: FontAwesomeIcons.phone.data,
            label: 'Phone',
            value: PortfolioData.phone,
            onTap: () => UrlUtils.phone(PortfolioData.phoneRaw),
          ),
          _ContactRow(
            icon: FontAwesomeIcons.linkedinIn.data,
            label: 'LinkedIn',
            value: 'rupesh-rajak',
            onTap: () => UrlUtils.open(PortfolioData.linkedin),
          ),
          _ContactRow(
            icon: FontAwesomeIcons.locationDot.data,
            label: 'Location',
            value: '${PortfolioData.location} · Remote friendly',
          ),
        ],
      ),
    );

    final form = Reveal(
      delay: const Duration(milliseconds: 120),
      offset: const Offset(40, 0),
      child: const _ContactForm(),
    );

    return SectionContainer(
      sectionKey: sectionKey,
      background: Stack(
        children: [
          Positioned(bottom: -150, left: 100, child: GlowBlob(color: AppColors.primary, size: 600, opacity: .2)),
        ],
      ),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'contact',
            title: 'Get in touch',
            subtitle: 'Open to senior Flutter roles, freelance projects and interesting collaborations.',
          ),
          const SizedBox(height: 56),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: info),
                const SizedBox(width: 48),
                Expanded(flex: 6, child: form),
              ],
            )
          else ...[
            info,
            const SizedBox(height: 40),
            form,
          ],
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label, required this.value, this.onTap});
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, size: 17, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12.5)),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _subject = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);

    final ok = await FirebaseService.instance.sendMessage(
      name: _name.text,
      email: _email.text,
      subject: _subject.text,
      message: _message.text,
    );

    if (!mounted) return;
    setState(() => _sending = false);

    if (ok) {
      setState(() => _sent = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thanks! Your message has been sent.')),
      );
    } else {
      // Firebase not configured / offline: open the user's mail client instead.
      await UrlUtils.email(
        PortfolioData.email,
        subject: _subject.text.isEmpty ? 'Portfolio enquiry' : _subject.text,
        body: '${_message.text}\n\n— ${_name.text} (${_email.text})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return HoverCard(
        glow: AppColors.success,
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(FontAwesomeIcons.circleCheck.data, color: AppColors.success, size: 48),
            const SizedBox(height: 20),
            Text('Message sent!', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('I will get back to you within 24 hours.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            OutlineButton(label: 'Send another', onPressed: () => setState(() => _sent = false)),
          ],
        ),
      );
    }

    final isMobile = Responsive.isMobile(context);
    return HoverCard(
      lift: 0,
      padding: EdgeInsets.all(isMobile ? 22 : 32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isMobile) ...[
              _field(_name, 'Your name', validator: _required),
              const SizedBox(height: 14),
              _field(_email, 'Email address', validator: _emailValidator, keyboard: TextInputType.emailAddress),
            ] else
              Row(
                children: [
                  Expanded(child: _field(_name, 'Your name', validator: _required)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _field(_email, 'Email address', validator: _emailValidator, keyboard: TextInputType.emailAddress),
                  ),
                ],
              ),
            const SizedBox(height: 14),
            _field(_subject, 'Subject', validator: _required),
            const SizedBox(height: 14),
            _field(_message, 'Tell me about your project…', validator: _required, maxLines: 6),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerRight,
              child: PrimaryButton(
                label: 'Send Message',
                icon: FontAwesomeIcons.paperPlane.data,
                loading: _sending,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String hint, {
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      keyboardType: keyboard,
      validator: validator,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(hintText: hint),
    );
  }

  static String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  static String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }
}
