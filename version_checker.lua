return function(resource, version)
    local hasEscrowIgnore = false
    local resourceName = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

    for i = 0, GetNumResourceMetadata(resourceName, "dependency") do
        local dep = GetResourceMetadata(resourceName, "dependency", i)
        if dep == "/assetpacks" then
            hasEscrowIgnore = true
        end
    end
    local apiUrl = ("https://filoversionchecker.vercel.app/api/check-version?resource=%s&version=%s&escrow=%s"):format(resourceName, currentVersion, (hasEscrowIgnore and "true" or "false"))

    PerformHttpRequest(apiUrl, function(err, text, headers)
        if text then
            local data = json.decode(text)
            if data and data.text then print(data.text) end
        end
    end, 'GET')
end
