class MutationRepository {
  static String getAuthTokenMutation() {
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

  static String getSignUpMutation() {
    return '''
      mutation registerUserMutation(
        \$nickname: String!,
        \$email: String!,
        \$phone: Int!,
        \$password:String!
      ){
        registerUser(
          input:{
            nickName: \$nickname,
            email:\$email,
            password:\$password,
            phoneNumber: \$phone
          }
        ){
          success
          user{
              id
              email
            userProfile{
                    nickName
                    firstName
                    lastName
                    phoneNumber
                }

          }
        }
      }
    ''';
  }
}
