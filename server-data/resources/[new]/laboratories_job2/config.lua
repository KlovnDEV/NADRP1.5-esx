mLibs = exports["meta_libs"]

Config = {
    Lang = 'en', -- Actuellement, prend uniquement en charge en.
    Debug = true, -- Retirez après le test.
    ShowDebugText = false, -- Afficher le texte du dessin pour la zone? Principalement utilisé pour le débogage.

    MetaLibsName = "meta_libs",

    InteractControl = 38, --- Contrôlez le code pour interagir avec la plupart des choses.
    SlingDrugsControl = 47, -- Raccourci pour lancer des drogues.
    SlingByHotkey = false, -- Si false doit utiliser la commande / slingdrugs
    InteractDist = 2.0, -- Distance pour interagir avec les choses.
    InfluenceInHouse = false, -- Gagnez de l'influence dans le logement des joueurs?

    InfluenceTick = 5000, -- combien de temps entre l'influence gain / perte tick?

    DisplayZoneForAll = true, -- Afficher les blips de zone de territoire pour tous?
    DrugProcessBlip = false, -- Afficher un blip de processus de drogue pour les membres d'un gang?

    MaxPlayerCount = 255, -- Changer si j'utilise onesync je suppose?
    UseProgBars = false, -- Vous utilisez ProgBars? (devrait être inclus dans le dossier mod)
    StartEvent = 'Thread', -- Si vous ne voulez pas démarrer le mod par Citizen.CreateThread, passez de "Thread" à votre nom d'événement.

    DrugSellDist = 0, -- Les pédiatres à distance achèteront des médicaments à
    DrugBuyChance = 0, -- % Possibilité pour le ped d'acheter des médicaments à un joueur.
    SalesReportChance = 0, -- % Possibilité pour le ped de signaler le joueur à la police s'il n'a pas acheté les drogues.
    SellDrugsTimer = 0, -- Combien de temps dure le trafic de drogue? (MME)
    MinSellAmount = 0, -- Quantité minimale de médicaments à vendre
    MaxSellAmount = 0, -- Quantité maximale de médicaments à vendre

    DirtyReward = true, -- Pour les offres de médicaments. Si faux, recevez de l'argent propre.
    DirtyAccount = 'black_money', -- Pour beaucoup de choses. Assurez-vous de le régler correctement.

    SetJobEvent = 'esx:setJob', -- Ne changez probablement pas cela si vous utilisez esx.
    SetOrgEvent = 'esx:setJob2', -- Si vous utilisez job2 ...

    UsingItemLimit = true, -- si vous utilisez les limites des éléments esx
    UsingWeightLimit = false, -- si vous utilisez le poids de l'article esx

    SqlSaveTimer = 1, -- minutes pour que l'influence de la zone soit sauvegardée dans la base de données

    SmackCheaters = true,

    PoliceJobs = {
        'lspd', -- Les noms des postes de police.
        'sheriff',
    },

    GangJobs = {                        -- Énumérez ici tous les emplois pouvant concourir et contrôler des territoires.
        "lost",
        "biker",
        "comorra",
        "ballas",
        "vagos",
        "hightable",
        "families",
        "aztecas",
        "pcc",
        "20th",
        "Marabunta",
        "triade",
        "bonelli",
        "oneil",
        "dystopia",
        "bratiskaia",
        "irish",
        "marabunta",
    }
}

-- Prix ​​de vente des médicaments, tout en lançant des médicaments à l'intérieur d'un territoire.
DrugPrices = {
    ['weed'] = 100,
    ['coke'] = 500,
    ['meth'] = 300,
}

-- Don't touch.
Langs = {}

