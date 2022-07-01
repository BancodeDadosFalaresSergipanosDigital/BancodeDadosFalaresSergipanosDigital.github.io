import 'package:flutter/material.dart';
import 'package:falaressergipanosdigital/resources/auth_methods.dart';
import 'package:falaressergipanosdigital/views/login/login.dart';
import '../../models/feedbackmodel.dart';
import '../aguardandoAprovacao.dart';
import 'widgets/ModalFit.dart';
import 'functions/getFeedbackFromSheet.dart';
import 'package:falaressergipanosdigital/models/user.dart' as user_model;
import 'widgets/FloatingModal.dart';

List<FeedbackModel> feedbacks = [];

class ListarDados extends StatefulWidget {
  const ListarDados({Key? key}) : super(key: key);

  @override
  _ListarDadosState createState() => _ListarDadosState();
}

class _ListarDadosState extends State<ListarDados> {
  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banco de dados Falares Sergipanos"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                AuthMethods authMethods = AuthMethods();
                await authMethods.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout)),
          FutureBuilder(
            future: authMethods.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Container();
              user_model.User user = snapshot.data as user_model.User;
              if (user.user_type == 1) return Container();
              return IconButton(onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AguardandoAprovacao()));
              }, icon: const Icon(Icons.event_available));
            },
          )
        ],
      ),
      body: FutureBuilder(
        initialData: feedbacks,
        future: feedbacks.isEmpty ? getFeedbackFromSheet() : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && feedbacks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (feedbacks.isEmpty) {
            feedbacks = snapshot.data as List<FeedbackModel>;
          }
          return SortableDataTable(
            feedbacks: feedbacks,
          );
        },
      ),
    );
  }
}

class SortableDataTable extends StatefulWidget {
  final List<FeedbackModel> feedbacks;

  const SortableDataTable({Key? key, required this.feedbacks}) : super(key: key);

  @override
  State<SortableDataTable> createState() => _SortableDataTableState();
}

class _SortableDataTableState extends State<SortableDataTable> {
  int? sortColumnIndex;
  bool isAscending = true;
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return buildDataTable();
  }

  Widget buildDataTable() {
    final columns = ['Idade', 'Sexo', 'Tempo No Curso', 'Escolaridade', 'Detalhes'];

    return Center(
      child: SizedBox(
        width: size!.width * 0.7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              sortAscending: isAscending,
              border: TableBorder.all(color: Colors.black, borderRadius: BorderRadius.circular(10)),
              sortColumnIndex: sortColumnIndex,
              columns: getColumns(columns),
              rows: getRows(widget.feedbacks),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns.map((String column) => DataColumn(label: Text(column), onSort: onSort)).toList();

  List<DataRow> getRows(List<FeedbackModel> feedbacks) => feedbacks.map((feedback) {
        final cells = [feedback.Idade, feedback.Genero, feedback.Tempo_no_curso, feedback.Escolaridade, 'Detalhes'];
        return DataRow(cells: getCells(cells, feedback));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells, FeedbackModel feedback) => cells
      .map((data) => DataCell('$data' == 'Detalhes'
          ? TextButton(
              onPressed: () => showFloatingModalBottomSheet(context: context, builder: (context) => ModalFit(feedback: feedback)),
              child: Text(data, style: const TextStyle(color: Colors.white)),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            )
          : Text('$data')))
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.feedbacks.sort((feedback1, feedback2) => ascending ? feedback1.Idade.compareTo(feedback2.Idade) : feedback2.Idade.compareTo(feedback1.Idade));
    } else if (columnIndex == 1) {
      widget.feedbacks.sort((feedback1, feedback2) => ascending ? feedback1.Genero.compareTo(feedback2.Genero) : feedback2.Genero.compareTo(feedback1.Genero));
    } else if (columnIndex == 2) {
      widget.feedbacks
          .sort((feedback1, feedback2) => ascending ? feedback1.Tempo_no_curso.compareTo(feedback2.Tempo_no_curso) : feedback2.Tempo_no_curso.compareTo(feedback1.Tempo_no_curso));
    } else if (columnIndex == 3) {
      widget.feedbacks.sort((feedback1, feedback2) => ascending ? feedback1.Escolaridade.compareTo(feedback2.Escolaridade) : feedback2.Escolaridade.compareTo(feedback1.Escolaridade));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
