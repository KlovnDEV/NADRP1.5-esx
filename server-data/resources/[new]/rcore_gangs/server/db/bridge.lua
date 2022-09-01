DB = {}

CreateThread(function()
    if Config.Database and string.strtrim(string.lower(Config.Database)) == 'mysql-async' then
        DB.fetchAll = function(query, params)
            return MySQL.Sync.fetchAll(query, params)
        end

        DB.fetchScalar = function(query, params)
            return MySQL.Sync.fetchScalar(query, params)
        end

        DB.execute = function(query, params)
            return MySQL.Sync.execute(query, params)
        end
    elseif Config.Database and string.strtrim(string.lower(Config.Database)) == 'oxmysql' then
        DB.fetchAll = function(query, params)
            return MySQL.query ~= nil and MySQL.query.await(query, params) or exports['oxmysql']:executeSync(query, params)
        end

        DB.fetchScalar = function(query, params)
            return MySQL.scalar ~= nil and MySQL.scalar.await(query, params) or exports['oxmysql']:scalarSync(query, params)
        end

        DB.execute = function(query, params)
            return MySQL.update ~= nil and MySQL.update.await(query, params) or exports['oxmysql']:executeSync(query, params)
        end
    elseif Config.Database and string.strtrim(string.lower(Config.Database)) == 'ghmattimysql' then
        DB.fetchAll = function(query, params)
            return exports['ghmattimysql']:executeSync(query, params)
        end

        DB.fetchScalar = function(query, params)
            return exports['ghmattimysql']:scalarSync(query, params)
        end

        DB.execute = function(query, params)
            return exports['ghmattimysql']:executeSync(query, params)
        end
    else
        print("^1================ WARNING ================^7")
        print("^7Choose your ^2database^7 in the config!^7")
        print("^1================ WARNING ================^7")
    end
end)