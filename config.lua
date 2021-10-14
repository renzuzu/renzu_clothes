Config = {}
Config.Components = {}
Config.Locale = "en"
Config.Mysql = 'mysql-async' -- "ghmattisql", "mysql-async", 'oxmysql'
Config.renzujobs = false -- Enable Job Owned Clothe Shop (Income Tax)
Config.Notify = function(type,title,message,source)
  if not source then
    TriggerEvent('renzu_notify:Notify',type,title,message)
  else
    TriggerClientEvent('renzu_notify:Notify',source,type,title,message)
  end
end

Config.Shop = {
  {
    showall = false, -- use categorized display shop or all in one menu
    name = 'Clothing Shop - Sinners Passage',
    range = 5.0,
    coord = vector3(427.474609375,-799.35137939453,29.491147994995),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(425.49340820313,-806.97125244141,29.491134643555),
    cashier_ped = vector3(427.10119628906,-806.98547363281,29.491134643555),
    -- config below will work only if showall is false
    wardrobe = vector3(429.90710449219,-812.01013183594,29.491146087646),
    clothesdisplay = {
      [1] = {
        coord = vector3(425.42288208008,-799.21997070313,29.491147994995),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(422.7532043457,-798.76983642578,29.491205215454),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(420.65289306641,-800.53283691406,29.491136550903),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(427.58071899414,-798.98614501953,29.491153717041),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(419.54400634766,-802.81787109375,29.491149902344),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(419.25454711914,-799.63012695313,29.496736526489),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(424.18872070313,-809.78118896484,29.491149902344),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(426.25311279297,-808.50073242188,29.491146087646),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },

  {
    showall = false, --
    name = 'Clothing Shop - Zancundo River',
    range = 5.0,
    coord = vector3(-1108.4, 2708.9, 18.1),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-1101.7569580078,2710.2026367188,19.107872009277),
    cashier_ped = vector3(-1101.8531494141,2712.1735839844,19.107873916626),
    -- config below will work only if showall is false
    wardrobe = vector3(-1099.9754638672,2717.6528320313,19.107873916626),
    clothesdisplay = {
      [1] = {
        coord = vector3(-1106.6472167969,2705.2578125,19.107872009277),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(-1109.9512939453,2708.9721679688,19.107872009277),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(-1102.7000732422,2703.5727539063,19.107879638672),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(-1108.2580566406,2707.1694335938,19.107872009277),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(-1099.7770996094,2703.9506835938,19.107873916626),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(-1101.6958007813,2701.7092285156,19.110013961792),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(-1097.4626464844,2711.4143066406,19.107872009277),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(-1100.5268554688,2712.5363769531,19.107872009277),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },

  {
    showall = false, --
    name = 'Clothing Shop - Chumash',
    range = 5.0,
    coord = vector3(-3172.5, 1048.1, 19.9),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-3170.6354980469,1043.7081298828,20.863206863403),
    cashier_ped = vector3(-3169.4013671875,1042.9071044922,20.863206863403),
    -- config below will work only if showall is false
    wardrobe = vector3(-3178.1774902344,1036.1475830078,20.863227844238),
    clothesdisplay = {
      [1] = {
        coord = vector3(-3175.7448730469,1051.3426513672,20.863235473633),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(-3174.0300292969,1041.7883300781,20.863235473633),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(-3166.0920410156,1049.1219482422,20.863237380981),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(-3174.1845703125,1046.1304931641,20.863237380981),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(-3177.1840820313,1045.5231933594,20.863237380981),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(-3162.982421875,1056.1975097656,20.86320495605),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(-3166.9440917969,1047.0441894531,20.863237380981),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(-3169.568359375,1046.2447509766,20.863237380981),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },

  {
    showall = false, --
    name = 'Del Perro - Clothing Shop',
    range = 5.0,
    coord = vector3(-1193.4, -772.3, 16.3),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-1192.5706787109,-767.62567138672,17.318658828735),
    cashier_ped = vector3(-1193.6887207031,-766.7568359375,17.316184997559),
    -- config below will work only if showall is false
    wardrobe = vector3(-1182.3435058594,-765.11059570313,17.326396942139),
    clothesdisplay = {
      [1] = {
        coord = vector3(-1192.6956787109,-777.15087890625,17.332313537598),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(-1195.578125,-779.55126953125,17.332601547241),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(-1199.5905761719,-770.42694091797,17.314926147461),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(-1190.9938964844,-771.65649414063,17.326272964478),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(-1188.4040527344,-772.50689697266,17.330362319946),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(-1205.6934814453,-775.05133056641,17.314853668213),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(-1197.712890625,-769.076171875,17.315061569214),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(-1195.333984375,-769.71417236328,17.318618774414),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },

  {
    showall = false, --
    name = 'Grand Senora Desert - Clothing Shop',
    range = 5.0,
    coord = vector3(1190.6, 2713.4, 37.2),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(1196.2154541016,2710.1633300781,38.222637176514),
    cashier_ped = vector3(1196.5815429688,2711.6484375,38.222637176514),
    -- config below will work only if showall is false
    wardrobe = vector3(1202.0113525391,2714.275390625,38.222591400146),
    clothesdisplay = {
      [1] = {
        coord = vector3(1191.0352783203,2707.2312011719,38.222637176514),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(1189.5870361328,2714.34375,38.222637176514),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(1191.8861083984,2715.4943847656,38.228694915771),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(1189.7221679688,2712.0949707031,38.222633361816),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(1193.0895996094,2704.2182617188,38.222629547119),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(1189.8846435547,2704.1359863281,38.222640991211),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(1200.2055664063,2708.5881347656,38.222595214844),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(1198.6348876953,2710.4760742188,38.222595214844),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },
  {
    showall = false, --
    name = 'Harmony - Clothing Shop',
    range = 5.0,
    coord = vector3(618.1, 2759.6, 41.1),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(614.19451904297,2763.677734375,42.088115692139),
    cashier_ped = vector3(612.87664794922,2762.7541503906,42.088115692139),
    -- config below will work only if showall is false
    wardrobe = vector3(617.57818603516,2773.1799316406,42.088115692139),
    clothesdisplay = {
      [1] = {
        coord = vector3(622.3759765625,2758.2609863281,42.088134765625),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(613.31567382813,2752.4016113281,42.088134765625),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(612.78680419922,2756.0551757813,42.088134765625),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(618.47161865234,2762.6552734375,42.088138580322),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(620.48864746094,2764.3903808594,42.088138580322),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(613.35772705078,2748.3347167969,42.088134765625),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(612.63220214844,2758.4631347656,42.088138580322),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(614.26739501953,2759.9367675781,42.08813858032),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },
  {
    showall = false, --
    name = 'ALTA - Clothing Shop',
    range = 5.0,
    coord = vector3(123.6, -219.4, 53.6),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(125.39047241211,-224.70080566406,54.557830810547),
    cashier_ped = vector3(127.05432891846,-224.11476135254,54.557830810547),
    -- config below will work only if showall is false
    wardrobe = vector3(118.55176544189,-232.09555053711,54.557830810547),
    clothesdisplay = {
      [1] = {
        coord = vector3(120.23133850098,-216.24253845215,54.557872772217),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(121.52603912354,-212.49964904785,54.557872772217),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(130.08329772949,-217.56893920898,54.557872772217),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(121.92754364014,-222.10810852051,54.557872772217),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(118.90754699707,-222.6357421875,54.557872772217),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(131.52593994141,-211.88539123535,54.557872772217),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(129.02584838867,-220.31727600098,54.557872772217),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(126.81050872803,-221.13395690918,54.557872772217),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },
  {
    name = 'Paleto Bay - Clothing Shop',
    range = 5.0,
    coord = vector3(11.6, 6514.2, 30.9),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(4.9661688804626,6512.5385742188,31.877851486206),
    cashier_ped = vector3(5.845956325531,6511.4262695313,31.877851486206),
    -- config below will work only if showall is false
    wardrobe = vector3(3.6173326969147,6505.6069335938,31.877855300903),
    clothesdisplay = {
      [1] = {
        coord = vector3(7.1124820709229,6518.158203125,31.889335632324),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(13.175498008728,6514.4379882813,31.877855300903),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(12.411615371704,6512.263671875,31.885139465332),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(11.23384475708,6515.8920898438,31.877851486206),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(3.2803764343262,6519.3061523438,31.877828598022),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(5.2073884010315,6521.2421875,31.877908706665),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(1.0801304578781,6511.259765625,31.877849578857),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(3.3995661735535,6510.7329101563,31.877849578857),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      -- [9] = {
      --   coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
      --   label = 'Earring 💎',
      --   indexes = {'ears_1','ears_2'},
      --   blacklist = {},
      -- },
      -- [10] = {
      --   coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
      --   label = 'Bracelet 👑',
      --   indexes = {'bracelets_1','bracelets_2'},
      --   blacklist = {},
      -- },
    }
  },
  {
    name = 'Cougar Avenue - Clothing Shop',
    range = 5.0,
    coord = vector3(-1447.8, -242.5, 48.8),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-1449.8309326172,-236.82116699219,49.810489654541),
    cashier_ped = vector3(-1449.5107421875,-238.78343200684,49.813491821289),
    -- config below will work only if showall is false
    wardrobe = vector3(-1446.8988037109,-243.03112792969,49.822860717773),
    clothesdisplay = {
      [1] = {
        coord = vector3(-1452.6494140625,-234.77481079102,49.803726196289),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(-1455.9630126953,-243.44987487793,49.81024169921),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(-1458.9240722656,-241.31132507324,49.803108215332),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(-1451.4538574219,-230.07043457031,49.799263000488),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(-1445.2071533203,-230.93284606934,49.809505462646),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(-1457.1577148438,-235.6615447998,49.798290252686),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(-1454.9448242188,-239.59648132324,49.806659698486),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(-1457.3161621094,-238.48524475098,49.801773071289),
        label = 'Glasses 👓',
        indexes = {'glasses_1','glasses_2'},
        blacklist = {},
      },
      [9] = {
        coord = vector3(-1453.6096191406,-241.39254760742,49.810981750488),
        label = 'Earring 💎',
        indexes = {'ears_1','ears_2'},
        blacklist = {},
      },
      [10] = {
        coord = vector3(-1454.7611083984,-237.38714599609,49.804039001465),
        label = 'Bracelet 👑',
        indexes = {'bracelets_1','bracelets_2'},
        blacklist = {},
      },
      [11] = {
        coord = vector3(-1451.7595214844,-238.84335327148,49.810340881348),
        label = 'Watches ⌚',
        indexes = {'watches_1','watches_2'},
        blacklist = {},
      },
    }
  },


  {
    name = 'PONSONBYS Clothe Shop',
    showall = false, -- disable by default| all in one clothing category in one menu, (not clothes display arrangement)
    range = 5.0,
    coord = vector3(-167.9, -299.0, 38.7),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-163.68531799316,-303.75512695313,39.733325958252),
    cashier_ped = vector3(-165.17021179199,-303.41387939453,39.733268737793),
    -- config below will work only if showall is false
    wardrobe = vector3(-168.92668151855,-299.11962890625,39.733299255371),
    clothesdisplay = {
      [1] = {
        coord = vector3(-160.37351989746,-304.58703613281,39.733325958252),
        label = 'T Shirt 👕',
        indexes = {'tshirt_1','tshirt_2','arms'},
        blacklist = {},
      },
      [2] = {
        coord = vector3(-160.1282043457,-295.11361694336,39.733329772949),
        label = 'Jackets 🧥',
        indexes = {'torso_1','torso_2','arms'},
        blacklist = {},
      },
      [3] = {
        coord = vector3(-157.00065612793,-296.09585571289,39.733329772949),
        label = 'Pants 👖',
        indexes = {'pants_1','pants_2'},
        blacklist = {},
      },
      [4] = {
        coord = vector3(-159.05406188965,-309.77944946289,39.733310699463),
        label = 'Head ⛑️',
        indexes = {'helmet_1','helmet_2'},
        blacklist = {},
      },
      [5] = {
        coord = vector3(-165.74737548828,-311.63604736328,39.733329772949),
        label = 'Footwear 👞',
        indexes = {'shoes_1','shoes_2'},
        blacklist = {},
      },
      [6] = {
        coord = vector3(-156.22618103027,-301.25335693359,39.733325958252),
        label = 'Bags 👜',
        indexes = {'bags_1','bags_2'},
        blacklist = {},
      },
      [7] = {
        coord = vector3(-159.92163085938,-298.97634887695,39.73327255249),
        label = 'Chains 👔',
        indexes = {'chain_1','chain_2'},
        blacklist = {},
      },
      [8] = {
        coord = vector3(-163.04884338379,-301.90658569336,39.733329772949),
        label = 'Watches ⌚',
        indexes = {'watches_1','watches_2'},
        blacklist = {},
      },
      [9] = {
        coord = vector3(-162.14483642578,-298.40255737305,39.73327255249),
        label = 'Earring 💎',
        indexes = {'ears_1','ears_2'},
        blacklist = {},
      },
      [10] = {
        coord = vector3(-158.64810180664,-301.44903564453,39.73327255249),
        label = 'Bracelet 👑',
        indexes = {'bracelets_1','bracelets_2'},
        blacklist = {},
      },
    },
  },

  {
    name = 'Mask Shop',
    showall = false, -- disable by default| all in one clothing category in one menu, (not clothes display arrangement)
    range = 5.0,
    coord = vector3(-1336.376953125,-1278.9876708984,4.8558125495911),
    job = 'police',
    blips = {sprite = 73,color = 1},
    cashier = vector3(-1336.3768310547,-1276.5521240234,4.8875975608826),
    cashier_ped = vector3(-1335.2003173828,-1276.7160644531,4.9635558128357),
    -- config below will work only if showall is false
    --wardrobe = vector3(-168.92668151855,-299.11962890625,39.733299255371),
    clothesdisplay = {
      [1] = {
        coord = vector3(-1336.3468017578,-1278.8399658203,4.8576703071594),
        label = 'Mask 🐵',
        indexes = {'mask_1','mask_2'},
        blacklist = {},
      },
    }
  },

  {
    name = 'Clothing Shop',
    range = 5.0,
    coord = vector3(-703.8, -152.3, 36.4),
    job = 'police',
    blips = {sprite = 73,color = 1}
  },
  {
    name = 'Clothing Shop',
    range = 5.0,
    coord = vector3(72.3, -1399.1, 28.4),
    job = 'police',
    blips = {sprite = 73,color = 1}
  },
}

Config.Data = {
  ['arms'] = {componentid = 3, type = 'ComponentVariations', m_default = 15, f_default = 15, multiplier = 1.0},
  ['torso_1'] = {componentid = 11, type = 'ComponentVariations', m_default = 15, f_default = 15, multiplier = 1.0},
  ['torso_2'] = {componentid = 11, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['tshirt_1'] = {componentid = 8, type = 'ComponentVariations', m_default = 15, f_default = 14, multiplier = 1.0},
  ['tshirt_2'] = {componentid = 8, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['glasses_1'] = {componentid = 1 ,type = 'Props', m_default = 14, f_default = 5, multiplier = 1.0},
  ['glasses_2'] = {componentid = 1 ,type = 'Props', m_default = 14, f_default = 5, multiplier = 1.0},
  ['pants_1'] = {componentid = 4, type = 'ComponentVariations', m_default = 14, f_default = 15, multiplier = 1.0},
  ['pants_2'] = {componentid = 4, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['helmet_1'] = {componentid = 0 ,type = 'Props', m_default = 11, f_default = -1, multiplier = 1.0},
  ['helmet_2'] = {componentid = 0 ,type = 'Props', m_default = -1, f_default = -1, multiplier = 1.0},
  ['watches_1'] = {componentid = 6 ,type = 'Props', multiplier = 1.0},
  ['watches_2'] = {componentid = 6 ,type = 'Props', multiplier = 1.0},
  ['bracelets_1'] = {componentid = 7 ,type = 'Props', multiplier = 1.0},
  ['bracelets_2'] = {componentid = 7 ,type = 'Props', multiplier = 1.0},
  ['ears_1'] = {componentid = 2 ,type = 'Props', multiplier = 1.0},
  ['ears_2'] = {componentid = 2 ,type = 'Props', multiplier = 1.0},
  ['shoes_1'] = {componentid = 6, type = 'ComponentVariations', m_default = 34, f_default = 35, multiplier = 1.0},
  ['shoes_2'] = {componentid = 6, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['decals_1'] = {componentid = 10, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['decals_2'] = {componentid = 10, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['bags_1'] = {componentid = 5, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['bags_2'] = {componentid = 5, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['chain_1'] = {componentid = 7, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['chain_2'] = {componentid = 7, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['mask_1'] = {componentid = 1, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
  ['mask_2'] = {componentid = 1, type = 'ComponentVariations', m_default = 0, f_default = 0, multiplier = 1.0},
}

-- Shop Default variants
Config.default = {
  'tshirt_1', 'tshirt_2',
  'torso_1', 'torso_2',
  'decals_1', 'decals_2',
  'arms',
  'pants_1', 'pants_2',
  'shoes_1', 'shoes_2',
  'bags_1', 'bags_2',
  'chain_1', 'chain_2',
  'helmet_1', 'helmet_2',
  'glasses_1', 'glasses_2',
  'mask_1', 'mask_2',
  'ears_1', 'ears_2',
  'bracelets_2', 'bracelets_2',
  'watches_1', 'watches_2',
}