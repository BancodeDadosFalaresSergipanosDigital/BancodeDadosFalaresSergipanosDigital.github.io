class FeedbackModel {
  String Informante;
  String Tipo_de_documentacao;
  String Comunidade;
  String Ano_de_coleta;
  String Tipo_de_deslocamento;
  String Tempo_no_curso;
  String Genero;
  String Escolaridade;
  String Idade;
  String Link;

  FeedbackModel(
      {required this.Informante,
      required this.Tipo_de_documentacao,
      required this.Comunidade,
      required this.Ano_de_coleta,
      required this.Tipo_de_deslocamento,
      required this.Tempo_no_curso,
      required this.Genero,
      required this.Escolaridade,
      required this.Idade,
      required this.Link
      });

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      Informante: "${json['Informante']}",
      Tipo_de_documentacao: "${json['Tipo_de_documentacao']}",
      Comunidade: "${json['Comunidade']}",
      Ano_de_coleta: "${json['Ano_de_coleta']}",
      Tipo_de_deslocamento: "${json['Tipo_de_deslocamento']}",
      Tempo_no_curso: "${json['Tempo_no_curso']}",
      Genero: "${json['Genero']}",
      Escolaridade: "${json['Escolaridade']}",
      Idade: "${json['Idade']}",
      Link: "${json['Link']}",
    );
  }

  Map toJson() => {
        "Informante": Informante,
        "Tipo_de_documentacao": Comunidade,
        "Comunidade": Ano_de_coleta,
        "Ano_de_coleta": Ano_de_coleta,
        "Tipo_de_deslocamento": Tipo_de_deslocamento,
        "Tempo_no_curso": Tempo_no_curso,
        "Genero": Genero,
        "Escolaridade": Escolaridade,
        "Idade": Idade,
        "Link": Link,
      };
}
