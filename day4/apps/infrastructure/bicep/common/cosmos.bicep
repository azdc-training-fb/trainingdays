@minLength(3)
@maxLength(8)
@description('Name of environment')
param env string = 'devd4'

var cosmosAccount = 'cosmos-scm-${env}-${uniqueString(resourceGroup().id)}'
var location = 'eastus' //resourceGroup().location

// CosmosDB Account
resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2021-03-15' = {
  name: cosmosAccount
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Eventual'
    }
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
  }
}
