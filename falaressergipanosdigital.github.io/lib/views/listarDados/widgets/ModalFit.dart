import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../../models/feedbackmodel.dart';

class ModalFit extends StatelessWidget {
  final FeedbackModel feedback;

  const ModalFit({Key? key, required this.feedback}) : super(key: key);

  Widget espacamento() {
    return const SizedBox(height: 15);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              rowData('Informante', feedback.Informante),
              espacamento(),
              rowData('Idade', feedback.Idade),
              espacamento(),
              rowData('Genero', feedback.Genero),
              espacamento(),
              rowData('Escolaridade', feedback.Escolaridade),
              espacamento(),
              rowData('Tempo_no_curso', feedback.Tempo_no_curso),
              espacamento(),
              rowData('Tipo_de_documentacao', feedback.Tipo_de_documentacao),
              espacamento(),
              rowData('Tipo_de_deslocamento', feedback.Tipo_de_deslocamento),
              espacamento(),
              rowData('Ano_de_coleta', feedback.Ano_de_coleta),
              espacamento(),
              rowData('Comunidade', feedback.Comunidade),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  if (feedback.Link != "") html.window.open(feedback.Link, 'new tab');
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text("Acessar\nArquivos", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
              espacamento(),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowData(String titulo, String valor) {
    return Column(
      children: [
        Row(
          children: [
            Text('$titulo: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(valor, style: const TextStyle(fontSize: 20)),
          ],
        ),
        const Divider(color: Colors.black, thickness: 1)
      ],
    );
  }
}
