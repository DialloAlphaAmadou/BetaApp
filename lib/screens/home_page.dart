import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // HERO SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 50,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.rocket_launch,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  "Bienvenue",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Une plateforme moderne pour gérer vos services, vos pages et vos paramètres facilement.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 25),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Commencer"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // STATISTIQUES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: const [
                _StatCard(
                  icon: Icons.people,
                  title: "Utilisateurs",
                  value: "1 245",
                ),
                _StatCard(
                  icon: Icons.build,
                  title: "Services",
                  value: "48",
                ),
                _StatCard(
                  icon: Icons.pages,
                  title: "Pages",
                  value: "120",
                ),
                _StatCard(
                  icon: Icons.star,
                  title: "Avis",
                  value: "4.9/5",
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // FONCTIONNALITÉS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Fonctionnalités principales",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    _FeatureCard(
                      icon: Icons.dashboard,
                      title: "Dashboard",
                      description:
                          "Visualisez toutes vos données rapidement.",
                    ),
                    _FeatureCard(
                      icon: Icons.settings,
                      title: "Paramètres",
                      description:
                          "Personnalisez votre expérience utilisateur.",
                    ),
                    _FeatureCard(
                      icon: Icons.language,
                      title: "Multi-langues",
                      description:
                          "Support de plusieurs langues.",
                    ),
                    _FeatureCard(
                      icon: Icons.dark_mode,
                      title: "Mode sombre",
                      description:
                          "Interface claire et sombre disponible.",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // SECTION ACTIONS
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      "Prêt à commencer ?",
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Accédez à vos services et découvrez toutes les fonctionnalités disponibles.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.explore),
                      label: const Text("Explorer"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 45),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}