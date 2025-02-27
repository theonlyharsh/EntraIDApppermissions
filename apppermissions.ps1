Connect-MgGraph -Scopes "AppCatalog.ReadWrite.All","Application.Read.All","DelegatedPermissionGrant.ReadWrite.All"
$enterpriseApps = Get-MgServicePrincipal -All
$appList = @() 
foreach ($app in $enterpriseApps) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
Write-Host "Processing: $($app.DisplayName)"
                      $consents = Get-MgOauth2PermissionGrant -Filter "clientId eq '$($app.AppId)'" -All
                        if ($consents.Count -eq 0){
                          Write-Host "No user consents found for: '$($app.DisplayName)'"
                          $appList += [PSCustomObject]@{
                            DisplayName = $app.DisplayName
                            AppId = $app.AppId
                            InstallDate = $app.AdditionalProperties.createdDateTime
                            }
                      }
}

$appList | Export-Csv -Path "D:\temp\appList.csv" -NoTypeInformation
Write-Host "Exported applications with no user consents are saved to CSV successfully: ".