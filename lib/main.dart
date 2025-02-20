import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ProfessionalProfileApp());
}

class ProfessionalProfileApp extends StatefulWidget {
  const ProfessionalProfileApp({Key? key}) : super(key: key);

  @override
  _ProfessionalProfileAppState createState() => _ProfessionalProfileAppState();
}

class _ProfessionalProfileAppState extends State<ProfessionalProfileApp> {
  bool isDarkMode = false;

  void _toggleThemeMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil Profesional',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: ProfilePage(
        onThemeToggle: _toggleThemeMode,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfilePage({
    Key? key, 
    required this.onThemeToggle,
    required this.isDarkMode,
  }) : super(key: key);

  // Función para lanzar URLs
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: _buildProfileCard(context),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 350,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey[850],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfileAvatar(),
              const SizedBox(height: 16),
              _buildProfileName(),
              const SizedBox(height: 8),
              _buildProfileTitle(),
              const SizedBox(height: 24),
              _buildSkillChips(),
              const SizedBox(height: 24),
              _buildSocialButtons(context),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 24),
              _buildProfileStats(),
            ],
          ),
        ),
        Positioned(
          top: 32,  // Ajustado para mover el botón más hacia abajo
          right: 32, // Ajustado para mover el botón más hacia la izquierda
          child: FloatingActionButton(
            onPressed: onThemeToggle,
            mini: true,
            elevation: 2, // Reducida la elevación para que sea más sutil
            backgroundColor: isDarkMode ? Colors.blueGrey : Colors.blue,
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'VR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Row _buildNavigationButtons() {
    return Row(
      children: [
        _buildNavButton('Nosotros'),
      ],
    );
  }

  TextButton _buildNavButton(String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[100],
            border: Border.all(
              color: Colors.blue,
              width: 3,
            ),
          ),
          child: const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.verified,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileName() {
    return const Text(
      'Victor Sanchez',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileTitle() {
    return const Text(
      'Desarrollador de Software',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildSkillChips() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildSkillChip('Flutter'),
        _buildSkillChip('C#'),
        _buildSkillChip('JS'),
        _buildSkillChip('PHP'),
        _buildSkillChip('MYSQL'),
        _buildSkillChip('PYTHON'),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    final Color buttonColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          Icons.business,
          'VR',
          buttonColor,
          '#',
        ),
        _buildSocialButton(
          Icons.link,
          'LinkedIn',
          buttonColor,
          '',
        ),
        _buildSocialButton(
          Icons.code,
          'GitHub',
          buttonColor,
          '',
        ),
        _buildSocialButton( 
          Icons.play_circle_outline,
          'YouTube',
          buttonColor,
          '',
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String tooltip,
    Color color,
    String url,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        onPressed: () => _launchUrl(url),
        icon: Icon(icon),
        color: color,
        tooltip: tooltip,
        iconSize: 28,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton('Contactar', Icons.mail),
        const SizedBox(width: 16),
        _buildActionButton('CV', Icons.description),
      ],
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon),
      label: Text(text),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _StatItem(value: '10', label: 'Proyectos'),
        _StatItem(value: '25K', label: 'Seguidores'),
        _StatItem(value: '4.95', label: 'Rating'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}