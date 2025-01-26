class QueryRepository {
  static String get getUserProfile => '''
    query{
      userProfile{
        firstName
        lastName
        email
        userId
        nickName
        civilStatus  
        hasCompletedOnboarding
        isActive
        occupation

     
        uuid
        imageProfileUrl
        address
        percentCompleteProfile
        hasCompletedTour
        
        lastNameFather
        lastNameMother
        typeDocument
        documentNumber
        gender
        region{
          id
        }
        provincia{
          id
        }
        distrito{
          id
        }
        country
        regionExt
        provinciaExt
        distritoExt
      	address
        houseNumber
        postalCode
        
        laborSituation
        actualPosition
        serviceTime

        biography
        facebook
        instagram
        linkedin

        isDirectorOrShareholder10Percent
        isPublicOfficialOrFamily
        acceptPrivacyPolicy
        acceptTermsConditions
        birthdayDate
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
            bankCciAccount
            currency
            alias
            typeAccount
            isJointAccount
            isDefaultAccount
            bankLogoUrl
            bankSlug
          }
        }
      }
    ''';
  }

  static String get rentabilityGraphic {
    return '''
      query rentabilityGraph(\$timeLine: TimeLineEnum, \$fundUUID: String) {
        rentabilityGraph(timeLine: \$timeLine, investmentFundUuid: \$fundUUID) {
          rentabilityInPen {
            month
            amountPoint
            date
          }
          rentabilityInUsd {
            month
            amountPoint
            date
          }
        }
      }

    ''';
  }

  static String get userInfoAllInvestment {
    return '''
      query userInfoAllInvestment {
      userInfoAllInvestment{
          invesmentInSoles {
            investmentPending{
              uuid
              amount
              finishDateInvestment
              isReInvestment
            }
            invesmentInProcess{
              uuid
              amount
              finishDateInvestment
            }
            invesmentInCourse{
              uuid
              amount
              finishDateInvestment
              reinvestmentAvailable
              actionStatus
              isReInvestment
              investmentFund{
              uuid
              name
              icon
              listBackgroundColorLight
              listBackgroundColorDark
              detailBackgroundColorLight
              detailBackgroundColorDark
              backgroundImageUrl
              mainImageUrl
              createdAt
              isDeleted
              isActive
              fundType
              tagDetailId
              tagBenefitsId
              tagDownloadInfoId
              tagInvestmentButtonId
              mainImageHorizontalUrl
              detailBackgroundColorSecondaryLight
              detailBackgroundColorDarkSecondary
              lastRentability
              netWorthAmount
              assetsUnderManagement
              moreInfoDownloadUrl
              minAmountInvestmentPen
              minAmountInvestmentUsd
              objectiveFunds
              }              
            }
            invesmentFinished{
              uuid
              amount
              finishDateInvestment
               rentabilityAmmount
              boucherList{
                boucherImage
              }
            }
          }
          invesmentInDolares{
              investmentPending{
              uuid
              amount
              finishDateInvestment
              isReInvestment
              
            }
            invesmentInProcess{
              uuid
              amount
              finishDateInvestment
            }
            invesmentInCourse{
              uuid
              amount
              finishDateInvestment
              reinvestmentAvailable
              actionStatus
              isReInvestment
              investmentFund{
                uuid
            name
            icon
            listBackgroundColorLight
            listBackgroundColorDark
            detailBackgroundColorLight
            detailBackgroundColorDark
            backgroundImageUrl
            mainImageUrl
            createdAt
            isDeleted
            isActive
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorSecondaryLight
            detailBackgroundColorDarkSecondary
            lastRentability
            netWorthAmount
            assetsUnderManagement
            moreInfoDownloadUrl
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds
              }
            }
            invesmentFinished{
              uuid
              amount
              finishDateInvestment
               rentabilityAmmount
              boucherList{
                boucherImage
              }
            }
          }
        }
      }
  

    ''';
  }

  static String get userInfoAllInvestmentV4 {
    return '''
      query userInfoAllInvestment {
      userInfoAllInvestment{
          invesmentInSoles {
            invesmentInProcess{
              uuid
              amount
              finishDateInvestment
              investmentFund{
                name
              }
              rentabilityPercent
            }
            invesmentInCourse{
              uuid
              amount
              finishDateInvestment
              reinvestmentAvailable
              actionStatus
              isReInvestment
              rentabilityAmmount
              investmentFund{
                uuid
            name
            icon
            listBackgroundColorLight
            listBackgroundColorDark
            detailBackgroundColorLight
            detailBackgroundColorDark
            backgroundImageUrl
            mainImageUrl
            createdAt
            isDeleted
            isActive
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorSecondaryLight
            detailBackgroundColorDarkSecondary
            lastRentability
            netWorthAmount
            assetsUnderManagement
            moreInfoDownloadUrl
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds
              }
            }
            invesmentFinished{
              uuid
              amount
              finishDateInvestment
              rentabilityAmmount
             	investmentFund{
                name
              }
              paymentRentability{
                amount
                paymentDate
              }
            }
          }
          invesmentInDolares{
            invesmentInProcess{
              uuid
              amount
              finishDateInvestment
              investmentFund{
                name
              }
              rentabilityPercent
            }
            invesmentInCourse{
              uuid
              amount
              finishDateInvestment
              reinvestmentAvailable
              actionStatus
              isReInvestment
               investmentFund{
                 uuid
                 name
              }
              rentabilityAmmount
            }
            invesmentFinished{
              uuid
              amount
              finishDateInvestment
              rentabilityAmmount
             	investmentFund{
 
                uuid
            name
            icon
            listBackgroundColorLight
            listBackgroundColorDark
            detailBackgroundColorLight
            detailBackgroundColorDark
            backgroundImageUrl
            mainImageUrl
            createdAt
            isDeleted
            isActive
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorSecondaryLight
            detailBackgroundColorDarkSecondary
            lastRentability
            netWorthAmount
            assetsUnderManagement
            moreInfoDownloadUrl
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds
              }
              paymentRentability{
                amount
                paymentDate
              }
            }
          }
        }
      }

    ''';
  }

  static String get investmentDetailByUuid {
    return '''
     query investmentDetail (\$preInvestmentUuid : String!) {
      investmentDetail(preInvestmentUuid : \$preInvestmentUuid){
        deadline {
          value
        }
        boucherList {
          boucherImage
        }
        actionStatus
        operationCode
        rentabilityIncreased
        uuid
        amount
        rentabilityAmmount
        rentabilityPercent
        startDateInvestment
        finishDateInvestment
        paymentCapitalDateInvestment
        contract
        isReInvestment
        bankAccountReceiver {
          uuid
          bankName
          bankAccount
          bankCciAccount
          bankLogoUrl
          bankSlug
          currency
          alias
          typeAccount
          isJointAccount
          isDefaultAccount
          createdAt
        }
        paymentRentability{
            paymentDate
            amount
          }
  
        bankAccountSender {
            uuid
            bankName
            bankAccount
            bankCciAccount
            bankLogoUrl
            bankSlug
            currency
            alias
            typeAccount
            isJointAccount
            isDefaultAccount
            createdAt
          }
          reinvestmentInfo{
            reinvestmentAditionalAmount
            startDate
            contractUrl
            reinvestmentType
          }
          investmentFund{
            uuid
            name
            icon
            listBackgroundColorLight
            listBackgroundColorDark
            detailBackgroundColorLight
            detailBackgroundColorDark
            backgroundImageUrl
            mainImageUrl
            createdAt
            isDeleted
            isActive
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorSecondaryLight
            detailBackgroundColorDarkSecondary
            lastRentability
            netWorthAmount
            assetsUnderManagement
            moreInfoDownloadUrl
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds

         
          }
        }
      }
    ''';
  }

  static String get getFundInvestmentDetail {
    return '''
       query getFundInvestmentDetail (\$preInvestmentUuid : String!) {
      investmentDetail(preInvestmentUuid : \$preInvestmentUuid){
       		deadline{
            value
          }
          rentabilityPercent
        uuid
        amount
        currency
          investmentFund {
            uuid
            name
            icon
            listBackgroundColorLight
            listBackgroundColorDark
            detailBackgroundColorLight
            detailBackgroundColorDark
            backgroundImageUrl
            mainImageUrl
            createdAt
            isDeleted
            isActive
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorSecondaryLight
            detailBackgroundColorDarkSecondary
            lastRentability
            netWorthAmount
            assetsUnderManagement
            moreInfoDownloadUrl
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds
          }
        }
      }
    ''';
  }

  static String get getFundInvestmentDetailV4 {
    return '''
       query getFundInvestmentDetail (\$preInvestmentUuid : String!) {
        investmentDetail(preInvestmentUuid : \$preInvestmentUuid){
            deadline{
              value
            }
            rentabilityPercent
            originFunds
            uuid
            amount
            currency
            investmentFund {
              uuid
              name
            }
          }
        }
    ''';
  }

  static String get preReinvest {
    return '''
    query preReinvest(\$preInvestmentUuid: String!){
      reInvestmentQueries{
        preReInvestment(preInvestmentUuid: \$preInvestmentUuid){
          initialAmount
          rentabilityAmount
          deadlineString
          futureRentabilityAmount
        }
      }
    }
    ''';
  }

  static String get getInvestmentMonthlyReturns {
    return '''
      query getInvestmentMonthlyReturns(\$preInvestmentUuid: String!){
        investmentDetail(preInvestmentUuid: \$preInvestmentUuid){
          paymentRentability{
            paymentDate
            amount
            numberPayment
            paymentVoucherUrl
          }
        }
      }
    ''';
  }

  static String get getInvestmentMonthlyReturnsV4 {
    return '''
        query getInvestmentMonthlyReturns(\$preInvestmentUuid: String!){
        investmentDetail(preInvestmentUuid: \$preInvestmentUuid){
       		rentabilityAmmount
        	rentabilityPercent
        	amount
    			paymentCapitalDateInvestment
          operationCode
          paymentRentability{
          isActive
           paymentDate
            amount
            numberPayment
            paymentVoucherUrl
            isCapitalPayment
          }
          	bankAccountReceiver {
       		  uuid
       		  bankName
       		  bankSlug
       		  bankLogoUrl
       		  bankAccount
       		  bankCciAccount
       		  currency
       		  alias
       		  typeAccount
       		  isJointAccount
       		  isDefaultAccount
       		  createdAt
       		}
          investmentFund{
            name
          }
        }
      }
    ''';
  }

  static String get getContratTaxReports {
    return '''
     query getContratTaxReports (\$preInvestmentUuid : UUID!){
      documentationQueries{
        contracts(preInvestmentUuid:\$preInvestmentUuid){
        contractDate
          contractUrl
        }
        taxes(preInvestmentUuid:\$preInvestmentUuid){
          taxDate
          taxUrl
        }
        quarterlyReports(preInvestmentUuid:\$preInvestmentUuid){
          reportDate
          reportUrl
        }
      }
    }
    ''';
  }

  static String get getFunds {
    return '''
       query getFunds{
        investmentFundsQueries{
          listInvestmentFundsAvailable{
            minAmountInvestmentPen
            minAmountInvestmentUsd
            objectiveFunds
            characteristics{
              benefitText
              icon
              isActive
            }
            uuid
            name
            icon
            listBackgroundColorDark
            listBackgroundColorLight
            detailBackgroundColorDark
            detailBackgroundColorLight
            backgroundImageUrl
            assetsUnderManagement
            mainImageUrl
            fundType
            tagDetailId
            tagBenefitsId
            tagDownloadInfoId
            tagInvestmentButtonId
            mainImageHorizontalUrl
            detailBackgroundColorDarkSecondary
            detailBackgroundColorSecondaryLight
          
            createdAt
            isDeleted
            isActive
            lastRentability
            netWorthGraph{
              date
              value
            }
            netWorthAmount
            currentInstallment{
              date
              value
            }
            moreInfoDownloadUrl
  
            
          }
        }
      }
      
    ''';
  }

  static String get getBenefitsFund {
    return '''
      query getFundBenefits(\$fundUUID:UUID!){
      investmentFundsQueries{
        listBenefitsInvestmentFundsAvailable(investmentFundUuid: \$fundUUID){
          uuid
          benefitText
          icon
          backgroundColorDark
          backgroundColorLight
          isDeleted
          isActive
        }
      }
    }
    ''';
  }

  static String get getAggroInvestmentList {
    return '''
      query AgroInvestment{
        agroInvestmentList{
          uuid
          investmentFundName
          parcelAmount
          parcelNumber
          numberOfInstallments
          parcelMonthlyInstallment
          createdAt
          updatedAt
          isActive
          progressInvestment{
            daysPassed
            daysRemaining
            totalDays
            startDay
            endDay
          }
        }
      }
    ''';
  }

  static String get userFeatureFlags {
    return '''
      query userData{
        userProfile{
          featuresFlagsAvailable{
              uuid
              name
              slug
              description
              isActive
          }
        }
      }
      ''';
  }

  static String get aggroInvestmentQuotes {
    return '''
      query getAggroQuotes{
        agroInvestmentQueries{
          calculateQuotesAvailable
        }
      }
    ''';
  }

  static String get regionsV2 {
    return '''
     query Region{
      regions {
        id
        nomDpto
      }
    }
    ''';
  }

  static String get getProvincesByIdV2 {
    return '''
      query getProvinciasByIdV2(\$idDpto: String!) {
        provincias(idDpto: \$idDpto) {
          id
          nomProv
        }
      }
      ''';
  }

  static String get getDistrictsByProvinceIdV2 {
    return '''
    query getDistritosByProvinceIdV2(\$idProv: String!) {
      distritos(idProv: \$idProv) {
        id
        nomDist
      }
    }
''';
  }

  static String get getLastOperationStatus {
    return '''
      query getLastOperations(\$fundUUID: String!){
        getStatusLastOperation(investmentFundsUuid: \$fundUUID){
          investmentFund{
            name
            uuid
            fundType
          }
          typeInvestment
          agroInvestment{
            investmentFundName
            uuid
            parcelAmount
            parcelNumber
            numberOfInstallments
            parcelMonthlyInstallment
            
          }
          preInvestment{
            uuidPreInvestment
            amount
            status
            actionStatus
            currency
            rentability
            deadline
            isReInvestment
          }
        }
        
      }

  ''';
  }

  static String get getPaymentDaysData {
    return '''
      query getPaymentHistory{
        corporatePaymentHistory{
        nextPayments{
            paymentVoucherUrl
            uuid
            paymentDate
            amount
            numberPayment
            paymentVoucherUrl
            investmentFundName
            currency
           isCapitalPayment
           operationCode
          }
          passPayments{
            paymentVoucherUrl
            uuid
            paymentDate
            amount
            numberPayment
            paymentVoucherUrl
            investmentFundName
            currency
            isCapitalPayment
            operationCode
          }

          recentPayments{
            paymentVoucherUrl
            uuid
            paymentDate
            amount
            numberPayment
            paymentVoucherUrl
            investmentFundName
            currency
            isCapitalPayment
            operationCode
          }
        }
      }
    ''';
  }

  static String get getLegalDocuments {
    return '''
     query{
      userGetLegalDocuments{
        legalAcceptance{
          termsAndConditions
          privacyPolicy
        }
        sunatDeclarations{ 
          nameFile
          declarationUrl
        }
      }
    }
    ''';
  }

  static String get getProfileCompleteness {
    return '''
     query getUserProfileCompleteness{
      userCompletenessProfile{
        completionPercentage
        personalDataComplete
        locationComplete
        occupationComplete
        legalTermsCompleteness
        profileComplete
      }
    }
    ''';
  }

  static String get getStepBankAccounts {
    return '''
    query getStepBankAccounts(\$uuid: UUID, \$bankSlug: String) {
      companyBankAccountQueries{
          companyBankAccounts( bankUuid : \$uuid , bankSlug : \$bankSlug   ) {
          companyBankType
          accountNumber
          accountCci
          bank{
            bankName
            slug
            bankImageUrl
          }
        
      }
    }
  }
    ''';
  }

  static String get getHomeInvestUser {
    return '''
  query userInfoAllInvestment{
    userInfoAllInvestment{
      invesmentInSoles{
        averageProfitability
        countPlanesActive
        capitalInCourse
        totalBalanceRentabilityIncreased
        totalPercentPerMonth
      }
      invesmentInDolares{
        countPlanesActive
        totalBalanceRentability
        capitalInCourse
     		totalBalanceRentabilityIncreased
        totalPercentPerMonth
      }
    }
  }
    ''';
  }

  static String get getNews {
    return '''
      query getNews{
        allNews{
          uuid
          isActive
          isDeleted
          publicationDate
          summary
          title
          image
          newsUrl
          author
          isPrincipal
          imageUrl
          
        }
      }
    ''';
  }

  static String get getRentabilityPerMonthAndUser {
    return '''
        query getRentabilityPerMonthByUser{
          rentabilityPerMonthByUser{
            rentabilityPercent
            rentabilityPerMonth
          }
        }
    ''';
  }
}