Langs['en'] = {

    ["enter_growhouse"] = "Appuyez sur ~INPUT_PICKUP~ pour ~b~accéder au laboratoire.",
    ["leave_growhouse"] = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir.",
    ["gather_plant"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Chanvre)",
    ["trim_plant"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Découpe)",
  
    ["enter_methlab"] = "Appuyez sur ~INPUT_PICKUP~ pour ~b~accéder au laboratoire.",
    ["leave_methlab"] = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir.", 
    ["cook_meth"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Cuisson de la méthamphétamine).",
    ["package_meth"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Emballage)",
  
    ["enter_laundry"] = "Appuyez sur ~INPUT_PICKUP~ pour ~b~accéder à l'entrepôt.",
    ["leave_laundry"] = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir.",
    ["gather_money"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Trie)",
    ["cutting_money"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Découpe)",
    ["cleaning_money"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Nettoyage)",
  
    ["enter_cokelab"] = "Appuyez sur ~INPUT_PICKUP~ pour ~b~accéder au laboratoire.",
    ["leave_cokelab"] = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir.",
    ["gather_cocaine"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Cocaïne)",
    ["process_cocaine"] = "Appuyez sur ~INPUT_PICKUP~ pour ~y~traiter la cocaïne.",
    ["package_cocaine"] = "Appuyez sur ~INPUT_PICKUP~ pour ~g~commencer.~s~\n(Emballage)",
  
    ["cancel_selling"] = "Vente de la drogue...\nAppuyez sur ~INPUT_DETONATE~ pour annuler.",
  
    ["no_drugs"] = "Vous n'avez aucun médicament à vendre ici.",
    ["cant_sell_here"] = "Vous ne pouvez pas vendre de drogue ici.",
  
    ["being_reported"] = "Vous êtes signalé.",
    ["drug_deal_reported"] = "Quelqu'un a signalé un trafic de drogue. Appuyez sur [~r~H~s~] pour définir un waypoint",
  
    -- PROGBARS TEXT
    ["gather_cocaine_prog"] = "Traitement en cours",
    ["process_cocaine_prog"] = "Découpage en cours",
    ["package_cocaine_prog"] = "Emballage en cours",
  
    ["gather_plant_prog"] = "Récolte en cours",
    ["trim_plant_prog"] = "Découpage en cours",
  
    ["cook_meth_prog"] = "Cuisson en cours",
    ["package_meth_prog"] = "Emballage en cours",
  
    ["gather_money_prog"] = "Tri de l'argent",
    ["cutting_money_prog"] = "Découpe de l'argent",
    ["cleaning_money_prog"] = "Nettoyage de l'argent",
  
    ["selling_drugs"] = "Vente des drogues",
  
    -- BLIP TEXT
    ["methlab_blip"] = "Meth Lab",
    ["growhouse_blip"] = "Grow House",
    ["cokelab_blip"] = "Cocaine Lab",
    ["laundry_blip"] = "Money Wash",
  
    ["not_enough"] = "~r~Vous n'avez pas assez de %s (%s manquant).",
}

_U = Langs[Config.Lang]

