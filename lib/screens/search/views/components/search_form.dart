import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    this.formKey,
    this.isEnabled = true,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onTabFilter,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  final GlobalKey<FormState>? formKey;
  final bool isEnabled;
  final ValueChanged<String?>? onSaved, onChanged, onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTabFilter;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        autofocus: autofocus,
        focusNode: focusNode,
        enabled: isEnabled,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Buscar por Producto",
          filled: false,
          prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.search, // Icono de búsqueda de Material Icons
                size: 24, // Tamaño del icono
                color: Theme.of(context)
                    .iconTheme
                    .color!
                    .withOpacity(0.3), // Color con opacidad
              )),
          suffixIcon: SizedBox(
            width: 40,
            child: Row(
              children: [
                const SizedBox(
                  height: 24,
                  child: VerticalDivider(width: 1),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: onTabFilter,
                      icon: Icon(
                        Icons.search, // Icono de búsqueda de Material Icons
                        size: 24, // Tamaño del icono
                        color: Theme.of(context)
                            .iconTheme
                            .color!
                            .withOpacity(0.3), // Color con opacidad
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
