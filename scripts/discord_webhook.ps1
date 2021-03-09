$webhook = ''

# The message you want to send
# For multiple lines, just press Enter

$Body = @{
    content = "";
    "username" = ""
    "avatar_url" = ""
}


$params = @{
    Headers = @{'accept'='application/json'}
    Body = $Body | ConvertTo-Json -Depth 5
    Method = 'Post'
    URI = $webhook
}
echo $Body | ConvertTo-Json -Depth 5
Invoke-RestMethod @params
