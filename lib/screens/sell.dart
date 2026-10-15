import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data.dart';
import '../services.dart';
import '../state.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddProductScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: s.products.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No listings yet.\nTap Add to list a product or service. It is free.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
              children: [
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('A listing helps customers find you. It does not guarantee a sale.'),
                  ),
                ),
                for (final p in s.products) _ProductCard(product: p),
              ],
            ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text('₹${product.price} • ${product.isService ? 'Service' : 'Qty ${product.qty}'} • Sold ${product.sold}'),
            const SizedBox(height: 4),
            Text(product.description),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('WhatsApp message'),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                      text: whatsappMessage(product.name, product.price, product.description),
                    ));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Message copied. Paste it in WhatsApp.')),
                      );
                    }
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Record sale'),
                  onPressed: () => s.recordSale(product),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, this.startWithVoice = false});
  final bool startWithVoice;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _speech = TextEditingController();
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _qty = TextEditingController();
  final _desc = TextEditingController();
  bool _service = false;

  static const _demoSpeech =
      'I make handmade crochet bags. Each bag costs ₹350, and I can make five bags per week.';

  @override
  void initState() {
    super.initState();
    if (widget.startWithVoice) _speech.text = _demoSpeech;
  }

  @override
  void dispose() {
    for (final c in [_speech, _name, _price, _qty, _desc]) {
      c.dispose();
    }
    super.dispose();
  }

  void _fillFromSpeech() {
    final d = parseListing(_speech.text);
    setState(() {
      if (d.name.isNotEmpty) _name.text = d.name;
      if (d.price != null) _price.text = '${d.price}';
      if (d.qty != null) _qty.text = '${d.qty}';
    });
  }

  void _suggestCaption() {
    final price = int.tryParse(_price.text) ?? 0;
    setState(() => _desc.text = captionFor(_name.text, price));
  }

  void _save() {
    final price = int.tryParse(_price.text);
    if (_name.text.trim().isEmpty || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a name and a price.')),
      );
      return;
    }
    AppScope.of(context).addProduct(Product(
      name: _name.text.trim(),
      price: price,
      description: _desc.text.trim().isEmpty ? captionFor(_name.text.trim(), price) : _desc.text.trim(),
      qty: int.tryParse(_qty.text) ?? 1,
      isService: _service,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add listing')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Speak or type about your product'),
          const SizedBox(height: 8),
          TextField(
            controller: _speech,
            maxLines: 3,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: _demoSpeech,
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic),
                tooltip: 'Demo voice input',
                onPressed: () => setState(() => _speech.text = _demoSpeech),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(
            onPressed: _fillFromSpeech,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Make a draft listing'),
          ),
          const Divider(height: 32),
          SwitchListTile(
            title: const Text('This is a service'),
            value: _service,
            onChanged: (v) => setState(() => _service = v),
          ),
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(
            controller: _price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _qty,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity available', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Description (you can edit)', border: OutlineInputBorder()),
          ),
          TextButton.icon(
            onPressed: _suggestCaption,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Suggest a description'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _save,
            child: const Padding(padding: EdgeInsets.all(12), child: Text('Publish listing')),
          ),
        ],
      ),
    );
  }
}
