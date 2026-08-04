import 'package:flutter_riverpod/flutter_riverpod.dart';

class Currency {
  final String code;
  final String symbol;
  final double rateFromUsd;

  const Currency({
    required this.code,
    required this.symbol,
    required this.rateFromUsd,
  });
}

const List<Currency> availableCurrencies = [
  Currency(code: 'USD', symbol: '\$', rateFromUsd: 1.0),
  Currency(code: 'EUR', symbol: '€', rateFromUsd: 0.92),
  Currency(code: 'GBP', symbol: '£', rateFromUsd: 0.78),
  Currency(code: 'INR', symbol: '₹', rateFromUsd: 83.50),
  Currency(code: 'JPY', symbol: '¥', rateFromUsd: 155.00),
];

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier() : super(availableCurrencies[0]);

  void setCurrency(Currency currency) {
    state = currency;
  }

  String formatPrice(double priceInUsd) {
    final converted = priceInUsd * state.rateFromUsd;
    if (state.code == 'JPY') {
      return '${state.symbol}${converted.toStringAsFixed(0)}';
    }
    return '${state.symbol}${converted.toStringAsFixed(2)}';
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>((ref) {
  return CurrencyNotifier();
});
