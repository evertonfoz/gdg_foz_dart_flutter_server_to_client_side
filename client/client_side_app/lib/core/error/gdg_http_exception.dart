class GdgHttpException implements Exception {
  final String message;

  GdgHttpException(this.message);

  static final Map<int, String> statusCodeResponses = {
    400:
        'Ocorreu um erro na comunicação com o servidor. Verifique sua conexão com a internet e tente novamente.',
    401: 'Falha na autorização. Verifique usuário e senha e tente novamente.',
    403: 'Falha na autenticação, verifique usuário e senha e tente novamente.',
    404: 'O recurso requisitado não existe. Verifique os valores informados.',
    409:
        'Há conflito nos dados informados. Possivelmente o email já esteja registrado.'
  };

  static String getErrorMessage(int statusCode) {
    if (statusCodeResponses.containsKey(statusCode)) {
      return statusCodeResponses[statusCode];
    }
    return 'Erro desconhecido.';
  }
}
