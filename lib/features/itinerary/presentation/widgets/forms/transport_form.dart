import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../shared/widgets/inputs/app_text_field.dart';

class TransportForm extends StatefulWidget {
  final Map<String, dynamic> initialMetadata;
  final DateTime? initialStartTime;
  final DateTime? initialEndTime;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const TransportForm({
    super.key,
    this.initialMetadata = const {},
    this.initialStartTime,
    this.initialEndTime,
    required this.onChanged,
  });

  @override
  State<TransportForm> createState() => _TransportFormState();
}

class _TransportFormState extends State<TransportForm> {
  late String _transportType;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _ticketController = TextEditingController();
  final _codeController = TextEditingController();

  late DateTime _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _transportType = widget.initialMetadata['transport_type'] ?? 'taxi';
    _fromController.text = widget.initialMetadata['from_location'] ?? '';
    _toController.text = widget.initialMetadata['to_location'] ?? '';
    _ticketController.text = widget.initialMetadata['ticket_number'] ?? '';
    _codeController.text = widget.initialMetadata['transport_code'] ?? '';

    _startTime = widget.initialStartTime ?? DateTime.now();
    _endTime = widget.initialEndTime;

    _fromController.addListener(_notifyChange);
    _toController.addListener(_notifyChange);
    _ticketController.addListener(_notifyChange);
    _codeController.addListener(_notifyChange);
  }

  void _notifyChange() {
    widget.onChanged({
      'transport_type': _transportType,
      'from_location': _fromController.text,
      'to_location': _toController.text,
      'ticket_number': _ticketController.text,
      'transport_code': _codeController.text,
      'start_time': _startTime,
      'end_time': _endTime,
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _ticketController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final initial = isStart
        ? _startTime
        : (_endTime ?? _startTime.add(const Duration(hours: 1)));
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isStart) {
        setState(() {
          _startTime = DateTime(_startTime.year, _startTime.month,
              _startTime.day, picked.hour, picked.minute);
        });
      } else {
        setState(() {
          var dt = DateTime(_startTime.year, _startTime.month, _startTime.day,
              picked.hour, picked.minute);
          if (dt.isBefore(_startTime)) {
            dt = dt.add(const Duration(days: 1));
          }
          _endTime = dt;
        });
      }
      _notifyChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Transport Type Selector
        const Text(
          'TRANSPORT TYPE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.playfulTextPrimary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTransportOption('walk', '🚶', 'Walk'),
            _buildTransportOption('bus', '🚌', 'Bus'),
            _buildTransportOption('train', '🚄', 'Train'),
            _buildTransportOption('taxi', '🚕', 'Taxi'),
            _buildTransportOption('plane', '✈️', 'Plane'),
          ],
        ),
        const SizedBox(height: 24),

        // Route
        // Route
        AppTextField(
          controller: _fromController,
          label: 'FROM',
          placeholder: 'Origin',
          prefixIcon: const Icon(Icons.location_on_outlined, size: 18),
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _toController,
          label: 'TO',
          placeholder: 'Destination',
          prefixIcon: const Icon(Icons.flag_outlined, size: 18),
        ),
        const SizedBox(height: 16),

        // Ticket Info
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _ticketController,
                label: 'TICKET #',
                placeholder: 'Optional',
                prefixIcon:
                    const Icon(Icons.confirmation_number_outlined, size: 18),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppTextField(
                controller: _codeController,
                label: 'CODE',
                placeholder: 'e.g. AA123',
                prefixIcon: const Icon(Icons.numbers, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Time
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                        text:
                            '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                    label: 'DEPART',
                    placeholder: '00:00',
                    prefixIcon: const Icon(Icons.schedule, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, false),
                child: AbsorbPointer(
                  child: AppTextField(
                    controller: TextEditingController(
                        text: _endTime != null
                            ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
                            : ''),
                    label: 'ARRIVE',
                    placeholder: 'Optional',
                    prefixIcon: const Icon(Icons.schedule_send, size: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransportOption(String value, String emoji, String label) {
    final isSelected = _transportType == value;
    return GestureDetector(
      onTap: () {
        setState(() => _transportType = value);
        _notifyChange();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.playfulTextPrimary
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
