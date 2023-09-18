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
        address
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

  static String get getPlansSoles {
    return '''
        query getPlansSoles{
            planSoles{
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

  static String get getPlansDolar {
    return '''
        query getPlansDolar{
            planDolar{
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

  static String get userGetBouchers {
    return '''
        query getBouchers{
          userGetBouchers{
            boucherImage
            plan{
              name
            }
            dateSended
            
          }
        }
      ''';
  }

  static String get userHomeReport {
    return '''
          query getUserInvestmentTotalBalance{
            userInfoInvestment{
              totalBalanceAmmount
              countPlanesActive
              totalBalanceRentability
            }
          }
        ''';
  }

  static String get userHomeReportV2 {
    return '''
      query getUserInvestmentTotalBalanceV2{
        userInfoAllInvestment{
          invesmentInDolares{
              totalBalanceAmmount
              countPlanesActive
              totalBalanceRentability
          },
          invesmentInSoles{
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
          }

        }
      }
    ''';
  }

  static String get investmentRentabilityReport {
    return '''
          query {
      userInfoInvestment{
        totalBalanceAmmount
        countPlanesActive
        totalBalanceRentability
        invesmentInCourse{
          uuid
          reinvestmentAvailable
          createdAt
          isActive
          amount
          deadline{
            uuid
            name
            value
            description
          }

          depositBank{
            bankName
            bankLogo
            slug
          }
          contract
          boucherTransaction
          status
          startDateInvestment
          finishDateInvestment
          rentabilityAmmount
          rentabilityPercent
          planName

        }
        invesmentFinished{
          uuid
          createdAt
          isActive
          amount
          deadline{
            uuid
            name
            value
            description
          }
          depositBank{
            bankName
            bankLogo
            slug
          }
          contract
          boucherTransaction
          status
          startDateInvestment
          finishDateInvestment
          rentabilityAmmount
          rentabilityPercent
          planName
        }
        
      }
    }
    ''';
  }

  static String get investmentRentabilityReportV2 {
    return '''
      query {
        userInfoAllInvestment {
          invesmentInDolares {
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
            invesmentInCourse {
              uuid
              reinvestmentAvailable
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
            invesmentFinished {
              uuid
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
          }
          invesmentInSoles {
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
            invesmentInCourse {
              uuid
              reinvestmentAvailable
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
            invesmentFinished {
              uuid
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
          }
        }
      }

    ''';
  }

  static String get investmentHistoryReport {
    return '''
      query {
        userInfoInvestment{
          totalBalanceAmmount
          countPlanesActive
          totalBalanceRentability
          invesmentInCourse{
            uuid
            amount
            deadline{
              uuid
              name
              value
              description
            }
            status
            startDateInvestment
            finishDateInvestment
            rentabilityAmmount
            rentabilityPercent
            planName
          }
          invesmentFinished{
            uuid
            amount
            deadline{
              uuid
              name
              value
              description
            }
            status
            startDateInvestment
            finishDateInvestment
            rentabilityAmmount
            rentabilityPercent
            planName
          }
          invesmentInProcess{
            uuid
            amount
            status
            planName
          }
          invesmentCanceled{
            uuid
            amount
            planName
          }
          
        }
      }
    ''';
  }

  static String get investmentHistoryReportV2 {
    return '''
      query {
        userInfoAllInvestment {
          invesmentInDolares {
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
            invesmentInCourse {
              uuid
              reinvestmentAvailable
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
            invesmentFinished {
              uuid
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
          }
          invesmentInSoles {
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
            invesmentInCourse {
              uuid
              reinvestmentAvailable
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
            invesmentFinished {
              uuid
              createdAt
              isActive
              amount
              deadline {
                uuid
                name
                value
                description
              }
              depositBank {
                bankName
                bankLogo
                slug
              }
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
          }
        }
      }
    ''';
  }

  static String get importantDays {
    return '''
      query getImportantDays{
        importantDays{
          month
          date
          description
        }
      }
    ''';
  }

  static String get paymentDays {
    return '''
      query getPaymentDays{
        paymentDays{
          month
          date
          description
        }
      }
    ''';
  }

  static String get appLastVersion {
    return '''
      query getLastVersion{
        lastVersion{
          minValue
          maxValue
        }
      }
    ''';
  }
}
