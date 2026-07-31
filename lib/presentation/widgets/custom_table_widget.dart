import 'package:fluent_ui/fluent_ui.dart';

// Modelo para definir la estructura de cada columna
class TableColumn<T> {
  final String title;
  final double? width; // Ancho fijo opcional
  final int flex; // Proporción de ancho (como en Expanded)
  final TextAlign? titleTextAlign; // Alineación del título (por defecto: izquierda)
  final Widget Function(T item) cellBuilder;

  TableColumn({
    required this.title,
    this.width,
    this.flex = 1,
    this.titleTextAlign,
    required this.cellBuilder,
  });
}

class CustomTableWidget<T> extends StatelessWidget {
  final List<T> items;
  final List<TableColumn<T>> columns;
  final String mensajeVacio;
  final EdgeInsets rowPadding;

  const CustomTableWidget({
    super.key,
    required this.items,
    required this.columns,
    this.mensajeVacio = 'No hay datos disponibles',
    this.rowPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(mensajeVacio));
    }

    return Column(
      children: [
        // 1. ENCABEZADO DE LA TABLA
        Container(
          padding: EdgeInsets.only(
            left: rowPadding.left,
            top: 10,
            right: rowPadding.right,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: FluentTheme.of(context).resources.subtleFillColorSecondary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
          child: Row(
            children: columns.map((col) {
              final headerWidget = Text(
                col.title,
                style: FluentTheme.of(context).typography.bodyStrong,
                textAlign: col.titleTextAlign ?? TextAlign.start,
              );

              final paddingWidget = Padding(
                padding: const EdgeInsets.only(right: 16),
                child: headerWidget,
              );

              if (col.width != null) {
                return SizedBox(width: col.width, child: paddingWidget);
              }
              return Expanded(flex: col.flex, child: paddingWidget);
            }).toList(),
          ),
        ),

        const Divider(style: DividerThemeData(verticalMargin: EdgeInsets.zero)),

        // 2. CUERPO DE LA TABLA (FILAS)
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) => const Divider(
              style: DividerThemeData(verticalMargin: EdgeInsets.zero),
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                padding: rowPadding,
                child: Row(
                  children: columns.map((col) {
                    final cellWidget = col.cellBuilder(item);

                    final paddingWidget = Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: cellWidget,
                    );

                    if (col.width != null) {
                      return SizedBox(width: col.width, child: paddingWidget);
                    }
                    return Expanded(flex: col.flex, child: paddingWidget);
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}