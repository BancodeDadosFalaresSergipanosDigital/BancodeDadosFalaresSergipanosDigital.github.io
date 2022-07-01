//  List<FeedbackModel> feedbacksFiltered = [];
//
//   late Values Idade = Values(selectedValue: '', list: [
//     '',
//   ]);
//   late Values Sexo = Values(selectedValue: '', list: ['', 'M', 'F']);
//   late Values Comunidade = Values(selectedValue: '', list: [
//     '',
//   ]);
//   late Values Ano = Values(selectedValue: '', list: [
//     '',
//   ]);
//   late Values Tipo = Values(selectedValue: '', list: ['', 'Entrevista ', 'Interação']);
//   late Values TempoNoCurso = Values(selectedValue: '', list: ['', 'Início', 'Final']);
//   late Values Escolaridade = Values(selectedValue: '', list: ['', 'Ensino Superior', 'Ensino Médio']);
//
// class DragDownWidget extends StatefulWidget {
//   const DragDownWidget({Key? key, required this.values}) : super(key: key);
//
//   final Values values;
//
//   @override
//   _DragDownWidgetState createState() => _DragDownWidgetState();
// }
//
// class _DragDownWidgetState extends State<DragDownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Text("Titulo: "),
//         Card(
//           elevation: 3,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DropdownButton<String>(
//               value: widget.values.selectedValue,
//               icon: const Icon(Icons.arrow_downward),
//               elevation: 16,
//               style: const TextStyle(color: Colors.deepPurple),
//               underline: Container(
//                 height: 2,
//                 color: Colors.deepPurpleAccent,
//               ),
//               onChanged: (String? newValue) => setState(() {
//                 widget.values.selectedValue = newValue!;
//               }),
//               items: widget.values.list.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class Values {
//   late String selectedValue;
//   late List<String> list;
//
//   Values({required this.selectedValue, required this.list});
// }
