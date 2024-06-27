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

        documentNumber
        gender
        hasCompletedOnboarding
        id
        isActive
        occupation

        typeDocument
        uuid
        imageProfileUrl
        address
        percentCompleteProfile

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
              objective
              minAmount
              value
              twelveMonthsReturn
              sixMonthsReturn
              returnDateEstimate
              planImageUrl
              distributionImageUrl
              characteristics{
                text
                isActive
                uuid
                text
                order
                
              }
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
                  objective
                  minAmount
                  value
                  twelveMonthsReturn
                  sixMonthsReturn
                  returnDateEstimate
                  planImageUrl
                  distributionImageUrl
                  characteristics{
                    text
                    isActive
                    uuid
                    text
                    order
                    
                  }
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
              bankLogoUrl
              bankImageCard
              bankImageCardUrl
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
          isReinvestment
          noReinvestment
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
          isReinvestment
          noReinvestment
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
                couponPartnerTags{
                  tagName
                  tagHex
                }
                partnerInfo{
                  partnerName
                  partnerLogo
                  partnerHex
                  partnerImageActivate
                }
                noReInvestment
                noReInvestment
                actionStatus
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
                couponPartnerTags{
                  tagName
                  tagHex
                }
                partnerInfo{
                  partnerName
                  partnerLogo
                  partnerHex
                  partnerImageActivate
                }
                isReInvestment
                noReInvestment
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
                couponPartnerTags{
                  tagName
                  tagHex
                }
                partnerInfo{
                  partnerName
                  partnerLogo
                  partnerHex
                  partnerImageActivate
                }
                isReInvestment
                noReInvestment
                actionStatus
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
                couponPartnerTags{
                  tagName
                  tagHex
                }
                partnerInfo{
                  partnerName
                  partnerLogo
                  partnerHex
                  partnerImageActivate
                }
                isReInvestment
                noReInvestment
              }
            }
          }
        }
''';
  }
  // static String get investmentRentabilityReportV2 {
  //   return '''
  //     query {
  //       userInfoAllInvestment {
  //         invesmentInDolares {
  //           totalBalanceAmmount
  //           countPlanesActive
  //           totalBalanceRentability
  //           invesmentInCourse {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             noReInvestment
  //             noReInvestment
  //           }
  //           investmentPending {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             noReInvestment
  //             noReInvestment
  //           }
  //           invesmentFinished {
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             noReInvestment
  //             noReInvestment
  //           }
  //         }
  //         invesmentInSoles {
  //           totalBalanceAmmount
  //           countPlanesActive
  //           totalBalanceRentability
  //           investmentPending {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             noReInvestment
  //             noReInvestment
  //           }
  //           invesmentInCourse {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             isReInvestment
  //             noReInvestment
  //           }
  //           invesmentFinished {
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //             couponPartnerTags{
  //               tagName
  //               tagHex
  //             }
  //             partnerInfo{
  //               partnerName
  //               partnerLogo
  //               partnerHex
  //               partnerImageActivate
  //             }
  //             isReInvestment
  //             noReInvestment
  //           }
  //         }
  //       }
  //     }
  //   ''';
  // }

  static String get investmentHistoryReportV2 {
    return '''
      query {
        userInfoAllInvestment {
          invesmentInDolares {
            totalBalanceAmmount
            countPlanesActive
            totalBalanceRentability
            invesmentInProcess{
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
            investmentPending {
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
            invesmentInProcess{
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
            investmentPending {
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
              contract
              boucherTransaction
              status
              startDateInvestment
              finishDateInvestment
              rentabilityAmmount
              rentabilityPercent
              planName
            }
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
  // static String get investmentHistoryReportV2 {
  //   return '''
  //     query {
  //       userInfoAllInvestment {
  //         invesmentInDolares {
  //           totalBalanceAmmount
  //           countPlanesActive
  //           totalBalanceRentability
  //           invesmentInProcess{
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //           invesmentInCourse {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //           invesmentFinished {
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //         }
  //         invesmentInSoles {
  //           totalBalanceAmmount
  //           countPlanesActive
  //           totalBalanceRentability
  //           invesmentInProcess{
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //           invesmentInCourse {
  //             uuid
  //             reinvestmentAvailable
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //           invesmentFinished {
  //             uuid
  //             createdAt
  //             isActive
  //             amount
  //             deadline {
  //               uuid
  //               name
  //               value
  //               description
  //             }
  //             depositBank {
  //               bankName
  //               bankLogo
  //               slug
  //             }
  //             contract
  //             boucherTransaction
  //             status
  //             startDateInvestment
  //             finishDateInvestment
  //             rentabilityAmmount
  //             rentabilityPercent
  //             planName
  //           }
  //         }
  //       }
  //     }

  //   ''';
  // }

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

  static String get hasInvestmentInProcess {
    return '''
      query{
        userProfile{
          haveInvestmentDraft
        }
      }
    ''';
  }

  static String get lastPreInvestment {
    return '''
      query getLastPreInvestment(\$email: String!){
        getLastPreInvestment(clientEmail: \$email){
          uuidPreInvestment
          amount
          uuidPlan
          uuidBank
          uuidDeadline
          currency
          couponCode
          countMonths
        }
      }
    ''';
  }

  static String get getUserNotification {
    return '''
      query{
        userNotificationQueries{
          userNotificationsSlider{
            title
            content
            imageSlider
            gradientData
            metadata
            type
          }
        }
      }
    ''';
  }

  static String get getUserBankAccounts {
    return '''
      query getUserBankAccount{
        userBankAccountQueries{
          listBankAccountUser{
            uuid
            bankName
            bankAccount
            currency
            alias
            typeAccount
            isJointAccount
            isDefaultAccount
          }
        }
      }
    ''';
  }

  static String get rentabilityGraph {
    return '''
      query rentabilityGraph(\$timeLine: TimeLineEnum) {
        rentabilityGraph(timeLine: \$timeLine) {
          rentabilityInPen {
            month
            amountPoint
          }
          rentabilityInUsd {
            month
            amountPoint
          }
        }
}
    ''';
  }
}
