using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name

if (-not $name) {
    $name = $Request.Body.Name
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name. This HTTP triggered function executed successfully."
    $StatusCode = [HttpStatusCode]::OK
    Write-Host "Status: 200 OK"
}

else {
    # $StatusCode = [HttpStatusCode]::InternalServerError                       #returns Status code: 500
    # $StatusCode = [HttpStatusCode]::UnprocessableEntity                       #returns Status code: 422
    $StatusCode = [HttpStatusCode]::BadRequest                                  #returns Status code: 400
    Write-Host "Status: 400 Bad request"
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode=$StatusCode
    Body = $body
})
