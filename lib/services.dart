// Lightweight helpers behind the "AI-assisted" features.
//
// The MVP runs these rules locally so the demo works offline and without
// API keys. To use a real model, replace the bodies of [parseListing] and
// [captionFor] with calls to an AI API (for example Gemini or Claude) and a
// speech-to-text plugin such as `speech_to_text`.

class ListingDraft {
  String name = '';
  int? price;
  int? qty;
}

const _numberWords = {
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
  'ten': 10,
};

/// Turns a spoken or typed sentence like
/// "I make handmade crochet bags. Each bag costs ₹350, I can make five bags per week."
/// into a draft listing the user can correct.
ListingDraft parseListing(String text) {
  final draft = ListingDraft();

  final nameMatch = RegExp(
    r'(?:make|sell)\s+(?:some\s+)?(.+?)(?:[.,]|\s+each|\s+and\s|$)',
    caseSensitive: false,
  ).firstMatch(text);
  if (nameMatch != null) draft.name = nameMatch.group(1)!.trim();

  final priceMatch = RegExp(
    r'(?:₹|rs\.?\s*|rupees\s*)(\d+)|(\d+)\s*(?:rupees|rs\b)',
    caseSensitive: false,
  ).firstMatch(text);
  if (priceMatch != null) {
    draft.price = int.tryParse(priceMatch.group(1) ?? priceMatch.group(2) ?? '');
  }

  final qtyMatch = RegExp(
    r'(\d+|one|two|three|four|five|six|seven|eight|nine|ten)\s+\w+\s+per\s+(?:week|month|day)',
    caseSensitive: false,
  ).firstMatch(text);
  if (qtyMatch != null) {
    final raw = qtyMatch.group(1)!.toLowerCase();
    draft.qty = int.tryParse(raw) ?? _numberWords[raw];
  }
  return draft;
}

String captionFor(String name, int price) {
  final label = name.isEmpty ? 'handmade product' : name;
  return 'Handmade $label, lovingly crafted with care. '
      'Price: ₹$price. Custom designs available. '
      'Message us to place your order!';
}

String whatsappMessage(String name, int price, String description) {
  return '*$name* - ₹$price\n$description\n\nTo order, reply to this message. Thank you! 🌻';
}

/// Suggested selling price = costs + desired profit.
int suggestedPrice({
  required int materials,
  required int packaging,
  required int labour,
  required int profit,
}) =>
    materials + packaging + labour + profit;