Territories = {

    ["Olympic Freeway"] = {
        control = "ballas",
        influence = 100.0,
        zone = "Olympic Freeway",

        canSell = false,
        blipactiv = false,

        areas = {
            [1] = {
                location = vector3(869.12, -1055.92, 29.44),
                width = 150.0,
                height = 150.0,
                heading = 42,
                display = 3
            }
        },

        actions = {
            ["entry"] = {
                helpText = _U["enter_methlab"],
                location = vector3(869.12, -1055.92, 29.44),
            },
            ["exit"] = {
                helpText = _U["leave_methlab"],
                location = vector3(997.0199, -3200.684, -36.39373),
            },
            ["cook_meth"] = {
                helpText = _U["cook_meth"],
                progText = _U["cook_meth_prog"],

                requireRate = 20,
                requireItem = "crystaldemeth",
                rewardItem = "meth_raw",
                rewardRate = 10,

                location = vector3(1005.80, -3200.40, -38.90),
                offset = vector3(-4.88, -1.95, 0.0),
                rotation = vector3(0.0, 0.0, 0.0),
                time = 70000,
                act = "Meth",
                scene = 1,
            },
            ["package_meth"] = {
                helpText = _U["package_meth"],
                progText = _U["package_meth_prog"],

                requireRate = 10,
                requireItem = "meth_raw",
                rewardItem = "meth",
                rewardRate = 10,

                location = vector3(1011.80, -3194.90, -38.99),
                offset = vector3(4.48, 1.7, 1.0),
                rotation = vector3(0.0, 0.0, 0.0),
                time = 45000,
                act = "Meth",
                scene = 2,
            },
        }
    },


    
    ["Marina Drive"] = {
        control = "vagos",
        influence = 100.0,
        zone = "Marina Drive",

        canSell = false,
        blipactiv = false,

        areas = {
            [1] = {
                location = vector3(1529.16, 3794.84, 34.48),
                width = 150.0,
                height = 150.0,
                heading = 42,
                display = 3
            }
        },

        actions = {
            ["entry"] = {
                helpText = _U["enter_cokelab"],
                location = vector3(1529.16, 3794.84, 34.48),
            },
            ["exit"] = {
                helpText = _U["leave_cokelab"],
                location = vector3(1088.74, -3187.61, -38.99),
            },
            ["gather_cocaine"] = {
                helpText = _U["gather_cocaine"],
                progText = _U["gather_cocaine_prog"],

                requireRate = 10,
                requireItem = "feuilledecoca",
                rewardItem = "cokebrut",
                rewardRate = 5,

                location = vector3(1093.18, -3194.925, -39.60),
                offset = vector3(1.911, 0.31, 0.0),
                rotation = vector3(0.0, 0.0, 0.0),
                time = 25000,
                act = "Cocaine",
                scene = 1,
            },
            ["package_cocaine"] = {
                helpText = _U["package_cocaine"],
                progText = _U["package_cocaine_prog"],

                requireRate = 5,
                requireItem = "cokebrut",
                rewardItem = "coke",
                rewardRate = 5,

                location = vector3(1101.245, -3198.82, -39.60),
                offset = vector3(7.663, -2.222, 0.395),
                rotation = vector3(0.0, 0.0, 0.0),
                time = 60000,
                act = "Cocaine",
                scene = 2,
            },
        }
    },

    ["Dry Dock Street"] = {
        control = "vagos",
        influence = 100.0,
        zone = "Dry Dock Street",

        blipactiv = false,

        canSell = {
            'meth1g',
        },

        areas = {
            [1] = {
                location = vector3(890.44, -2221.6, 30.52),
                width = 200.0,
                height = 225.0,
                heading = 50,
                display = 3
            },
        },


        actions = {
            ["entry"] = {
                helpText = _U["enter_laundry"],
                location = vector3(890.44, -2221.6, 30.52),
            },
            ["exit"] = {
                helpText = _U["leave_laundry"],
                location = vector3(1118.89, -3193.33, -40.00),
            },
            ["gather_money"] = {
                helpText = _U["gather_money"], -- esx.ShowHelpText in top left corner while standing near this zone.
                progText = _U["gather_money_prog"], -- Text inside the progress bar while performing this action.

                requireItem = false, -- Required item to perform this action (false if none).
                requireRate = false, -- Required amount of required item.
                requireCash = 10000, -- If not requireItem, requireCash instead. NOTE: Always dirty.

                rewardRate = 10, -- Reward item from perform action.
                rewardItem = "sorted_money", -- Reward item amount.
                rewardCash = false, -- If not rewardItem, rewardCash instead. NOTE: Always clean.

                location = vector3(1119.55, -3197.79, -40.39), -- The position to interact with this action.
                offset = vector3(-0.8, 0.896, 0.6), -- The offset for the scene/animations.
                rotation = vector3(0.0, 0.0, 180.0), -- Target rotation for the scene.
                time = 20000, -- Action bar timer. Probably don't change these unless you find they're set incorrect.
                act = "Money", -- Which set of scenes should we be performing?
                scene = 1, -- Which scene should we perform from above set?

                extraProps = {                                   -- If extra props needed for scene that cannot be defined within the scene, set them here.
                    [1] = {
                        model = "bkr_prop_money_counter", -- Model of prop.
                        pos = vector3(-0.25, 0.22, 0.4), -- Offset from scene start location.
                        rot = vector3(0.0, 0.0, 180.0), -- Object rotation.
                    },
                    [2] = {
                        model = "bkr_prop_moneypack_03a",
                        pos = vector3(-0.7, -0.25, 0.4),
                        rot = vector3(0.0, 0.00, 0.0),
                    },
                    [3] = {
                        model = "bkr_prop_moneypack_03a",
                        pos = vector3(-0.7, -0.25, 0.55),
                        rot = vector3(0.0, 0.00, 0.00),
                    }
                }
            },
            ["package_money"] = {
                helpText = _U["cutting_money"],
                progText = _U["cutting_money_prog"],

                requireRate = 10,
                requireItem = "sorted_money",
                requireCash = false,

                rewardRate = 10,
                rewardItem = "cut_money",
                rewardCash = false,

                location = vector3(1122.27, -3197.82, -40.39),
                offset = vector3(2.15, 0.67, 0.6),
                rotation = vector3(0.0, 0.0, 180.0),
                time = 45000,
                act = "Money",
                scene = 2,
            },
            ["clean_money"] = {
                helpText = _U["cleaning_money"],
                progText = _U["cleaning_money_prog"],

                requireRate = 1,
                requireItem = "cut_money",
                requireCash = false,

                rewardRate = false,
                rewardItem = false,
                rewardCash = 1000,

                location = vector3(1122.40, -3194.63, -40.39),
                offset = vector3(0.15, 0.0, 0.0),
                rotation = vector3(0.0, 0.0, 65.0),
                time = 45000,
                act = "Money",
                scene = 3,
            }
        }
    },

    ["Bay City Avenue"] = {
        control = "hightable",
        influence = 100.0,
        zone = "Bay City Avenue",

        canSell = false,

        areas = {
            [1] = {
                location = vector3(-1029.92, -1604.0, 4.96),
                width = 350.0,
                height = 200.0,
                heading = 60,
                display = 3
            }
        },

        actions = {
            ["entry"] = {
                helpText = "Appuyez sur ~INPUT_PICKUP~ pour ~b~accéder à l'entrepôt.",
                location = vector3(-1029.92, -1604.0, 4.96),
            },
            ["exit"] = {
                helpText = _U["leave_cokelab"],
                location = vector3(894.28, -3245.96, -98.24),
            },
        }
    },

    -- DAVIS
    ["Mirror Park Boulevard"] = {
        control = "vagos",
        influence = 100.0,
        zone = "Mirror Park Boulevard",

        blipactiv = false,

        canSell = {
            'weed',
        },

        areas = {
            [1] = {
                location = vector3(53.95, -1818.36, 27.66),
                width = 390.0,
                height = 210.0,
                heading = 50,
                display = 3
            },
            [2] = {
                location = vector3(170.0, -1579.00, 77.28895),
                width = 260.0,
                height = 300.0,
                heading = 50,
                display = 3
            },
        },

        blipData = {
            pos = vector3(143.72, -1656.48, 29.32),
            sprite = 496,
            color = 2,
            text = _U["growhouse_blip"],
            display = 5,
            shortRange = true,
            scale = 1.0,
        },


        actions = {
            ["entry"] = {
                helpText = _U["enter_growhouse"],
                location = vector3(1222.48, -487.92, 66.96),
            },
            ["exit"] = {
                helpText = _U["leave_growhouse"],
                location = vector3(1066.28, -3183.46, -39.16),
            },
            ["gather_plant"] = {
                helpText = _U["gather_plant"],
                progText = _U["gather_plant_prog"],

                requireRate = 10,
                requireItem = "graineweed",
                rewardItem = "chanvre",
                rewardRate = 5,

                location = vector3(1057.54, -3197.2, -39.13),
                offset = vector3(-0.014, 0.896, 1.0),
                rotation = vector3(0.0, 0.0, 90.0),
                time = 15000,
                act = "Weed",
                scene = 1,
            },
            ["trim_plant"] = {
                helpText = _U["trim_plant"],
                progText = _U["trim_plant_prog"],

                requireRate = 5,
                requireItem = "chanvre",
                rewardItem = "weed",
                rewardRate = 5,

                location = vector3(1038.14, -3205.45, -38.16),
                offset = vector3(-0.3, 0.4, 0.96),
                rotation = vector3(0.0, 0.0, 90.0),
                time = 30000,
                act = "Weed",
                scene = 2,
            },
        }
    },
}

