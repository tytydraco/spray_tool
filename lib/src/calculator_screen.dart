import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spray_tool/src/decimal_text_input_formatter.dart';

/// Screen for calculating everything.
class CalculatorScreen extends StatefulWidget {
  /// Creates a new [CalculatorScreen].
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _totalCapacityController = TextEditingController();
  final _numberOfSpraysController = TextEditingController();
  final _mgPerSprayController = TextEditingController();
  final _mLPerBatchController = TextEditingController();

  Widget _titleText() => const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Text(
            'Spray tool',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _resultText(Object result) => Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            result.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      );

  Widget _unsignedDoubleField(
    String labelText,
    TextEditingController textEditingController,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: [UnsignedDoubleTextInputFormatter()],
          onChanged: (_) => setState(() {}),
        ),
      );

  Widget _unsignedIntField(
    String labelText,
    TextEditingController textEditingController,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (_) => setState(() {}),
        ),
      );

  Widget _totalCapacityField() => _unsignedDoubleField(
        'Total liquid capacity (mL)',
        _totalCapacityController,
      );

  Widget _numberOfSpraysField() =>
      _unsignedIntField('Total number of sprays', _numberOfSpraysController);

  Widget _desiredDosageField() => _unsignedDoubleField(
        'Medication dosage per spray (mg)',
        _mgPerSprayController,
      );

  Widget _mLPerBatchField() =>
      _unsignedDoubleField('Batch liquid capacity (mL)', _mLPerBatchController);

  Widget _mLPerSprayText() => _resultText('${_prettyMLPerSpray()}mL/spray');

  Widget _spraysPerMLText() => _resultText('${_prettySpraysPerML()} sprays/mL');

  Widget _mgPerMLText() => _resultText('${_prettyMgPerML()}mg/mL for solution');

  Widget _mgPerBatchText() => _resultText('${_prettyMgPerBatch()}mg for batch');

  double _calcMLPerSpray() {
    final totalCapacity = double.tryParse(_totalCapacityController.text);
    final numberOfSprays = int.tryParse(_numberOfSpraysController.text);

    if (totalCapacity == null || numberOfSprays == null) return 0;

    return totalCapacity / numberOfSprays;
  }

  String _prettyMLPerSpray() {
    final mLPerSpray = _calcMLPerSpray();
    return mLPerSpray.toStringAsFixed(2);
  }

  double _calcSpraysPerML() {
    final totalCapacity = double.tryParse(_totalCapacityController.text);
    final numberOfSprays = int.tryParse(_numberOfSpraysController.text);

    if (totalCapacity == null || numberOfSprays == null) return 0;

    return numberOfSprays / totalCapacity;
  }

  String _prettySpraysPerML() {
    final spraysPerML = _calcSpraysPerML();
    return spraysPerML.toStringAsFixed(2);
  }

  double _calcMgPerML() {
    final mgPerSpray = double.tryParse(_mgPerSprayController.text);
    final spraysPerML = _calcSpraysPerML();

    if (mgPerSpray == null) return 0;

    return mgPerSpray * spraysPerML;
  }

  String _prettyMgPerML() {
    final mgPerML = _calcMgPerML();
    return mgPerML.toStringAsFixed(2);
  }

  double _calcMgPerBatch() {
    final mLPerBatch = double.tryParse(_mLPerBatchController.text);
    final mgPerML = _calcMgPerML();

    if (mLPerBatch == null) return 0;

    return mLPerBatch * mgPerML;
  }

  String _prettyMgPerBatch() {
    final mgPerML = _calcMgPerBatch();
    return mgPerML.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            shrinkWrap: true,
            children: [
              _titleText(),
              _totalCapacityField(),
              _numberOfSpraysField(),
              _desiredDosageField(),
              _mLPerBatchField(),
              const Divider(),
              _mLPerSprayText(),
              _spraysPerMLText(),
              _mgPerMLText(),
              _mgPerBatchText(),
            ],
          ),
        ),
      ),
    );
  }
}
