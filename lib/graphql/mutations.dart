class MutationRepository {
  static String getAuthToken() {
    return '''
      mutation getTokenAuth(\$password: String!, \$email: String!) {
        tokenAuth( password: \$password, email: \$email){
          payload
          token
          refreshExpiresIn
        }
    }
    ''';
  }
}