SceneDicts = {
    Cocaine = {
        [1] = 'anim@amb@business@coc@coc_unpack_cut_left@',
        [2] = 'anim@amb@business@coc@coc_packing_hi@',
    },
    Meth = {
        [1] = 'anim@amb@business@meth@meth_monitoring_cooking@cooking@',
        [2] = 'anim@amb@business@meth@meth_smash_weight_check@',
    },
    Weed = {
        [1] = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
        [2] = 'anim@amb@business@weed@weed_sorting_seated@',
    },
    Money = {
        [1] = 'anim@amb@business@cfm@cfm_counting_notes@',
        [2] = 'anim@amb@business@cfm@cfm_cut_sheets@',
        [3] = 'anim@amb@business@cfm@cfm_drying_notes@',
    }
}

PlayerAnims = {
    Cocaine = {
        [1] = 'coke_cut_v5_coccutter',
        [2] = 'full_cycle_v3_pressoperator'
    },
    Meth = {
        [1] = 'chemical_pour_short_cooker',
        [2] = 'break_weigh_v3_char01',
    },
    Weed = {
        [1] = 'weed_spraybottle_crouch_spraying_02_inspector',
        [2] = "sorter_right_sort_v3_sorter02",
    },
    Money = {
        [1] = 'note_counting_v2_counter',
        [2] = 'extended_load_tune_cut_billcutter',
        [3] = 'loading_v3_worker',
    }
}

