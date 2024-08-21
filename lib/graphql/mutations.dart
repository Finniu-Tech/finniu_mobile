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
        \$image: String!
      ){
        registerUser(
          input:{
            nickName: \$nickname,
            email: \$email,
            password: \$password,
            phoneNumber: \$phone,
            imageProfile: \$image
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
                imageProfile
                imageProfileUrl
            }

          }
        }
      }
    ''';
  }

  static String validateOTP() {
    return '''
      mutation validateOtp(\$email:String!, \$code:String!, \$action:String!){
        validOtpUser(input:{
          otpCode:\$code,
          email:\$email,
          action: \$action
        }){
          success
        }
      }
    ''';
  }

  static String resendOTPCode() {
    return '''
      mutation resendCode(\$email:String!){
        resendOtpCode(input: {
          email: \$email
        }){
          success
        }
      }
    ''';
  }

  static String sendEmailOTPCode() {
    return '''
      mutation sendEmailOTPCode(\$email: String!){
        sendMailOtp(input: {email: \$email}){
          success
          successResendCode
        }
      }
    ''';
  }

  static String startOnboardingQuestions() {
    return '''
      mutation startOnboarding(\$user_id: ID!, \$question_id: String,  \$answer_id: String){
  startOnboarding(input:{
    userId: \$user_id, questionUuid: \$question_id, answerUuid: \$answer_id
  }
  ){
    success
    successRegisterResponse
    totalQuestions
    questionsCompleted
    questions{
      text
      uuid
      questionImageUrl
      answers{
        
        uuid
        value
        text
      }
      answerMarked{
        uuid
        text
        value
      }
    }
  }
}
    ''';
  }

  static String finishOnboardingQuestions() {
    return '''
      mutation finishOnboarding(\$user_id: ID!){
        finishOnboarding(input: {
          userId: \$user_id
        }){
          success
          plan{
            uuid
            name
            minAmount
            value
            twelveMonthsReturn
            sixMonthsReturn
            description
          }
        }
      }
        ''';
  }

  static String sendEmailRecoveryPassword() {
    return '''
      mutation recoveryPassword(\$email:String!){
        recoveryPassword(email: \$email){
          success
          successSendCode
        }
      }
    ''';
  }

  static String setNewPassword() {
    return '''
      mutation setNewPassword(\$email:String!, \$password:String!){
        changePasswordMinimal(input:{
          email: \$email,
          newPassword: \$password
        }){
          success
        }
      }
    ''';
  }

  static String calculateInvestment() {
    return '''
        mutation calculateInvestment(\$amount: Int!, \$deadline: Int!,  \$currency: String, \$coupon: String){
            calculateInvestment(
              input: {
                ammount: \$amount,
                deadline:\$deadline,
                coupon: \$coupon,
                currency: \$currency
              }
            ){
              finalRestabilityPercent
              success
              profitability{
                preInvestmentAmount
              }
              plan{
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
              estimatedDates{
                startDate
                endDate
              }
              messages{
                field
                message
                errorCode
              }
            }
        }
    ''';
  }

  static String savePreInvestment() {
    return '''
     mutation savePreInvestmentMutation(\$amount: Int!,\$bankAccountSender: String,\$couponCode: String, \$currency: String, \$originFunds: OriginFundsInput, \$uuidDeadline: String!, \$uuidPlan: String!,\$uuidBank: String ){
          savePreInvestment(
              amount: \$amount,
              bankAccountSender:\$bankAccountSender,
              uuidDeadline: \$uuidDeadline,
              uuidPlan: \$uuidPlan,
            	currency: \$currency,
              couponCode:  \$couponCode,
            	originFunds: \$originFunds,
            	uuidBank: \$uuidBank
          ){
            success,
            preInvestmentUuid
            messages{
              field
              message
              errorCode
            }
          }
      }
    ''';
  }

  static String updatePreInvestment() {
    return '''
      mutation updatePreinvestment(\$uuid: String!, \$readContract:Boolean!, \$files: [String], \$bankAccountReceiverUUID: String, \$bankAccountSenderUUID: String){
        updatePreinvestment(
          preInvestmentUuid: \$uuid,
          userReadContract: \$readContract,
          filesTransaction: \$files,
          bankAccountReceiver: \$bankAccountReceiverUUID,
          bankAccountSender: \$bankAccountSenderUUID
        ){
          success
          preInvestmentUuid
          messages{
              field
              message
              errorCode
            }
        }
      }
    ''';
  }

  static String saveNPS() {
    return '''
      mutation sendNPS(\$question: String!, \$answer: String!, \$text:String) {
        saveNps(
          input:{
            question: \$question,
            answer: \$answer,
            text: \$text
          }
        ){
        success 
        }
      }''';
  }

  static String updateUserProfile() {
    return '''
        mutation updateUserProfile(
          \$firstName:String!,
          \$lastName:String!,
          \$docNumber: String!,
          \$region: String,
          \$province: String,
          \$distric: String,
          \$civilStatus: String,
          \$imageProfile: String,
          \$address: String,
          \$occupation: String
        ){
          updateUser(
            input: {
              firstName: \$firstName,
              lastName: \$lastName,
              documentNumber: \$docNumber,
              region: \$region,
              provincia: \$province,
              distrito: \$distric,
              civilStatus: \$civilStatus,
              imageProfile: \$imageProfile,
              address: \$address,
              occupation: \$occupation,
            }
          ){
            success
            userProfile{
              percentCompleteProfile
            }
          }
        }
    ''';
  }

  static String updateAvatar() {
    return '''
        mutation updateUserProfileImage(\$imageProfile: String!){
          updateUserImageProfile(imageProfile: \$imageProfile){
            success
            userProfile{
              imageProfileUrl
            }
          }
        }
    ''';
  }

  static String changePasswordLogued() {
    return '''
      mutation changePasswordLogued(\$oldPassword: String!, \$newPassword: String!){
        changePassword(
          input:{
            oldPassword: \$oldPassword,
            newPassword: \$newPassword
          }
        ){
          success
        }
      }
    ''';
  }

  static String discardPreInvestment() {
    return '''
      mutation discardPreInvestment(\$preInvestmentUUID: String!){
        discardPreInvestment(preInvestmentUuid: \$preInvestmentUUID){
          success
        }
      }
    ''';
  }

  static String loginUser() {
    return '''
      mutation loginUserMutation(\$username: String!, \$password: String!){
        loginUser(input:{
          username: \$username,
          password: \$password
        }){
          success
    			messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String rejectReInvestment() {
    return '''
      mutation rejectReInvestment(\$preInvestmentUUID: String!, \$rejectMotivation: RejectedMotivationEnum!, \$textRejected: String){
        rejectReInvestment(input: {
          preInvestmentUuid: \$preInvestmentUUID,
          rejectedMotivation: \$rejectMotivation,
          textRejected: \$textRejected
        }){
          success
          messages{
            field
            message
            errorCode
          }
        }
      }

    ''';
  }

  static String createBankAccount() {
    return '''
      mutation createUserBankAccount(
        \$bankUUID: String!,
        \$typeAccount: TypeAccountEnum!,
        \$currency: CurrencyEnum!,
        \$bankAccount: String!,
        \$aliasBankAccount: String,
        \$joinAccount: JointAccountInput,
        \$isDefault: Boolean,
        \$isPersonalAccount: Boolean,
        \$cci: String
      ) {
        createBankAccount(
          input:{
            bankUuid: \$bankUUID,
            typeAccount: \$typeAccount,
            currency: \$currency,
            bankAccount: \$bankAccount,
            bankCciAccount: \$cci,
            aliasBankAccount: \$aliasBankAccount,
            useDefaultAccount: \$isDefault,
            checkPersonalAccount: \$isPersonalAccount,
            jointAccount: \$joinAccount
          }
        ) {
          success
          messages {
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String createReInvestment() {
    return '''
      mutation createReInvestment(
        \$preInvestmentUUID: String!,
        \$finalAmount: String!,
        \$currency: String!,
        \$deadlineUUID: String!,
        \$coupon: String,
        \$originFounds: OriginFundsInput!,
        \$typeReinvestment: TypeReInvestmentEnum!,
        \$bankAccountSender: String,
      ){
        createReInvestment(input:{
          preInvestmentUuid: \$preInvestmentUUID,
          finalAmount: \$finalAmount,
          currency: \$currency,
          deadlineUuid: \$deadlineUUID,
          coupon: \$coupon,
          originFunds: \$originFounds,
          typeReInvestment: \$typeReinvestment,
          bankAccountSender: \$bankAccountSender
        }){
          success
          reInvestmentUuid
          reInvestmentContractUrl
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String updateReInvestment() {
    return '''
      mutation updateReInvestment(\$preInvestmentUUID: String!, \$userReadContract:Boolean!, \$files: [String], \$bankAccountReceiverUUID: String, \$bankAccountSenderUUID: String){
        updateReInvestment(input:{
          preInvestmentUuid: \$preInvestmentUUID,
          userReadContract: \$userReadContract,
          filesTransaction: \$files,
          bankAccountReceiver: \$bankAccountReceiverUUID,
          bankAccountSender: \$bankAccountSenderUUID
        }){
          success
          reInvestmentUuid
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String setBankAccountReceiverToReinvestment() {
    return '''
      mutation setBankAccountUser(\$reInvestmentUUID: String!,  \$bankAccountReceiver: String!){
        setBankAccountUser(input:{
          preInvestmentUuid: \$reInvestmentUUID,
          bankAccountReceiver: \$bankAccountReceiver
        }){
          success
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String calculateAggroInvestment() {
    return '''
      mutation calculateAgroInvestment(\$numberOfInstallments: Int!, \$parcelNumber:Int!, \$fundUUID: String!){
        calculateAgroInvestment(numberOfInstallments:\$numberOfInstallments, parcelNumber: \$parcelNumber, investmentFundUuid: \$fundUUID){
          success
          parcelMonthlyInstallment
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String saveAggroInvestment() {
    return '''
      mutation saveAgroInvestment(\$numberOfInstallments: Int!, \$parcelNumber:Int!, \$originFunds: OriginFundsInput!, \$fundUUID: String!){
        saveAgroInvestment(
          numberOfInstallments:\$numberOfInstallments,
          parcelNumber: \$parcelNumber,
          originFunds: \$originFunds,
          investmentFundUuid: \$fundUUID){
          success
          agroInvestmentUuid
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String saveCorporateInvestment() {
    return '''
      mutation saveCorporateInvestment(\$amount:String!, \$couponCode:String, \$currency: String!, \$deadline: String!, \$investmentFund: String!, \$originFunds: OriginFundsInput!){
        saveCorporateInvestment(
          amount: \$amount,
          couponCode: \$couponCode,
          currency: \$currency,
          deadline: \$deadline,
          investmentFund: \$investmentFund,
          originFunds: \$originFunds
          ){
          success
          preInvestmentUuid
          contract
          messages{
            field
            message
            errorCode
          }
        }
      }
    ''';
  }

  static String saveCreateUserV2() {
    return '''
     mutation CreateUserV2 (
      \$nickName: String!
      \$countryPrefix: String!
      \$phoneNumber: String!
      \$email: String!
      \$password: String!
      \$confirmPassword: String!
      \$acceptTermsConditions: Boolean!
      \$acceptPrivacyPolicy: Boolean!
      ){
      registerUserV2(input:{
        nickName: \$nickName,
        countryPrefix: \$countryPrefix,
        phoneNumber: \$phoneNumber,
        email: \$email,
        password: \$password,
        confirmPassword: \$confirmPassword,
        acceptPrivacyPolicy: \$acceptTermsConditions,
        acceptTermsConditions: \$acceptPrivacyPolicy
      }){
        success
        messages{
          field
          message
          errorCode
        }
        user {
          id
          email
        }
      }
    }
    ''';
  }

  static String savePersonalDataV2() {
    return '''
    mutation RegisterPersonalData (
      \$firstName: String!
      \$lastNameFather: String!
      \$lastNameMother: String!
      \$documentType: DocumentTypeEnum!
      \$documentNumber: String!
      \$civilStatus: CivilStatusEnum!
      \$gender: String!
    ){
    registerPersonalData(input:{
      firstName: \$firstName,
      lastNameFather: \$lastNameFather,
      lastNameMother: \$lastNameMother,
      documentType: \$documentType,
      documentNumber: \$documentNumber,
      civilStatus: \$civilStatus,
      gender: \$gender
    }
    )
    {
    success
    messages {
      field
      message
      errorCode
    }
    }
}
    ''';
  }

  static String saveLocationDataV2() {
    return '''
  mutation RegisterUserUbication(
      \$country: String!
      \$region: String!
      \$province: String!
      \$district: String!
      \$address: String!
      \$houseNumber: String!
      \$postalCode: String!
  ){
    registerUserUbication(input:{
      country: \$country,
      region: \$region,
      province: \$province,
      district: \$district,
      address: \$address,
      houseNumber: \$houseNumber,
      postalCode: \$postalCode
    }){
      success
      messages {
        field
        message
        errorCode
      }
    }
  }
    ''';
  }
}
