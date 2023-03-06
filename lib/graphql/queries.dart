class QueryRepository {
  static String get getUserProfile => '''
    query{
      userProfile{
        firstName
        lastName
        email
        id
        nickName
        civilStatus
        distrito
        documentNumber
        gender
        hasCompletedOnboarding
        id
        isActive
        occupation
        provincia
        region
        typeDocument
        uuid
        imageProfileUrl
      }
    }
  ''';
}
