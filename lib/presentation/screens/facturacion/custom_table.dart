import 'package:fluent_ui/fluent_ui.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. ENCABEZADO DE LA TABLA (Una fila horizontal fija)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: FluentTheme.of(
                  context,
                ).resources.solidBackgroundFillColorBase,
              ),
            ),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Código',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Nombre',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'P. Unitario',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Cantidad',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Subtotal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Acciones',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        // 2. CUERPO DE LA TABLA (El ListView ahora sí está abajo del encabezado)
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: FluentTheme.of(context).shadowColor.withValues(
                        alpha:
                            0.1, // Reducido a 0.1 para que se vea sutil como Windows 11
                        red: 0.5,
                        green: 0.5,
                        blue: 0.5,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Text('75010011')),
                    const Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                          'Harina de Maíz 1kg',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: Text('\$ 1.20')),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 90,
                          child: NumberBox<int>(
                            min: 1,
                            max: 999,
                            value: 2,
                            onChanged: (val) {},
                            mode: SpinButtonPlacementMode.none,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: Text('\$ 2.40')),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(FluentIcons.delete, size: 14),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
