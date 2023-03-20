const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "onlinepanchayat": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://obmow6rk7fd3pkzlkmndty5uam.appsync-api.ap-south-1.amazonaws.com/graphql",
                    "region": "ap-south-1",
                    "authorizationType": "AWS_IAM",
                    "apiKey": "da2-qpjr266gpjdhpb2jsrnqu4mymq"
                },
                "AdminQueries": {
                    "endpointType": "REST",
                    "endpoint": "https://jkrr1kwn2i.execute-api.ap-south-1.amazonaws.com/staging",
                    "region": "ap-south-1",
                    "authorizationType": "AWS_IAM"
                },
                "onlinepanchayat-staging": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://obmow6rk7fd3pkzlkmndty5uam.appsync-api.ap-south-1.amazonaws.com/graphql",
                    "region": "ap-south-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://obmow6rk7fd3pkzlkmndty5uam.appsync-api.ap-south-1.amazonaws.com/graphql",
                        "Region": "ap-south-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "onlinepanchayat_AWS_IAM"
                    },
                    "onlinepanchayat_API_KEY": {
                        "ApiUrl": "https://obmow6rk7fd3pkzlkmndty5uam.appsync-api.ap-south-1.amazonaws.com/graphql",
                        "Region": "ap-south-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-qpjr266gpjdhpb2jsrnqu4mymq",
                        "ClientDatabasePrefix": "onlinepanchayat_API_KEY"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-south-1:f715d16d-0925-47af-badd-4640698572c5",
                            "Region": "ap-south-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-south-1_CPN1tWno1",
                        "AppClientId": "6tqus7bqjddtj199a3nffkacfa",
                        "Region": "ap-south-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "CUSTOM_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "PHONE_NUMBER"
                        ],
                        "signupAttributes": [],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "PHONE_NUMBER"
                        ]
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "c22f7fb85cb7459aae47d2e8837441af",
                        "Region": "ap-south-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "ap-south-1"
                    }
                }
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "c22f7fb85cb7459aae47d2e8837441af",
                    "region": "ap-south-1"
                },
                "pinpointTargeting": {
                    "region": "ap-south-1"
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "user-profile-pic-bucket111248-staging",
                "region": "ap-south-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';