SceneAnims = {
    Cocaine = {
        [1] = {
            bakingsoda = 'coke_cut_v5_bakingsoda',
            creditcard1 = 'coke_cut_v5_creditcard',
            creditcard2 = 'coke_cut_v5_creditcard^1',
        },
        [2] = {
            scoop = 'full_cycle_v3_scoop',
            box1 = 'full_cycle_v3_FoldedBox',
            dollmold = 'full_cycle_v3_dollmould',
            dollcast1 = 'full_cycle_v3_dollcast',
            dollcast2 = 'full_cycle_v3_dollCast^1',
            dollcast3 = 'full_cycle_v3_dollCast^2',
            dollcast4 = 'full_cycle_v3_dollCast^3',
            press = 'full_cycle_v3_cokePress',
            doll = 'full_cycle_v3_cocdoll',
            bowl = 'full_cycle_v3_cocbowl',
            boxed = 'full_cycle_v3_boxedDoll',
        },
    },
    Meth = {
        [1] = {
            ammonia = 'chemical_pour_short_ammonia',
            clipboard = 'chemical_pour_short_clipboard',
            pencil = 'chemical_pour_short_pencil',
            sacid = 'chemical_pour_short_sacid',
        },
        [2] = {
            box1 = 'break_weigh_v3_box01',
            box2 = 'break_weigh_v3_box01^1',
            clipboard = 'break_weigh_v3_clipboard',
            methbag1 = 'break_weigh_v3_methbag01',
            methbag2 = 'break_weigh_v3_methbag01^1',
            methbag3 = 'break_weigh_v3_methbag01^2',
            methbag4 = 'break_weigh_v3_methbag01^3',
            methbag5 = 'break_weigh_v3_methbag01^4',
            methbag6 = 'break_weigh_v3_methbag01^5',
            methbag7 = 'break_weigh_v3_methbag01^6',
            pen = 'break_weigh_v3_pen',
            scale = 'break_weigh_v3_scale',
            scoop = 'break_weigh_v3_scoop',
        },
    },
    Weed = {
        [1] = {},
        [2] = {
            weeddry1 = 'sorter_right_sort_v3_weeddry01a',
            weeddry2 = 'sorter_right_sort_v3_weeddry01a^1',
            weedleaf1 = 'sorter_right_sort_v3_weedleaf01a',
            weedleaf2 = 'sorter_right_sort_v3_weedleaf01a^1',
            weedbag = 'sorter_right_sort_v3_weedbag01a',
            weedbud1a = 'sorter_right_sort_v3_weedbud02b',
            weedbud2a = 'sorter_right_sort_v3_weedbud02b^1',
            weedbud3a = 'sorter_right_sort_v3_weedbud02b^2',
            weedbud4a = 'sorter_right_sort_v3_weedbud02b^3',
            weedbud5a = 'sorter_right_sort_v3_weedbud02b^4',
            weedbud6a = 'sorter_right_sort_v3_weedbud02b^5',
            weedbud1b = 'sorter_right_sort_v3_weedbud02a',
            weedbud2b = 'sorter_right_sort_v3_weedbud02a^1',
            weedbud3b = 'sorter_right_sort_v3_weedbud02a^2',
            bagpile = 'sorter_right_sort_v3_weedbagpile01a',
            weedbuck = 'sorter_right_sort_v3_bucket01a',
            weedbuck = 'sorter_right_sort_v3_bucket01a^1',
        },
    },
    Money = {
        [1] = {
            binmoney = 'note_counting_v2_binmoney',
            moneybin = 'note_counting_v2_moneybin',
            money1 = 'note_counting_v2_moneyunsorted',
            money2 = 'note_counting_v2_moneyunsorted^1',
            wrap1 = 'note_counting_v2_moneywrap',
            wrap2 = 'note_counting_v2_moneywrap^1',
        },
        [2] = {
            cutter = 'extended_load_tune_cut_papercutter',
            singlep1 = 'extended_load_tune_cut_singlemoneypage',
            singlep2 = 'extended_load_tune_cut_singlemoneypage^1',
            singlep3 = 'extended_load_tune_cut_singlemoneypage^2',
            table = 'extended_load_tune_cut_table',
            stack = 'extended_load_tune_cut_moneystack',
            strip1 = 'extended_load_tune_cut_singlemoneystrip',
            strip2 = 'extended_load_tune_cut_singlemoneystrip^1',
            strip3 = 'extended_load_tune_cut_singlemoneystrip^2',
            strip4 = 'extended_load_tune_cut_singlemoneystrip^3',
            strip5 = 'extended_load_tune_cut_singlemoneystrip^4',
            sinstack = 'extended_load_tune_cut_singlestack',
        },
        [3] = {
            bucket = 'loading_v3_bucket',
            money1 = 'loading_v3_money01',
            money2 = 'loading_v3_money01^1',
        }
    },
}

