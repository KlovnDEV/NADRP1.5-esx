-- **NOTE:** This shop is only available if you are using QBCore
-- If you use ESX follow the instructions given in the ReadMe file.

OpenInvTrigger   = "inventory:server:OpenInventory"          
ShopName         = "Fishing Shop"                          
Products = {
    ["Fishing"] = {
        [1] = {
            name = "fishbait",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "fishbaitilegal",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "anchor",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "fishicebox",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "fogueira",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 5,
        },
        -- You can add more items
    },
}

LojinhaFishing = {
    ["Fishing"] = {
        ["label"] = "Fishing",
        ["type"] = "BM",
        ["coords"] = {
            [1] = {
                ["x"] = 1333.06,    -- Dont touch, is using qb-target.
                ["y"] = 4326.86,    -- Dont touch, is using qb-target.
                ["z"] = 38.017,     -- Dont touch, is using qb-target.
            },
        },
        ["CoisasBoas"] = Products["Fishing"],
    },
}