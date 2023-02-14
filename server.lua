ESX = nil

AddEventHandler('onResourceStart', function(resourceName)
    if ( string.find(resourceName, "ax_") ) then
        TriggerEvent('ax_core:VersionCheck', resourceName, GetResourceMetadata(resourceName, 'version'), GetResourceMetadata(resourceName, 'versioncheck'))
    end
end)

AddEventHandler('ax_core:VersionCheck', function(resourceName, currentVersion, url)
  if (currentVersion == nil or url == nil) then return end
  Citizen.Wait(10000)
  CreateThread(function()
    local latestVersion = nil
    local outdated = '^3[' .. resourceName .. ']^7 - You can upgrade to ^2v%s^7 (currently using ^1v%s^7)'
    while Config.VersionChecks do
      Citizen.Wait(1000)
      PerformHttpRequest(url, function (errorCode, resultData, resultHeaders)
        if errorCode ~= 200 then print("Returned error code:" .. tostring(errorCode)) else
          local data, version = tostring(resultData)
          for line in data:gmatch("([^\n]*)\n?") do
            if line:find('^version ') then version = line:sub(10, (line:len(line) - 1)) break end
          end         
          latestVersion = version
          if latestVersion then 
            if currentVersion ~= latestVersion then
              print(outdated:format(latestVersion, currentVersion))
            end
          end
        end
      end)
      Citizen.Wait(60000 * 120)
    end
  end)
end)

AddEventHandler('ax_core:VersionCheck', function(resourceName, currentVersion, url)
    if (currentVersion == nil or url == nil) then return end
    CreateThread(function()
        Citizen.Wait(10000)

        local latestVersion = nil
        local outdated = '^3[' .. resourceName .. ']^7 - You can upgrade to ^2v%s^7 (currently using ^1v%s^7)'
        PerformHttpRequest(url, function (errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then print("Returned error code:" .. tostring(errorCode)) else
                local data, version = tostring(resultData)
                for line in data:gmatch("([^\n]*)\n?") do
                    if line:find('^version ') then version = line:sub(10, (line:len(line) - 1)) break end
                end         
                latestVersion = version
                if latestVersion and currentVersion ~= latestVersion then 
                    print(outdated:format(latestVersion, currentVersion))
                end
            end
        end)
    end)
end)



AddScriptHandler('ax_core:VersionCheck', function(resourceName, currentVersion, url)
    if (currentVersion == nil or url == nil) then return end
    CreateThread(function()
        Citizen.Wait(10000)

        local latestVersion = nil
        local outdated = '^3[' .. resourceName .. ']^7 - You can upgrade to ^2v%s^7 (currently using ^1v%s^7)'
        PerformHttpRequest(url, function (errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then print("Returned error code:" .. tostring(errorCode)) else
                local data, version = tostring(resultData)
                for line in data:gmatch("([^\n]*)\n?") do
                    if line:find('^version ') then version = line:sub(10, (line:len(line) - 1)) break end
                end         
                latestVersion = version
                if latestVersion and currentVersion ~= latestVersion then 
                    print(outdated:format(latestVersion, currentVersion))
                end
            end
        end)
    end)
end)