SceneItems = {
    Cocaine = {
        [1] = {
            bakingsoda = 'bkr_prop_coke_bakingsoda_o',
            creditcard1 = 'prop_cs_credit_card',
            creditcard2 = 'prop_cs_credit_card',
        },
        [2] = {
            scoop = 'bkr_prop_coke_fullscoop_01a',
            doll = 'bkr_prop_coke_doll',
            boxed = 'bkr_prop_coke_boxedDoll',
            dollcast1 = 'bkr_prop_coke_dollCast',
            dollcast2 = 'bkr_prop_coke_dollCast',
            dollcast3 = 'bkr_prop_coke_dollCast',
            dollcast4 = 'bkr_prop_coke_dollCast',
            dollmold = 'bkr_prop_coke_dollmould',
            bowl = 'bkr_prop_coke_fullmetalbowl_02',
            press = 'bkr_prop_coke_press_01b',
            box1 = 'bkr_prop_coke_dollboxfolded',
        },
    },
    Meth = {
        [1] = {
            ammonia = 'bkr_prop_meth_ammonia',
            clipboard = 'bkr_prop_fakeid_clipboard_01a',
            pencil = 'bkr_prop_fakeid_penclipboard',
            sacid = 'bkr_prop_meth_sacid',
        },
        [2] = {
            box1 = 'bkr_prop_meth_bigbag_04a',
            box2 = 'bkr_prop_meth_bigbag_03a',
            clipboard = 'bkr_prop_fakeid_clipboard_01a',
            methbag1 = 'bkr_prop_meth_openbag_02',
            methbag2 = 'bkr_prop_meth_openbag_02',
            methbag3 = 'bkr_prop_meth_openbag_02',
            methbag4 = 'bkr_prop_meth_openbag_02',
            methbag5 = 'bkr_prop_meth_openbag_02',
            methbag6 = 'bkr_prop_meth_openbag_02',
            methbag7 = 'bkr_prop_meth_openbag_02',
            pen = 'bkr_prop_fakeid_penclipboard',
            scale = 'bkr_prop_coke_scale_01',
            scoop = 'bkr_prop_meth_scoop_01a',
        },
    },
    Weed = {
        [1] = {},
        [2] = {
            weeddry1 = 'bkr_prop_weed_dry_01a',
            weeddry2 = 'bkr_prop_weed_dry_01a',
            weedleaf1 = 'bkr_prop_weed_leaf_01a',
            weedleaf2 = 'bkr_prop_weed_leaf_01a',
            weedbag = 'bkr_prop_weed_bag_01a',
            weedbud1a = 'bkr_prop_weed_bud_02b',
            weedbud2a = 'bkr_prop_weed_bud_02b',
            weedbud3a = 'bkr_prop_weed_bud_02b',
            weedbud4a = 'bkr_prop_weed_bud_02b',
            weedbud5a = 'bkr_prop_weed_bud_02b',
            weedbud6a = 'bkr_prop_weed_bud_02b',
            weedbud1b = 'bkr_prop_weed_bud_02a',
            weedbud2b = 'bkr_prop_weed_bud_02a',
            weedbud3b = 'bkr_prop_weed_bud_02a',
            bagpile = 'bkr_prop_weed_bag_pile_01a',
            weedbuck = 'bkr_prop_weed_bucket_open_01a',
            weedbuck = 'bkr_prop_weed_bucket_open_01a',
        },
    },
    Money = {
        [1] = {
            binmoney = 'bkr_prop_coke_tin_01',
            moneybin = 'bkr_prop_tin_cash_01a',
            money1 = 'bkr_prop_money_unsorted_01',
            money2 = 'bkr_prop_money_unsorted_01',
            wrap1 = 'bkr_prop_money_wrapped_01',
            wrap2 = 'bkr_prop_money_wrapped_01',
        },
        [2] = {
            cutter = 'bkr_prop_fakeid_papercutter',
            singlep1 = 'bkr_prop_cutter_moneypage',
            singlep2 = 'bkr_prop_cutter_moneypage',
            singlep3 = 'bkr_prop_cutter_moneypage',
            table = 'bkr_prop_fakeid_table',
            stack = 'bkr_prop_cutter_moneystack_01a',
            strip1 = 'bkr_prop_cutter_moneystrip',
            strip2 = 'bkr_prop_cutter_moneystrip',
            strip3 = 'bkr_prop_cutter_moneystrip',
            strip4 = 'bkr_prop_cutter_moneystrip',
            strip5 = 'bkr_prop_cutter_moneystrip',
            sinstack = 'bkr_prop_cutter_singlestack_01a',
        },
        [3] = {
            bucket = 'bkr_prop_money_pokerbucket',
            money1 = 'bkr_prop_money_unsorted_01',
            money2 = 'bkr_prop_money_unsorted_01',
        }
    },
}

GangLookup = {}
for k, v in pairs(Config.GangJobs) do
    GangLookup[v] = true;
end ;
for k, v in pairs(Config.PoliceJobs) do
    GangLookup[v] = true;
end ;
PoliceLookup = {};
for k, v in pairs(Config.PoliceJobs) do
    PoliceLookup[v] = true;
end ;

FrameworkStart = function()
    while not ESX do
        TriggerEvent('tac:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(0)
    end
end

Citizen.CreateThread(FrameworkStart)