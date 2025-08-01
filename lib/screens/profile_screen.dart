import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Антон');
  final TextEditingController _ageController = TextEditingController(text: '25');
  final TextEditingController _heightController = TextEditingController(text: '180');
  final TextEditingController _weightController = TextEditingController(text: '75');
  
  String _selectedGender = 'male';
  String _selectedActivityLevel = 'moderate';
  bool _isExperimentActive = false;
  int _experimentDaysCompleted = 0;
  double _muscleProgress = 0.0;

    List<ProgressMetric> _getProgressMetrics(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      ProgressMetric(
        name: l10n.muscleMass,
        currentValue: 65.0,
        targetValue: 70.0,
        unit: l10n.kg,
        icon: Icons.fitness_center,
        color: Colors.green,
      ),
      ProgressMetric(
        name: l10n.fatMass,
        currentValue: 15.0,
        targetValue: 12.0,
        unit: l10n.percent,
        icon: Icons.pie_chart,
        color: Colors.orange,
      ),
      ProgressMetric(
        name: l10n.gripStrength,
        currentValue: 45.0,
        targetValue: 55.0,
        unit: l10n.kg,
        icon: Icons.handshake,
        color: Colors.blue,
      ),
    ];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        backgroundColor: Colors.deepPurple.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade700,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile header
              _buildProfileHeader(),
              const SizedBox(height: 20),
              
              // Personal info
              _buildPersonalInfo(),
              const SizedBox(height: 20),
              
              // Progress metrics
              _buildProgressMetrics(),
              const SizedBox(height: 20),
              
              // Experiment status
              _buildExperimentStatus(),
              const SizedBox(height: 20),
              
              // Settings
              _buildSettings(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.deepPurple.shade300,
            child: Text(
              _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : 'А',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _nameController.text.isNotEmpty ? _nameController.text : AppLocalizations.of(context)!.user,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.experimentParticipant,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.personalInformation,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildInfoField(AppLocalizations.of(context)!.name, _nameController, Icons.person),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(child: _buildInfoField(AppLocalizations.of(context)!.age, _ageController, Icons.cake)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoField(AppLocalizations.of(context)!.gender, null, Icons.people, isDropdown: true)),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(child: _buildInfoField(AppLocalizations.of(context)!.height, _heightController, Icons.height)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoField(AppLocalizations.of(context)!.weight, _weightController, Icons.monitor_weight)),
            ],
          ),
          const SizedBox(height: 12),
          
          _buildInfoField(AppLocalizations.of(context)!.activityLevel, null, Icons.directions_run, isDropdown: true),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController? controller, IconData icon, {bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        if (isDropdown) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
            child: DropdownButton<String>(
              value: label == 'Пол' ? _selectedGender : _selectedActivityLevel,
              dropdownColor: Colors.deepPurple.shade800,
              style: const TextStyle(color: Colors.white),
              underline: const SizedBox(),
              isExpanded: true,
              items: label == AppLocalizations.of(context)!.gender 
                ? [
                    DropdownMenuItem(value: 'male', child: Text(AppLocalizations.of(context)!.male)),
                    DropdownMenuItem(value: 'female', child: Text(AppLocalizations.of(context)!.female)),
                  ]
                : [
                    DropdownMenuItem(value: 'low', child: Text(AppLocalizations.of(context)!.low)),
                    DropdownMenuItem(value: 'moderate', child: Text(AppLocalizations.of(context)!.moderate)),
                    DropdownMenuItem(value: 'high', child: Text(AppLocalizations.of(context)!.high)),
                  ],
              onChanged: (value) {
                setState(() {
                  if (label == 'Пол') {
                    _selectedGender = value!;
                  } else {
                    _selectedActivityLevel = value!;
                  }
                });
              },
            ),
          ),
        ] else ...[
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProgressMetrics() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.progress,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          ..._getProgressMetrics(context).map((metric) => _buildProgressMetric(metric)),
        ],
      ),
    );
  }

  Widget _buildProgressMetric(ProgressMetric metric) {
    final progress = metric.currentValue / metric.targetValue;
    final isImproving = metric.name == AppLocalizations.of(context)!.fatMass 
        ? metric.currentValue > metric.targetValue 
        : metric.currentValue < metric.targetValue;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: metric.color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(metric.icon, color: metric.color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  metric.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${metric.currentValue.toStringAsFixed(1)}/${metric.targetValue.toStringAsFixed(1)} ${metric.unit}',
                style: TextStyle(
                  color: metric.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(metric.color),
          ),
          const SizedBox(height: 4),
          Text(
            isImproving ? 'Progress: ${(progress * 100).toInt()}%' : 'Target: ${metric.targetValue} ${metric.unit}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.experimentStatus,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Icon(
                _isExperimentActive ? Icons.play_circle : Icons.pause_circle,
                color: _isExperimentActive ? Colors.green : Colors.orange,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isExperimentActive ? AppLocalizations.of(context)!.experimentActive : AppLocalizations.of(context)!.experimentNotStarted,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Days Completed: $_experimentDaysCompleted',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (_isExperimentActive) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _muscleProgress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              'Progress: ${(_muscleProgress * 100).toInt()}%',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.settings,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSettingItem(
            AppLocalizations.of(context)!.notifications,
            AppLocalizations.of(context)!.notificationsDescription,
            Icons.notifications,
            true,
          ),
          _buildSettingItem(
            AppLocalizations.of(context)!.autoSave,
            AppLocalizations.of(context)!.autoSaveDescription,
            Icons.save,
            true,
          ),
          _buildSettingItem(
            AppLocalizations.of(context)!.darkTheme,
            AppLocalizations.of(context)!.darkThemeDescription,
            Icons.dark_mode,
            true,
          ),
          _buildSettingItem(
            AppLocalizations.of(context)!.exportData,
            AppLocalizations.of(context)!.exportDataDescription,
            Icons.download,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon, bool hasSwitch) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (hasSwitch)
            Switch(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.deepPurple.shade300,
            ),
        ],
      ),
    );
  }
}

class ProgressMetric {
  final String name;
  final double currentValue;
  final double targetValue;
  final String unit;
  final IconData icon;
  final Color color;

  ProgressMetric({
    required this.name,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
    required this.icon,
    required this.color,
  });
} 