## Features

a simple way to create a selector with predefined options for the user

## Images

<div style="display: flex;">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/1.png" alt="Start" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/2.png" alt="All" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/3.png" alt="Filter" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/4.png" alt="Select" style="flex: 1; padding: 10px;" width="324" height="720">
</div>

## Getting started

Just import the package.

```dart
import 'package:selectpicker/selectpicker.dart';
```

And transform your list in a list of SelectPickerIten and call the SelectPicker

```dart
SelectPicker(
        hint: "Select an item",
        list: [
            SelectPickerIten("title1", "id", null),
            SelectPickerIten("title2", "id", null),
            SelectPickerIten("title3", "id", null),
        ],
        selectFirst: true,
        showId: true,
        onSelect: (value) {
         if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.title.toString())));
          }
        },
        hintSearch: "Serach by item description or ID",
        selectPickerInputStyle: SelectPickerInputStyle(),
)
```

Enjoy.

## Example

This a simple screen with usage example.
[example/example.dart](https://github.com/gaabrielricci/selectpicker/blob/main/lib/example/example.dart)

```dart
import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/selectpicker.dart';
import 'package:selectpicker/styles/input_style.dart';

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SelectPicker", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectPicker(
              hint: "Select an UF",
              list: getStatesPicker(),
              selectFirst: false,
              onSelect: (value) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(value.title.toString())));
              },
              hintSearch: "Serach by UF description or ID",
              selectPickerInputStyle: SelectPickerInputStyle(),
              initialItem: "DF",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectPicker(
              hint: "Select an item",
              list: [
                SelectPickerIten("title1", "id", null),
                SelectPickerIten("title2", "id", null),
                SelectPickerIten("title3", "id", null),
              ],
              selectFirst: true,
              showId: true,
              onSelect: (value) {
                if (mounted) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value.title.toString())));
                }
              },
              hintSearch: "Serach by item description or ID",
              selectPickerInputStyle: SelectPickerInputStyle(),
            ),
          ),
        ],
      ),
    );
  }

  static List<Uf> getUf() {
    List<Uf> list = [];
    list.add(Uf("Acre", "AC"));
    list.add(Uf("Alagoas", "AL"));
    list.add(Uf("Amapá", "AP"));
    list.add(Uf("Amazonas", "AM"));
    list.add(Uf("Bahia", "BA"));
    list.add(Uf("Ceará", "CE"));
    list.add(Uf("Espírito Santo", "ES"));
    list.add(Uf("Goiás", "GO"));
    list.add(Uf("Maranhão", "MA"));
    list.add(Uf("Mato Grosso", "MT"));
    list.add(Uf("Mato Grosso do Sul", "MS"));
    list.add(Uf("Minas Gerais", "MG"));
    list.add(Uf("Pará", "PA"));
    list.add(Uf("Paraíba", "PB"));
    list.add(Uf("Paraná", "PR"));
    list.add(Uf("Pernambuco", "PE"));
    list.add(Uf("Piauí", "PI"));
    list.add(Uf("Rio de Janeiro", "RJ"));
    list.add(Uf("Rio Grande do Norte", "RN"));
    list.add(Uf("Rio Grande do Sul", "RS"));
    list.add(Uf("Rondônia", "RO"));
    list.add(Uf("Roraima", "RR"));
    list.add(Uf("Santa Catarina", "SC"));
    list.add(Uf("São Paulo", "SP"));
    list.add(Uf("Sergipe", "SE"));
    list.add(Uf("Tocantins", "TO"));
    list.add(Uf("Distrito Federal", "DF"));
    return list;
  }

  static List<SelectPickerIten> getStatesPicker() {
    try {
      List<SelectPickerIten> list = [];
      for (Uf item in getUf()) {
        list.add(SelectPickerIten(item.name, item.uf, item));
      }
      return list;
    } catch (error) {
      return [];
    }
  }
}

class Uf {
  Uf(this.name, this.uf);

  String name;
  String uf;
}



```

## Credits

- Created by [Ricci Mobile](https://riccimobile.com.br)
