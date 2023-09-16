import 'dart:io';
import 'package:flutter/material.dart';

class CadastrarContatosController extends ChangeNotifier {
  // Lista de opções para os campos de seleção
  final List<String> dias =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> meses =
      List.generate(12, (index) => (index + 1).toString());
  final List<String> anos =
      List.generate(100, (index) => (2023 - index).toString());

  // Valores selecionados para os campos de seleção
  String? selectedDia;
  String? selectedMes;
  String? selectedAno;
  File? selectedImage;
}
