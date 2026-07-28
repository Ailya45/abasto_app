import 'package:fluent_ui/fluent_ui.dart';

class ResumenPagoPanel extends StatefulWidget {
  const ResumenPagoPanel({super.key});

  @override
  State<ResumenPagoPanel> createState() => _ResumenPagoPanelState();
}

class _ResumenPagoPanelState extends State<ResumenPagoPanel> {
  String? metodoSeleccionado;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTotalPagar(context),

        Expanded(child: _buildResumenPagar(context)),
      ],
    );
  }

  Container _buildResumenPagar(BuildContext context) {
    List<String> metodosPago = [
      'Efectivo',
      'Biopago',
      'Tarjeta de debito',
      'Tarjeta de credito',
      'Pago movil',
    ];
    return Container(
      padding: EdgeInsets.all(24),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: FluentTheme.of(context).cardColor,
        border: Border.all(
          color: FluentTheme.of(context).resources.solidBackgroundFillColorBase,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Text(
            textAlign: TextAlign.center,
            'Resumen y Pago:',
            style: FluentTheme.of(
              context,
            ).typography.bodyStrong?.copyWith(fontSize: 24),
          ),
          SizedBox(height: 24),
          InfoLabel(
            label: 'Metodo de pago:',
            child: ComboBox<String>(
              value: metodoSeleccionado,
              placeholder: Text("Seleccione un metodo de pago"),
              items: metodosPago.map((metPago) {
                return ComboBoxItem(value: metPago, child: Text(metPago));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  metodoSeleccionado = value;
                });
              },
            ),
          ),
          SizedBox(height: 24),
          InfoLabel(
            label: 'Precio en Bs:',
            child: TextBox(placeholder: 'Bs. 0.00'),
          ),
          SizedBox(height: 16),

          InfoLabel(
            label: 'Precio en Bs + IVA:',
            child: TextBox(placeholder: 'Bs. 0.00', readOnly: true),
          ),
          SizedBox(height: 16),

          InfoLabel(
            label: 'Total a pagar en Bs:',
            child: TextBox(placeholder: 'Bs. 0.00'),
          ),

          SizedBox(height: 40),

          FilledButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.payment_card),
                SizedBox(width: 8),
                Text("Finalizar Venta"),
              ],
            ),
            onPressed: () {},
          ),
        ],
        ),
      ),
    );
  }

  Container _buildTotalPagar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: FluentTheme.of(context).cardColor,
        border: Border.all(
          color: FluentTheme.of(context).resources.solidBackgroundFillColorBase,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Total a pagar",
            style: FluentTheme.of(
              context,
            ).typography.bodyStrong?.copyWith(fontSize: 24),
          ),
          Text(
            "Bs. 0.00",
            style: FluentTheme.of(context).typography.bodyStrong?.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
