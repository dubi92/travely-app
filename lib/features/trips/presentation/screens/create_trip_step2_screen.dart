import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/trip_provider.dart';

class CreateTripStep2Screen extends ConsumerStatefulWidget {
  const CreateTripStep2Screen({super.key});

  @override
  ConsumerState<CreateTripStep2Screen> createState() => _CreateTripStep2ScreenState();
}

class _CreateTripStep2ScreenState extends ConsumerState<CreateTripStep2Screen> {
  String _selectedCurrency = 'USD'; // Default
  // Mock currencies
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD'];

  @override
  void initState() {
    super.initState();
    final draft = ref.read(createTripDraftProvider);
    if (draft['default_currency'] != null) {
      _selectedCurrency = draft['default_currency'];
    }
  }

  void _onNext() {
    // Update draft
    ref.read(createTripDraftProvider.notifier).update((state) => {
      ...state,
      'default_currency': _selectedCurrency,
      // Members logical handling would go here, for now just creator is implied
    });

    context.push('/trips/create/step3');
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _currencies.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            final currency = _currencies[index];
            return ListTile(
              title: Text(currency, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: _selectedCurrency == currency ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
              onTap: () {
                setState(() {
                  _selectedCurrency = currency;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Create Trip'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Step Progress
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(1, false, completed: true),
                _buildStepLine(true),
                _buildStepIndicator(2, true),
                _buildStepLine(false),
                _buildStepIndicator(3, false),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      "Who's joining?",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add friends to the trip and set your currency.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Members Section
                    Text('Trip Members', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    
                    // Current User Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                           BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            radius: 24,
                            child: Text('ME', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('Trip Admin', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                           Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Joined', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Action Buttons (Mock)
                    Row(
                      children: [
                        Expanded(child: _buildActionButton(Icons.link, 'Invite via Link', onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You can invite members after creating the trip.')));
                        })),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionButton(Icons.contacts, 'From Contacts')),
                      ],
                    ),

                    const SizedBox(height: 32),
                     const Divider(),
                    const SizedBox(height: 32),

                    // Currency Section
                    Text('Default Currency', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _showCurrencyPicker,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                         decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_selectedCurrency, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const Icon(Icons.expand_more, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      'This will be used for splitting bills. You can add more currencies later.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),
          
          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
               width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _onNext,
                 style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Next Step'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _buildStepIndicator(int step, bool isActive, {bool completed = false}) {
     Color bgColor = isActive ? Theme.of(context).primaryColor : Colors.transparent;
     Color textColor = isActive ? Colors.white : Colors.grey.shade400;
     Border? border = isActive ? null : Border.all(color: Colors.grey.shade300, width: 2);
     Widget child = Text(step.toString(), style: TextStyle(color: textColor, fontWeight: FontWeight.bold));

     if (completed) {
       bgColor = Theme.of(context).primaryColor;
       textColor = Colors.white;
       border = null;
       child = const Icon(Icons.check, color: Colors.white, size: 16);
     }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildStepLine(bool completed) {
    return Container(
      width: 40,
      height: 2,
      color: completed ? Theme.of(context).primaryColor : Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
           borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent),
           boxShadow: [
               BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
           ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Icon(icon, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
