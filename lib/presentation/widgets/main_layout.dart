import 'package:abasto_app/presentation/screens/facturacion/facturacion_screen.dart';
import 'package:abasto_app/presentation/screens/inventario/agregar_producto.dart';
import 'package:abasto_app/presentation/screens/inventario/historial_inventario.dart';
import 'package:abasto_app/presentation/screens/inventario/inventario.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

// Importa aquí tus pantallas conforme las vayas creando
// import '../../billing/presentation/screens/billing_screen.dart';
// import '../../inventory/presentation/screens/inventory_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Capa 1: La interfaz completa del sistema
        NavigationView(
          titleBar: TitleBar(
            height: 40,
            title: const Row(
              children: [
                Icon(FluentIcons.shop, size: 16),
                SizedBox(width: 10),
                Text(
                  'AbaSTO - Sistema de Víveres',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            captionControls: const WindowButtons(),
          ),
          pane: NavigationPane(
            selected: _currentIndex,
            onChanged: (index) => setState(() => _currentIndex = index),
            displayMode: PaneDisplayMode.compact,
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.payment_card),
                title: const Text('Facturación'),
                body: FacturacionScreen(),
              ),
              PaneItemExpander(
                icon: const Icon(FluentIcons.product_variant),
                title: Text('Inventario'),
                items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.package),
                    title: const Text('Agregar Productos'),
                    body: AgregarProducto(),
                  ),
                   PaneItem(
                    icon: const Icon(FluentIcons.product_list),
                    title: const Text('Lista de Productos'),
                    body: InventarioScreen(),
                  ),

                  PaneItem(
                    icon: const Icon(FluentIcons.history),
                    title: const Text('Historial de Inventario'),
                    body: HistorialInventarioScreen(),
                  ),

                  PaneItem(
                    icon: const Icon(FluentIcons.category_classification),
                    title: const Text('Categorias'),
                    body: const Center(
                      child: Text('Categoria de los productos del inventario'),
                    ),
                  ),
              ])
            ],
            footerItems: [
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text('Configuración'),
                body: const Center(child: Text('Pantalla de Configuración')),
              ),
            ],
          ),
        ),

        // Capa 2: Zona de arrastre invisible absoluta (Evita el bloqueo de Fluent)
        Positioned(
          top: 0,
          left: 0,
          right:
              140, // Dejamos un margen libre a la derecha para que los botones de minimizar/cerrar sigan recibiendo clics
          height: 40, // Mismo alto que la barra de título
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) => windowManager.startDragging(),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}

// COMPONENTE PARA LOS BOTONES DE CONTROL DE VENTANA
class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(FluentIcons.chrome_minimize, size: 10),
            onPressed: () => windowManager.minimize(),
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(FluentIcons.chrome_full_screen, size: 10),
            onPressed: () async {
              bool isMaximized = await windowManager.isMaximized();
              if (isMaximized) {
                windowManager.restore();
              } else {
                windowManager.maximize();
              }
            },
          ),
          SizedBox(width: 5),
          IconButton(
            icon: Icon(FluentIcons.chrome_close, size: 10, color: Colors.white),
            // Estilo Fluent para el botón de cerrar (se pone rojo al pasar el mouse)
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((state) {
                if (state.contains(WidgetState.hovered)) {
                  return Colors.red;
                }
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>((state) {
                if (state.contains(WidgetState.hovered)) {
                  return Colors.white;
                }
                return Colors.black;
              }),
            ),
            onPressed: () => windowManager.close(),
          ),
        ],
      ),
    );
  }
}
