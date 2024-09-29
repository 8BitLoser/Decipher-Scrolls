---@class bsDecipherCommon
local common = {}

---@param scanCode tes3.scanCode
function common.isKeyDown(scanCode)
    return tes3.worldController.inputController:isKeyDown(scanCode)
end

common.sounds = {
    alitMOAN = "alitMOAN",
    alitROAR = "alitROAR",
    alitSCRM = "alitSCRM",
    Alma_att0 = "Alma_att0",
    Alma_att1 = "Alma_att1",
    Alma_att2 = "Alma_att2",
    Alma_hit0 = "Alma_hit0",
    Alma_hit1 = "Alma_hit1",
    Alma_hit2 = "Alma_hit2",
    alteration_area = "alteration area",
    alteration_bolt = "alteration bolt",
    alteration_cast = "alteration cast",
    alteration_hit = "alteration hit",
    Ambient_Factory_Ruins = "Ambient Factory Ruins",
    ancestor_ghost_moan = "ancestor ghost moan",
    ancestor_ghost_roar = "ancestor ghost roar",
    ancestor_ghost_scream = "ancestor ghost scream",
    animalLARGEleft = "animalLARGEleft",
    animalLARGEright = "animalLARGEright",
    animalSMALLleft = "animalSMALLleft",
    animalSMALLright = "animalSMALLright",
    ash_ghoul_moan = "ash ghoul moan",
    ash_ghoul_roar = "ash ghoul roar",
    ash_ghoul_scream = "ash ghoul scream",
    ash_slave_moan = "ash slave moan",
    ash_slave_roar = "ash slave roar",
    ash_slave_scream = "ash slave scream",
    ash_vampire_moan = "ash vampire moan",
    ash_vampire_roar = "ash vampire roar",
    ash_vampire_scream = "ash vampire scream",
    ash_zombie_moan = "ash zombie moan",
    ash_zombie_roar = "ash zombie roar",
    ash_zombie_scream = "ash zombie scream",
    Ashstorm = "Ashstorm",
    atroflame_moan = "atroflame moan",
    atroflame_roar = "atroflame roar",
    atroflame_scream = "atroflame scream",
    atrofrost_moan = "atrofrost moan",
    atrofrost_roar = "atrofrost roar",
    atrofrost_scream = "atrofrost scream",
    atrostorm_moan = "atrostorm moan",
    atrostorm_roar = "atrostorm roar",
    atrostorm_scream = "atrostorm scream",
    bear_moan = "bear moan",
    bear_roar = "bear roar",
    bear_scream = "bear scream",
    bearsniff = "bearsniff",
    bell1 = "bell1",
    bell2 = "bell2",
    bell3 = "bell3",
    bell4 = "bell4",
    bell5 = "bell5",
    bell6 = "bell6",
    blackoutin = "blackoutin",
    Blight = "Blight",
    BM_big_fire = "BM big fire",
    BM_Blizzard = "BM Blizzard",
    BM_Ice_Sheet = "BM_Ice_Sheet",
    BM_Nord_attack = "BM Nord attack",
    BM_Nord_attackF = "BM Nord attackF",
    BM_pipe_large = "BM pipe large",
    BM_pipe_medium = "BM pipe medium",
    BM_pipe_small = "BM pipe small",
    BM_Sun = "BM Sun",
    BM_Wilderness = "BM Wilderness",
    BM_Wilderness2 = "BM Wilderness2",
    BM_Wilderness3 = "BM Wilderness3",
    BM_Wind = "BM Wind",
    boar_moan = "boar moan",
    boar_roar = "boar roar",
    boar_scream = "boar scream",
    boarsniff = "boarsniff",
    Boat_Creak = "Boat Creak",
    boat_docked = "boat docked",
    Boat_Hull = "Boat Hull",
    Body_Fall_Large = "Body Fall Large",
    Body_Fall_Medium = "Body Fall Medium",
    Body_Fall_Small = "Body Fall Small",
    bonelord_moan = "bonelord moan",
    bonelord_roar = "bonelord roar",
    bonelord_scream = "bonelord scream",
    bonewalkerMOAN = "bonewalkerMOAN",
    bonewalkerROAR = "bonewalkerROAR",
    bonewalkerSCRM = "bonewalkerSCRM",
    bonewalkerWAR_moan = "bonewalkerWAR moan",
    bonewalkerWAR_roar = "bonewalkerWAR roar",
    bonewalkerWAR_scream = "bonewalkerWAR scream",
    book_close = "book close",
    book_open = "book open",
    book_page = "book page",
    book_page2 = "book page2",
    bowPull = "bowPull",
    bowShoot = "bowShoot",
    Bubbles = "Bubbles",
    Cave_Drip = "Cave Drip",
    Cave_Waterfall = "Cave_Waterfall",
    Cave_Wind = "Cave Wind",
    cavein = "cavein",
    cent_proj_moan = "cent proj moan",
    cent_proj_roar = "cent proj roar",
    cent_proj_scream = "cent proj scream",
    cent_proj_shoot = "cent proj shoot",
    cent_sphere_moan = "cent sphere moan",
    cent_sphere_roar = "cent sphere roar",
    cent_sphere_scream = "cent sphere scream",
    cent_spider_moan = "cent spider moan",
    cent_spider_roar = "cent spider roar",
    cent_spider_scream = "cent spider scream",
    cent_steam_fall = "cent steam fall",
    cent_steam_moan = "cent steam moan",
    cent_steam_roar = "cent steam roar",
    cent_steam_scream = "cent steam scream",
    chest_close = "chest close",
    chest_open = "chest open",
    chimes_wood = "chimes wood",
    clannfear_moan = "clannfear moan",
    clannfear_roar = "clannfear roar",
    clannfear_scream = "clannfear scream",
    cliff_racer_moan = "cliff racer moan",
    cliff_racer_roar = "cliff racer roar",
    cliff_racer_scream = "cliff racer scream",
    conjuration_area = "conjuration area",
    conjuration_bolt = "conjuration bolt",
    conjuration_cast = "conjuration cast",
    conjuration_hit = "conjuration hit",
    corpDRAG = "corpDRAG",
    corpus_stalker_moan = "corpus stalker moan",
    corpus_stalker_roar = "corpus stalker roar",
    corpus_stalker_scream = "corpus stalker scream",
    corpuslameMOAN = "corpuslameMOAN",
    corpuslameROAR = "corpuslameROAR",
    corpuslameSCRM = "corpuslameSCRM",
    Creeky_Wood = "Creeky Wood",
    critical_damage = "critical damage",
    crossbowPull = "crossbowPull",
    crossbowShoot = "crossbowShoot",
    crowd_booing = "crowd booing",
    CrowdBoo = "CrowdBoo",
    Crystal_Ringing = "Crystal Ringing",
    Daedric_Chant = "Daedric Chant",
    daedroth_moan = "daedroth moan",
    daedroth_roar = "daedroth roar",
    daedroth_scream = "daedroth scream",
    Dagoth_Ur_Moan = "Dagoth Ur Moan",
    Dagoth_Ur_Scream = "Dagoth Ur Scream",
    Default_Moan = "Default Moan",
    Default_Roar = "Default Roar",
    Default_Scream = "Default Scream",
    DefaultLand = "DefaultLand",
    DefaultLandWater = "DefaultLandWater",
    destruction_area = "destruction area",
    destruction_bolt = "destruction bolt",
    destruction_cast = "destruction cast",
    destruction_hit = "destruction hit",
    Disarm_Trap = "Disarm Trap",
    Disarm_Trap_Fail = "Disarm Trap Fail",
    Dock_Creak = "Dock Creak",
    Door_Creaky_Close = "Door Creaky Close",
    Door_Creaky_Open = "Door Creaky Open",
    Door_Heavy_Close = "Door Heavy Close",
    Door_Heavy_Open = "Door Heavy Open",
    Door_Latched_One_Close = "Door Latched One Close",
    Door_Latched_One_Open = "Door Latched One Open",
    Door_Latched_Two_Close = "Door Latched Two Close",
    Door_Latched_Two_Open = "Door Latched Two Open",
    Door_Metal_Close = "Door Metal Close",
    Door_Metal_Open = "Door Metal Open",
    Door_Stone_Close = "Door Stone Close",
    Door_Stone_Open = "Door Stone Open",
    dremora_moan = "dremora moan",
    dremora_roar = "dremora roar",
    dremora_scream = "dremora scream",
    dreugh_moan = "dreugh moan",
    dreugh_roar = "dreugh roar",
    dreugh_scream = "dreugh scream",
    drgr_moan = "drgr moan",
    drgr_roar = "drgr roar",
    drgr_scream = "drgr scream",
    Drink = "Drink",
    drown = "drown",
    drowning_damage = "drowning damage",
    dwarven_ghost_moan = "dwarven ghost moan",
    dwarven_ghost_roar = "dwarven ghost roar",
    dwarven_ghost_scream = "dwarven ghost scream",
    Dwe_waterfall = "Dwe_waterfall",
    Dwemer_Door_Close = "Dwemer Door Close",
    Dwemer_Door_Open = "Dwemer Door Open",
    Dwemer_Fan = "Dwemer Fan",
    enchant_fail = "enchant fail",
    enchant_success = "enchant success",
    endboom1 = "endboom1",
    endboom2 = "endboom2",
    endboom3 = "endboom3",
    endboom4 = "endboom4",
    endrumble = "endrumble",
    FabBossAlive = "FabBossAlive",
    FabBossClank = "FabBossClank",
    fabBossDead = "fabBossDead",
    FabBossGyro = "FabBossGyro",
    FabBossHit = "FabBossHit",
    fabBossLeft = "fabBossLeft",
    fabBossRight = "fabBossRight",
    FabBossRoar = "FabBossRoar",
    FabBossWhir = "FabBossWhir",
    FabHulkLeft = "FabHulkLeft",
    fabHulkMoan = "fabHulkMoan",
    FabHulkRight = "FabHulkRight",
    fabHulkRoar = "fabHulkRoar",
    fabHulkScream = "fabHulkScream",
    fabVermLeft = "fabVermLeft",
    fabVermMoan = "fabVermMoan",
    fabVermRight = "fabVermRight",
    fabVermRoar = "fabVermRoar",
    fabVermScream = "fabVermScream",
    Fire = "Fire",
    Fire_40 = "Fire 40",
    Fire_50 = "Fire 50",
    Flag = "Flag",
    Flies = "Flies",
    FootBareLeft = "FootBareLeft",
    FootBareRight = "FootBareRight",
    FootHeavyLeft = "FootHeavyLeft",
    FootHeavyRight = "FootHeavyRight",
    FootLightLeft = "FootLightLeft",
    FootLightRight = "FootLightRight",
    FootMedLeft = "FootMedLeft",
    FootMedRight = "FootMedRight",
    FootWaterLeft = "FootWaterLeft",
    FootWaterRight = "FootWaterRight",
    forcefield = "forcefield",
    frgiant_moan = "frgiant moan",
    frgiant_roar = "frgiant roar",
    frgiant_scream = "frgiant scream",
    frgtLeft = "frgtLeft",
    frgtRight = "frgtRight",
    frost_area = "frost area",
    frost_bolt = "frost_bolt",
    frost_cast = "frost_cast",
    frost_hit = "frost_hit",
    Gate_Large_Locked = "Gate Large Locked",
    ghostgate_sound = "ghostgate sound",
    goblin_large_moan = "goblin large moan",
    goblin_large_roar = "goblin large roar",
    goblin_large_scream = "goblin large scream",
    goblin_moan = "goblin moan",
    goblin_roar = "goblin roar",
    goblin_scream = "goblin scream",
    gold_saint_moan = "gold saint moan",
    gold_saint_roar = "gold saint roar",
    gold_saint_scream = "gold saint scream",
    gren_moan = "gren moan",
    gren_roar = "gren roar",
    gren_scream = "gren scream",
    greneat = "greneat",
    guar_moan = "guar moan",
    guar_roar = "guar roar",
    guar_scream = "guar scream",
    Hand_To_Hand_Hit = "Hand To Hand Hit",
    Hand_to_Hand_Hit_2 = "Hand to Hand Hit 2",
    Haunted = "Haunted",
    Health_Damage = "Health Damage",
    Heart = "Heart",
    heartdead = "heartdead",
    hearthit1 = "hearthit1",
    hearthit2 = "hearthit2",
    hearthit3 = "hearthit3",
    hearthit4 = "hearthit4",
    heartsunder = "heartsunder",
    Heavy_Armor_Hit = "Heavy Armor Hit",
    hirc_moan = "hirc moan",
    hirc_roar = "hirc roar",
    hirc_scream = "hirc scream",
    howl1 = "howl1",
    howl2 = "howl2",
    howl3 = "howl3",
    howl4 = "howl4",
    howl5 = "howl5",
    howl6 = "howl6",
    howl7 = "howl7",
    howl8 = "howl8",
    hrkLeft = "hrkLeft",
    hrkr_moan = "hrkr moan",
    hrkr_roar = "hrkr roar",
    hrkr_scream = "hrkr scream",
    hrkrbellow = "hrkrbellow",
    hrkRight = "hrkRight",
    ice_troll_moan = "ice troll moan",
    ice_troll_roar = "ice troll roar",
    ice_troll_scream = "ice troll scream",
    illusion_area = "illusion area",
    illusion_bolt = "illusion bolt",
    illusion_cast = "illusion cast",
    illusion_hit = "illusion hit",
    Item_Ammo_Down = "Item Ammo Down",
    Item_Ammo_Up = "Item Ammo Up",
    Item_Apparatus_Down = "Item Apparatus Down",
    Item_Apparatus_Up = "Item Apparatus Up",
    Item_Armor_Heavy_Down = "Item Armor Heavy Down",
    Item_Armor_Heavy_Up = "Item Armor Heavy Up",
    Item_Armor_Light_Down = "Item Armor Light Down",
    Item_Armor_Light_Up = "Item Armor Light Up",
    Item_Armor_Medium_Down = "Item Armor Medium Down",
    Item_Armor_Medium_Up = "Item Armor Medium Up",
    Item_Bodypart_Down = "Item Bodypart Down",
    Item_Bodypart_Up = "Item Bodypart Up",
    Item_Book_Down = "Item Book Down",
    Item_Book_Up = "Item Book Up",
    Item_Clothes_Down = "Item Clothes Down",
    Item_Clothes_Up = "Item Clothes Up",
    Item_Gold_Down = "Item Gold Down",
    Item_Gold_Up = "Item Gold Up",
    Item_Ingredient_Down = "Item Ingredient Down",
    Item_Ingredient_Up = "Item Ingredient Up",
    Item_Lockpick_Down = "Item Lockpick Down",
    Item_Lockpick_Up = "Item Lockpick Up",
    Item_Misc_Down = "Item Misc Down",
    Item_Misc_Up = "Item Misc Up",
    Item_Potion_Down = "Item Potion Down",
    Item_Potion_Up = "Item Potion Up",
    Item_Probe_Down = "Item Probe Down",
    Item_Probe_Up = "Item Probe Up",
    Item_Repair_Down = "Item Repair Down",
    Item_Repair_Up = "Item Repair Up",
    Item_Ring_Down = "Item Ring Down",
    Item_Ring_Up = "Item Ring Up",
    Item_Weapon_Blunt_Down = "Item Weapon Blunt Down",
    Item_Weapon_Blunt_Up = "Item Weapon Blunt Up",
    Item_Weapon_Bow_Down = "Item Weapon Bow Down",
    Item_Weapon_Bow_Up = "Item Weapon Bow Up",
    Item_Weapon_Crossbow_Down = "Item Weapon Crossbow Down",
    Item_Weapon_Crossbow_Up = "Item Weapon Crossbow Up",
    Item_Weapon_Longblade_Down = "Item Weapon Longblade Down",
    Item_Weapon_Longblade_Up = "Item Weapon Longblade Up",
    Item_Weapon_Shortblade_Down = "Item Weapon Shortblade Down",
    Item_Weapon_Shortblade_Up = "Item Weapon Shortblade Up",
    Item_Weapon_Spear_Down = "Item Weapon Spear Down",
    Item_Weapon_Spear_Up = "Item Weapon Spear Up",
    kagouti_moan = "kagouti moan",
    kagouti_roar = "kagouti roar",
    kagouti_scream = "kagouti scream",
    kwama_forager_slither = "kwama forager slither",
    kwamaF_left = "kwamaF left",
    kwamaF_right = "kwamaF right",
    kwamF_moan = "kwamF moan",
    kwamF_roar = "kwamF roar",
    kwamF_scream = "kwamF scream",
    kwamQ_moan = "kwamQ moan",
    kwamQ_roar = "kwamQ roar",
    kwamQ_scream = "kwamQ scream",
    kwamWK_moan = "kwamWK moan",
    kwamWK_roar = "kwamWK roar",
    kwamWK_scream = "kwamWK scream",
    kwamWR_moan = "kwamWR moan",
    kwamWR_roar = "kwamWR roar",
    kwamWR_scream = "kwamWR scream",
    Lava_Layer = "Lava Layer",
    LeftL = "LeftL",
    LeftM = "LeftM",
    LeftS = "LeftS",
    lich_lord_moan = "lich lord moan",
    lich_lord_roar = "lich lord roar",
    lich_lord_scream = "lich lord scream",
    Light_Armor_Hit = "Light Armor Hit",
    LockedChest = "LockedChest",
    LockedDoor = "LockedDoor",
    Machinery = "Machinery",
    magic_sound = "magic sound",
    Medium_Armor_Hit = "Medium Armor Hit",
    Menu_Click = "Menu Click",
    Menu_Size = "Menu Size",
    miss = "miss",
    MournDayAmb = "MournDayAmb",
    MournGates = "MournGates",
    MournGatesClose = "MournGatesClose",
    MournNightAmb = "MournNightAmb",
    MournSpray = "MournSpray",
    MournTempleAmb = "MournTempleAmb",
    mud_bubbles = "mud bubbles",
    mudcrab_moan = "mudcrab moan",
    mudcrab_roar = "mudcrab roar",
    mudcrab_scream = "mudcrab scream",
    mysticism_area = "mysticism area",
    mysticism_bolt = "mysticism bolt",
    mysticism_cast = "mysticism cast",
    mysticism_hit = "mysticism hit",
    netchBET_moan = "netchBET moan",
    netchBET_roar = "netchBET roar",
    netchBET_scream = "netchBET scream",
    netchBUL_moan = "netchBUL moan",
    netchBUL_roar = "netchBUL roar",
    netchBUL_scream = "netchBUL scream",
    nix_hound_moan = "nix hound moan",
    nix_hound_roar = "nix hound roar",
    nix_hound_scream = "nix hound scream",
    ogrim_moan = "ogrim moan",
    ogrim_roar = "ogrim roar",
    ogrim_scream = "ogrim scream",
    oil_bubbly = "oil bubbly",
    Open_Lock = "Open Lock",
    Open_Lock_Fail = "Open Lock Fail",
    Pack = "Pack",
    potion_fail = "potion fail",
    potion_success = "potion success",
    power_hummer = "power hummer",
    Power_Light = "Power Light",
    Power_light_50 = "Power light 50",
    Rain = "Rain",
    rain_heavy = "rain heavy",
    rat_moan = "rat moan",
    rat_roar = "rat roar",
    rat_scream = "rat scream",
    Repair = "Repair",
    repair_fail = "repair fail",
    restoration_area = "restoration area",
    restoration_bolt = "restoration bolt",
    restoration_cast = "restoration cast",
    restoration_hit = "restoration hit",
    riek_moan = "riek moan",
    riek_roar = "riek roar",
    riek_scream = "riek scream",
    RightL = "RightL",
    RightM = "RightM",
    RightS = "RightS",
    rmnt_moan = "rmnt moan",
    rmnt_roar = "rmnt roar",
    rmnt_scream = "rmnt scream",
    rock_and_roll = "rock and roll",
    rocks1 = "rocks1",
    rocks2 = "rocks2",
    rocks3 = "rocks3",
    rocks4 = "rocks4",
    rocks5 = "rocks5",
    rocks6 = "rocks6",
    rocks7 = "rocks7",
    rocks8 = "rocks8",
    ropebridge = "ropebridge",
    rumble1 = "rumble1",
    rumble2 = "rumble2",
    rumble3 = "rumble3",
    rumble4 = "rumble4",
    SatchelBlast = "SatchelBlast",
    scamp_moan = "scamp moan",
    scamp_roar = "scamp roar",
    scamp_scream = "scamp scream",
    scrib_moan = "scrib moan",
    scrib_roar = "scrib roar",
    scrib_scream = "scrib scream",
    scribLEFT = "scribLEFT",
    scribRIGHT = "scribRIGHT",
    scroll = "scroll",
    shalk_moan = "shalk moan",
    shalk_roar = "shalk roar",
    shalk_scream = "shalk scream",
    shock_area = "shock area",
    shock_bolt = "shock bolt",
    shock_cast = "shock cast",
    shock_hit = "shock hit",
    Silt_1 = "Silt_1",
    Silt_2 = "Silt_2",
    Silt_3 = "Silt_3",
    Sixth_Bell = "Sixth_Bell",
    SkaalAttackNoise = "SkaalAttackNoise",
    skeleton_moan = "skeleton moan",
    skeleton_roar = "skeleton roar",
    skeleton_scream = "skeleton scream",
    skillraise = "skillraise",
    slaughterfish_moan = "slaughterfish moan",
    slaughterfish_roar = "slaughterfish roar",
    slaughterfish_scream = "slaughterfish scream",
    sludgeworm_fall = "sludgeworm fall",
    sludgeworm_left = "sludgeworm left",
    sludgeworm_moan = "sludgeworm moan",
    sludgeworm_right = "sludgeworm right",
    sludgeworm_roar = "sludgeworm roar",
    sludgeworm_scream = "sludgeworm scream",
    SothaAmbient = "SothaAmbient",
    SothaBlade = "SothaBlade",
    SothaBladeRoll = "SothaBladeRoll",
    SothaDoorClose = "SothaDoorClose",
    SothaDoorOpen = "SothaDoorOpen",
    SothaFabMachine = "SothaFabMachine",
    SothaGear = "SothaGear",
    SothaGiantBlade = "SothaGiantBlade",
    SothaLab = "SothaLab",
    SothaLever = "SothaLever",
    SothaSpark = "SothaSpark",
    SothaSpikes = "SothaSpikes",
    sound_boat_creak = "sound_boat_creak",
    Sound_Test = "Sound Test",
    Sound_Test_Loop = "Sound Test Loop",
    Spell_Failure_Alteration = "Spell Failure Alteration",
    Spell_Failure_Conjuration = "Spell Failure Conjuration",
    Spell_Failure_Destruction = "Spell Failure Destruction",
    Spell_Failure_Illusion = "Spell Failure Illusion",
    Spell_Failure_Mysticism = "Spell Failure Mysticism",
    Spell_Failure_Restoration = "Spell Failure Restoration",
    spellmake_fail = "spellmake fail",
    spellmake_success = "spellmake success",
    spiderATTACK1 = "spiderATTACK1",
    spiderATTACK2 = "spiderATTACK2",
    spiderLEFT = "spiderLEFT",
    spiderRIGHT = "spiderRIGHT",
    Spirit_Ambient_Voices = "Spirit Ambient Voices",
    spriggan_moan = "spriggan moan",
    spriggan_resurrect = "spriggan resurrect",
    spriggan_roar = "spriggan roar",
    spriggan_scream = "spriggan scream",
    sprigganmagic = "sprigganmagic",
    Steam = "Steam",
    steamATTACK1 = "steamATTACK1",
    steamATTACK2 = "steamATTACK2",
    steamLEFT = "steamLEFT",
    steamRIGHT = "steamRIGHT",
    steamROLL = "steamROLL",
    Stone_Door_Open_1 = "Stone Door Open 1",
    StoneSound = "StoneSound",
    Swallow = "Swallow",
    swamp_1 = "swamp 1",
    swamp_2 = "swamp 2",
    swamp_3 = "swamp 3",
    Swim_Left = "Swim Left",
    Swim_Right = "Swim Right",
    SwishL = "SwishL",
    SwishM = "SwishM",
    SwishS = "SwishS",
    Thunder0 = "Thunder0",
    Thunder1 = "Thunder1",
    Thunder2 = "Thunder2",
    Thunder3 = "Thunder3",
    ThunderClap = "ThunderClap",
    Torch_Out = "Torch Out",
    Underwater = "Underwater",
    volcano_rumble = "volcano rumble",
    Water_Layer = "Water Layer",
    waterfall_small = "waterfall small",
    Weapon_Swish = "Weapon Swish",
    were_moan = "were moan",
    were_roar = "were roar",
    were_scream = "were scream",
    weregrowl = "weregrowl",
    werehowl = "werehowl",
    weresniff = "weresniff",
    wind_calm1 = "wind calm1",
    wind_calm2 = "wind calm2",
    wind_calm3 = "wind calm3",
    wind_calm4 = "wind calm4",
    wind_calm5 = "wind calm5",
    wind_des1 = "wind des1",
    wind_des2 = "wind des2",
    wind_des3 = "wind des3",
    wind_des4 = "wind des4",
    Wind_Light = "Wind Light",
    wind_low1 = "wind low1",
    wind_low2 = "wind low2",
    wind_low3 = "wind low3",
    wind_trees1 = "wind trees1",
    wind_trees2 = "wind trees2",
    wind_trees3 = "wind trees3",
    wind_trees4 = "wind trees4",
    wind_trees5 = "wind trees5",
    wind_trees6 = "wind trees6",
    wind_trees7 = "wind trees7",
    WindBag = "WindBag",
    winged_twil_moan = "winged twil moan",
    winged_twil_roar = "winged twil roar",
    winged_twil_scream = "winged twil scream",
    wolf_moan = "wolf moan",
    wolf_roar = "wolf roar",
    wolf_scream = "wolf scream",
    WolfActivator1 = "WolfActivator1",
    WolfContainer1 = "WolfContainer1",
    WolfContainer2 = "WolfContainer2",
    WolfCreature1 = "WolfCreature1",
    WolfCreature2 = "WolfCreature2",
    WolfCreature3 = "WolfCreature3",
    WolfEquip1 = "WolfEquip1",
    WolfEquip2 = "WolfEquip2",
    WolfEquip3 = "WolfEquip3",
    WolfEquip4 = "WolfEquip4",
    WolfEquip5 = "WolfEquip5",
    WolfHit1 = "WolfHit1",
    WolfHit2 = "WolfHit2",
    WolfHit3 = "WolfHit3",
    wolfhowl = "wolfhowl",
    WolfItem1 = "WolfItem1",
    WolfItem2 = "WolfItem2",
    WolfItem3 = "WolfItem3",
    WolfNPC1 = "WolfNPC1",
    WolfNPC2 = "WolfNPC2",
    WolfNPC3 = "WolfNPC3",
    WolfRun = "WolfRun",
    wolfskel_moan = "wolfskel moan",
    wolfskel_roar = "wolfskel roar",
    wolfskel_scream = "wolfskel scream",
    wolfskhowl = "wolfskhowl",
    WolfSwing = "WolfSwing",
    WolfSwing1 = "WolfSwing1",
    WolfSwing2 = "WolfSwing2",
    WolfSwing3 = "WolfSwing3",
    Wooden_Door_Close_1 = "Wooden Door Close 1",
    Wooden_Door_Open_1 = "Wooden Door Open 1",
}

