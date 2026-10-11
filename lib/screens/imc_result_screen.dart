import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;
  const ImcResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(context),
    );
  }

  Padding bodyResult(BuildContext context) {
    double fixedHeight = height / 100;
    double imcResult = weight / (fixedHeight * fixedHeight);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundComponent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTitleByImc(imcResult),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: getColorByImc(imcResult),
                      ),
                    ),
                    Text(
                      imcResult.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 76,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getDescriptionByImc(imcResult),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  AppColors.primary,
                ),
              ),
              child: Text("finalizar", style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      title: Text("IMC Result"),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    );
  }

  Color? getColorByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 => Colors.blue, //imc bajo
      < 24.9 => Colors.green, //imc normal
      < 29.9 => Colors.orange, //imc sobrepeso
      _ => Colors.red, //imc obesidad
    };
  }

  String getTitleByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 => "Bajo peso", //imc bajo
      < 24.9 => "Normal", //imc normal
      < 29.9 => "Sobrepeso", //imc sobrepeso
      _ => "Obesidad", //imc obesidad
    };
  }

  String getDescriptionByImc(double imcResult) {
    return switch(imcResult){
      < 18.5 => "Tu peso está por debajo de lo recomendado", //imc bajo
      < 24.9 => "Tu peso está dentro del rango normal", //imc normal
      < 29.9 => "Tu peso está por encima del rango normal", //imc sobrepeso
      _ => "Tienes obesidad consulta con un especialista", //imc obesidad
    };
  }
}
