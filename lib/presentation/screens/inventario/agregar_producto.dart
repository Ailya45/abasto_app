import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/presentation/providers/productos/product_provider.dart';
import 'package:abasto_app/presentation/widgets/custom_form_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgregarProducto extends ConsumerStatefulWidget {
  const AgregarProducto({super.key});

  @override
  ConsumerState<AgregarProducto> createState() => _AgregarProductoState();
}

class _AgregarProductoState extends ConsumerState<AgregarProducto> {
  // Formulario para agregar productos
  // Llave para usar Form
  final _formKey = GlobalKey<FormState>();

  String? _codigo;
  String? _nombre;
  String? _precioTexto;
  String? _stockTexto;
  String _categoriaSeleccionada = 'Sin categoría';
  
  final List<String> _categorias = [
    'Sin categoría',
    'Licores',
    'Víveres',
    'Lácteos',
    'Limpieza',
    'Snacks',
  ];

  bool _guardando = false;

  // Metodo para guardar el producto
  Future<void> _guardar() async {
    // Validar el formulario
    if (!_formKey.currentState!.validate()) return;

    // Guardar el formulario
    _formKey.currentState!.save();

    // Crear el producto
    final producto = Product(
      barcode: _codigo!,
      name: _nombre!,
      price: double.parse(_precioTexto!),
      stock: int.parse(_stockTexto!),
      category: _categoriaSeleccionada,
    );

    // Mostrar indicador de progreso
    setState(() => _guardando = true);
    try {
      // Guardar el producto
      await ref.read(productProvider.notifier).addProduct(producto);

      if (mounted) {
        // Mostrar mensaje de exito
        _mostrarExito();
        // Limpiar el formulario
        _formKey.currentState!.reset();
      }
    } catch (e) {
      // Mostrar mensaje de error
      _mostrarError(e.toString());
    } finally {
      // Ocultar indicador de progreso
      if (mounted) setState(() => _guardando = false);
    }
  }

  // Metodo para mostrar un cuadro de dialogo con el mensaje de exito
  void _mostrarExito() {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text('Éxito'),
        content: const Text('Producto guardado correctamente.'),
        actions: [
          FilledButton(
            child: const Text('Aceptar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // Metodo para mostrar un cuadro de dialogo con el mensaje de error
  void _mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text('Error'),
        content: Text('No se pudo guardar: $mensaje'),
        actions: [
          Button(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Agregar producto')),
      content: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: FluentTheme.of(context).resources.solidBackgroundFillColorTertiary,
            ),
            color: FluentTheme.of(context).resources.solidBackgroundFillColorQuinary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: FluentTheme.of(context).shadowColor.withValues(
                  alpha: 0.1,
                  red: 0.5,
                  green: 0.5,
                  blue: 0.5,
                ),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600, minWidth: 300),
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Form(
                  // Llave para usar Form
                  key: _formKey, // ← CORREGIDO: ¡Ahora el Form tiene la llave!
                  child: Column(
                    children: [
                      CustomTextFormBox(
                        label: 'Código de barras',
                        placeholder: 'Ej. 085000546546',
                        prefix: const Icon(FluentIcons.edit),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Código de barras es requerido';
                          }
                          return null;
                        },
                        onSaved: (value) => _codigo = value,
                      ),
                      const SizedBox(height: 24),

                      CustomTextFormBox(
                        label: 'Nombre del producto',
                        placeholder: 'Ej. Harina PAN 1Kg',
                        prefix: const Icon(FluentIcons.edit),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nombre es requerido';
                          }
                          if (value.length < 3) {
                            return 'El nombre debe tener al menos 3 caracteres';
                          }
                          return null;
                        },
                        onSaved: (value) => _nombre = value,
                      ),
                      const SizedBox(height: 24),

                      InfoLabel(
                        label: 'Categoría del producto',
                        child: ComboBox<String>(
                          value: _categoriaSeleccionada,
                          isExpanded: true,
                          items: _categorias.map((cat) {
                            return ComboBoxItem(value: cat, child: Text(cat));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _categoriaSeleccionada = value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      CustomTextFormBox(
                        label: 'Precio unitario (USD)',
                        placeholder: 'Precio unitario (USD)',
                        prefix: const Icon(FluentIcons.edit),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Precio es requerido';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Precio inválido';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Debe ser mayor a 0';
                          }
                          return null;
                        },
                        onSaved: (value) => _precioTexto = value,
                      ),
                      const SizedBox(height: 24),

                      CustomTextFormBox(
                        label: 'Stock',
                        placeholder: '10',
                        prefix: const Icon(FluentIcons.edit),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Stock es requerido';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Stock inválido';
                          }
                          if (int.parse(value) < 0) {
                            return 'No puede ser negativo';
                          }
                          return null;
                        },
                        onSaved: (value) => _stockTexto = value,
                      ),
                      const SizedBox(height: 32),

                      FilledButton(
                        onPressed: _guardando ? null : _guardar,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_guardando)
                              const SizedBox(
                                height: 16,
                                width: 16,
                                child: ProgressRing(strokeWidth: 2),
                              ),
                            if (_guardando) const SizedBox(width: 8),
                            const Text('Agregar Producto'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}