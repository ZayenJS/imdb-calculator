import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ironmaster_dumbbell_calculator/utils/converter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedEquipement = 0;

  // weights are in lbs
  final double dumbbellWeight = 10.0;
  final double kettlebellWeight = 22.5;
  final double ezBarWeight = 15.0;

  Map<String, double> _neededWeights = {
    '22_5': 0,
    '5': 0,
    '2_5': 0,
  };
  double _realWeight = 0.0;

  late TextEditingController _weightInKgController;
  late TextEditingController _weightInLbsController;

  @override
  void initState() {
    super.initState();

    _weightInKgController = TextEditingController();
    _weightInLbsController = TextEditingController();
  }

  @override
  void dispose() {
    _weightInKgController.dispose();
    _weightInLbsController.dispose();

    super.dispose();
  }

  void _handleEquipementChange(int index) {
    setState(() {
      _selectedEquipement = index;
    });
  }

  Color _getEquipementColor(int index) {
    return _selectedEquipement == index
        ? Theme.of(context).colorScheme.secondary.withOpacity(0.25)
        : Colors.transparent;
  }

  void _calculateNeededWeights() {
    final weightInLbs = double.tryParse(_weightInLbsController.text);

    if (weightInLbs == null) {
      setState(() {
        _realWeight = 0.0;
        _neededWeights = {
          '22_5': 0,
          '5': 0,
          '2_5': 0,
        };
      });
      return;
    }

    // TODO: refactor + extract to a class -> param = weightInLbs
    double available22_5LbsPlates = 2;
    double available5LbsPlates = 12;
    double available2_5LbsPlates = 2;

    final double _maxAchievableWeight = 22.5 * available22_5LbsPlates +
        5 * available5LbsPlates +
        2.5 * available2_5LbsPlates;

    if (weightInLbs > _maxAchievableWeight) {
      // TODO: show a snackbar
      setState(() {
        _realWeight = 0.0;
        _neededWeights = {
          '22_5': 0,
          '5': 0,
          '2_5': 0,
        };
      });
      return;
    }

    double needed22_5LbsPlates = 0;
    double needed5LbsPlates = 0;
    double needed2_5LbsPlates = 0;

    double remainingWeight = weightInLbs;

    if (_selectedEquipement == 0) {
      remainingWeight -= dumbbellWeight;

      // always use pairs for 22.5 lbs plates
      if (available22_5LbsPlates >= 2) {
        for (int i = 0; i < available22_5LbsPlates; i++) {
          if (remainingWeight >= 22.5 * 2) {
            needed22_5LbsPlates += 2;
            remainingWeight -= 22.5 * 2;
          }
        }
      }

      // always use pairs for 5 lbs plates
      for (int i = 0; i < available5LbsPlates; i++) {
        if (remainingWeight >= 5 * 2) {
          needed5LbsPlates += 2;
          remainingWeight -= 5 * 2;
        }
      }

      for (int i = 0; i < available2_5LbsPlates; i++) {
        if (remainingWeight >= 2.5) {
          needed2_5LbsPlates++;
          remainingWeight -= 2.5;
        }
      }
    } else if (_selectedEquipement == 1) {
      remainingWeight -= kettlebellWeight;

      if (available22_5LbsPlates > 0) {
        for (int i = 0; i < available22_5LbsPlates; i++) {
          if (remainingWeight >= 22.5) {
            needed22_5LbsPlates++;
            remainingWeight -= 22.5;
          }
        }
      }

      for (int i = 0; i < available5LbsPlates; i++) {
        if (remainingWeight >= 5) {
          needed5LbsPlates++;
          remainingWeight -= 5;
        }
      }

      for (int i = 0; i < available2_5LbsPlates; i++) {
        if (remainingWeight >= 2.5) {
          needed2_5LbsPlates++;
          remainingWeight -= 2.5;
        }
      }
    } else if (_selectedEquipement == 2) {
      remainingWeight -= ezBarWeight;

      // always use pairs for 22.5 lbs plates
      if (available22_5LbsPlates >= 2) {
        for (int i = 0; i < available22_5LbsPlates; i++) {
          if (remainingWeight >= 22.5 * 2) {
            needed22_5LbsPlates += 2;
            remainingWeight -= 22.5 * 2;
          }
        }
      }

      // always use pairs for 5 lbs plates
      for (int i = 0; i < available5LbsPlates; i++) {
        if (remainingWeight >= 5 * 2) {
          needed5LbsPlates += 2;
          remainingWeight -= 5 * 2;
        }
      }

      for (int i = 0; i < available2_5LbsPlates; i++) {
        if (remainingWeight >= 2.5) {
          needed2_5LbsPlates++;
          remainingWeight -= 2.5;
        }
      }
    }

    setState(() {
      _realWeight = weightInLbs - remainingWeight;
      _neededWeights = {
        '22_5': needed22_5LbsPlates,
        '5': needed5LbsPlates,
        '2_5': needed2_5LbsPlates,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width / 5;
    const double imageHeight = 70.0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Text(
                  'Select your equipment',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _getEquipementColor(0),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        _handleEquipementChange(0);
                      },
                      child: Image.asset(
                        'assets/images/dumbbell.png',
                        width: imageWidth,
                        height: imageHeight,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _getEquipementColor(1),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        _handleEquipementChange(1);
                      },
                      child: Image.asset(
                        'assets/images/kettlebell.png',
                        width: imageWidth,
                        height: imageHeight,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _getEquipementColor(2),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        _handleEquipementChange(2);
                      },
                      child: Image.asset(
                        'assets/images/ez-bar.png',
                        width: imageWidth,
                        height: imageHeight,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _weightInKgController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight in kg',
                      ),
                      onChanged: (value) {
                        final weightInKg = double.tryParse(value);

                        if (weightInKg == null) {
                          _weightInLbsController.text = '';
                        } else {
                          _weightInLbsController.text =
                              Converter.kgToLbs(weightInKg).toString();
                        }

                        _calculateNeededWeights();
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _weightInLbsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight in lbs',
                      ),
                      onChanged: (value) {
                        final weightInLbs = double.tryParse(value);

                        if (weightInLbs == null) {
                          _weightInKgController.text = '';
                        } else {
                          _weightInKgController.text =
                              Converter.lbsToKg(weightInLbs).toString();
                        }

                        _calculateNeededWeights();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Text(
                  'Needed plates',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('22.5 lbs'),
                          Text(
                            _neededWeights['22_5']!.toInt().toString(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('5 lbs'),
                          Text(
                            _neededWeights['5']!.toInt().toString(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('2.5 lbs'),
                          Text(
                            _neededWeights['2_5']!.toInt().toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
