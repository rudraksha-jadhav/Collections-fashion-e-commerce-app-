import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class TrackingStep {
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;

  TrackingStep({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isCurrent = false,
  });

  TrackingStep copyWith({bool? isCompleted, bool? isCurrent}) {
    return TrackingStep(
      title: title,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}

class OrderModel {
  final String orderId;
  final String date;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String paymentMethod;
  final List<TrackingStep> trackingSteps;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.trackingSteps,
  });

  OrderModel copyWith({
    String? status,
    List<TrackingStep>? trackingSteps,
  }) {
    return OrderModel(
      orderId: orderId,
      date: date,
      items: items,
      totalAmount: totalAmount,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      trackingSteps: trackingSteps ?? this.trackingSteps,
    );
  }
}

class OrdersNotifier extends StateNotifier<List<OrderModel>> {
  OrdersNotifier()
      : super([
          OrderModel(
            orderId: '#ORD-98421',
            date: 'Aug 04, 2026 — 14:32 PM',
            items: [
              CartItem(
                id: '1',
                title: 'Revival Hoodies',
                price: 320.99,
                size: 'M',
                image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
                quantity: 1,
              ),
            ],
            totalAmount: 323.49,
            status: 'Out for Delivery',
            deliveryAddress: '742 Evergreen Terrace, Suite 4B, New York, NY 10001',
            paymentMethod: 'Apple Pay',
            trackingSteps: [
              TrackingStep(title: 'Order Placed', description: 'Aug 04, 2026 — 14:32 PM', isCompleted: true),
              TrackingStep(title: 'Quality Inspection', description: 'Aug 04, 2026 — 16:00 PM', isCompleted: true),
              TrackingStep(title: 'Out for Delivery (DHL Express)', description: 'Driver assigned — ETA today 18:00 PM', isCompleted: false, isCurrent: true),
              TrackingStep(title: 'Delivered', description: 'Pending package arrival', isCompleted: false),
            ],
          ),
        ]);

  OrderModel placeOrder({
    required List<CartItem> items,
    required double totalAmount,
    required String deliveryAddress,
    required String paymentMethod,
  }) {
    final randomNum = Random().nextInt(90000) + 10000;
    final orderId = '#ORD-$randomNum';
    final newOrder = OrderModel(
      orderId: orderId,
      date: 'Just now',
      items: items,
      totalAmount: totalAmount,
      status: 'Order Placed',
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      trackingSteps: [
        TrackingStep(title: 'Order Placed', description: 'Just now — Payment confirmed', isCompleted: true, isCurrent: true),
        TrackingStep(title: 'Quality Inspection', description: 'Pending verification at hub', isCompleted: false),
        TrackingStep(title: 'Out for Delivery (DHL Express)', description: 'Pending dispatch', isCompleted: false),
        TrackingStep(title: 'Delivered', description: 'Pending package arrival', isCompleted: false),
      ],
    );

    state = [newOrder, ...state];
    return newOrder;
  }

  void advanceTrackingStatus(String orderId) {
    state = state.map((order) {
      if (order.orderId != orderId) return order;

      final steps = [...order.trackingSteps];
      final currentIdx = steps.indexWhere((s) => s.isCurrent);

      if (currentIdx >= 0 && currentIdx < steps.length - 1) {
        steps[currentIdx] = steps[currentIdx].copyWith(isCompleted: true, isCurrent: false);
        steps[currentIdx + 1] = steps[currentIdx + 1].copyWith(isCurrent: true);

        final newStatus = steps[currentIdx + 1].title;
        return order.copyWith(status: newStatus, trackingSteps: steps);
      } else if (currentIdx == steps.length - 1) {
        steps[currentIdx] = steps[currentIdx].copyWith(isCompleted: true, isCurrent: false);
        return order.copyWith(status: 'Delivered', trackingSteps: steps);
      }

      return order;
    }).toList();
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<OrderModel>>((ref) {
  return OrdersNotifier();
});

final latestOrderProvider = Provider<OrderModel?>((ref) {
  final orders = ref.watch(ordersProvider);
  return orders.isNotEmpty ? orders.first : null;
});
