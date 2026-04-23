import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/checkout_order_item.dart';
import '../widgets/checkout_order_summary_item.dart';
import '../widgets/checkout_text_field.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  bool _didSeedControllers = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didSeedControllers) {
      return;
    }

    final store = AppScope.of(context);
    final defaultAddress = store.defaultAddress;
    _fullNameController.text = store.userName;
    _phoneController.text = defaultAddress.phoneNumber;
    _addressController.text = defaultAddress.addressLine;
    _cityController.text = defaultAddress.city;
    _postalCodeController.text = defaultAddress.postalCode;
    _didSeedControllers = true;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final items = store.cart
            .map((line) => _toCheckoutOrderItem(store, line))
            .toList(growable: false);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.4,
                  ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHECKOUT JOURNEY',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF676767),
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Finalize Purchase',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1.0,
                        ),
                  ),
                  const SizedBox(height: 28),
                  if (items.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Text(
                              'Add products to your bag before checkout.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: const Color(0xFF727272),
                                  ),
                            ),
                            const SizedBox(height: 18),
                            FilledButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteNames.mainShell,
                                  (route) => false,
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text('CONTINUE SHOPPING'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Text(
                      'DELIVERY DETAILS',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF3B3B3B),
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: store.addresses.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final address = store.addresses[index];
                          final isSelected = address.isDefault;
                          return ChoiceChip(
                            label: Text(address.label),
                            selected: isSelected,
                            onSelected: (_) {
                              store.setDefaultAddress(address.id);
                              _fullNameController.text = address.recipientName;
                              _phoneController.text = address.phoneNumber;
                              _addressController.text = address.addressLine;
                              _cityController.text = address.city;
                              _postalCodeController.text = address.postalCode;
                            },
                            selectedColor: Colors.black,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF313131),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    CheckoutTextField(
                      label: 'Full Name',
                      controller: _fullNameController,
                    ),
                    const SizedBox(height: 14),
                    CheckoutTextField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),
                    CheckoutTextField(
                      label: 'Shipping Address',
                      controller: _addressController,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CheckoutTextField(
                            label: 'City',
                            controller: _cityController,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: CheckoutTextField(
                            label: 'Postal Code',
                            controller: _postalCodeController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'PAYMENT METHOD',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF3B3B3B),
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 14),
                    ...store.paymentMethods.map(
                      (method) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => store.setDefaultPaymentMethod(method.id),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: method.isDefault
                                    ? Colors.black
                                    : const Color(0xFFD7D3CC),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  method.brand == 'VISA'
                                      ? Icons.credit_card
                                      : Icons.account_balance_wallet_outlined,
                                  color: const Color(0xFF444444),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${method.brand} ${method.maskedNumber}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: const Color(0xFF222222),
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${method.holderName}  |  Expires ${method.expiry}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: const Color(0xFF666666),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (method.isDefault)
                                  const Icon(Icons.check_circle,
                                      color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF3B3B3B),
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 18),
                    for (int i = 0; i < items.length; i++) ...[
                      CheckoutOrderSummaryItem(item: items[i]),
                      if (i != items.length - 1) const SizedBox(height: 18),
                    ],
                    const SizedBox(height: 24),
                    _SummaryLine(
                      label: 'Subtotal',
                      value: CurrencyFormatter.lkr(store.cartSubtotal),
                    ),
                    const SizedBox(height: 10),
                    if (store.cartDiscount > 0) ...[
                      _SummaryLine(
                        label: 'Discount',
                        value: '- ${CurrencyFormatter.lkr(store.cartDiscount)}',
                        valueColor: const Color(0xFF2C6A45),
                      ),
                      const SizedBox(height: 10),
                    ],
                    _SummaryLine(
                      label: 'Shipping',
                      value: store.cartShipping == 0
                          ? 'FREE'
                          : CurrencyFormatter.lkr(store.cartShipping),
                    ),
                    const SizedBox(height: 10),
                    _SummaryLine(
                      label: 'Tax',
                      value: CurrencyFormatter.lkr(store.cartTax),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFFE0DCD5), height: 1),
                    const SizedBox(height: 16),
                    _SummaryLine(
                      label: 'Total',
                      value: CurrencyFormatter.lkr(store.cartTotal),
                      emphasized: true,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          final fullName = _fullNameController.text.trim();
                          final phone = _phoneController.text.trim();
                          final address = _addressController.text.trim();
                          final city = _cityController.text.trim();
                          final postalCode = _postalCodeController.text.trim();

                          if (fullName.isEmpty ||
                              phone.isEmpty ||
                              address.isEmpty ||
                              city.isEmpty ||
                              postalCode.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please complete your delivery details.'),
                              ),
                            );
                            return;
                          }

                          final success = store.placeOrder(
                            fullName: fullName,
                            phone: phone,
                            address: address,
                            city: city,
                            postalCode: postalCode,
                          );

                          if (!success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Add items to your bag before placing an order.'),
                              ),
                            );
                            return;
                          }

                          Navigator.pushNamed(context, RouteNames.orderSuccess);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        child: const Text('PLACE ORDER'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'Secure encrypted checkout with saved delivery and payment preferences.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF6F6F6F),
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  CheckoutOrderItem _toCheckoutOrderItem(AppStore store, CartLine line) {
    final product = store.productById(line.productId);
    return CheckoutOrderItem(
      name: product.name,
      meta:
          '${product.productType} | SIZE ${line.selectedSize} | QTY ${line.quantity}',
      price: CurrencyFormatter.lkr(product.price * line.quantity),
      background: product.cardBackgroundColor,
      icon: product.cardIcon,
      iconColor: product.cardIconColor,
      imagePath: product.imagePath,
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasized;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = emphasized
        ? Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFF232323),
              fontWeight: FontWeight.w700,
            )
        : Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF5A5A5A),
              fontWeight: FontWeight.w500,
            );

    return Row(
      children: [
        Text(label, style: textStyle),
        const Spacer(),
        Text(
          value,
          style: textStyle?.copyWith(
            color: valueColor ?? textStyle.color,
          ),
        ),
      ],
    );
  }
}
