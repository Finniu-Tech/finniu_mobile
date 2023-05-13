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

  static String get regions => '''
    query{
      regions{
        coddpto
        nomDpto
        slug
      }
    }
  ''';

  static String get provinces => '''
    query{
      provincias{
        idprov
        codprov
        nomProv
        dpto{
          coddpto
        }
        slug
      }
    }
  ''';

  static String get districts => '''
    query{
      distritos{
        prov{
          codprov
          dpto{
            coddpto
          }
        }
        iddist
        coddist
        nomDist
        slug
      }
    }
  ''';

  static String get getPlans {
    return '''
      query getPlans{
        planData{
          uuid
          name
          description
          minAmount
          value
          twelveMonthsReturn
          sixMonthsReturn
          returnDateEstimate
          planImageUrl
        }
      }
  ''';
  }

  static String get getDeadLines {
    return '''
    query getDeadLines{
      deadlines{
        uuid
        isActive
        name
        value
        description
        
      }
    }
  ''';
  }

  static String get getBanks {
    return '''
      query getBanks{
        banks{
          uuid
          isActive
          bankName
          bankLogo
        }
      }
    ''';
  }

  static String get contractUrl {
    return '''
      query getContract(\$uuid: String! ){
        getContractPreinvestment(preInvestmentUuid: \$uuid){
        contract
        }
      }
    ''';
  }
}
