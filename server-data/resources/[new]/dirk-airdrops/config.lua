Config = {
  UsingESX    = true, 
  UsingQBCore = false, 
  TimeBeforeAnnounce = 45,
  DropSpeed   = 0.02, --## Higher is faster obviously
  Drops = {

    ['BigGunBox'] = {
      WarningAnnounce = "There is a big gun drop happening in %s minutes",
      Height          = 40, --## How high of the ground. Lower the faster it'll drop obviously.
      CrateObject     = "ex_prop_crate_jewels_racks_sc",
      Positions       = {
       vector4(-62.451034545898,-1103.1921386719,26.299259185791,322.05395507813),
      },
      SetTimes        = {
        [9] = true, --## At 1300 Hours this will drop.
        [10] = true, --## At 1300 Hours this will drop.
        [11] = true, --## At 1300 Hours this will drop.
        [8] = true, --## At 1300 Hours this will drop.
        [19] = true, --## At 1300 Hours this will drop.
      },
      Loot            = {
        cash = {
          chance = 100, 
          minAmt = 1000, 
          maxAmt = 5000, 
        }, 
        weapon_pistol = {
          chance = 100, 
          minAmt = 20, 
          maxAmt = 500, 
        },  

        hacking_device = {
          chance = 20, 
          minAmt = 20, 
          maxAmt = 500, 
        },
        
        
      },
    },




  },
}

if Config.UsingQBCore then 
QBCore = exports['qb-core']:GetCoreObject()
elseif Config.UsingESX then 
  TriggerEvent("tac:getSharedObject", function(obj) ESX = obj; end)
end