common.rgb = {
    bsPrettyBlue = { 0.235, 0.616, 0.949 },
    bsNiceRed = { 0.941, 0.38, 0.38 },
    bsPrettyGreen = { 0.38, 0.941, 0.525 },
    bsLightGrey = { 0.839, 0.839, 0.839 },
    bsRoyalPurple = { 0.714, 0.039, 0.902 },
    activeColor = { 0.376, 0.439, 0.792 },
    activeOverColor = { 0.623, 0.662, 0.874 },
    activePressedColor = { 0.874, 0.886, 0.956 },
    answerColor = { 0.588, 0.196, 0.117 },
    answerPressedColor = { 0.952, 0.929, 0.866 },
    bigAnswerPressedColor = { 0.952, 0.929, 0.086 },
    blackColor = { 0, 0, 0 },
    disabledColor = { 0.701, 0.658, 0.529 },
    fatigueColor = { 0, 0.588, 0.235 },
    focusColor = { 0.313, 0.313, 0.313 },
    healthColor = { 0.784, 0.235, 0.117 },
    healthNpcColor = { 1, 0.729, 0 },
    journalFinishedQuestColor = { 0.235, 0.235, 0.235 },
    journalFinishedQuestOverColor = { 0.392, 0.392, 0.392 },
    journalFinishedQuestPressedColor = { 0.862, 0.862, 0.862 },
    journalLinkColor = { 0.145, 0.192, 0.439 },
    journalTopicOverColor = { 0.227, 0.301, 0.686 },
    linkColor = { 0.439, 0.494, 0.811 },
    linkOverColor = { 0.560, 0.607, 0.854 },
    linkPressedColor = { 0.686, 0.721, 0.894 },
    magicColor = { 0.207, 0.270, 0.623 },
    miscColor = { 0, 0.803, 0.803 },
    normalColor = { 0.792, 0.647, 0.376 },
    positiveColor = { 0.874, 0.788, 0.623 },
    whiteColor = { 1, 1, 1 }
}

return common