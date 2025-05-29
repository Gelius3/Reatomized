#this is the hash that will become the full multforms hash
PokemonForms = {
PBSpecies::UNOWN => {
	:OnCreation => proc{rand(28)}
},

PBSpecies::FLABEBE => {
	:OnCreation => proc{rand(5)}
},

PBSpecies::SQUAWKABILLY => {
	:FormName => {
		0 => "Green",
		1 => "Blue",
		2 => "Yellow",
		3 => "White"
	},
	:OnCreation => proc{rand(4)},

	"Blue" => {
		:DexEntry => "Blue-feathered Squawkabilly view their green-feathered counterparts as rivals, since the latter make up the largest, most powerful groups."
	},

	"Yellow" => {
		:DexEntry => "These Squawkabilly are hotheaded, and their fighting style is vicious. They’ll leap within reach of their foes to engage in close combat."
	},

	"White" => {
		:DexEntry => "This Pokémon dislikes being alone. It has a strong sense of community and survives by cooperating with allies."
	}
},

PBSpecies::CASTFORM => {
	:FormName => {
		1 => "Sunny Form",
		2 => "Rainy Form",
		3 => "Snowy Form",
		4 => "Sandy Form",
		9 => "Amalgaform"
	},
	"Sunny Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FIRE
	},
	"Rainy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::WATER,
		:Type2 => PBTypes::WATER
	},
	"Snowy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE
	},
	"Sandy Form" => {
		:BaseStats => [70,70,80,110,110,80],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::ROCK
	},
	"Amalgaform" =>  {
		:BaseStats => [250,120,200,70,110,200],
		:EVs => [12,0,0,0,0,0],
		:type1 => PBTypes::QMARKS,
		:type2 => PBTypes::QMARKS
	}
},

PBSpecies::DEOXYS => {
	:FormName => {
		1 => "Attack Form",
		2 => "Defense Form",
		3 => "Speed Form",
	},

	:DefaultForm => 0, #Not really

	"Attack Form" => {
		:BaseStats => [50,180,20,150,180,20],
		:EVs => [0,2,0,0,1,0],
	},

	"Defense Form" => {
		:BaseStats => [50, 70,160, 90, 70,160],
		:EVs => [0,0,2,0,0,1],
	},

	"Speed Form" => {
		:BaseStats => [50, 95, 90,180, 95, 90],
		:EVs => [0,0,0,3,0,0],
	},
},

PBSpecies::BURMY => {
	:FormName => {
		1 => "Sandy Cloak",
		2 => "Trash Cloak"
	},

	:OnCreation => proc{
		begin #horribly stupid section to make the battle stress test work
		case $fefieldeffect
			when 1,5,6,10,11,17,18,19,24,26,29,30,35,36,37
				next 2 # Trash Cloak
			when 2,3,7,8,9,15,21,22,31,33,34
				next 0 # Plant Cloak
			when 4,12,13,14,16,20,23,25,27,28,32
				next 1 # Sandy Cloak
		end
		env=pbGetEnvironment()
		if env==PBEnvironment::Sand || env==PBEnvironment::Rock || env==PBEnvironment::Cave
			next 1 # Sandy Cloak
		elsif !pbGetMetadata($game_map.map_id,MetadataOutdoor)
			next 2 # Trash Cloak
		else
			next 0 # Plant Cloak
		end
		rescue
			next 0
		end
	}
},

PBSpecies::WORMADAM => {
	:FormName => {
		1 => "Sandy Cloak",
		2 => "Trash Cloak"
	},

	:OnCreation => proc{
		begin #horribly stupid section to make the battle stress test work
		case $fefieldeffect
			when 1,5,6,10,11,17,18,19,24,26,29,30,35,36,37
				next 2 # Trash Cloak
			when 2,3,7,8,9,15,21,22,31,33,34
				next 0 # Plant Cloak
			when 4,12,13,14,16,20,23,25,27,28,32
				next 1 # Sandy Cloak
		end
		env=pbGetEnvironment()
		if env==PBEnvironment::Sand || env==PBEnvironment::Rock || env==PBEnvironment::Cave
			next 1 # Sandy Cloak
		elsif !pbGetMetadata($game_map.map_id,MetadataOutdoor)
			next 2 # Trash Cloak
		else
			next 0 # Plant Cloak
		end
		rescue
			next 0
		end
	},

	"Sandy Cloak" => {
		:BaseStats => [60,79,105,36,59,85],
		:EVs => [0,0,2,0,0,0],
		:Type2 => PBTypes::GROUND,
		:Movelist => [[0,PBMoves::GUST],[1,PBMoves::GUST],[1,PBMoves::TACKLE],
		[1,PBMoves::PROTECT],[1,PBMoves::STRUGGLEBUG],[10,PBMoves::STRINGSHOT],[15,PBMoves::BUGBITE],
		[20,PBMoves::HIDDENPOWER],[23,PBMoves::CONFUSION],[26,PBMoves::ROCKBLAST],[28,PBMoves::HARDEN],
		[30,PBMoves::INFESTATION],[32,PBMoves::CAPTIVATE],[35,PBMoves::PSYBEAM],[37,PBMoves::SILVERWIND],
		[39,PBMoves::FLAIL],[41,PBMoves::ATTRACT],[43,PBMoves::EARTHPOWER],[45,PBMoves::PSYCHIC],
		[47,PBMoves::FISSURE],[50,PBMoves::SUCKERPUNCH],[53,PBMoves::BUGBUZZ],[56,PBMoves::QUIVERDANCE],
		[59,PBMoves::SHOREUP]],
	},

	"Trash Cloak" => {
		:BaseStats => [60,69,95,36,69,95],
		:EVs => [0,0,1,0,0,1],
		:Type2 => PBTypes::STEEL,
		:Movelist => [[0,PBMoves::GUST],[1,PBMoves::GUST],[1,PBMoves::TACKLE],[1,PBMoves::PROTECT],
		[1,PBMoves::STRUGGLEBUG],[10,PBMoves::STRINGSHOT],[15,PBMoves::BUGBITE],[20,PBMoves::HIDDENPOWER],
		[23,PBMoves::CONFUSION],[26,PBMoves::MIRRORSHOT],[28,PBMoves::METALSOUND],[30,PBMoves::INFESTATION],
		[32,PBMoves::CAPTIVATE],[35,PBMoves::PSYBEAM],[37,PBMoves::SILVERWIND],[39,PBMoves::FLAIL],
		[41,PBMoves::ATTRACT],[43,PBMoves::IRONHEAD],[45,PBMoves::PSYCHIC],[47,PBMoves::METALBURST],
		[50,PBMoves::SUCKERPUNCH],[53,PBMoves::BUGBUZZ],[56,PBMoves::QUIVERDANCE],[59,PBMoves::RECOVER]],
	}
},

PBSpecies::CHERRIM => {
	:FormName => {
		1 => "Sunshine Form"
	},

	"Sunshine Form" => {
		:BaseStats => [70,90,70,85,87,117],
		:Type2 => PBTypes::FAIRY,
	}
},

PBSpecies::SHELLOS => {
	:OnCreation => proc{
		maps=[206,513,519,522,526,528,530,536,538,547,553,555,556,558,562,563,565,566,567,569,574,585,586,603,604,605,608,610] # Map IDs for second form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	}
},

PBSpecies::ROTOM => {
	:FormName => {
		1 => "Heat",
		2 => "Wash",
		3 => "Frost",
		4 => "Fan",
		5 => "Mow"
	},

	"Heat" => {
		:Type2 => PBTypes::FIRE,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::SOLARPOWER,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Wash" => {
		:Type2 => PBTypes::WATER,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::WATERABSORB,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Frost" => {
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::SNOWWARNING,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Fan" => {
		:Type2 => PBTypes::FLYING,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::WINDPOWER,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	},
	"Mow" => {
		:Type2 => PBTypes::GRASS,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::GRASSYSURGE,PBAbilities::MOTORDRIVE],
		:BaseStats => [50,65,107,86,105,107]
	}
},

PBSpecies::GIRATINA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin",
		2 => "Cyrus' Origin",
		3 => "Cyrus' Cosmic"
	},

	"Origin" => {
		:BaseStats => [150,120,100,90,120,100],
		:Ability => PBAbilities::LEVITATE,
		:Height => 69,
		:Weight => 6500
	},

	"Cyrus' Origin" => {
		:BaseStats => [155,125,105,95,125,105],
		:Ability => PBAbilities::LEVITATE,
		:Height => 69,
		:Weight => 6500
	},

	"Cyrus' Cosmic" => {
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [155,125,105,95,125,105],
		:Ability => PBAbilities::LEVITATE,
		:Height => 69,
		:Weight => 6500
	}
},

PBSpecies::PALKIA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin"
	},

	"Origin" => {
		:BaseStats => [90,100,100,120,150,120],
		:Weight => 6600
	}
},

PBSpecies::DIALGA => {
	:FormName => {
		0 => "Altered",
		1 => "Origin",
		2 => "Primal"
	},

	"Origin" => {
		:BaseStats => [100,100,120,90,150,120],
		:Weight => 8500,
		:Height => 700
	},

	"Primal" => {
		:BaseStats => [100,170,65,110,170,65],
		:Weight => 683
	}
},

PBSpecies::SHAYMIN => {
	:FormName => {1 => "Sky"},

	"Sky" => {
		:BaseStats => [100,103,75,127,120,75],
		:EVs => [0,0,0,3,0,0],
		:Type2 => PBTypes::FLYING,
		:Ability => PBAbilities::SERENEGRACE,
		:Height => 04,
		:Weight => 52
	}
},

PBSpecies::BASCULIN => {
	:FormName => {
		0 => "White-Striped",
		1 => "Red-Striped",
		2 => "Blue-Striped"
	},
	:OnCreation => proc{rand(3)},

	"Red-Striped" => {
		:DexEntry => "Its temperament is vicious and aggressive. This Pokémon is also full of vitality and can multiply rapidly before anyone notices.",
		:WildHoldItems => [0,PBItems::DEEPSEATOOTH,0],
		:GetEvo => []
	},

	"Blue-Striped" => {
		:DexEntry => "The power of its jaws is immense—enough to leave teeth marks in iron sheets. Its personality is also extremely vicious.",
		:WildHoldItems => [0,PBItems::DEEPSEASCALE,0],
		:GetEvo => []
	}
},

PBSpecies::BASCULEGION => {
	#Gender difference
	"Female" => {
		:DexEntry => "It can afflict a target with terrifying illusions that are under its control. The deeper the sadness in its friends' souls, the paler Basculegion becomes.",
		:BaseStats => [120,80,65,78,112,75], #Canon: [120,92,65,78,100,75]
		:WildItemRare => :EXPCANDYM
	}
},

PBSpecies::DARUMAKA => {
	:FormName => {2 => "Galarian"},

	:OnCreation => proc{
		maps=[412] # Map IDs for Galarian form
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Galarian" => {
		:DexEntry => "It lived in snowy areas for so long that its fire sac cooled off and atrophied. It now has an organ that generates cold instead.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
			[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
			[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
			[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER]],
		:EggMoves => [PBMoves::FLAMEWHEEL,PBMoves::FOCUSPUNCH,PBMoves::FREEZEDRY,PBMoves::HAMMERARM,
			PBMoves::INCINERATE,PBMoves::POWERUPPUNCH,PBMoves::TAKEDOWN,PBMoves::YAWN]
	}
},

PBSpecies::DARMANITAN => {
	:FormName => {
		1 => "Zen",
		2 => "Galarian",
		3 => "Galarian Zen"
	},

	:OnCreation => proc{
		maps=[] # Map IDs for Galarian form
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Zen" => {
		:DexEntry => "When wounded, it stops moving. It goes as still as stone to meditate, sharpening its mind and spirit.",
		:BaseStats => [105,30,105,55,140,105],
		:EVs => [0,0,0,0,2,0],
		:Type2 => PBTypes::PSYCHIC
	},

	"Galarian" => {
		:DexEntry => "Though it has a gentle disposition, it's also very strong. It will quickly freeze the snowball on its head before going for a headbutt.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::GORILLATACTICS,PBAbilities::CONQUEROR,PBAbilities::HERO,PBAbilities::SPIRIT,PBAbilities::ZENMODE],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
		[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
		[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
		[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER],[50,PBMoves::ICICLECRASH]],
		:Height => 1.7,
		:Weight => 120
	},

	"Galarian Zen" => {
		:DexEntry => "Darmanitan takes this form when enraged. It won't stop spewing flames until its rage has settled, even if its body starts to melt.",
		:BaseStats => [105,160,55,135,30,55],
		:EVs => [0,0,0,0,2,0],
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FIRE,
		:Ability => [PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::GORILLATACTICS,PBAbilities::ZENMODE],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TACKLE],[4,PBMoves::TAUNT],[8,PBMoves::BITE],
		[12,PBMoves::HEADBUTT],[16,PBMoves::AVALANCHE],[20,PBMoves::WORKUP],[24,PBMoves::ICEFANG],
		[28,PBMoves::UPROAR],[32,PBMoves::BELLYDRUM],[36,PBMoves::ICEPUNCH],[40,PBMoves::THRASH],
		[44,PBMoves::BLIZZARD],[48,PBMoves::SUPERPOWER],[50,PBMoves::ICICLECRASH]],
		:Height => 1.7,
		:Weight => 120
	}
},

PBSpecies::DEERLING => {
	:OnCreation => proc{
		maps=[710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,742]
		case rand(2)
			when 0 then next $game_map && maps.include?($game_map.map_id) ? 2 : 0
			when 1 then next $game_map && maps.include?($game_map.map_id) ? 3 : 1
		end
	}
},

PBSpecies::TORNADUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [79,100,80,121,110,90],
		:EVs => [0,0,0,3,0,0],
		:Ability => [PBAbilities::REGENERATOR,PBAbilities::WINDRIDER,PBAbilities::WINDPOWER],
		:Height => 14
	}
},

PBSpecies::THUNDURUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [79,105,70,101,145,80],
		:EVs => [0,0,0,0,3,0],
		:Ability => [PBAbilities::VOLTABSORB,PBAbilities::WINDRIDER,PBAbilities::STORMBRINGER],
		:Height => 30
	}
},

PBSpecies::LANDORUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [89,145,90,91,105,80],
		:EVs => [0,3,0,0,0,0],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::WINDRIDER],
		:Height => 13
	}
},

PBSpecies::ENAMORUS => {
	:FormName => {1 => "Therian"},

	"Therian" => {
		:BaseStats => [74,115,110,46,135,100],
		:Ability => [PBAbilities::OVERCOAT,PBAbilities::WINDRIDER],
		:Height => 16
	}
},

PBSpecies::KYUREM => {
	:FormName => {
		1 => "White",
		2 => "Black"
	},

	"White" => {
		:BaseStats => [125,120,90,95,170,100],
		:EVs => [0,0,0,0,3,0],
		:Ability => PBAbilities::TURBOBLAZE,
		:Height => 36
	},

	"Black" => {
		:BaseStats => [125,170,100,95,120,90],
		:EVs => [0,3,0,0,0,0],
		:Ability => PBAbilities::TERAVOLT,
		:Height => 33
	}
},

PBSpecies::CALYREX => {
	:FormName => {
		1 => "Ice Rider",
		2 => "Shadow Rider"
	},

	"Ice Rider" => {
		:DexEntry => "According to lore, this Pokémon showed no mercy to those who got in its way, yet it would heal its opponents' wounds after battle.",
		:BaseStats => [100,165,150,50,85,130],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::ICE,
		:Ability => PBAbilities::ASONE,
		:Height => 24,
		:Weight => 809
	},

	"Shadow Rider" => {
		:DexEntry => "Legend says that by using its power to see all events from past to future, this Pokémon saved the creatures of a forest from a meteorite strike.",
		:BaseStats => [100,85,80,150,165,100],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::ASONE,
		:Height => 24,
		:Weight => 53
	}
},

PBSpecies::MELOETTA => {
	:FormName => {1 => "Pirouette"},

	"Pirouette" => {
		:BaseStats => [100,128,90,128,77,77],
		:EVs => [0,1,1,1,0,0],
		:Type2 => PBTypes::FIGHTING,
	}
},

PBSpecies::PUMPKABOO => {
	:FormName => {1 => "Small"},
	:OnCreation => proc{rand(2)},

	"Small" => {
		:BaseStats => [44,66,70,56,44,55],
		:Height => 03,
		:Weight => 35
	}
},

PBSpecies::GOURGEIST => {
	:FormName => {
		1 => "Small",
		2 => "Mega"
	},
	:OnCreation => proc{rand(2)},

	:DefaultForm => 0, #Not really
	:MegaForm => 2,

	"Small" => {
		:BaseStats => [55,85,122,99,58,75],
		:Height => 07,
		:Weight => 95
	},

	"Mega" => {
		:BaseStats => [85,130,132,84,78,85],
		:Ability => [PBAbilities::PRANKSTER],
	}
},

PBSpecies::AEGISLASH => {
	:FormName => {
		1 => "Blade",
		2 => "Crystal"
	},

	"Blade" => {:BaseStats => [60,140,50,60,140,50]},

	"Crystal" => {
		:BaseStats => [200,150,150,70,150,150],
		:EVs => [0,2,0,0,2,0],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::FRIENDGUARD
	}
},

PBSpecies::ZYGARDE => {
	:FormName => {
		0 => "50%",
		1 => "10%",
		2 => "100%"
	},

	"10%" => {
		:DexEntry => "Its sharp fangs make short work of finishing off its enemies, but it's unable to maintain this body indefinitely. After a period of time, it falls apart.",
		:BaseStats => [54,100,71,115,61,85],
		:Height => 12,
		:Weight => 335
	},

	"100%" => {
		:DexEntry => "This is Zygarde's form at times when it uses its overwhelming power to suppress those who endanger the ecosystem.",
		:BaseStats => [216,100,121,85,91,95],
		:Height => 45,
		:Weight => 6100
	}
},

PBSpecies::HOOPA => {
	:FormName => {1 => "Unbound"},

	"Unbound" => {
		:BaseStats => [80,160,60,80,170,130],
		:Type2 => PBTypes::DARK,
		:Height => 65,
		:Weight => 4900
	}
},

PBSpecies::ORICORIO => {
	:FormName => {
		1 => "Pom-Pom",
		2 => "Pa'u",
		3 => "Sensu"
	},

	"Pom-Pom" => {
		:DexEntry => "It creates an electric charge by rubbing its feathers together. It dances over to its enemies and delivers shocking electrical punches.",
		:Type1 => PBTypes::ELECTRIC,
		:WildHoldItems => [0,PBItems::YELLOWNECTAR,0]
	},

	"Pa'u" => {
		:DexEntry => "This Oricorio relaxes by swaying gently. This increases its psychic energy, which it then fires at its enemies.",
		:Type1 => PBTypes::PSYCHIC,
		:WildHoldItems => [0,PBItems::PINKNECTAR,0]
	},

	"Sensu" => {
		:DexEntry => "It summons the dead with its dreamy dancing. From their malice, it draws power with which to curse its enemies.",
		:Type1 => PBTypes::GHOST,
		:WildHoldItems => [0,PBItems::PURPLENECTAR,0]
	}
},

PBSpecies::LYCANROC => {
	:FormName => {
		1 => "Midnight",
		2 => "Dusk"
	},

	:OnCreation => proc{
		daytime = PBDayNight.isDay?(pbGetTimeNow)
		dusktime = PBDayNight.isDusk?(pbGetTimeNow)
		if dusktime
			next 2
		elsif daytime
			next 0
		else
			next 1
		end
	},

	"Midnight" => {
		:DexEntry => "It goads its enemies into attacking, withstands the hits, and in return, delivers a headbutt, crushing their bones with its rocky mane.",
		:BaseStats => [85,115,75,82,55,75],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::VITALSPIRIT,PBAbilities::VITALSPIRIT,
			PBAbilities::NOGUARD],
		:Height => 11,
	},

	"Dusk" => {
		:DexEntry => "Bathed in the setting sun of evening, Lycanroc has undergone a special kind of evolution. An intense fighting spirit underlies its calmness.",
		:BaseStats => [75,117,65,110,55,65],
		:Ability => [PBAbilities::TOUGHCLAWS,PBAbilities::TOUGHCLAWS,PBAbilities::TOUGHCLAWS,
			PBAbilities::TOUGHCLAWS],
	}
},

PBSpecies::WISHIWASHI => {
	:FormName => {1 => "School"},

	"School" => {
		:DexEntry => "At their appearance, even Gyarados will flee. When they team up to use Water Gun, its power exceeds that of Hydro Pump.",
		:BaseStats => [45,140,130,30,140,135],
		:Height => 82,
 		:Weight => 786,
	}
},

PBSpecies::MINIOR => {
	:FormName => {7 => "Core"},
	:OnCreation => proc{rand(7)},

	"Core" => {
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::FLYING,
		:BaseStats => [60,60,100,60,60,100],
		:EVs => [0,1,0,0,1,0],
 		:Weight => 400,
		:CatchRate => 30
	}
},

PBSpecies::NECROZMA => {
	:FormName => {
		1 => "Dusk Mane",
		2 => "Dawn Wings",
		3 => "Ultra",
		4 => "Totem"
	},

	:UltraForm => 3,

	"Dusk Mane" => {
		:DexEntry => "This is its form while it is devouring the light of Solgaleo. It pounces on foes and then slashes them with the claws on its four limbs and back.",
		:BaseStats => [97,157,127,77,113,109],
		:EVs => [0,3,0,0,0,0],
		:Type2 => PBTypes::STEEL,
		:Ability => [PBAbilities::FULLMETALBODY,PBAbilities::PRISMARMOR,PBAbilities::BEASTBOOST],
		:Height => 38,
		:Weight => 4600
	},

	"Dawn Wings" => {
		:DexEntry => "This is its form while it's devouring the light of Lunala. It grasps foes in its giant claws and rips them apart with brute force.",
		:BaseStats => [97,113,109,77,157,127],
		:EVs => [0,0,0,0,3,0],
		:Type2 => PBTypes::GHOST,
		:Height => 42,
		:Ability => [PBAbilities::SHADOWSHIELD,PBAbilities::PRISMARMOR,PBAbilities::BEASTBOOST],
		:Weight => 3500
	},

	"Ultra" => {
		:DexEntry => "The light pouring out from all over its body affects living things and nature, impacting them in various ways.",
		:BaseStats => [97,167,97,129,167,97],
		:EVs => [0,1,0,1,1,0],
		:Type2 => PBTypes::DRAGON,
		:Ability => PBAbilities::NEUROFORCE,
		:Height => 75,
		:Weight => 2300
	},

	"Totem" => {
		:BaseStats => [97,167,97,129,167,97],
		:EVs => [0,1,0,1,1,0],
		:Type2 => PBTypes::DRAGON,
		:Ability => PBAbilities::NEUROFORCE,
		:Height => 75,
		:Weight => 2300
	}
},

PBSpecies::EISCUE => {
	:FormName => {1 => "Noice"},

	"Noice" => {
		:DexEntry => "Contrary to its looks, Eiscue is a poor swimmer. It creates ice balls at the tip of its single hair to lure prey in and fish them up.",
		:BaseStats => [75,80,70,130,65,50]
	}
},

PBSpecies::MORPEKO => {
	:FormName => {
		0 => "Full Belly",
		1 => "Hangry"
	},

	"Hangry" => {
		:DexEntry => "Hunger hormones affect its temperament. Until its hunger is appeased, it gets up to all manner of evil deeds."
	}
},

PBSpecies::INDEEDEE => {
	#Gender difference
	"Female" => {
		:DexEntry => "These intelligent Pokémon touch horns with each other to share information between them.",
		:Ability => [PBAbilities::SYNCHRONIZE,PBAbilities::PSYCHICSURGE,PBAbilities::INNERFOCUS,
			PBAbilities::OWNTEMPO],
		:BaseStats => [70,55,65,85,95,105]
	}
},

###################### Regional Variants ######################

PBSpecies::CHARMANDER => {
	:FormName => {
		5 => "Rebornian"
	},

	:OnCreation => proc{
		mapWasteland=[209]
		randomnum = rand(4)
		if $game_map && mapWasteland.include?($game_map.map_id)
			next 5
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "This Pokémon has a mixture of thousands of deadly toxins and minerals inside its belly and tail. Due to its body's naturally high temperature, the venomous solution inside it glows bright, attracting bugs and other preys.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON,
		:BaseStats => [70,60,60,35,20,70],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[7,PBMoves::POISONSTING],[10,PBMoves::SMOKESCREEN],[10,PBMoves::TWINEEDLE],[16,PBMoves::JETINJECTOR],[19,PBMoves::FELLSTINGER],[25,PBMoves::FIREFANG],
			[28,PBMoves::POISONFANG],[28,PBMoves::NEEDLEARM],[34,PBMoves::POISONJAB],[37,PBMoves::NEEDLEDRAIN],[43,PBMoves::CRUNCH],[46,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::FINALGAMBIT,PBMoves::FURYSWIPES,PBMoves::MEFIRST,PBMoves::SNATCH,PBMoves::UPROAR],
		:Weight => 370,
		:kind => "Venomous Lizard"
	}
},

PBSpecies::CHARMELEON => {
	:FormName => {
		5 => "Rebornian"
	},

	"Rebornian" => {
		:DexEntry => "After evolving, the venom inside its body becomes stronger, which is said to make this Pokémon more aggressive. This may explain Charmeleon's inclination for rebellious behavior.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::POISON,
		:BaseStats => [90,85,70,40,30,90],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[1,PBMoves::POISONSTING],[7,PBMoves::PINMISSILE],[10,PBMoves::SMOKESCREEN],[10,PBMoves::TWINEEDLE],[17,PBMoves::JETINJECTOR],[21,PBMoves::FELLSTINGER],[28,PBMoves::FIREFANG],
			[28,PBMoves::POISONFANG],[32,PBMoves::NEEDLEARM],[39,PBMoves::POISONJAB],[43,PBMoves::NEEDLEDRAIN],[50,PBMoves::CRUNCH],[54,PBMoves::FLAREBLITZ]],
		:Weight => 370,
		:kind => "Needle"
	}
},

PBSpecies::RATTATA => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Alolan" => {
		:DexEntry => "With its incisors, it gnaws through doors and infiltrates people's homes. Then, with a twitch of its whiskers, it steals whatever food it finds.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::NORMAL,
		:Weight => 38,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::HUSTLE,PBAbilities::THICKFAT],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[1,PBMoves::GROWL],
			[4,PBMoves::QUICKATTACK],[6,PBMoves::LEER],[8,PBMoves::FOCUSENERGY],
			[10,PBMoves::BITE],[12,PBMoves::SANDATTACK],[14,PBMoves::PURSUIT],
			[16,PBMoves::LASERFOCUS],[18,PBMoves::TAKEDOWN],[22,PBMoves::HYPERFANG],
			[24,PBMoves::ASSURANCE],[28,PBMoves::SUCKERPUNCH],[30,PBMoves::CRUNCH],
			[32,PBMoves::SUPERFANG],[34,PBMoves::DOUBLEEDGE],[42,PBMoves::REVERSAL],
			[44,PBMoves::ENDEAVOR],[46,PBMoves::HYPERBEAM]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::FINALGAMBIT,PBMoves::FURYSWIPES,PBMoves::ICEFANG,
				PBMoves::MEFIRST,PBMoves::POISONFANG,PBMoves::PSYCHICFANGS,PBMoves::REVENGE,PBMoves::REVERSAL,
				PBMoves::SNATCH,PBMoves::STOCKPILE,PBMoves::SWALLOW,PBMoves::SWITCHEROO,
				PBMoves::THUNDERFANG,PBMoves::UPROAR],
		:WildHoldItems => [0,PBItems::PECHABERRY,0],
		:GetEvo => [[PBSpecies::RATICATE,PBEvolution::LevelNight,20]]
	}
},

PBSpecies::RATICATE => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Alolan" => {
		:DexEntry => "It forms a group of Rattata, which it assumes command of. Each group has its own territory, and disputes over food happen often.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [75,71,70,77,40,80],
		:Weight => 255,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::HUSTLE,PBAbilities::THICKFAT],
		:Movelist => [[0,PBMoves::SCARYFACE],[1,PBMoves::SWORDSDANCE],[1,PBMoves::COUNTER],
			[1,PBMoves::FURYSWIPES],[1,PBMoves::SCARYFACE],[1,PBMoves::TACKLE],
			[1,PBMoves::TAILWHIP],[1,PBMoves::GROWL],[4,PBMoves::QUICKATTACK],
			[6,PBMoves::LEER],[8,PBMoves::FOCUSENERGY],[10,PBMoves::BITE],
			[12,PBMoves::SANDATTACK],[14,PBMoves::PURSUIT],[16,PBMoves::LASERFOCUS],
			[18,PBMoves::TAKEDOWN],[22,PBMoves::HYPERFANG],[24,PBMoves::ASSURANCE],
			[26,PBMoves::GLARE],[28,PBMoves::SUCKERPUNCH],[30,PBMoves::CRUNCH],
			[32,PBMoves::SUPERFANG],[34,PBMoves::DOUBLEEDGE],[36,PBMoves::LUNGE],
			[38,PBMoves::THRASH],[40,PBMoves::SLASH],[42,PBMoves::REVERSAL],
			[44,PBMoves::ENDEAVOR],[46,PBMoves::HYPERBEAM]],
		:WildHoldItems => [0,PBItems::PECHABERRY,0]
	}
},

##############################################
# Nuclear Altforms
##############################################

PBSpecies::NIDORANfE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NIDORINA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:GetEvo => [[PBSpecies::NIDOQUEEN,PBEvolution::Item,PBItems::MOONSTONE]]
	}
},

PBSpecies::NIDOQUEEN => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Mega" => {
		:BaseStats => [90,102,107,76,125,105],
		:Ability => PBAbilities::TOXICDEBRIS,
		:Weight => 840
	}
},

PBSpecies::NIDORANmA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NIDORINO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:GetEvo => [[PBSpecies::NIDOKING,PBEvolution::Item,PBItems::MOONSTONE]]
	}
},

PBSpecies::MAGIKARP => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ZUBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOLBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CROBAT => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VAPOREON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::JOLTEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLAREON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ESPEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LEAFEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SYLVEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EEVEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MANEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAWKEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ZIRCONEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TITANEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DREKEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KITSUNEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EPHEMEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TOXEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRISTLEON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MAREEP => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLAAFFY => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YANMA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YANMEGA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WYNAUT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WOBBUFFET => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNUBBULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRANBULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TEDDIURSA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::URSARING => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::URSALUNA => {
	:FormName => {
		1 => "Nuclear",
		2 => "Blood Moon"
},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Blood Moon" => {
		:DexEntry => "This special Ursaluna can see in the dark with its left eye and protects itself with mud that is as hard as iron.",
		:BaseStats => [113,70,120,52,135,65],
		:Ability => [PBAbilities::MINDSEYE],
		:Movelist => [[0,PBMoves::HARDEN],[1,PBMoves::SCARYFACE],[1,PBMoves::MOONLIGHT],[1,PBMoves::HARDEN],
			[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::LICK],[1,PBMoves::BABYDOLLEYES],
			[7,PBMoves::FAKETEARS],[10,PBMoves::FURYSWIPES],[13,PBMoves::SWEETSCENT],[15,PBMoves::TACKLE],
			[17,PBMoves::PAYBACK],[19,PBMoves::FLING],[22,PBMoves::COVET],[25,PBMoves::PLAYNICE],
			[27,PBMoves::BULLDOZE],[29,PBMoves::CHARM],[31,PBMoves::FEINTATTACK],[33,PBMoves::SLASH],
			[36,PBMoves::PLAYROUGH],[41,PBMoves::REST],[41,PBMoves::SNORE],[43,PBMoves::EARTHPOWER],
			[45,PBMoves::THRASH],[47,PBMoves::MOONBLAST],[49,PBMoves::HIGHHORSEPOWER],[51,PBMoves::DOUBLEEDGE],
			[54,PBMoves::HAMMERARM],[57,PBMoves::HEADLONGRUSH],[64,PBMoves::BLOODMOON]]
	}
},

PBSpecies::HOUNDOUR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SKARMORY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LARVITAR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PUPITAR => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNEASLER => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YAMASK => {
	:FormName => {
		1 => "Galar",
		2 => "Nuclear",
		3 => "NuclearGalar"
	},

	:OnCreation => proc{
		chancemaps=[198,281] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Galar" => {
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::WANDERINGSPIRIT],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::MEANLOOK],[4,PBMoves::DISABLE],[8,PBMoves::HAZE],
			[12,PBMoves::NIGHTSHADE],[16,PBMoves::CURSE],[20,PBMoves::SLAM],[24,PBMoves::CRAFTYSHIELD],
			[28,PBMoves::BRUTALSWING],[32,PBMoves::HEX],[36,PBMoves::POWERSPLIT],[36,PBMoves::GUARDSPLIT],
			[40,PBMoves::PROTECT],[44,PBMoves::SHADOWBALL],[48,PBMoves::EARTHQUAKE],[52,PBMoves::DESTINYBOND]],
		:EggMoves => [PBMoves::ALLYSWITCH,PBMoves::CRAFTYSHIELD,PBMoves::DISABLE,PBMoves::ENDURE,
			PBMoves::FAKETEARS,PBMoves::HEALBLOCK,PBMoves::IMPRISON,PBMoves::MEMENTO,PBMoves::NASTYPLOT,
			PBMoves::NIGHTMARE,PBMoves::STRENGTHSAP,PBMoves::TOXICSPIKES],
		:GetEvo => [[PBSpecies::RUNERIGUS,PBEvolution::LevelNight,34]]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"NuclearGalar" => {
		:Type2 => PBTypes::NUCLEAR,
		:Ability => [PBAbilities::WANDERINGSPIRIT],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::MEANLOOK],[4,PBMoves::DISABLE],[8,PBMoves::HAZE],
		[12,PBMoves::NIGHTSHADE],[16,PBMoves::CURSE],[20,PBMoves::SLAM],[24,PBMoves::CRAFTYSHIELD],
		[28,PBMoves::BRUTALSWING],[32,PBMoves::HEX],[36,PBMoves::POWERSPLIT],[36,PBMoves::GUARDSPLIT],
		[40,PBMoves::PROTECT],[44,PBMoves::SHADOWBALL],[48,PBMoves::EARTHQUAKE],[52,PBMoves::DESTINYBOND]],
	:EggMoves => [PBMoves::ALLYSWITCH,PBMoves::CRAFTYSHIELD,PBMoves::DISABLE,PBMoves::ENDURE,
		PBMoves::FAKETEARS,PBMoves::STRENGTHSAP,PBMoves::TOXICSPIKES],
		:GetEvo => [[PBSpecies::RUNERIGUS,PBEvolution::LevelNight,34]]
	}
},

PBSpecies::COFAGRIGUS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [58,115,85,85,125,115],
		:Ability => PBAbilities::WANDERINGSPIRIT
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::RUNERIGUS => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SURSKIT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MASQUERAIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NINCADA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NINJASK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHEDINJA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PROBOPASS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOSEPASS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ARON => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LAIRON => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SPOINK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRUMPIG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FEEBAS => {
	:FormName => {
		1 => "Nuclear",
		3 => "Delta"
	},

	:OnCreation => proc{
		mapDelta1=[758] # Map IDs for Delta form
		next $game_map && mapDelta1.include?($game_map.map_id) ? 3 : 0
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "Condemned to live in the darkest places of the abyss, it uses its orbs' psychic powers and its toxic spiked tail to defend itself.",
		:BaseStats => [26,16,31,76,11,46],
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::POISON,
		:Ability => [PBAbilities::POISONPOINT,PBAbilities::LIQUIDOOZE,PBAbilities::MAGICGUARD],
		:Movelist => [[1,PBMoves::SPLASH],[115,PBMoves::POISONSTING],[25,PBMoves::FLAIL]],
	}
},

PBSpecies::SEVIPER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLYGON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRAPINCH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VIBRAVA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SNORUNT => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HIPPOPOTAS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HIPPOWDON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRIFBLIM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRIFLOON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRONZOR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHINX => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LUXIO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LUXRAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::RAMPARDOS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CRANIDOS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BASTIODON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHIELDON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ROGGENROLA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOLDORE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GIGALITH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::THROH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SAWK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SCRAGGY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SOLOSIS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DUOSION => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRUBBISH => {
	:FormName => {
		2 => "Nuclear"
	},

	:OnCreation => proc{
		chancemaps=[214,215,216,217,219]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VANILLITE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VANILLISH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},


PBSpecies::VANILLUXE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MIENFOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MIENSHAO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EELEKTRIK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TYNAMO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EELEKTROSS => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLETCHLING => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLETCHINDER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TALONFLAME => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SKIDDO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOGOAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PYROAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LITLEO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SWIRLIX => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SLURPUFF => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::INKAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MALAMAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HELIOPTILE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HELIOLISK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ESPURR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MEOWSTIC => {
	:FormName => {1 => "Nuclear"},

	#Gender difference
	"Female" => {
		:Ability => [PBAbilities::KEENEYE,PBAbilities::INFILTRATOR,PBAbilities::COMPETITIVE,
			PBAbilities::PRANKSTER]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	#Gender difference
	"NuclearFemale" => {
		:Ability => [PBAbilities::KEENEYE,PBAbilities::INFILTRATOR,PBAbilities::COMPETITIVE,
		PBAbilities::PRANKSTER],
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAWLUCHA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CARBINK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KLEFKI => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOIVERN => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::NOIBAT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GRUBBIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHARJABUG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::VIKAVOLT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MORELULL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SHIINOTIC => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOUNSWEET => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::STEENEE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SALAZZLE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SALANDIT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KOMMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::JANGMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAKAMOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DHELMISE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DRAMPA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PYUKUMUKU => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WIMPOD => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOLISOPOD => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::PASSIMIAN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ORANGURU => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::COMFEY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ELDEGOSS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GOSSIFLEUR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WOOLOO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DUBWOOL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHEWTLE => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::YAMPER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BOLTUND => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SILICOBRA => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::ROLYCOLY => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CARKOL => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::IMPIDIMP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MORGREM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FALINKS => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CUFANT => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SIZZLIPEDE => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::GLIGAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::POISONSTING],[4,PBMoves::SANDATTACK],[7,PBMoves::HARDEN],[9,PBMoves::MUDSLAP],
		[12,PBMoves::QUICKATTACK],[16,PBMoves::FURYCUTTER],[19,PBMoves::FEINTATTACK],[21,PBMoves::POISONTAIL],
		[23,PBMoves::NUCLEARSLASH],[25,PBMoves::AERIALACE],[27,PBMoves::SCREECH],[29,PBMoves::HALFLIFE],
		[31,PBMoves::MUDBOMB],[34,PBMoves::ACROBATICS],[36,PBMoves::KNOCKOFF],[38,PBMoves::POISONJAB],
		[40,PBMoves::SLASH],[42,PBMoves::SWORDSDANCE],[44,PBMoves::UTURN],[46,PBMoves::CRABHAMMER],
		[49,PBMoves::SKYUPPERCUT],[55,PBMoves::XSCISSOR],[60,PBMoves::EARTHQUAKE],[65,PBMoves::GUILLOTINE]]
	}
},

PBSpecies::GLISCOR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::THUNDERFANG],[1,PBMoves::ICEFANG],[1,PBMoves::FIREFANG],
		[1,PBMoves::NIGHTSLASH],[1,PBMoves::PINMISSILE],[1,PBMoves::POISONSTING],[4,PBMoves::SANDATTACK],
		[7,PBMoves::HARDEN],[9,PBMoves::MUDSLAP],[12,PBMoves::QUICKATTACK],[16,PBMoves::FURYCUTTER],
		[19,PBMoves::FEINTATTACK],[21,PBMoves::POISONTAIL],[23,PBMoves::NUCLEARSLASH],[25,PBMoves::AERIALACE],
		[27,PBMoves::SCREECH],[29,PBMoves::HALFLIFE],[31,PBMoves::MUDBOMB],[34,PBMoves::ACROBATICS],
		[36,PBMoves::KNOCKOFF],[38,PBMoves::POISONJAB],[40,PBMoves::SLASH],[42,PBMoves::SWORDSDANCE],
		[44,PBMoves::UTURN],[46,PBMoves::CRABHAMMER],[49,PBMoves::SKYUPPERCUT],[52,PBMoves::EARTHPOWER],
		[55,PBMoves::XSCISSOR],[60,PBMoves::EARTHQUAKE],[65,PBMoves::GUILLOTINE]]
	}
},

PBSpecies::BUIZEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FLOATZEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHYINMUNK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::TACKLE],[6,PBMoves::CHARGE],[13,PBMoves::THUNDERSHOCK],
		[15,PBMoves::QUICKATTACK],[15,PBMoves::GAMMARAY],[20,PBMoves::DOUBLETEAM],[24,PBMoves::SPARK],
		[32,PBMoves::HYPERFANG],[34,PBMoves::ENDEAVOR],[39,PBMoves::SUPERFANG],[47,PBMoves::PROTONBEAM],
		[52,PBMoves::AGILITY]]
	}
},

PBSpecies::KINETMUNK => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::TACKLE],[6,PBMoves::CHARGE],[13,PBMoves::THUNDERSHOCK],
		[15,PBMoves::QUICKATTACK],[15,PBMoves::GAMMARAY],[20,PBMoves::DOUBLETEAM],[24,PBMoves::SPARK],
		[28,PBMoves::BITE],[32,PBMoves::HYPERFANG],[34,PBMoves::ENDEAVOR],[39,PBMoves::SUPERFANG],
		[44,PBMoves::DISCHARGE],[47,PBMoves::PROTONBEAM],[52,PBMoves::AGILITY]]
	}
},

PBSpecies::BIRBIE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::AVEDEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SPLENDIFOWL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TONEMY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::TACKLE],[9,PBMoves::SMOG],[16,PBMoves::LICK],
		[21,PBMoves::GASTROACID],[25,PBMoves::POISONFANG],[31,PBMoves::RADIOACID],[33,PBMoves::HAZE],
		[35,PBMoves::NUCLEARSLASH],[37,PBMoves::SPITUP],[37,PBMoves::STOCKPILE],[37,PBMoves::SWALLOW],
		[40,PBMoves::TOXIC],[42,PBMoves::HALFLIFE],[49,PBMoves::GUNKSHOT]]
	}
},

PBSpecies::TOFURANG => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::TACKLE],[9,PBMoves::SMOG],[16,PBMoves::LICK],
		[21,PBMoves::GASTROACID],[25,PBMoves::POISONFANG],[31,PBMoves::RADIOACID],[33,PBMoves::HAZE],
		[35,PBMoves::NUCLEARSLASH],[37,PBMoves::SPITUP],[37,PBMoves::STOCKPILE],[37,PBMoves::SWALLOW],
		[40,PBMoves::TOXIC],[42,PBMoves::HALFLIFE],[45,PBMoves::BODYSLAM],[49,PBMoves::GUNKSHOT]]
	}
},

PBSpecies::OWTEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::CHARM],[4,PBMoves::FORESIGHT],[8,PBMoves::QUICKATTACK],
		[13,PBMoves::CONFUSION],[15,PBMoves::GAMMARAY],[19,PBMoves::SING],[23,PBMoves::WINGATTACK],
		[26,PBMoves::OMINOUSWIND],[30,PBMoves::DOUBLETEAM],[32,PBMoves::NUCLEARWIND],[34,PBMoves::PSYCHUP],
		[38,PBMoves::AIRSLASH],[40,PBMoves::ZENHEADBUTT],[44,PBMoves::BRAVEBIRD],[46,PBMoves::PROTONBEAM],
		[50,PBMoves::SKYATTACK]]
	}
},

PBSpecies::ESHOUTEN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::BITE],[1,PBMoves::BITE],[1,PBMoves::PECK],[1,PBMoves::CHARM],
		[4,PBMoves::FORESIGHT],[8,PBMoves::QUICKATTACK],[13,PBMoves::CONFUSION],[15,PBMoves::GAMMARAY],
		[19,PBMoves::SING],[23,PBMoves::WINGATTACK],[26,PBMoves::OMINOUSWIND],[30,PBMoves::DOUBLETEAM],
		[32,PBMoves::NUCLEARWIND],[34,PBMoves::PSYCHUP],[38,PBMoves::AIRSLASH],[40,PBMoves::ZENHEADBUTT],
		[44,PBMoves::BRAVEBIRD],[46,PBMoves::PROTONBEAM],[50,PBMoves::SKYATTACK]]
	}
},

PBSpecies::BRAINOAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRAILIP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TANCOON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::SANDATTACK],[4,PBMoves::HOWL],[7,PBMoves::SUDDENSTRIKE],
		[9,PBMoves::ODORSLEUTH],[11,PBMoves::SNARL],[13,PBMoves::ROAR],[15,PBMoves::GAMMARAY],[17,PBMoves::BITE],
		[19,PBMoves::SCARYFACE],[21,PBMoves::SWAGGER],[23,PBMoves::TAKEDOWN],[25,PBMoves::TAUNT],
		[27,PBMoves::NUCLEARSLASH],[31,PBMoves::CRUNCH],[33,PBMoves::FACADE],[37,PBMoves::FOULPLAY]]
	}
},

PBSpecies::TANSCURE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::TAILSLAP],[1,PBMoves::TAILSLAP],[1,PBMoves::TACKLE],[1,PBMoves::SANDATTACK],
		[4,PBMoves::HOWL],[7,PBMoves::SUDDENSTRIKE],[9,PBMoves::ODORSLEUTH],[11,PBMoves::SNARL],
		[13,PBMoves::ROAR],[15,PBMoves::GAMMARAY],[17,PBMoves::BITE],[19,PBMoves::SCARYFACE],
		[21,PBMoves::SWAGGER],[23,PBMoves::TAKEDOWN],[25,PBMoves::TAUNT],[27,PBMoves::NUCLEARSLASH],
		[31,PBMoves::CRUNCH],[33,PBMoves::FACADE],[37,PBMoves::FOULPLAY],[41,PBMoves::HALFLIFE]]
	}
},

PBSpecies::PAHAR => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::PECK],[4,PBMoves::EMBER],[8,PBMoves::GROWL],[11,PBMoves::QUICKATTACK],
		[13,PBMoves::GAMMARAY],[15,PBMoves::INCINERATE],[18,PBMoves::AIRCUTTER],[22,PBMoves::FLAMEBURST],
		[25,PBMoves::SUNNYDAY],[27,PBMoves::NUCLEARWIND],[29,PBMoves::FEATHERDANCE],[32,PBMoves::MIRRORMOVE],
		[36,PBMoves::ROOST],[38,PBMoves::HALFLIFE],[39,PBMoves::AIRSLASH],[43,PBMoves::LAVAPLUME],
		[46,PBMoves::TAILWIND],[48,PBMoves::PROTONBEAM],[50,PBMoves::FLAMETHROWER],[53,PBMoves::BRAVEBIRD]]
	}
},

PBSpecies::PALIJ => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::PECK],[4,PBMoves::EMBER],[8,PBMoves::GROWL],[11,PBMoves::QUICKATTACK],
		[13,PBMoves::GAMMARAY],[15,PBMoves::INCINERATE],[18,PBMoves::AIRCUTTER],[22,PBMoves::FLAMEBURST],
		[25,PBMoves::SUNNYDAY],[27,PBMoves::NUCLEARWIND],[29,PBMoves::FEATHERDANCE],[32,PBMoves::MIRRORMOVE],
		[36,PBMoves::ROOST],[38,PBMoves::HALFLIFE],[39,PBMoves::AIRSLASH],[43,PBMoves::LAVAPLUME],
		[46,PBMoves::TAILWIND],[48,PBMoves::PROTONBEAM],[50,PBMoves::FLAMETHROWER],[53,PBMoves::BRAVEBIRD]]
	}
},

PBSpecies::PAJAY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::WILLOWISP],[1,PBMoves::WILLOWISP],[1,PBMoves::PECK],[4,PBMoves::EMBER],
		[8,PBMoves::GROWL],[11,PBMoves::QUICKATTACK],[13,PBMoves::GAMMARAY],[15,PBMoves::INCINERATE],
		[18,PBMoves::AIRCUTTER],[22,PBMoves::FLAMEBURST],[25,PBMoves::SUNNYDAY],[27,PBMoves::NUCLEARWIND],
		[29,PBMoves::FEATHERDANCE],[32,PBMoves::MIRRORMOVE],[36,PBMoves::ROOST],[38,PBMoves::HALFLIFE],
		[39,PBMoves::AIRSLASH],[43,PBMoves::LAVAPLUME],[46,PBMoves::TAILWIND],[48,PBMoves::PROTONBEAM],
		[50,PBMoves::FLAMETHROWER],[53,PBMoves::BRAVEBIRD],[55,PBMoves::FIERYDANCE]]
	}
},

PBSpecies::JERBOLTA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],[1,PBMoves::NUZZLE],[5,PBMoves::SANDATTACK],
		[9,PBMoves::QUICKATTACK],[13,PBMoves::CHARM],[15,PBMoves::SPARK],[17,PBMoves::ENDURE],
		[19,PBMoves::MAGNITUDE],[21,PBMoves::MUDSHOT],[23,PBMoves::THUNDERFANG],[25,PBMoves::ROLLOUT],
		[27,PBMoves::ELECTRIFY],[29,PBMoves::ELECTROBALL],[31,PBMoves::DIG],[33,PBMoves::HYPERFANG],
		[37,PBMoves::DISCHARGE],[41,PBMoves::EARTHPOWER],[43,PBMoves::VOLTSWITCH],[45,PBMoves::BOUNCE],
		[47,PBMoves::RADIOACID],[49,PBMoves::ELECTRICTERRAIN],[51,PBMoves::NUCLEARWASTE],[53,PBMoves::SUPERFANG],
		[55,PBMoves::PROTONBEAM],[57,PBMoves::SCORCHINGSANDS]]
	}
},

PBSpecies::BAASHAUN => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::LOWKICK],[1,PBMoves::LEER],[7,PBMoves::FOCUSENERGY],[13,PBMoves::STOMP],
		[15,PBMoves::BEATUP],[19,PBMoves::SCARYFACE],[21,PBMoves::NUCLEARSLASH],[25,PBMoves::REVENGE],
		[27,PBMoves::HALFLIFE],[31,PBMoves::FEINTATTACK],[35,PBMoves::SUBMISSION],[37,PBMoves::JUMPKICK],
		[43,PBMoves::CROSSCHOP],[47,PBMoves::FOULPLAY],[49,PBMoves::HIJUMPKICK]]
	}
},

PBSpecies::BAASCHAF => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::SEISMICTOSS],[1,PBMoves::SEISMICTOSS],[1,PBMoves::LOWKICK],[1,PBMoves::LEER],
		[7,PBMoves::FOCUSENERGY],[13,PBMoves::STOMP],[15,PBMoves::BEATUP],[19,PBMoves::SCARYFACE],
		[21,PBMoves::NUCLEARSLASH],[25,PBMoves::REVENGE],[27,PBMoves::HALFLIFE],[31,PBMoves::FEINTATTACK],
		[35,PBMoves::SUBMISSION],[37,PBMoves::JUMPKICK],[40,PBMoves::SHADOWBALL],[43,PBMoves::CROSSCHOP],
		[45,PBMoves::ATOMICPUNCH],[47,PBMoves::FOULPLAY],[49,PBMoves::HIJUMPKICK],[57,PBMoves::AXEKICK]]
	}
},

PBSpecies::COSTRAW => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::WRAP],[1,PBMoves::LEER],[8,PBMoves::ABSORB],[12,PBMoves::CONFUSION],
		[14,PBMoves::GAMMARAY],[16,PBMoves::ACID],[20,PBMoves::MEGADRAIN],[24,PBMoves::CONFUSERAY],
		[28,PBMoves::SLUDGE],[32,PBMoves::STOCKPILE],[34,PBMoves::SPITUP],[34,PBMoves::SWALLOW],
		[36,PBMoves::RADIOACID],[38,PBMoves::LEECHLIFE],[41,PBMoves::SLUDGEBOMB],[44,PBMoves::TOXIC],
		[47,PBMoves::PROTONBEAM],[49,PBMoves::PSYCHIC]]
	}
},

PBSpecies::TRAWPINT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::WRAP],[1,PBMoves::LEER],[8,PBMoves::ABSORB],[12,PBMoves::CONFUSION],
		[14,PBMoves::GAMMARAY],[16,PBMoves::ACID],[20,PBMoves::MEGADRAIN],[24,PBMoves::CONFUSERAY],
		[28,PBMoves::SLUDGE],[32,PBMoves::STOCKPILE],[34,PBMoves::SPITUP],[34,PBMoves::SWALLOW],
		[36,PBMoves::RADIOACID],[38,PBMoves::LEECHLIFE],[41,PBMoves::SLUDGEBOMB],[44,PBMoves::TOXIC],
		[47,PBMoves::PROTONBEAM],[49,PBMoves::PSYCHIC]]
	}
},

PBSpecies::TUBJAW => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[6,PBMoves::WATERGUN],[10,PBMoves::BITE],
		[14,PBMoves::AQUAJET],[18,PBMoves::TORMENT],[22,PBMoves::SCARYFACE],[26,PBMoves::ICEFANG],
		[31,PBMoves::SWAGGER],[33,PBMoves::HALFLIFE],[35,PBMoves::ASSURANCE],[38,PBMoves::THRASH],
		[40,PBMoves::NUCLEARSLASH],[42,PBMoves::AQUATAIL],[47,PBMoves::CRUNCH]]
	}
},

PBSpecies::TUBAREEL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[6,PBMoves::WATERGUN],[10,PBMoves::BITE],
		[14,PBMoves::AQUAJET],[18,PBMoves::TORMENT],[22,PBMoves::SCARYFACE],[26,PBMoves::ICEFANG],
		[31,PBMoves::SWAGGER],[33,PBMoves::HALFLIFE],[35,PBMoves::ASSURANCE],[38,PBMoves::THRASH],
		[40,PBMoves::NUCLEARSLASH],[42,PBMoves::AQUATAIL],[47,PBMoves::CRUNCH]]
	}
},

PBSpecies::NUPIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],[7,PBMoves::GROWTH],[11,PBMoves::MEGADRAIN],
		[17,PBMoves::SYNTHESIS],[21,PBMoves::SHOCKWAVE],[27,PBMoves::SUNNYDAY],[31,PBMoves::GIGADRAIN],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::RECOVER],[43,PBMoves::ENERGYBALL],[45,PBMoves::RADIOACID],
		[50,PBMoves::ACIDARMOR],[52,PBMoves::NUCLEARWASTE],[57,PBMoves::SOLARBEAM]]
	}
},

PBSpecies::GELLIN => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::MAGNETRISE],[1,PBMoves::MAGNETRISE],[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],
		[7,PBMoves::GROWTH],[11,PBMoves::MEGADRAIN],[17,PBMoves::SYNTHESIS],[21,PBMoves::SHOCKWAVE],
		[27,PBMoves::SUNNYDAY],[31,PBMoves::GIGADRAIN],[37,PBMoves::THUNDERBOLT],[41,PBMoves::RECOVER],
		[43,PBMoves::ENERGYBALL],[45,PBMoves::RADIOACID],[47,PBMoves::ACUPRESSURE],[50,PBMoves::ACIDARMOR],
		[52,PBMoves::NUCLEARWASTE],[57,PBMoves::SOLARBEAM]]
	}
},

PBSpecies::BARAND => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::PECK],[6,PBMoves::SANDATTACK],[11,PBMoves::LEER],[16,PBMoves::BITE],
		[21,PBMoves::FORCEPALM],[23,PBMoves::NUCLEARSLASH],[26,PBMoves::TAKEDOWN],[28,PBMoves::HALFLIFE],
		[31,PBMoves::DRAGONCLAW],[36,PBMoves::CRUSHCLAW],[41,PBMoves::DRAGONDANCE],[46,PBMoves::SLASH],
		[48,PBMoves::ATOMICPUNCH],[51,PBMoves::DRAGONRUSH],[56,PBMoves::CRUSHGRIP]]
	}
},

PBSpecies::PARAUDIO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[8,PBMoves::ROAR],[13,PBMoves::CONFUSION],
		[16,PBMoves::SNARL],[20,PBMoves::SUPERSONIC],[24,PBMoves::PSYBEAM],[28,PBMoves::ROUND],
		[32,PBMoves::ZENHEADBUTT],[36,PBMoves::PSYSHOCK],[38,PBMoves::UPROAR],[41,PBMoves::NASTYPLOT],
		[44,PBMoves::PSYCHIC],[48,PBMoves::RADIOACID],[50,PBMoves::HYPERVOICE],[52,PBMoves::NUCLEARWASTE],
		[60,PBMoves::BOOMBURST]]
	}
},

PBSpecies::PARABOOM => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[8,PBMoves::ROAR],[13,PBMoves::CONFUSION],
		[16,PBMoves::SNARL],[20,PBMoves::SUPERSONIC],[24,PBMoves::PSYBEAM],[28,PBMoves::ROUND],
		[32,PBMoves::ZENHEADBUTT],[36,PBMoves::PSYSHOCK],[38,PBMoves::UPROAR],[41,PBMoves::NASTYPLOT],
		[44,PBMoves::PSYCHIC],[48,PBMoves::RADIOACID],[50,PBMoves::HYPERVOICE],[52,PBMoves::NUCLEARWASTE],
		[60,PBMoves::BOOMBURST]]
	}
},

PBSpecies::FLAGER => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHIMICAL => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHIMACONDA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::UNYMPH => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HARPTERA => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TRACTON => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TITANICE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::FRYNAI => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SAIDINE => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::DAIKATUNA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CHUPACHO => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::ABSORB],[1,PBMoves::SCARYFACE],[6,PBMoves::POISONSTING],[8,PBMoves::BITE],
		[11,PBMoves::FEINT],[17,PBMoves::PURSUIT],[21,PBMoves::SCREECH],[24,PBMoves::POISONFANG],
		[29,PBMoves::TWINEEDLE],[33,PBMoves::TOXICSPIKES],[35,PBMoves::KNOCKOFF],[37,PBMoves::NUCLEARSLASH],
		[41,PBMoves::AGILITY],[43,PBMoves::HALFLIFE],[45,PBMoves::CROSSPOISON],[51,PBMoves::TOXIC],
		[53,PBMoves::LEECHLIFE]]
	}
},

PBSpecies::LUCHABRA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::BEATUP],[1,PBMoves::LOWSWEEP],[1,PBMoves::BEATUP],[1,PBMoves::LOWSWEEP],
		[1,PBMoves::ABSORB],[1,PBMoves::SCARYFACE],[6,PBMoves::POISONSTING],[8,PBMoves::BITE],
		[11,PBMoves::FEINT],[17,PBMoves::PURSUIT],[21,PBMoves::SCREECH],[24,PBMoves::POISONFANG],
		[29,PBMoves::TWINEEDLE],[33,PBMoves::TOXICSPIKES],[35,PBMoves::KNOCKOFF],[37,PBMoves::NUCLEARSLASH],
		[39,PBMoves::MATBLOCK],[41,PBMoves::AGILITY],[42,PBMoves::BULKUP],[43,PBMoves::HALFLIFE],
		[45,PBMoves::CROSSPOISON],[47,PBMoves::CLOSECOMBAT],[49,PBMoves::SEISMICTOSS],[51,PBMoves::TOXIC],
		[53,PBMoves::LEECHLIFE],[55,PBMoves::POISONJAB],[57,PBMoves::ATOMICPUNCH],[59,PBMoves::DYNAMICPUNCH],
		[61,PBMoves::CROSSCHOP]]
	}
},

PBSpecies::SHRIMPUTY => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::KRILVOLVER => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LAVENT => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::HAGOOP => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::MUDSPORT],[1,PBMoves::ASTONISH],[1,PBMoves::MUDSLAP],[7,PBMoves::THUNDERSHOCK],
		[10,PBMoves::SLUDGE],[14,PBMoves::CAMOUFLAGE],[18,PBMoves::IONDELUGE],[22,PBMoves::MUDSHOT],
		[26,PBMoves::PARABOLICCHARGE],[30,PBMoves::BODYSLAM],[34,PBMoves::TOXIC],[36,PBMoves::SLUDGEBOMB],
		[38,PBMoves::ACIDARMOR],[39,PBMoves::NUCLEARWASTE],[40,PBMoves::RECOVER],[42,PBMoves::DISCHARGE],
		[44,PBMoves::MUDDYWATER],[45,PBMoves::RADIOACID],[46,PBMoves::SLUDGEWAVE],[48,PBMoves::THUNDERBOLT],
		[50,PBMoves::SUCKERPUNCH],[52,PBMoves::COIL],[53,PBMoves::PROTONBEAM],[56,PBMoves::THUNDER],
		[60,PBMoves::ZAPCANNON]]
	}
},

PBSpecies::HAAGROSS => {
	:FormName => {1 => "Nuclear"},

	:OnCreation => proc{
		nukemaps=[914]
		next $game_map && nukemaps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::ELECTRICTERRAIN],[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::MUDSPORT],
		[1,PBMoves::ASTONISH],[1,PBMoves::MUDSLAP],[7,PBMoves::THUNDERSHOCK],[10,PBMoves::SLUDGE],
		[14,PBMoves::CAMOUFLAGE],[18,PBMoves::IONDELUGE],[22,PBMoves::MUDSHOT],[26,PBMoves::PARABOLICCHARGE],
		[30,PBMoves::BODYSLAM],[34,PBMoves::TOXIC],[36,PBMoves::SLUDGEBOMB],[38,PBMoves::ACIDARMOR],
		[39,PBMoves::NUCLEARWASTE],[40,PBMoves::RECOVER],[42,PBMoves::DISCHARGE],[44,PBMoves::MUDDYWATER],
		[45,PBMoves::RADIOACID],[46,PBMoves::SLUDGEWAVE],[48,PBMoves::THUNDERBOLT],[50,PBMoves::SUCKERPUNCH],
		[52,PBMoves::COIL],[54,PBMoves::WILDCHARGE],[53,PBMoves::PROTONBEAM],[56,PBMoves::THUNDER],
		[60,PBMoves::ZAPCANNON]]
	}
},

PBSpecies::GARLIKID => {
	:FormName => {
		1 => "Nuclear",
		2 => "Saitama"
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Saitama" => { #* This is for a special boss fight
		:Ability => PBAbilities::PLOTARMOR
	}
},

PBSpecies::KOMALA => {
	:FormName => {1 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

#############################################################
# Nuclear Altforms End
#############################################################

PBSpecies::RAICHU => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		chancemaps=[834]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Alolan" => {
		:DexEntry => "It uses psychokinesis to control electricity. It hops aboard its own tail, using psychic power to lift the tail and move about while riding it.",
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [60,85,50,120,95,85],
		:Height => 7,
		:Weight => 210,
		:Ability => [PBAbilities::SURGESURFER,PBAbilities::SURGESURFER,PBAbilities::SURGESURFER,PBAbilities::INSTINCT],
		:Movelist => [[0,PBMoves::PSYCHIC],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
			[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::SPEEDSWAP],[1,PBMoves::FAKEOUT],
			[1,PBMoves::ENCORE],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
			[1,PBMoves::HEARTSTAMP],[1,PBMoves::PSYCHIC],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],
			[1,PBMoves::TACKLE],[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],
			[1,PBMoves::TAILWHIP],[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],
			[3,PBMoves::PLAYNICE],[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],
			[9,PBMoves::DOUBLEKICK],[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],
			[21,PBMoves::SWIFT],[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],
			[29,PBMoves::FEINT],[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
			[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN],
			[101,PBMoves::ZIPPYZAP],[101,PBMoves::FLOATYFALL],[101,PBMoves::SPLISHYSPLASH],
			[101,PBMoves::PIKAPAPOW]]
	}
},

PBSpecies::SANDSHREW => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[364, 366, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 390, 396, 430, 433, 434, 440, 441, 442] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "It lives on snowy mountains. Its steel shell is very hard—so much so, it can't roll its body up into a ball.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [50,75,90,40,10,35],
		:Height => 6,
		:Weight => 400,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SLUSHRUSH],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::DEFENSECURL],[3,PBMoves::BIDE],
			[5,PBMoves::POWDERSNOW],[7,PBMoves::ICEBALL],[9,PBMoves::RAPIDSPIN],
			[11,PBMoves::MIST],[13,PBMoves::FURYCUTTER],[15,PBMoves::METALCLAW],[17,PBMoves::SWIFT],
			[19,PBMoves::ROLLOUT],[21,PBMoves::FURYSWIPES],[23,PBMoves::IRONDEFENSE],[26,PBMoves::SLASH],
			[28,PBMoves::ICESHARD],[30,PBMoves::IRONHEAD],[32,PBMoves::MIRRORCOAT],[34,PBMoves::GYROBALL],
			[36,PBMoves::ICEPUNCH],[38,PBMoves::SWORDSDANCE],[42,PBMoves::HAIL],[45,PBMoves::SNOWSCAPE],
			[48,PBMoves::BLIZZARD]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::CHIPAWAY,PBMoves::COUNTER,PBMoves::CRUSHCLAW,
				PBMoves::CURSE,PBMoves::ENDURE,PBMoves::FLAIL,PBMoves::HONECLAWS,
				PBMoves::ICICLECRASH,PBMoves::ICICLESPEAR,PBMoves::METALCLAW,PBMoves::NIGHTSLASH,
				PBMoves::POISONSTING,PBMoves::SANDATTACK],
		:WildHoldItems => [0,PBItems::PECHABERRY,0],
		:GetEvo => [[PBSpecies::SANDSLASH,PBEvolution::Item,PBItems::ICESTONE]]
	}
},

PBSpecies::SANDSLASH => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega"
	},

	:OnCreation => proc{
		maps=[364, 366, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 390, 396, 430, 433, 434, 440, 441, 442, 749, 750, 834, 882] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "This Pokémon's steel spikes are sheathed in ice. Stabs from these spikes cause deep wounds and severe frostbite as well.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [75,100,120,65,25,65],
		:Height => 12,
		:Weight => 550,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SLUSHRUSH],
		:Movelist => [[0,PBMoves::ICICLESPEAR],[1,PBMoves::SPIKYSHIELD],[1,PBMoves::ICICLECRASH],
			[1,PBMoves::METALBURST],[1,PBMoves::COUNTER],[1,PBMoves::ICICLESPEAR],[1,PBMoves::SCRATCH],
			[1,PBMoves::DEFENSECURL],[3,PBMoves::BIDE],[5,PBMoves::POWDERSNOW],[7,PBMoves::ICEBALL],
			[9,PBMoves::RAPIDSPIN],[11,PBMoves::MIST],[13,PBMoves::FURYCUTTER],[15,PBMoves::METALCLAW],
			[17,PBMoves::SWIFT],[19,PBMoves::ROLLOUT],[21,PBMoves::FURYSWIPES],[23,PBMoves::IRONDEFENSE],
			[26,PBMoves::SLASH],[28,PBMoves::ICESHARD],[30,PBMoves::IRONHEAD],[32,PBMoves::MIRRORCOAT],
			[34,PBMoves::GYROBALL],[36,PBMoves::ICEPUNCH],[38,PBMoves::SWORDSDANCE],[42,PBMoves::HAIL],
			[45,PBMoves::SNOWSCAPE],[48,PBMoves::BLIZZARD]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::CHIPAWAY,PBMoves::COUNTER,PBMoves::CRUSHCLAW,
				PBMoves::CURSE, PBMoves::ENDURE,PBMoves::FLAIL,PBMoves::HONECLAWS,
				PBMoves::ICICLECRASH,PBMoves::ICICLESPEAR,PBMoves::METALCLAW,PBMoves::NIGHTSLASH,
				PBMoves::POISONSTING,PBMoves::SANDATTACK],
		:WildHoldItems => [0,PBItems::PECHABERRY,0]
	},

	"Mega" => {
		:BaseStats => [75,130,130,95,45,75],
		:Ability => [PBAbilities::TOUGHCLAWS],
	}
},

PBSpecies::VULPIX => {
	:FormName => {
		1 => "Alolan",
		2 => "Nuclear"
	},

	:OnCreation => proc{
		maps=[439,721,723,725,726,727,729,794] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "In hot weather, this Pokémon makes ice shards with its six tails and sprays them around to cool itself off.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::ICE,
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SNOWWARNING],
		:Movelist => [[1,PBMoves::POWDERSNOW],[1,PBMoves::TAILWHIP],[1,PBMoves::DISABLE],[1,PBMoves::TACKLE],
			[3,PBMoves::ROAR],[5,PBMoves::MIST],[7,PBMoves::QUICKATTACK],[9,PBMoves::BABYDOLLEYES],
			[12,PBMoves::ICESHARD],[14,PBMoves::CONFUSERAY],[15,PBMoves::ICYWIND],[17,PBMoves::PAYBACK],
			[19,PBMoves::SPITE],[21,PBMoves::DRAININGKISS],[23,PBMoves::CAPTIVATE],[25,PBMoves::FEINTATTACK],
			[27,PBMoves::HEX],[29,PBMoves::ICEFANG],[31,PBMoves::AURORABEAM],[33,PBMoves::EXTRASENSORY],
			[35,PBMoves::SAFEGUARD],[37,PBMoves::ICEBEAM],[39,PBMoves::IMPRISON],[41,PBMoves::AURORAVEIL],
			[43,PBMoves::FREEZEDRY],[45,PBMoves::GRUDGE],[47,PBMoves::NASTYPLOT],[49,PBMoves::BLIZZARD],
			[51,PBMoves::SHEERCOLD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::CHARM,PBMoves::DISABLE,PBMoves::EMBER,
				PBMoves::ENCORE,PBMoves::ENERGYBALL,PBMoves::EXTRASENSORY,PBMoves::FIREBLAST,
				PBMoves::FIRESPIN,PBMoves::FLAIL,PBMoves::FLAMETHROWER,PBMoves::FREEZEDRY,
				PBMoves::HOWL,PBMoves::HYPNOSIS,PBMoves::MOONBLAST,PBMoves::POWERSWAP,
				PBMoves::SPITE,PBMoves::SECRETPOWER,PBMoves::TAILSLAP,PBMoves::WILLOWISP],
		:WildHoldItems => [0,PBItems::SNOWBALL,0],
		:GetEvo => [[PBSpecies::NINETALES,PBEvolution::Item,PBItems::ICESTONE]]
	}
},

PBSpecies::NINETALES => {
	:FormName => {
		1 => "Alolan",
		2 => "Nuclear",
		3 => "Mega"
	},

	:OnCreation => proc{
		maps=[439,721,723,725,726,727,729,794,857,859] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Mega" => {
		:BaseStats => [73,86,75,110,131,130],
		:Ability => PBAbilities::TRACE,
		:Type2 => PBTypes::GHOST
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "Possessing a calm demeanor, this Pokémon was revered as a deity incarnate before it was identified as a regional variant of Ninetales.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [73,67,75,109,81,100],
		:EVs => [0,0,0,2,0,0],
		:Ability => [PBAbilities::SNOWCLOAK,PBAbilities::SNOWWARNING],
		:Movelist => [[0,PBMoves::DAZZLINGGLEAM],[1,PBMoves::DAZZLINGGLEAM],[1,PBMoves::HYPNOSIS],
			[1,PBMoves::POWDERSNOW],[1,PBMoves::TAILWHIP],[1,PBMoves::DISABLE],[1,PBMoves::TACKLE],
			[3,PBMoves::ROAR],[5,PBMoves::MIST],[7,PBMoves::QUICKATTACK],[9,PBMoves::BABYDOLLEYES],
			[12,PBMoves::ICESHARD],[14,PBMoves::CONFUSERAY],[15,PBMoves::ICYWIND],[17,PBMoves::PAYBACK],
			[19,PBMoves::SPITE],[21,PBMoves::DRAININGKISS],[23,PBMoves::CAPTIVATE],[25,PBMoves::FEINTATTACK],
			[27,PBMoves::HEX],[29,PBMoves::ICEFANG],[31,PBMoves::AURORABEAM],[33,PBMoves::EXTRASENSORY],
			[35,PBMoves::SAFEGUARD],[37,PBMoves::ICEBEAM],[39,PBMoves::IMPRISON],[41,PBMoves::AURORAVEIL],
			[43,PBMoves::FREEZEDRY],[45,PBMoves::GRUDGE],[47,PBMoves::NASTYPLOT],[49,PBMoves::BLIZZARD],
			[51,PBMoves::SHEERCOLD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::CHARM,PBMoves::DISABLE,PBMoves::EMBER,
		PBMoves::ENCORE,PBMoves::ENERGYBALL,PBMoves::EXTRASENSORY,PBMoves::FIREBLAST,
		PBMoves::FIRESPIN,PBMoves::FLAIL,PBMoves::FLAMETHROWER,PBMoves::FREEZEDRY,PBMoves::HOWL,
		PBMoves::HYPNOSIS,PBMoves::MOONBLAST,PBMoves::POWERSWAP,PBMoves::SPITE,PBMoves::SECRETPOWER,
		PBMoves::TAILSLAP,PBMoves::WILLOWISP],
		:WildHoldItems => [0,PBItems::SNOWBALL,0]
	}
},

PBSpecies::DIGLETT => {
	:FormName => {
		1 => "Alolan"
	},

	:OnCreation => proc{
		aMaps=[33, 34, 35, 199, 201, 202, 203, 204]
		# Map IDs for Alolan
		if $game_map && aMaps.include?($game_map.map_id)
			next 1
		else
			next 0
		end
 	},

	"Alolan" => {
		:DexEntry => "Its head sports an altered form of whiskers made of metal. When in communication with its comrades, its whiskers wobble to and fro.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [10,55,30,90,35,40],
		:Ability => [PBAbilities::SANDVEIL,PBAbilities::TANGLINGHAIR,PBAbilities::SANDFORCE],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],[4,PBMoves::GROWL],
			[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],[18,PBMoves::BULLDOZE],
			[20,PBMoves::FURYSWIPES],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],[28,PBMoves::EARTHPOWER],
			[31,PBMoves::DIG],[33,PBMoves::AGILITY],[35,PBMoves::IRONHEAD],[37,PBMoves::SLASH],
			[39,PBMoves::EARTHQUAKE],[41,PBMoves::SANDSTORM],[43,PBMoves::FISSURE]],
		:EggMoves => [PBMoves::ANCIENTPOWER,PBMoves::BEATUP,PBMoves::ENDURE,PBMoves::FEINTATTACK,
				PBMoves::FINALGAMBIT,PBMoves::REVERSAL,PBMoves::FLASH,PBMoves::HEADBUTT,PBMoves::MEMENTO,
				PBMoves::METALSOUND,PBMoves::HONECLAWS,PBMoves::PURSUIT,PBMoves::THRASH],
		:Weight => 10
	},
},

PBSpecies::DUGTRIO => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega"
	},

	:OnCreation => proc{
		maps=[33, 34, 35, 199, 201, 202, 203, 204] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
 	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "Its shining gold hair provides it with protection. It's reputed that keeping any of its fallen hairs will bring bad luck.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [35,100,60,110,50,70],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::SANDVEIL,PBAbilities::TANGLINGHAIR,PBAbilities::SANDFORCE],
		:Movelist => [[0,PBMoves::SANDTOMB],[0,PBMoves::TRIATTACK],[1,PBMoves::MAKEITRAIN],
			[1,PBMoves::ROTOTILLER],[1,PBMoves::NIGHTSLASH],[1,PBMoves::SCREECH],[1,PBMoves::TRIATTACK],
			[1,PBMoves::SANDTOMB],[1,PBMoves::SCRATCH],[1,PBMoves::SANDATTACK],[1,PBMoves::METALCLAW],
			[4,PBMoves::GROWL],[7,PBMoves::ASTONISH],[10,PBMoves::MUDSLAP],[14,PBMoves::MAGNITUDE],
			[18,PBMoves::BULLDOZE],[20,PBMoves::FURYSWIPES],[22,PBMoves::SUCKERPUNCH],[25,PBMoves::MUDBOMB],
			[28,PBMoves::EARTHPOWER],[31,PBMoves::DIG],[33,PBMoves::AGILITY],[35,PBMoves::IRONHEAD],
			[37,PBMoves::SLASH],[39,PBMoves::EARTHQUAKE],[41,PBMoves::SANDSTORM],[43,PBMoves::FISSURE]],
		:Weight => 666
	},

	"Mega" => {
		:BaseStats => [85,120,75,135,60,70],
		:Ability => [PBAbilities::MOLDBREAKER],
	},
},

PBSpecies::MEOWTH => {
	:FormName => {
		1 => "Alolan",
		2 => "Galarian",
		3 => "Dyna"
	},

	:OnCreation => proc{
		aMaps=[170, 524]
		gMaps=[412,439]
		# Map IDs for Alolan and Galarian forms respectively
		if $game_map && aMaps.include?($game_map.map_id)
			next 1
		elsif $game_map && gMaps.include?($game_map.map_id)
			next 2
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Alolan" => {
		:DexEntry => "When its delicate pride is wounded, or when the gold coin on its forehead is dirtied, it flies into a hysterical rage.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [40,35,35,90,50,40],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::PICKUP,PBAbilities::TECHNICIAN,PBAbilities::RATTLED,PBAbilities::BONANZA,PBAbilities::FORTUNE,PBAbilities::MOUNTAINEER],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[6,PBMoves::BITE],
			[9,PBMoves::FAKEOUT],[14,PBMoves::FURYSWIPES],[17,PBMoves::SCREECH],
			[22,PBMoves::FEINTATTACK],[25,PBMoves::TAUNT],[30,PBMoves::PAYDAY],
			[33,PBMoves::FEINT],[38,PBMoves::CAPTIVATE],[41,PBMoves::ASSURANCE],
			[46,PBMoves::SLASH],[48,PBMoves::NASTYPLOT],[50,PBMoves::NIGHTSLASH],
			[53,PBMoves::DARKPULSE],[55,PBMoves::PLAYROUGH]],
		:EggMoves => [PBMoves::AMNESIA,PBMoves::ASSIST,PBMoves::CHARM,PBMoves::COVET,PBMoves::DESTINYBOND,
			PBMoves::FLAIL,PBMoves::FLATTER,PBMoves::FOULPLAY,PBMoves::HYPNOSIS,PBMoves::MAKEITRAIN,
			PBMoves::PARTINGSHOT,PBMoves::PUNISHMENT,PBMoves::SNATCH,PBMoves::SPITE],
		:GetEvo => [[PBSpecies::PERSIAN,PBEvolution::Happiness,0]]
	},

	"Galarian" => {
		:DexEntry => "These daring Pokémon have coins on their foreheads. Darker coins are harder, and harder coins garner more respect among Meowth.",
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [40,35,35,90,50,40],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::PICKUP,PBAbilities::TOUGHCLAWS,PBAbilities::UNNERVE,PBAbilities::BONANZA,PBAbilities::FORTUNE,PBAbilities::MOUNTAINEER],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[4,PBMoves::FAKEOUT],[8,PBMoves::HONECLAWS],
			[12,PBMoves::FURYSWIPES],[16,PBMoves::METALCLAW],[20,PBMoves::SCREECH],[24,PBMoves::TAUNT],
			[29,PBMoves::PAYDAY],[32,PBMoves::SWAGGER],[36,PBMoves::METALSOUND],[40,PBMoves::SLASH],
			[44,PBMoves::THRASH]],
		:EggMoves => [PBMoves::COVET,PBMoves::FEINT,PBMoves::FLAIL,PBMoves::SPITE,PBMoves::DOUBLEEDGE,
			PBMoves::CURSE,PBMoves::KNOCKOFF,PBMoves::NIGHTSLASH],
		:GetEvo => [[PBSpecies::PERRSERKER,PBEvolution::Level,28]]
	},

	"Dyna" => {
		:BaseStats => [80,55,50,115,40,50],
		:Ability => PBAbilities::HUGEPOWER
	}
},

PBSpecies::PERSIAN => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[170, 524, 866] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "It looks down on everyone other than itself. Its preferred tactics are sucker punches and blindside attacks.",
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::DARK,
		:BaseStats => [65,60,60,115,75,65],
		:EVs => [0,2,0,0,0,0],
		:Ability => [PBAbilities::FURCOAT,PBAbilities::TECHNICIAN,PBAbilities::RATTLED,PBAbilities::HIGHRISE,PBAbilities::MOUNTAINEER],
		:Movelist => [[0,PBMoves::SWIFT],[0,PBMoves::POWERGEM],[1,PBMoves::QUASH],[1,PBMoves::AMNESIA],
			[1,PBMoves::HYPNOSIS],[1,PBMoves::SWITCHEROO],[1,PBMoves::POWERGEM],[1,PBMoves::SWIFT],
			[1,PBMoves::SCRATCH],[1,PBMoves::GROWL],[6,PBMoves::BITE],[9,PBMoves::FAKEOUT],
			[14,PBMoves::FURYSWIPES],[17,PBMoves::SCREECH],[22,PBMoves::FEINTATTACK],[25,PBMoves::TAUNT],
			[30,PBMoves::PAYDAY],[33,PBMoves::FEINT],[38,PBMoves::CAPTIVATE],[41,PBMoves::ASSURANCE],
			[46,PBMoves::SLASH],[48,PBMoves::NASTYPLOT],[50,PBMoves::NIGHTSLASH],[53,PBMoves::DARKPULSE],
			[55,PBMoves::PLAYROUGH]],
		:GetEvo => [],
		:Height => 11,
		:Weight => 330
	}
},

PBSpecies::GEODUDE => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "If you accidentally step on a Geodude sleeping on the ground, you'll hear a crunching sound and feel a shock ripple through your entire body.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],[2,PBMoves::THUNDERSHOCK],
			[4,PBMoves::CHARGE],[6,PBMoves::ROCKPOLISH],[8,PBMoves::BIDE],[10,PBMoves::ROLLOUT],
			[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],
			[22,PBMoves::THUNDERPUNCH],[24,PBMoves::SELFDESTRUCT],[28,PBMoves::STEALTHROCK],
			[30,PBMoves::ROCKBLAST],[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],[38,PBMoves::ROCKSLIDE],
			[40,PBMoves::DOUBLEEDGE],[42,PBMoves::STONEEDGE]],
		:EggMoves => [PBMoves::AUTOTOMIZE,PBMoves::BLOCK,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::ENDURE,
			PBMoves::FLAIL,PBMoves::MAGNETRISE,PBMoves::ROCKCLIMB,PBMoves::SANDATTACK,PBMoves::SCREECH,
			PBMoves::WIDEGUARD,PBMoves::ZAPCANNON],
		:Weight => 203,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GRAVELER => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "They eat rocks and often get into a scrap over them. The shock of Graveler smashing together causes a flash of light and a booming noise.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::DEFENSECURL],[2,PBMoves::THUNDERSHOCK],
			[4,PBMoves::CHARGE],[6,PBMoves::ROCKPOLISH],[8,PBMoves::BIDE],[10,PBMoves::ROLLOUT],
			[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],
			[22,PBMoves::THUNDERPUNCH],[24,PBMoves::SELFDESTRUCT],[28,PBMoves::STEALTHROCK],
			[30,PBMoves::ROCKBLAST],[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],[38,PBMoves::ROCKSLIDE],
			[40,PBMoves::DOUBLEEDGE],[42,PBMoves::STONEEDGE]],
		:Weight => 1100,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GOLEM => {
	:FormName => {1 => "Alolan"},

	:OnCreation => proc{
		maps=[231, 247, 251, 258, 259, 260, 261, 262, 263, 264, 340, 341, 342, 343, 344, 346, 347, 348, 349, 371, 614, 615, 616, 618, 847] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "Because it can't fire boulders at a rapid pace, it's been known to seize nearby Geodude and fire them from its back.",
		:Type2 => PBTypes::ELECTRIC,
		:Ability => [PBAbilities::MAGNETPULL,PBAbilities::STURDY,PBAbilities::GALVANIZE],
		:Movelist => [[1,PBMoves::MEGAPUNCH],[1,PBMoves::STEAMROLLER],[1,PBMoves::TACKLE],
			[1,PBMoves::DEFENSECURL],[2,PBMoves::THUNDERSHOCK],[4,PBMoves::CHARGE],[6,PBMoves::ROCKPOLISH],
			[8,PBMoves::BIDE],[10,PBMoves::ROLLOUT],[12,PBMoves::SPARK],[14,PBMoves::TAKEDOWN],
			[16,PBMoves::ROCKTHROW],[18,PBMoves::SMACKDOWN],[22,PBMoves::THUNDERPUNCH],
			[24,PBMoves::SELFDESTRUCT],[28,PBMoves::STEALTHROCK],[30,PBMoves::ROCKBLAST],
			[34,PBMoves::DISCHARGE],[36,PBMoves::EXPLOSION],[38,PBMoves::ROCKSLIDE],[40,PBMoves::DOUBLEEDGE],
			[42,PBMoves::STONEEDGE],[44,PBMoves::HEAVYSLAM],[50,PBMoves::DOUBLESHOCK]],
		:Height => 17,
		:Weight => 3160,
		:WildHoldItems => [0,PBItems::CELLBATTERY,0]
	}
},

PBSpecies::GRIMER => {
	:FormName => {
		1 => "Alolan",
		3 => "Nuclear"
	},

	:OnCreation => proc{
		maps=[467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Alolan" => {
		:DexEntry => "The crystals on Grimer's body are lumps of toxins. If one falls off, lethal poisons leak out.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::GLUTTONY,PBAbilities::POWEROFALCHEMY],
		:Movelist => [[1,PBMoves::POUND],[1,PBMoves::POISONGAS],[4,PBMoves::HARDEN],[7,PBMoves::BITE],
			[12,PBMoves::DISABLE],[15,PBMoves::ACIDSPRAY],[18,PBMoves::POISONFANG],[21,PBMoves::MINIMIZE],
			[26,PBMoves::FLING],[29,PBMoves::KNOCKOFF],[31,PBMoves::CRUNCH],[33,PBMoves::TOXIC],
			[35,PBMoves::SCREECH],[37,PBMoves::SLUDGEBOMB],[40,PBMoves::GUNKSHOT],[43,PBMoves::ACIDARMOR],
			[46,PBMoves::BELCH],[48,PBMoves::MEMENTO]],
		:EggMoves => [PBMoves::ASSURANCE,PBMoves::CLEARSMOG,PBMoves::CURSE,PBMoves::GASTROACID,
			PBMoves::IMPRISON,PBMoves::MEANLOOK,PBMoves::POWERUPPUNCH,PBMoves::PURSUIT,
			PBMoves::RECYCLE,PBMoves::SCARYFACE,PBMoves::SHADOWSNEAK,PBMoves::SLUDGE,PBMoves::SPITE,
			PBMoves::SPITUP,PBMoves::STOCKPILE,PBMoves::SUDDENSTRIKE,PBMoves::SWALLOW],
		:Height => 7,
		:Weight => 420
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MUK => {
	:FormName => {
		1 => "Alolan",
		2 => "PULSE",
		3 => "Nuclear"
	},

	:OnCreation => proc{
		maps=[467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 879] # Map IDs for Alolan form
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	:DefaultForm => 0,
	:PulseForm => 2,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Alolan" => {
		:DexEntry => "While it's unexpectedly quiet and friendly, if it's not fed any trash for a while, it will smash its Trainer's furnishings and eat up the fragments.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::GLUTTONY,PBAbilities::POWEROFALCHEMY],
		:Movelist => [[0,PBMoves::VENOMDRENCH],[1,PBMoves::MOONBLAST],[1,PBMoves::HAZE],[1,PBMoves::VENOMDRENCH],
			[1,PBMoves::POUND],[1,PBMoves::POISONGAS],[4,PBMoves::HARDEN],[7,PBMoves::BITE],[12,PBMoves::DISABLE],
			[15,PBMoves::ACIDSPRAY],[18,PBMoves::POISONFANG],[21,PBMoves::MINIMIZE],[26,PBMoves::FLING],
			[29,PBMoves::KNOCKOFF],[31,PBMoves::CRUNCH],[33,PBMoves::TOXIC],[35,PBMoves::SCREECH],
			[37,PBMoves::SLUDGEBOMB],[40,PBMoves::GUNKSHOT],[43,PBMoves::ACIDARMOR],[46,PBMoves::BELCH],
			[48,PBMoves::MEMENTO]],
		:Height => 10,
		:Weight => 520
	},

	"PULSE" => {
		:BaseStats => [105,105,70,40,97,250],
		:Ability => PBAbilities::PROTEAN,
		:Weight => 1023
	}
},

PBSpecies::EXEGGUTOR => {
	:FormName => {1 => "Alolan"},

	"Alolan" => {
		:DexEntry => "As it grew taller and taller, it outgrew its reliance on psychic powers, while within it awakened the power of the sleeping dragon.",
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [95,105,85,45,125,75],
		:Ability => [PBAbilities::FRISK,PBAbilities::FRISK,PBAbilities::HARVEST],
		:Movelist => [[0,PBMoves::DRAGONHAMMER],[1,PBMoves::SOFTBOILED],[1,PBMoves::POWERWHIP],
			[1,PBMoves::DRAGONPULSE],[1,PBMoves::PSYSHOCK],[1,PBMoves::SEEDBOMB],[1,PBMoves::GROWTH],
			[1,PBMoves::DRAGONHAMMER],[1,PBMoves::BARRAGE],[1,PBMoves::HYPNOSIS],[1,PBMoves::ABSORB],
			[6,PBMoves::CONFUSION],[11,PBMoves::LEECHSEED],[13,PBMoves::BULLETSEED],[15,PBMoves::SWEETSCENT],
			[17,PBMoves::REFLECT],[19,PBMoves::STUNSPORE],[21,PBMoves::POISONPOWDER],[23,PBMoves::SLEEPPOWDER],
			[25,PBMoves::MEGADRAIN],[27,PBMoves::PSYBEAM],[29,PBMoves::NATURALGIFT],[31,PBMoves::EGGBOMB],
			[33,PBMoves::BESTOW],[35,PBMoves::SYNTHESIS],[37,PBMoves::UPROAR],[39,PBMoves::WOODHAMMER],
			[41,PBMoves::GIGADRAIN],[43,PBMoves::EXTRASENSORY],[45,PBMoves::LEAFSTORM],[47,PBMoves::WORRYSEED],
			[50,PBMoves::PSYCHIC],[53,PBMoves::SOLARBEAM]],
		:Height => 109,
		:Weight => 4156
	}
},

PBSpecies::MAROWAK => {
	:FormName => {
		1 => "Alolan",
		2 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[669,881] # Map IDs for Alolan form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Alolan" => {
		:DexEntry => "The bones it possesses were once its mother's. Its mother's regrets have become like a vengeful spirit protecting this Pokémon.",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,80,110,45,50,80],
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::LIGHTNINGROD,PBAbilities::ROCKHEAD],
		:Movelist => [[0,PBMoves::SHADOWBONE],[1,PBMoves::SWORDSDANCE],[1,PBMoves::FLAMEWHEEL],
			[1,	PBMoves::FIRESPIN],[1,PBMoves::SCREECH][1,PBMoves::SHADOWBONE],[1,PBMoves::MUDSLAP],
			[1,PBMoves::GROWL],[3,PBMoves::TAILWHIP],[5,PBMoves::HEADBUTT],[7,PBMoves::LEER],
			[9,PBMoves::FOCUSENERGY],[11,PBMoves::BONECLUB],[13,PBMoves::RAGE],[17,PBMoves::CHARM],
			[19,PBMoves::HEX],[21,PBMoves::FALSESWIPE],[23,PBMoves::FLING],[25,PBMoves::WILLOWISP],
			[27,PBMoves::BONERUSH],[31,PBMoves::RETALIATE],[33,PBMoves::STOMPINGTANTRUM],
			[37,PBMoves::THRASH],[41,PBMoves::BONEMERANG],[43,PBMoves::ENDEAVOR],[47,PBMoves::DOUBLEEDGE],
			[50,PBMoves::FLAREBLITZ]],
		:GetEvo => [],
		:Weight => 340
	},

	"Mega" => {
		:BaseStats => [70,110,120,95,50,80],
		:Ability => [PBAbilities::STAMINA],
	}
},

PBSpecies::MISDREAVUS => {
	:FormName => {1 => "Aevian"},

	"Aevian" => {
		:DexEntry => "It knows the swamp it lives in like no other and blends in perfectly. It's more timid than its regular counterpart, and doesn't like showing itself to bypassers.",
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,85,60,85,85,60],
		:Ability => [PBAbilities::MAGICBOUNCE,PBAbilities::POISONPOINT,PBAbilities::TANGLINGHAIR],
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::VINEWHIP],[5,PBMoves::POISONPOWDER],[10,PBMoves::ASTONISH],
			[14,PBMoves::CONFUSERAY],[19,PBMoves::SNAPTRAP],[23,PBMoves::HEX],[28,PBMoves::GIGADRAIN],
			[32,PBMoves::INGRAIN],[37,PBMoves::GRUDGE],[41,PBMoves::SHADOWBALL],
			[46,PBMoves::PERISHSONG],[50,PBMoves::POWERWHIP],[55,PBMoves::POWERGEM]],
		:EggMoves => [PBMoves::CURSE,PBMoves::DESTINYBOND,PBMoves::GROWTH,PBMoves::MEFIRST,PBMoves::MEMENTO,
			PBMoves::NASTYPLOT,PBMoves::CLEARSMOG,PBMoves::SCREECH,PBMoves::SHADOWSNEAK,PBMoves::LIFEDEW,
			PBMoves::TOXIC,PBMoves::SUCKERPUNCH,PBMoves::WONDERROOM],
		:Height => 7,
		:Weight => 420,
		:GetEvo => [[PBSpecies::MISMAGIUS,PBEvolution::Item,PBItems::LEAFSTONE]]
	}
},

PBSpecies::MISMAGIUS => {
	:FormName => {
		1 => "Aevian",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Aevian" => {
		:DexEntry => "A gentle but misleadingly strong Pokémon, it helps those who got lost in the wetlands find their way out... At the cost of a little of their life force.",
		:Type1 => PBTypes::GRASS,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,105,60,105,105,60],
		:Ability => [PBAbilities::MAGICBOUNCE,PBAbilities::POISONPOINT,PBAbilities::TANGLINGHAIR],
		:Movelist => [[1,PBMoves::POISONJAB],[1,PBMoves::POWERGEM],[1,PBMoves::PHANTOMFORCE],[1,PBMoves::LUCKYCHANT],[1,PBMoves::MAGICALLEAF],[1,PBMoves::GROWL],[1,PBMoves::VINEWHIP],[1,PBMoves::POISONPOWDER],[1,PBMoves::ASTONISH],[0,PBMoves::SHADOWCLAW]],
		:Weight => 10
	},

	"Mega" => {
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [70,60,70,125,140,135],
		:Ability => [PBAbilities::INFILTRATOR],
	}
},

PBSpecies::GROWLITHE => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear"
	},

	:OnCreation => proc{
		chancemaps=[523] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "They patrol their territory in pairs. I believe the igneous rock components in the fur of this species are the result of volcanic activity in its habitat.",
		:Type2 => PBTypes::ROCK,
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::FLASHFIRE,PBAbilities::ROCKHEAD,PBAbilities::ROCKHEAD,PBAbilities::JUSTIFIED],
		:BaseStats => [60,75,45,55,65,50],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::LEER],[1,PBMoves::EMBER],[4,PBMoves::HOWL],
			[8,PBMoves::BITE],[12,PBMoves::FLAMEWHEEL],[16,PBMoves::HELPINGHAND],[20,PBMoves::ROCKTHROW],
			[24,PBMoves::FIREFANG],[28,PBMoves::RETALIATE],[32,PBMoves::CRUNCH],[36,PBMoves::TAKEDOWN],
			[40,PBMoves::FLAMETHROWER],[44,PBMoves::ROAR],[48,PBMoves::ROCKSLIDE],[52,PBMoves::REVERSAL],
			[56,PBMoves::DOUBLEEDGE],[60,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::COVET,PBMoves::DOUBLEEDGE,PBMoves::DOUBLEKICK,PBMoves::HEADSMASH,
			PBMoves::MORNINGSUN,PBMoves::SACREDFIRE,PBMoves::THRASH],
		:Weight => 227,
		:Height => 8,
		:WildItemCommon => :RAWSTBERRY,
		:WildItemRare => :EXPCANDYS
	}
},

PBSpecies::ARCANINE => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear",
		3 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "Despite its bulk, it deftly feints every which way, leading opponents on a deceptively merry chase as it all but dances around them.",
		:Type2 => PBTypes::ROCK,
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::FLASHFIRE,PBAbilities::ROCKHEAD,PBAbilities::CONQUEROR,PBAbilities::JUSTIFIED],
		:BaseStats => [95,115,80,90,95,80],
		:Movelist => [[0,PBMoves::EXTREMESPEED],[1,PBMoves::AGILITY],[1,PBMoves::EXTREMESPEED],
			[1,PBMoves::TACKLE],[1,PBMoves::LEER],[1,PBMoves::EMBER],[4,PBMoves::HOWL],[8,PBMoves::BITE],
			[12,PBMoves::FLAMEWHEEL],[16,PBMoves::HELPINGHAND],[20,PBMoves::ROCKTHROW],[24,PBMoves::FIREFANG],
			[28,PBMoves::RETALIATE],[32,PBMoves::CRUNCH],[36,PBMoves::TAKEDOWN],[40,PBMoves::FLAMETHROWER],
			[44,PBMoves::ROAR],[48,PBMoves::ROCKSLIDE],[52,PBMoves::REVERSAL],[56,PBMoves::DOUBLEEDGE],
			[60,PBMoves::FLAREBLITZ],[64,PBMoves::RAGINGFURY]],
		:Weight => 1680,
		:Height => 20,
		:WildItemCommon => :RAWSTBERRY,
		:WildItemRare => :EXPCANDYM
	},

	"Mega" => {
		:BaseStats => [100,130,95,105,130,95],
		:Ability => [PBAbilities::DROUGHT]
	}
},

PBSpecies::VOLTORB => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[198,281] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "An enigmatic Pokémon that happens to bear a resemblance to a Poké Ball. When excited, it discharges the electric current it has stored in its belly, then lets out a great, uproarious laugh.",
		:Type2 => PBTypes::GRASS,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::CHARGE],[3,PBMoves::THUNDERSHOCK],[5,PBMoves::THUNDERWAVE],
			[7,PBMoves::STUNSPORE],[9,PBMoves::BULLETSEED],[11,PBMoves::ROLLOUT],[13,PBMoves::SCREECH],
			[16,PBMoves::CHARGEBEAM],[18,PBMoves::SPARK],[20,PBMoves::SWIFT],[22,PBMoves::ELECTROBALL],
			[26,PBMoves::SELFDESTRUCT],[29,PBMoves::GYROBALL],[31,PBMoves::THUNDERBOLT],[34,PBMoves::SEEDBOMB],
			[37,PBMoves::THUNDER],[39,PBMoves::DISCHARGE],[41,PBMoves::EXPLOSION],[46,PBMoves::ENERGYBALL],
			[50,PBMoves::GRASSYTERRAIN]],
		:EggMoves => [PBMoves::ICESPINNER,PBMoves::LEECHSEED,PBMoves::RAPIDSPIN,PBMoves::RECYCLE,
			PBMoves::WORRYSEED],
		:Weight => 130,
		:GetEvo => [[PBSpecies::ELECTRODE,PBEvolution::Item,PBItems::LEAFSTONE]],
		:WildItemRare => :EXPCANDYS
	}
},

PBSpecies::ELECTRODE => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[455,857] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "The tissue on the surface of its body is curiously similar in composition to an Apricorn. When irritated, this Pokémon lets loose an electric current equal to 20 lightning bolts.",
		:Type2 => PBTypes::GRASS,
		:Movelist => [[0,PBMoves::CHLOROBLAST],[1,PBMoves::CHLOROBLAST],[1,PBMoves::TACKLE],[1,PBMoves::CHARGE],
			[3,PBMoves::THUNDERSHOCK],[5,PBMoves::THUNDERWAVE],[7,PBMoves::STUNSPORE],[9,PBMoves::BULLETSEED],
			[11,PBMoves::ROLLOUT],[13,PBMoves::SCREECH],[16,PBMoves::CHARGEBEAM],[18,PBMoves::SPARK],
			[20,PBMoves::SWIFT],[22,PBMoves::ELECTROBALL],[26,PBMoves::SELFDESTRUCT],[29,PBMoves::GYROBALL],
			[31,PBMoves::THUNDERBOLT],[34,PBMoves::SEEDBOMB],[37,PBMoves::THUNDER],[39,PBMoves::DISCHARGE],
			[41,PBMoves::EXPLOSION],[46,PBMoves::ENERGYBALL],[50,PBMoves::GRASSYTERRAIN]],
		:Weight => 710,
		:WildItemRare => :EXPCANDYS
	}
},

PBSpecies::QWILFISH => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[364,366,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,390,430,433,434] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "Fishers detest this troublesome Pokémon because it sprays poison from its spines, getting it everywhere. A different form of Qwilfish lives in other regions.",
		:Type1 => PBTypes::DARK,
		:Ability => [PBAbilities::TOXICDEBRIS,PBAbilities::POISONPOINT,PBAbilities::SWIFTSWIM,
			PBAbilities::INTIMIDATE],
		:Movelist => [[1,PBMoves::POISONSTING],[1,PBMoves::TACKLE],[4,PBMoves::HARDEN],[8,PBMoves::BITE],
			[12,PBMoves::SPIKES],[14,PBMoves::FELLSTINGER],[16,PBMoves::MINIMIZE],[20,PBMoves::WATERPULSE],
			[24,PBMoves::SELFDESTRUCT],[26,PBMoves::PINMISSILE],[28,PBMoves::TOXICSPIKES],[32,PBMoves::BRINE],
			[36,PBMoves::STOCKPILE],[36,PBMoves::SPITUP],[40,PBMoves::TOXIC],[44,PBMoves::DARKPULSE],
			[48,PBMoves::POISONJAB],[50,PBMoves::AQUATAIL],[52,PBMoves::BARBBARRAGE],[56,PBMoves::DOUBLEEDGE],
			[60,PBMoves::CRUNCH],[66,PBMoves::DESTINYBOND]],
		:EggMoves => [PBMoves::AQUAJET,PBMoves::ASTONISH,PBMoves::BANEFULBUNKER,PBMoves::BUBBLEBEAM,
			PBMoves::FLAIL,PBMoves::MORTALSPIN,PBMoves::SUPERSONIC],
		:GetEvo => [[PBSpecies::OVERQWIL,PBEvolution::HasMove,PBMoves::BARBBARRAGE]],
		:WildItemRare => :EXPCANDYS
	}
},

PBSpecies::SNEASEL => {
	:FormName => {
		1 => "Hisui",
		2 => "Nuclear",
		3 => "NuclearHisui",
		4 => "Delta"
	},

	:OnCreation => proc{
		maps=[361,404]
		mapDelta1=[757]
		if $game_map && maps.include?($game_map.map_id)
			next 1
		elsif $game_map && mapDelta1.include?($game_map.map_id)
			next 4
		else
			next 0
		end
 	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Hisui" => {
		:DexEntry => "Its sturdy, curved claws are ideal for traversing precipitous cliffs. From the tips of these claws drips a venom that infiltrates the nerves of any prey caught in Sneasel's grasp.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::POISON,
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::KEENEYE,PBAbilities::SHARPNESS,
			PBAbilities::DODGE,PBAbilities::PICKPOCKET,PBAbilities::HIGHRISE,PBAbilities::POISONTOUCH,
			PBAbilities::MELEE],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::TAUNT],[6,PBMoves::ROCKSMASH],
			[8,PBMoves::QUICKATTACK],[11,PBMoves::METALCLAW],[18,PBMoves::SWIFT],[24,PBMoves::SCREECH],
			[30,PBMoves::SLASH],[34,PBMoves::HONECLAWS],[36,PBMoves::POISONJAB],[42,PBMoves::AGILITY],
			[48,PBMoves::BRICKBREAK],[54,PBMoves::SWORDSDANCE],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::COUNTER,PBMoves::CRUSHCLAW,PBMoves::DETECT,PBMoves::DIRECLAW,PBMoves::DOUBLEHIT,
			PBMoves::DRAINPUNCH,PBMoves::FAKEOUT,PBMoves::FEINT,PBMoves::FOCUSENERGY,PBMoves::IRONTAIL,
			PBMoves::NIGHTSLASH,PBMoves::QUICKGUARD,PBMoves::SHADOWSNEAK,PBMoves::SNARL,PBMoves::SWITCHEROO],
		:GetEvo => [[PBSpecies::SNEASLER,PBEvolution::DayHoldItem,PBItems::RAZORCLAW]],
		:WildItemUncommon => :RAZORCLAW,
		:WildItemRare => :EXPCANDYS
	},

	"NuclearHisui" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::NUCLEAR,
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::KEENEYE,PBAbilities::SHARPNESS,
			PBAbilities::DODGE,PBAbilities::PICKPOCKET,PBAbilities::HIGHRISE,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::NUCLEARSLASH],[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[1,PBMoves::TAUNT],
			[6,PBMoves::ROCKSMASH],[8,PBMoves::QUICKATTACK],[11,PBMoves::METALCLAW],[18,PBMoves::SWIFT],
			[24,PBMoves::SCREECH],[30,PBMoves::SLASH],[34,PBMoves::HONECLAWS],[36,PBMoves::POISONJAB],
			[42,PBMoves::AGILITY],[48,PBMoves::BRICKBREAK],[54,PBMoves::SWORDSDANCE],[60,PBMoves::CLOSECOMBAT]],
		:GetEvo => [[PBSpecies::SNEASLER,PBEvolution::DayHoldItem,PBItems::RAZORCLAW]]
	},

	"Delta" => {
		:DexEntry => "The obsidian shard shoved in its head drove it insane. Only the sound of its quartz claws screeching on rocks may calm it down.",
		:BaseStats => [61,101,76,101,41,56],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::KEENEYE,PBAbilities::PICKPOCKET,
			PBAbilities::INNERFOCUS,PBAbilities::TOUGHCLAWS],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::CONFUSERAY],[6,PBMoves::SANDATTACK],
			[12,PBMoves::ASTONISH],[18,PBMoves::ACCELEROCK],[24,PBMoves::MEANLOOK],[30,PBMoves::ANCIENTPOWER],
			[36,PBMoves::HONECLAWS],[42,PBMoves::SHADOWSNEAK],[48,PBMoves::ROCKPOLISH],[54,PBMoves::HEX],
			[60,PBMoves::SLASH]],
		:EggMoves => [PBMoves::FAKEOUT,PBMoves::DOUBLEHIT,PBMoves::ICEPUNCH,PBMoves::COUNTER,PBMoves::SPITE,
			PBMoves::POISONFANG,PBMoves::THROATCHOP,PBMoves::CRUSHCLAW,PBMoves::CROSSPOISON,PBMoves::DETECT,
			PBMoves::SKYUPPERCUT,PBMoves::DIRECLAW]
	}
},

PBSpecies::TYPHLOSION => {
	:FormName => {
		1 => "Hisui",
		3 => "Rebornian",
		4 => "Mega X",
		5 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::TYPHLOSINITEX => 4,
		PBItems::TYPHLOSINITEY => 5
	},

	"Hisui" => {
		:DexEntry => "Said to purify lost, forsaken souls with its flames and guide them to the afterlife. I believe its form has been influenced by the energy of the sacred mountain towering at Hisui's center.",
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::BLAZE,PBAbilities::INFILTRATOR,PBAbilities::FRISK,PBAbilities::FLASHFIRE],
		:BaseStats => [73,84,78,95,119,85],
		:Movelist => [[0,PBMoves::HEX],[1,PBMoves::GYROBALL],[1,PBMoves::OMINOUSWIND],[1,PBMoves::MYSTICALFIRE],
			[1,PBMoves::SLASH],[1,PBMoves::HEX],[1,PBMoves::FURYCUTTER],[1,PBMoves::SCRATCH],[1,PBMoves::LEER],
			[6,PBMoves::SMOKESCREEN],[9,PBMoves::TACKLE],[11,PBMoves::EMBER],[13,PBMoves::QUICKATTACK],
			[15,PBMoves::ROAR],[17,PBMoves::BITE],[19,PBMoves::FLAMEWHEEL],[21,PBMoves::DEFENSECURL],
			[23,PBMoves::FURYSWIPES],[25,PBMoves::FLAMECHARGE],[27,PBMoves::SCARYFACE],[29,PBMoves::SWIFT],
			[31,PBMoves::ROLLOUT],[33,PBMoves::LAVAPLUME],[35,PBMoves::REST],[37,PBMoves::INFERNO],
			[39,PBMoves::DOUBLEEDGE],[41,PBMoves::INFERNALPARADE],[43,PBMoves::FLAMETHROWER],
			[45,PBMoves::OVERHEAT],[47,PBMoves::BURNUP],[49,PBMoves::SHADOWBALL],[51,PBMoves::WILLOWISP],
			[55,PBMoves::ERUPTION]],
		:WildItemCommon => :SITRUSBERRY,
		:WildItemRare => :EXPCANDYL
	},

	"Rebornian" => {
		:DexEntry => "As this Pokémon runs, the scales on its back rub against each other creating a massive amount of static electricity that keeps it moving through any fatigue it may have. This Pokémon can chase prey for a month without rest. It will always take the most direct course to get to where it's going. There have even been reports that entire towns have been run through by this pokemon.",
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [89,109,81,100,79,81],
		:EVs => [0,0,0,1,2,0],
		:Ability => [PBAbilities::RECKLESS,PBAbilities::HUSTLE,PBAbilities::CLOUDNINE],
		:Movelist => [[0,PBMoves::DOUBLEEDGE],[0,PBMoves::FLAMECHARGE],[0,PBMoves::ENDEAVOR],[0,PBMoves::LEER],[0,PBMoves::THUNDERSHOCK],[6,PBMoves::THUNDERSHOCK],[10,PBMoves::QUICKATTACK],[20,PBMoves::SPARK],
			[24,PBMoves::DUALCHOP],[27,PBMoves::POISONFANG],[31,PBMoves::HONECLAWS],
			[35,PBMoves::WILDCHARGE],[38,PBMoves::TAKEDOWN],[43,PBMoves::SCALESHOT],[48,PBMoves::DRAGONRUSH],[56,PBMoves::JAWLOCK],[62,PBMoves::VOLTTACKLE],[69,PBMoves::SLACKOFF],[70,PBMoves::TAILWIND]],
		:EggMoves => [PBMoves::FLAREBLITZ,PBMoves::HEADSMASH,PBMoves::CLANGOROUSSOUL,PBMoves::EXTREMESPEED,PBMoves::NATUREPOWER,PBMoves::THRASH,PBMoves::IRONHEAD],
		:Weight => 680,
		:Height => 19,
		:kind => "Static Predator"
	},

	"Mega X" => {
		:Type2 => PBTypes::FIGHTING,
		:Ability => PBAbilities::RECKLESS,
		:BaseStats => [78,154,118,90,99,95],
		:Weight => 860
	},

	"Mega Y" => {
		:Ability => PBAbilities::BERSERK,
		:BaseStats => [78,84,88,120,149,115],
		:Weight => 860
	}
},

PBSpecies::SAMUROTT => {
	:FormName => {
		1 => "Hisui",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Hisui" => {
		:DexEntry => "Hard of heart and deft of blade, this rare form of Samurott is a product of the Pokémon's evolution in the region of Hisui. Its turbulent blows crash into foes like ceaseless pounding waves.",
		:Type2 => PBTypes::DARK,
		:Ability => [PBAbilities::TORRENT,PBAbilities::SHELLARMOR,PBAbilities::AQUABOOST,PBAbilities::SWIFTSWIM,PBAbilities::CONQUEROR,PBAbilities::SHARPNESS],
		:BaseStats => [90,108,80,85,100,65],
		:Movelist => [[0,PBMoves::CEASELESSEDGE],[1,PBMoves::CEASELESSEDGE],[1,PBMoves::TACKLE],
			[5,PBMoves::TAILWHIP],[7,PBMoves::WATERSPORT],[9,PBMoves::WATERGUN],[11,PBMoves::HEADBUTT],
			[13,PBMoves::FOCUSENERGY],[15,PBMoves::SOAK],[17,PBMoves::WHIRLPOOL],[19,PBMoves::FURYCUTTER],
			[21,PBMoves::AQUAJET],[23,PBMoves::REVENGE],[25,PBMoves::WATERPULSE],[27,PBMoves::SWAGGER],
			[29,PBMoves::AERIALACE],[31,PBMoves::BRINE],[33,PBMoves::SLASH],[35,PBMoves::RAZORSHELL],
			[37,PBMoves::ENCORE],[39,PBMoves::FLAIL],[41,PBMoves::SUCKERPUNCH],[43,PBMoves::RETALIATE],
			[45,PBMoves::AQUATAIL],[47,PBMoves::MEGAHORN],[49,PBMoves::NIGHTSLASH],[52,PBMoves::WATERPLEDGE],
			[55,PBMoves::SWORDSDANCE],[57,PBMoves::DARKPULSE],[62,PBMoves::HYDROPUMP]],
		:Weight => 582,
		:WildItemCommon => :SITRUSBERRY,
		:WildItemRare => :EXPCANDYL
	},

	"Mega" => {
		:BaseStats => [95,140,105,90,108,90],
		:Ability => PBAbilities::SHARPNESS
	}
},

PBSpecies::EMBOAR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [110,163,95,75,100,85],
		:Ability => PBAbilities::MOXIE
	}
},

PBSpecies::SERPERIOR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DRAGON,
		:BaseStats => [75,95,115,133,95,115],
		:Ability => PBAbilities::ADAPTABILITY
	}
},

PBSpecies::DECIDUEYE => {
	:FormName => {1 => "Hisui"},

	"Hisui" => {
		:DexEntry => "The air stored inside the rachises of Decidueye's feathers insulates the Pokémon against Hisui's extreme cold. This is firm proof that evolution can be influenced by environment.",
		:Type2 => PBTypes::FIGHTING,
		:Ability => [PBAbilities::OVERGROW,PBAbilities::LONGREACH,PBAbilities::SCRAPPY,PBAbilities::STRONGHEEL],
		:BaseStats => [88,112,80,60,95,95],
		:Movelist => [[0,PBMoves::ROCKSMASH],[1,PBMoves::AXEKICK],[1,PBMoves::BULKUP],[1,PBMoves::ROCKSMASH],
			[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[4,PBMoves::LEAFAGE],[6,PBMoves::PECK],[8,PBMoves::FORESIGHT],
			[11,PBMoves::GUST],[14,PBMoves::ASTONISH],[16,PBMoves::FURYATTACK],[18,PBMoves::SHADOWSNEAK],
			[20,PBMoves::RAZORLEAF],[22,PBMoves::OMINOUSWIND],[25,PBMoves::SYNTHESIS],[27,PBMoves::MAGICALLEAF],
			[29,PBMoves::PLUCK],[31,PBMoves::FEATHERDANCE],[33,PBMoves::AERIALACE],[35,PBMoves::ROOST],
			[37,PBMoves::SUCKERPUNCH],[39,PBMoves::TRIPLEARROWS],[43,PBMoves::UTURN],[46,PBMoves::AURASPHERE],
			[49,PBMoves::NASTYPLOT],[51,PBMoves::AIRSLASH],[54,PBMoves::LEAFBLADE],[58,PBMoves::BRAVEBIRD],
			[60,PBMoves::LEAFSTORM],[140,PBMoves::THOUSANDARROWS]],
		:Weight => 370,
		:WildItemCommon => :SITRUSBERRY,
		:WildItemRare => :EXPCANDYL
	}
},

PBSpecies::ZORUA => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[797,803,807] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "A once-departed soul, returned to life in Hisui. Derives power from resentment, which rises as energy atop its head and takes on the forms of foes. In this way, Zorua vents lingering malice.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [35,60,40,70,85,40],
		:Movelist => [[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[4,PBMoves::TORMENT],[8,PBMoves::SPITE],
			[12,PBMoves::SHADOWSNEAK],[16,PBMoves::TAUNT],[20,PBMoves::CURSE],[22,PBMoves::SNARL],
			[24,PBMoves::HONECLAWS],[26,PBMoves::SWIFT],[28,PBMoves::AGILITY],[32,PBMoves::KNOCKOFF],
			[34,PBMoves::SLASH],[36,PBMoves::BITTERMALICE],[40,PBMoves::FOULPLAY],[44,PBMoves::SHADOWCLAW],
			[48,PBMoves::NASTYPLOT],[54,PBMoves::SHADOWBALL]],
		:EggMoves => [PBMoves::BITTERBLADE,PBMoves::COMEUPPANCE,PBMoves::DETECT,PBMoves::EXTRASENSORY,
		PBMoves::GLARE,PBMoves::MEMENTO,PBMoves::MOONBLAST],
		:WildItemRare => :EXPCANDYS
	}
},

PBSpecies::ZOROARK => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[797,803,807] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "With its disheveled white fur, it looks like an embodiment of death. Heedless of its own safety, Zoroark attacks its nemeses with a bitter energy so intense, it lacerates Zoroark's own body.",
		:Type1 => PBTypes::NORMAL,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [55,100,60,110,125,60],
		:Movelist => [[0,PBMoves::EXTRASENSORY],[1,PBMoves::EXTRASENSORY],
			[1,PBMoves::SCRATCH],[1,PBMoves::LEER],[4,PBMoves::TORMENT],[8,PBMoves::SPITE],
			[12,PBMoves::SHADOWSNEAK],[16,PBMoves::TAUNT],[20,PBMoves::CURSE],[22,PBMoves::SNARL],
			[24,PBMoves::HONECLAWS],[26,PBMoves::SWIFT],[28,PBMoves::AGILITY],[32,PBMoves::KNOCKOFF],
			[34,PBMoves::SLASH],[36,PBMoves::BITTERMALICE],[40,PBMoves::FOULPLAY],[44,PBMoves::SHADOWCLAW],
			[48,PBMoves::NASTYPLOT],[52,PBMoves::UTURN],[54,PBMoves::SHADOWBALL]],
		:Weight => 730,
		:WildItemRare => :EXPCANDYM
	}
},

PBSpecies::BRAVIARY => {
	:FormName => {1 => "Hisui"},

	:OnCreation => proc{
		chancemaps=[642,643,646,836,837] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Hisui" => {
		:DexEntry => "Screaming a bloodcurdling battle cry, this huge and ferocious bird Pokémon goes out on the hunt. It blasts lakes with shock waves, then scoops up any prey that float to the water's surface.",
		:Type1 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,0,2,0],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::SHEERFORCE,PBAbilities::DEFIANT,PBAbilities::PRIDE,PBAbilities::HERO,PBAbilities::TINTEDLENS,PBAbilities::TINTEDLENS],
		:BaseStats => [110,83,70,65,112,70],
		:Movelist => [[0,PBMoves::ESPERWING],[1,PBMoves::SUPERPOWER],[1,PBMoves::PSYWAVE],[1,PBMoves::ESPERWING],
			[1,PBMoves::PECK],[1,PBMoves::LEER],[5,PBMoves::FURYATTACK],[10,PBMoves::SCARYFACE],
			[12,PBMoves::QUICKATTACK],[14,PBMoves::HONECLAWS],[16,PBMoves::TWISTER],[19,PBMoves::WINGATTACK],
			[23,PBMoves::WHIRLWIND],[28,PBMoves::DEFOG],[32,PBMoves::AERIALACE],[37,PBMoves::SLASH],
			[41,PBMoves::TAILWIND],[43,PBMoves::ROOST],[46,PBMoves::AIRSLASH],[50,PBMoves::CRUSHCLAW],
			[55,PBMoves::SKYDROP],[59,PBMoves::THRASH],[64,PBMoves::BRAVEBIRD],[66,PBMoves::DOUBLEEDGE],
			[72,PBMoves::SKYATTACK],[80,PBMoves::HURRICANE]],
		:Weight => 434,
		:WildItemRare => :EXPCANDYM
	}
},

PBSpecies::SLIGGOO => {
	:FormName => {1 => "Hisui"},		

	"Hisui" => {
		:DexEntry => "A creature given to melancholy. I suspect its metallic shell developed as a result of the mucus on its skin reacting with the iron in Hisui's water.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [58,75,83,40,83,113],
		:Ability => [PBAbilities::SAPSIPPER,PBAbilities::SHELLARMOR,PBAbilities::OVERCOAT,PBAbilities::GOOEY],
		:Movelist => [[0,PBMoves::IRONHEAD],[1,PBMoves::IRONHEAD],[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],
			[5,PBMoves::BIDE],[9,PBMoves::WATERGUN],[13,PBMoves::DRAGONBREATH],[15,PBMoves::CURSE],
			[18,PBMoves::BUBBLE],[20,PBMoves::FLAIL],[25,PBMoves::ACIDSPRAY],[28,PBMoves::RAINDANCE],
			[30,PBMoves::WATERPULSE],[32,PBMoves::PROTECT],[35,PBMoves::BODYSLAM],[38,PBMoves::ACIDARMOR],
			[40,PBMoves::MUDDYWATER],[42,PBMoves::SHELTER],[45,PBMoves::DRAGONPULSE],[47,PBMoves::HYDROPUMP]],
		:Weight => 685,
		:WildItemRare => :EXPCANDYM
	}
},

PBSpecies::GOODRA => {
	:FormName => {1 => "Hisui"},

	"Hisui" => {
		:DexEntry => "Able to freely control the hardness of its metallic shell. It loathes solitude and is extremely clingy—it will fume and run riot if those dearest to it ever leave its side.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [80,100,100,60,110,150],
		:Ability => [PBAbilities::SAPSIPPER,PBAbilities::SHELLARMOR,PBAbilities::OVERCOAT,PBAbilities::GOOEY],
		:Movelist => [[0,PBMoves::FEINT],[1,PBMoves::FEINT],[1,PBMoves::IRONHEAD],
		[1,PBMoves::TACKLE],[1,PBMoves::ABSORB],[5,PBMoves::BIDE],[9,PBMoves::WATERGUN],
		[13,PBMoves::DRAGONBREATH],[15,PBMoves::CURSE],[18,PBMoves::BUBBLE],[20,PBMoves::FLAIL],
		[25,PBMoves::ACIDSPRAY],[28,PBMoves::RAINDANCE],[30,PBMoves::WATERPULSE],[32,PBMoves::PROTECT],
		[35,PBMoves::BODYSLAM],[38,PBMoves::ACIDARMOR],[40,PBMoves::MUDDYWATER],[42,PBMoves::SHELTER],
		[45,PBMoves::DRAGONPULSE],[47,PBMoves::HYDROPUMP],[51,PBMoves::IRONTAIL],[55,PBMoves::TEARFULLOOK],
		[67,PBMoves::HEAVYSLAM]],
		:Weight => 3341,
		:WildItemRare => :EXPCANDYL
	}
},

PBSpecies::WEEZING => {
	:FormName => {
		1 => "Galarian",
		2 => "Cosmic"
	},

	"Galarian" => {
		:DexEntry => "This Pokémon consumes particles that contaminate the air. Instead of leaving droppings, it expels clean air.",
		:Type2 => PBTypes::FAIRY,
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::MISTYSURGE],
		:Movelist => [[0,PBMoves::DOUBLEHIT],[1,PBMoves::HEATWAVE],[1,PBMoves::STRANGESTEAM],
			[1,PBMoves::AROMATICMIST],[1,PBMoves::DEFOG],[1,PBMoves::FAIRYWIND],[1,PBMoves::AROMATHERAPY],
			[1,PBMoves::DOUBLEHIT],[1,PBMoves::TACKLE],[1,PBMoves::POISONGAS],[4,PBMoves::SMOG],
			[6,PBMoves::SMOKESCREEN],[8,PBMoves::CLEARSMOG],[10,PBMoves::ASSURANCE],[12,PBMoves::GYROBALL],
			[15,PBMoves::SLUDGE],[18,PBMoves::SELFDESTRUCT],[23,PBMoves::HAZE],[26,PBMoves::TOXIC],
			[28,PBMoves::SLUDGEBOMB],[33,PBMoves::EXPLOSION],[37,PBMoves::MEMENTO],[40,PBMoves::BELCH],
			[42,PBMoves::MISTYTERRAIN],[45,PBMoves::DESTINYBOND]],
		:WildHoldItems => [0,PBItems::ELEMENTALSEED,0]
	},

	"Cosmic" => {
		:DexEntry => "After evolving, this Pokémon's body mass increases significantly, making it produce an enormous amount of inebriating gas that puts Weezing on a terrible bad trip. ",
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [100,50,70,110,90,120], # ? Cosmic increases by +50
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::CURIOUSMEDICINE],
		:Movelist => [[0,PBMoves::DOUBLEHIT],[1,PBMoves::DEFOG],[1,PBMoves::SMOG],[1,PBMoves::SMOKESCREEN],
			[1,PBMoves::CLEARSMOG],[1,PBMoves::SLUDGE],[1,PBMoves::DESTINYBOND],[1,PBMoves::MOONLIGHT],[40,PBMoves::TOXIC],[42,PBMoves::PSYBEAM],[46,PBMoves::MYSTICALFIRE],[50,PBMoves::BELCH],[57,PBMoves::MOONBLAST],[60,PBMoves::COSMICDANCE],[105,PBMoves::COSMICBARRAGE]]
	},
},

PBSpecies::FARFETCHD => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[150,848,849,850,857,859] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "The Farfetch’d of the Galar region are brave warriors, and they wield thick, tough leeks in battle.",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [52,95,55,55,58,62],
		:Ability => [PBAbilities::STEADFAST,PBAbilities::SCRAPPY],
		:Movelist => [[1,PBMoves::PECK],[1,PBMoves::SANDATTACK],[5,PBMoves::LEER],[10,PBMoves::FURYCUTTER],
			[15,PBMoves::ROCKSMASH],[20,PBMoves::BRUTALSWING],[25,PBMoves::DETECT],[30,PBMoves::SLAM],
			[35,PBMoves::KNOCKOFF],[40,PBMoves::DEFOG],[45,PBMoves::BRICKBREAK],[50,PBMoves::SWORDSDANCE],
			[55,PBMoves::LEAFBLADE],[60,PBMoves::FINALGAMBIT],[65,PBMoves::BRAVEBIRD]],
		:EggMoves => [PBMoves::AGILITY,PBMoves::AIRSLASH,PBMoves::COUNTER,PBMoves::COVET,PBMoves::CURSE,
			PBMoves::CUT,PBMoves::DOUBLEEDGE,PBMoves::FEINT,PBMoves::FLAIL,PBMoves::FURYATTACK,
			PBMoves::MIRRORMOVE,PBMoves::NIGHTSLASH,PBMoves::QUICKATTACK,PBMoves::QUICKGUARD,PBMoves::RAZORLEAF,
			PBMoves::ROOST,PBMoves::SACREDSWORD,PBMoves::SIMPLEBEAM,PBMoves::SLASH,PBMoves::SKYATTACK],
		:GetEvo => [[PBSpecies::SIRFETCHD,PBEvolution::LandCritical,3]]
	}
},

PBSpecies::PONYTA => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,292] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "This Pokémon will look into your eyes and read the contents of your heart. If it finds evil there, it promptly hides away.",
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::PSYCHIC,
		:Ability => [PBAbilities::RUNAWAY,PBAbilities::PASTELVEIL,PBAbilities::ANTICIPATION],
		:Movelist => [[1,PBMoves::GROWL],[1,PBMoves::TACKLE],[5,PBMoves::TAILWHIP],[10,PBMoves::CONFUSION],
			[15,PBMoves::FAIRYWIND],[20,PBMoves::STOMP],[25,PBMoves::PSYBEAM],[20,PBMoves::TAKEDOWN],
			[35,PBMoves::AGILITY],[41,PBMoves::HEALPULSE],[45,PBMoves::DAZZLINGGLEAM],[50,PBMoves::PSYCHIC],
			[55,PBMoves::HEALINGWISH]],
		:EggMoves => [PBMoves::AQUAJET,PBMoves::DOUBLEEDGE,PBMoves::DOUBLEKICK,PBMoves::EMBER,
			PBMoves::EXTREMESPEED,PBMoves::FIREBLAST,PBMoves::FIRESPIN,PBMoves::FLAREBLITZ,PBMoves::HORNDRILL,
			PBMoves::HYPNOSIS,PBMoves::PLAYROUGH,PBMoves::MORNINGSUN,PBMoves::QUICKATTACK,PBMoves::THRASH,
			PBMoves::ZENHEADBUTT],
	}
},

PBSpecies::RAPIDASH => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,696,697,700,788,812,849,850] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Brave and prideful, this Pokémon dashes airily through the forest, its steps aided by the psychic power stored in the fur on its fetlocks.",
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::FAIRY,
		:Ability => [PBAbilities::RUNAWAY,PBAbilities::PASTELVEIL,PBAbilities::ANTICIPATION],
		:Movelist => [[0,PBMoves::PSYCHOCUT],[1,PBMoves::MEGAHORN],[1,PBMoves::QUICKATTACK],[1,PBMoves::GROWL],
			[1,PBMoves::TACKLE],[5,PBMoves::TAILWHIP],[10,PBMoves::CONFUSION],[15,PBMoves::FAIRYWIND],
			[20,PBMoves::STOMP],[25,PBMoves::PSYBEAM],[20,PBMoves::TAKEDOWN],[35,PBMoves::AGILITY],
			[41,PBMoves::HEALPULSE],[45,PBMoves::DAZZLINGGLEAM],[50,PBMoves::PSYCHIC],
			[55,PBMoves::HEALINGWISH]]
	}
},

PBSpecies::ARTICUNO => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "Its feather-like blades are composed of psychic energy and can shear through thick iron sheets as if they were paper.",
		:Type1 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,0,3,0],
		:BaseStats => [90,85,85,95,125,100],
		:Ability => [PBAbilities::COMPETITIVE,PBAbilities::MAGICIAN],
		:Movelist => [[1,PBMoves::ICEBEAM],[1,PBMoves::GUST],[1,PBMoves::PSYCHOSHIFT],[5,PBMoves::CONFUSION],
			[10,PBMoves::REFLECT],[15,PBMoves::HYPNOSIS],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],
			[30,PBMoves::TAILWIND],[35,PBMoves::PSYCHOCUT],[40,PBMoves::RECOVER],[45,PBMoves::FREEZINGGLARE],
			[50,PBMoves::DREAMEATER],[55,PBMoves::HURRICANE],[60,PBMoves::MINDREADER],[65,PBMoves::DOUBLETEAM],
			[70,PBMoves::FUTURESIGHT],[75,PBMoves::TRICKROOM]],
		:Weight => 509
	}
},

PBSpecies::ZAPDOS => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "One kick from its powerful legs will pulverize a dump truck. Supposedly, this Pokémon runs through the mountains at over 180 mph.",
		:Type1 => PBTypes::FIGHTING,
		:EVs => [0,3,0,0,0,0],
		:BaseStats => [90,125,90,100,85,90],
		:Ability => [PBAbilities::DEFIANT,PBAbilities::STRONGHEEL],
		:Movelist => [[1,PBMoves::BOLTBEAK],[1,PBMoves::PECK],[1,PBMoves::FOCUSENERGY],[5,PBMoves::ROCKSMASH],
			[10,PBMoves::LIGHTSCREEN],[15,PBMoves::PLUCK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],
			[30,PBMoves::BRICKBREAK],[35,PBMoves::DRILLPECK],[40,PBMoves::QUICKGUARD],
			[45,PBMoves::THUNDEROUSKICK],[50,PBMoves::BULKUP],[55,PBMoves::COUNTER],[60,PBMoves::DETECT],
			[65,PBMoves::CLOSECOMBAT],[70,PBMoves::REVERSAL]],
		:Weight => 582
	}
},

PBSpecies::MOLTRES => {
	:FormName => {1 => "Galarian"},
	
	"Galarian" => {
		:DexEntry => "This Pokémon's sinister, flame-like aura will consume the spirit of any creature it hits. Victims become burned-out shadows of themselves.",
		:Type1 => PBTypes::DARK,
		:EVs => [0,0,0,0,0,3],
		:BaseStats => [90,85,90,90,100,125],
		:Ability => [PBAbilities::BERSERK,PBAbilities::FLASHFIRE],
		:Movelist => [[1,PBMoves::HEATWAVE],[1,PBMoves::GUST],[1,PBMoves::LEER],[5,PBMoves::PAYBACK],
			[10,PBMoves::SAFEGUARD],[15,PBMoves::WINGATTACK],[20,PBMoves::AGILITY],[25,PBMoves::ANCIENTPOWER],
			[30,PBMoves::SUCKERPUNCH],[35,PBMoves::AIRSLASH],[40,PBMoves::AFTERYOU],[45,PBMoves::FIERYWRATH],
			[50,PBMoves::NASTYPLOT],[55,PBMoves::HURRICANE],[60,PBMoves::ENDURE],[65,PBMoves::MEMENTO],
			[70,PBMoves::SKYATTACK]],
		:Weight => 660
	}
},

PBSpecies::SLOWPOKE => {
	:FormName => {2 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[238,412,545,546,713,715,716,718,726,742,763] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Although this Pokémon is normally zoned out, its expression abruptly sharpens on occasion. The cause for this seems to lie in Slowpoke’s diet.",
		:Type1 => PBTypes::PSYCHIC,
		:Ability => [PBAbilities::GLUTTONY,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::CURSE],[3,PBMoves::GROWL],[6,PBMoves::ACID],
			[9,PBMoves::YAWN],[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],[18,PBMoves::WATERPULSE],
			[21,PBMoves::HEADBUTT],[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],[30,PBMoves::RAINDANCE],
			[33,PBMoves::SURF],[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],
			[45,PBMoves::PSYCHIC]],
		:EggMoves => [PBMoves::BELCH,PBMoves::BELLYDRUM,PBMoves::BLOCK,PBMoves::SHEDTAIL,PBMoves::STOMP],
		:GetEvo => [[PBSpecies::SLOWBRO,PBEvolution::Item,PBItems::GALARICACUFF],
			[PBSpecies::SLOWKING,PBEvolution::Item,PBItems::GALARICAWREATH]]
	}
},

PBSpecies::SLOWKING => {
	:FormName => {2 => "Galarian"},

	"Galarian" => {
		:DexEntry => "A combination of toxins and the shock of evolving has increased Shellder’s intelligence to the point that Shellder now controls Slowking.",
		:Type1 => PBTypes::POISON,
		:Ability => [PBAbilities::CURIOUSMEDICINE,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::EERIESPELL],[1,PBMoves::CHILLYRECEPTION],[1,PBMoves::NASTYPLOT],
			[1,PBMoves::TOXICSPIKES],[1,PBMoves::POWERGEM],[1,PBMoves::SWAGGER],[1,PBMoves::EERIESPELL],
			[1,PBMoves::TACKLE],[1,PBMoves::CURSE],[3,PBMoves::GROWL],[6,PBMoves::ACID],[9,PBMoves::YAWN],
			[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],[18,PBMoves::WATERPULSE],[21,PBMoves::HEADBUTT],
			[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],[30,PBMoves::RAINDANCE],[33,PBMoves::SURF],
			[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],[45,PBMoves::PSYCHIC]]
	}
},

PBSpecies::CORSOLA => {
	:FormName => {
		1 => "Galarian",
		2 => "Nuclear",
		3 => "NuclearGalarian",
		4 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[575,576,577,578,579,608,610,851,856,863] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 4,

	"Galarian" => {
		:DexEntry => "Sudden climate change wiped out this ancient kind of Corsola. This Pokémon absorbs others’ life-force through its branches.",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,55,100,30,65,100],
		:Ability => [PBAbilities::WEAKARMOR,PBAbilities::CURSEDBODY],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::TACKLE],[5,PBMoves::ASTONISH],[10,PBMoves::DISABLE],
			[15,PBMoves::SPITE],[20,PBMoves::NIGHTSHADE],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::HEX],
			[35,PBMoves::CURSE],[40,PBMoves::STRENGTHSAP],[45,PBMoves::POWERGEM],[50,PBMoves::GRUDGE],
			[55,PBMoves::MIRRORCOAT]],
		:EggMoves => [PBMoves::CONFUSERAY,PBMoves::CORALBREAK,PBMoves::DESTINYBOND,PBMoves::HAZE,		
			PBMoves::HEADSMASH,PBMoves::NATUREPOWER,PBMoves::SALTCURE,PBMoves::WATERPULSE],
		:GetEvo => [[PBSpecies::CURSOLA,PBEvolution::Level,38]],
		:Weight => 5
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::HARDEN],[4,PBMoves::WATERGUN],[6,PBMoves::REFRESH],
		[8,PBMoves::LUCKYCHANT],[10,PBMoves::AQUARING],[12,PBMoves::BUBBLE],[16,PBMoves::LIFEDEW],
		[19,PBMoves::ROCKBLAST],[21,PBMoves::GAMMARAY],[23,PBMoves::BUBBLEBEAM],[25,PBMoves::SPIKECANNON],
		[27,PBMoves::ANCIENTPOWER],[29,PBMoves::ENDURE],[31,PBMoves::FLAIL],[33,PBMoves::RECOVER],
		[35,PBMoves::LIGHTSCREEN],[37,PBMoves::BRINE],[39,PBMoves::IRONDEFENSE],[41,PBMoves::EARTHPOWER],
		[43,PBMoves::POWERGEM],[45,PBMoves::MIRRORCOAT],[47,PBMoves::CORALBREAK],[47,PBMoves::PROTONBEAM]]
	},

	"NuclearGalarian" => {
		:DexEntry => "Sudden climate change wiped out this ancient kind of Corsola. This Pokémon absorbs others’ life-force through its branches.",
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [60,55,100,30,65,100],
		:Ability => [PBAbilities::WEAKARMOR,PBAbilities::CURSEDBODY],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::TACKLE],[5,PBMoves::ASTONISH],[10,PBMoves::DISABLE],
		[15,PBMoves::SPITE],[20,PBMoves::NIGHTSHADE],[23,PBMoves::GAMMARAY],[25,PBMoves::ANCIENTPOWER],
		[30,PBMoves::HEX],[35,PBMoves::CURSE],[40,PBMoves::STRENGTHSAP],[43,PBMoves::PROTONBEAM],
		[45,PBMoves::POWERGEM],[50,PBMoves::GRUDGE],[55,PBMoves::MIRRORCOAT]],
		:GetEvo => [[PBSpecies::CURSOLA,PBEvolution::Level,38]],
		:Weight => 5
	},

	"Mega" => {
		:BaseStats => [55,45,75,105,95,75],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::WATERBUBBLE
	}
},

PBSpecies::CURSOLA => {
	:FormName => {3 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::PERISHSONG],[1,PBMoves::PERISHSONG],[1,PBMoves::HARDEN],[1,PBMoves::TACKLE],
		[5,PBMoves::ASTONISH],[10,PBMoves::DISABLE],[15,PBMoves::SPITE],[20,PBMoves::NIGHTSHADE],
		[23,PBMoves::GAMMARAY],[25,PBMoves::ANCIENTPOWER],[30,PBMoves::HEX],[33,PBMoves::RADIOACID],
		[35,PBMoves::CURSE],[40,PBMoves::STRENGTHSAP],[43,PBMoves::PROTONBEAM],[45,PBMoves::POWERGEM],
		[50,PBMoves::GRUDGE],[55,PBMoves::MIRRORCOAT]]
	}
},

PBSpecies::CORSOREEF => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::ICICLESPEAR],[1,PBMoves::ICICLESPEAR],[1,PBMoves::TACKLE],[1,PBMoves::HARDEN],
		[4,PBMoves::WATERGUN],[6,PBMoves::REFRESH],[8,PBMoves::LUCKYCHANT],[10,PBMoves::AQUARING],
		[12,PBMoves::BUBBLE],[16,PBMoves::LIFEDEW],[19,PBMoves::ROCKBLAST],[21,PBMoves::GAMMARAY],
		[23,PBMoves::BUBBLEBEAM],[25,PBMoves::SPIKECANNON],[27,PBMoves::ANCIENTPOWER],[29,PBMoves::ENDURE],
		[31,PBMoves::FLAIL],[32,PBMoves::RADIOACID],[33,PBMoves::RECOVER],[35,PBMoves::LIGHTSCREEN],
		[37,PBMoves::BRINE],[39,PBMoves::IRONDEFENSE],[41,PBMoves::EARTHPOWER],[43,PBMoves::POWERGEM],
		[45,PBMoves::MIRRORCOAT],[47,PBMoves::CORALBREAK],[47,PBMoves::PROTONBEAM],[49,PBMoves::TOXIC],
		[51,PBMoves::SHELLSMASH]]
	}
},

PBSpecies::ZIGZAGOON => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[234,519] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "Thought to be the oldest form of Zigzagoon, it moves in zigzags and wreaks havoc upon its surroundings.",
		:Type1 => PBTypes::DARK,
		:Movelist => [[1,PBMoves::LEER],[1,PBMoves::TACKLE],[3,PBMoves::SANDATTACK],[6,PBMoves::LICK],
			[9,PBMoves::SNARL],[12,PBMoves::HEADBUTT],[15,PBMoves::BABYDOLLEYES],[18,PBMoves::PINMISSILE],
			[21,PBMoves::REST],[24,PBMoves::TAKEDOWN],[27,PBMoves::SCARYFACE],[30,PBMoves::COUNTER],
			[43,PBMoves::TAUNT],[56,PBMoves::DOUBLEEDGE]],
		:EggMoves => [PBMoves::CRUSHCLAW,PBMoves::EXTREMESPEED,PBMoves::KNOCKOFF,PBMoves::PARTINGSHOT,
			PBMoves::QUICKGUARD]
	}
},

PBSpecies::LINOONE => {
	:FormName => {1 => "Galarian"},

	:OnCreation => proc{
		chancemaps=[285,286,287,290,291,519,831] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
 	},

	"Galarian" => {
		:DexEntry => "This very aggressive Pokémon will recklessly challenge opponents stronger than itself.",
		:Type1 => PBTypes::DARK,
		:Movelist => [[0,PBMoves::FURYSWIPES],[1,PBMoves::FURYSWIPES],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
			[3,PBMoves::SANDATTACK],[6,PBMoves::LICK],[9,PBMoves::SNARL],[12,PBMoves::HEADBUTT],
			[15,PBMoves::BABYDOLLEYES],[18,PBMoves::PINMISSILE],[21,PBMoves::REST],[24,PBMoves::TAKEDOWN],
			[27,PBMoves::SCARYFACE],[30,PBMoves::COUNTER],[33,PBMoves::SWITCHEROO],[38,PBMoves::HONECLAWS],
			[43,PBMoves::TAUNT],[45,PBMoves::SUCKERPUNCH],[52,PBMoves::NIGHTSLASH],[56,PBMoves::DOUBLEEDGE]],
		:GetEvo => [[PBSpecies::OBSTAGOON,PBEvolution::LevelNight,35]]
	}
},

PBSpecies::SINISTEA => {
	:FormName => {
		0 => "Phony",
		1 => "Antique"
	},
	:OnCreation => proc{rand(2)},

	"Antique" => {
		:DexEntry => "The swirl pattern in this Pokémon's body is its weakness. If it gets stirred, the swirl loses its shape, and Sinistea gets dizzy.",
		:GetEvo => [[PBSpecies::POLTEAGEIST,PBEvolution::Item,PBItems::CRACKEDPOT]]
	}
},

PBSpecies::POLTEAGEIST => {
	:FormName => {
		0 => "Phony",
		1 => "Antique"
	},

	"Antique" => {
		:DexEntry => "When angered, it launches tea from its body at the offender's mouth. The tea causes strong chills if swallowed."
	}
},

PBSpecies::POLTCHAGEIST => {
	:FormName => {
		0 => "Counterfeit",
		1 => "Artisan"
	},
	:OnCreation => proc{rand(2)},

	"Artisan" => {
		:DexEntry => "It sprinkles some of its powdery body onto food and drains the life-force from those who so much as lick it.",
		:GetEvo => [[PBSpecies::SINISTCHA,PBEvolution::Item,PBItems::MASTERPIECETEACUP]]
	}
},

PBSpecies::SINISTCHA => {
	:FormName => {
		0 => "Unremarkable",
		1 => "Masterpiece"
	},

	"Masterpiece" => {
		:DexEntry => "It lives inside a superb teacup that was crafted by a potter of great renown. Collectors positively adore this Pokémon."
	}
},

PBSpecies::STUNFISK => {
	:FormName => {1 => "Galarian"},
	:OnCreation => proc{rand(2)},

	"Galarian" => {
		:DexEntry => "Living in mud with a high iron content has given it a strong steel body.",
		:Type2 => PBTypes::STEEL,
		:BaseStats => [109,81,99,32,66,84],
		:Ability => [PBAbilities::MIMICRY],
		:Movelist => [[1,PBMoves::MUDSLAP],[1,PBMoves::TACKLE],[1,PBMoves::WATERGUN],[1,PBMoves::ENDURE],
			[5,PBMoves::METALCLAW],[10,PBMoves::METALSOUND],[15,PBMoves::REVENGE],[20,PBMoves::MUDSHOT],
			[25,PBMoves::IRONDEFENSE],[30,PBMoves::SNAPTRAP],[35,PBMoves::FLAIL],[40,PBMoves::SUCKERPUNCH],
			[45,PBMoves::BOUNCE],[50,PBMoves::MUDDYWATER],[55,PBMoves::FISSURE]],
		:EggMoves => [PBMoves::ASTONISH,PBMoves::BIND,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::MEFIRST,
			PBMoves::PAINSPLIT,PBMoves::REFLECTTYPE,PBMoves::SLEEPTALK,PBMoves::SPIKYSHIELD,PBMoves::SPITE,
			PBMoves::YAWN]
	}
},

###################### Paldean Forms Gen 9 ######################

PBSpecies::TAUROS => {
	:FormName => {
		1 => "Combat Breed",
		2 => "Blaze Breed",
		3 => "Aqua Breed"
	},

	"Combat Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
			[15,PBMoves::ASSURANCE],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
			[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
			[55,PBMoves::DOUBLEEDGE],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::SCREECH,PBMoves::HEADLONGRUSH]
	},

	"Blaze Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::FIRE,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
		[15,PBMoves::FLAMECHARGE],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
		[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
		[55,PBMoves::FLAREBLITZ],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::FIRELASH,PBMoves::SCREECH]
	},

	"Aqua Breed" => {
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::WATER,
		:BaseStats => [75,110,105,100,30,70],
		:Ability => [PBAbilities::INTIMIDATE,PBAbilities::ANGERPOINT,PBAbilities::CUDCHEW],
		:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::WORKUP],[10,PBMoves::DOUBLEKICK],
		[15,PBMoves::AQUAJET],[20,PBMoves::SCARYFACE],[25,PBMoves::HEADBUTT],[30,PBMoves::REST],
		[35,PBMoves::SWAGGER],[40,PBMoves::ZENHEADBUTT],[45,PBMoves::RAGINGBULL],[50,PBMoves::THRASH],
		[55,PBMoves::WAVECRASH],[60,PBMoves::CLOSECOMBAT]],
		:EggMoves => [PBMoves::CURSE,PBMoves::ENDEAVOR,PBMoves::SCREECH,PBMoves::WATERFALL]
	}
},

PBSpecies::WOOPER => {
	:FormName => {1 => "Paldean"},
	:OnCreation => proc{rand(2)},

	"Paldean" => {
		:DexEntry => "After losing a territorial struggle, Wooper began living on land. The Pokémon changed over time, developing a poisonous film to protect its body.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::POISONPOINT,PBAbilities::WATERABSORB,PBAbilities::WATERABSORB,PBAbilities::DEEPSLEEP,PBAbilities::UNAWARE],
		:Movelist => [[1,PBMoves::TAILWHIP],[1,PBMoves::POISONSTING],[1,PBMoves::MUDSHOT],[4,PBMoves::TACKLE],
			[8,PBMoves::POISONTAIL],[12,PBMoves::TOXICSPIKES],[16,PBMoves::SLAM],[21,PBMoves::YAWN],
			[24,PBMoves::POISONJAB],[28,PBMoves::SLUDGEWAVE],[32,PBMoves::AMNESIA],[40,PBMoves::TOXIC],
			[44,PBMoves::EARTHQUAKE]],
		:EggMoves => [PBMoves::AFTERYOU,PBMoves::ANCIENTPOWER,PBMoves::COUNTER,PBMoves::DOUBLEKICK,
			PBMoves::GASTROACID,PBMoves::MIST,PBMoves::RECOVER,PBMoves::SOAK,PBMoves::SPITUP,PBMoves::STOCKPILE,
			PBMoves::SWALLOW],
		:GetEvo => [[PBSpecies::CLODSIRE,PBEvolution::Level,20]],
	}
},

PBSpecies::OINKOLOGNE => {
	#Gender difference
	"Female" => {
		:DexEntry => "This is a meticulous Pokémon that likes to keep things tidy. It shrouds itself in a floral aroma that soothes the Pokémon around it.",
		:Ability => [PBAbilities::AROMAVEIL,PBAbilities::LINGERINGAROMA,PBAbilities::GLUTTONY,
			PBAbilities::THICKFAT],
		:BaseStats => [115,90,70,65,59,90]
	}
},

PBSpecies::PALAFIN => {
	:FormName => {1 => "Hero"},

	"Hero" => {
		:DexEntry => "This Pokémon’s ancient genes have awakened. It is now so extraordinarily strong that it can easily lift a cruise ship with one fin.",
		:BaseStats => [100,160,97,100,106,87]
	}
},

PBSpecies::DUNSPARCE => {
	:OnCreation => proc{
		randomnum = rand(10)
		next randomnum==0 ? 1 : 0
	}
},

PBSpecies::DUDUNSPARCE => {
	:FormName => {
		0 => "Double",
		1 => "Triple"
	},

	"Triple" => {
		:DexEntry => "The gentle Dudunsparce will put Pokémon that wander into its nest onto its back and carry them to the entrance."
	}
},

PBSpecies::TANDEMAUS => {
	:OnCreation => proc{
		randomnum = rand(10)
		next randomnum==0 ? 1 : 0
	}
},

PBSpecies::MAUSHOLD => {
	:FormName => {
		0 => "Fours",
		1 => "Threes"
	},

	"Threes" => {
		:DexEntry => "The little one just appeared one day. They all live together like a family, but the relationship between the three is still unclear."
	}
},

PBSpecies::GIMMIGHOUL => {
	:FormName => {
		0 => "Chest",
		1 => "Wandering"
	},

	"Wandering" => {
		:DexEntry => "It wanders around, carrying an old coin on its back. It survives by draining the life-force from humans who try to pick up its coin.",
		:BaseStats => [45,30,25,80,75,45],
		:Ability => PBAbilities::RUNAWAY
	}
},

PBSpecies::TATSUGIRI => {
	:FormName => {
		0 => "Curly",
		1 => "Droopy",
		2 => "Stretchy"
	},
	:OnCreation => proc{rand(3)},

	"Droopy" => {
		:DexEntry => "This species’ differing colors and patterns are apparently the result of Tatsugiri changing itself to suit the preferences of the prey it lures in."
	},

	"Stretchy" => {
		:DexEntry => "It's one of the most intelligent dragon Pokémon. It camouflages itself by inflating its throat sac."
	}
},

PBSpecies::OGERPON => {
	:FormName => {
		0 => "Unmasked",
		1 => "Teal Mask",
		2 => "Wellspring Mask",
		3 => "Hearthflame Mask",
		4 => "Cornerstone Mask",
		5 => "Mega Teal",
		6 => "Mega Wellspring",
		7 => "Mega Hearthflame",
		8 => "Mega Cornerstone"
	},

	:DefaultForm => {
		PBItems::TEALMASK => 1,
		PBItems::WELLSPRINGMASK => 2,
		PBItems::HEARTHFLAMEMASK => 3,
		PBItems::CORNERSTONEMASK => 4
	},
	:MegaForm => {
		PBItems::TEALMASK => 5,
		PBItems::WELLSPRINGMASK => 6,
		PBItems::HEARTHFLAMEMASK => 7,
		PBItems::CORNERSTONEMASK => 8
	},

	"Teal Mask" => {
		:DexEntry => "This mischief-loving Pokémon is full of curiosity. It battles by drawing out the type-based energy contained within its masks.",
		:Ability => PBAbilities::DEFIANT
	},

	"Wellspring Mask" => {
		:DexEntry => "This form excels in both attack and defense. It ceaselessly unleashes moves like a spring gushes water.",
		:Type2 => PBTypes::WATER,
		:Ability => PBAbilities::WATERABSORB
	},

	"Hearthflame Mask" => {
		:DexEntry => "This form is the most aggressive, bombarding enemies with the intensity of flames blazing within a hearth.",
		:Type2 => PBTypes::FIRE,
		:Ability => PBAbilities::MOLDBREAKER
	},

	"Cornerstone Mask" => {
		:DexEntry => "This form has excellent defenses, absorbing impacts solidly like the cornerstones that support houses.",
		:Type2 => PBTypes::ROCK,
		:Ability => PBAbilities::STURDY
	},

	"Mega Teal" => {
		:Ability => PBAbilities::EMBODYASPECT
	},

	"Mega Wellspring" => {
		:Type2 => PBTypes::WATER,
		:Ability => PBAbilities::EMBODYASPECT
	},

	"Mega Hearthflame" => {
		:Type2 => PBTypes::FIRE,
		:Ability => PBAbilities::EMBODYASPECT
	},

	"Mega Cornerstone" => {
		:Type2 => PBTypes::ROCK,
		:Ability => PBAbilities::EMBODYASPECT
	},
},

###################### Custom Megas ######################

PBSpecies::DELIBIRD => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,100,50,120,45,55],
		:Ability => PBAbilities::TECHNICIAN,
	}
},

PBSpecies::VILEPLUME => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,95,105,30,155,120],
		:Ability => PBAbilities::EFFECTSPORE,
	}
},

PBSpecies::VICTREEBEL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [90,125,85,80,120,90],
		:Ability => PBAbilities::CHLOROPHYLL,
	}
},

PBSpecies::STARMIE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,90,85,130,135,90],
		:Ability => PBAbilities::MAGICGUARD,
	}
},

PBSpecies::NOCTOWL => {
	:FormName => {
		2 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[333,334,335,358,359,360,361,372,404,412,439,519,522,523,525,526,527,528,530,533,544,551,573]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 1 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type1 => PBTypes::PSYCHIC,
		:BaseStats => [120,50,60,90,136,96],
		:Ability => PBAbilities::TINTEDLENS,
	}
},

PBSpecies::XATU => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,95,80,115,125,90],
		:Ability => PBAbilities::MAGICBOUNCE,
	}
},

PBSpecies::JUMPLUFF => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [75,115,80,120,65,105],
		:Ability => PBAbilities::TECHNICIAN
	}
},

PBSpecies::SUNFLORA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,55,65,50,145,115],
		:Ability => PBAbilities::HYDRABOND
	}
},

PBSpecies::SHUCKLE => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::GHOST,
		:BaseStats => [20,15,250,55,15,250],
		:Ability => PBAbilities::SHADOWTAG,
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::LANTURN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [125,98,68,107,86,76],
		:Ability => PBAbilities::RECKLESS
	}
},

PBSpecies::ZANGOOSE => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [83,145,70,120,70,70],
		:Ability => PBAbilities::TOUGHCLAWS,
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::EXPLOUD => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::ELECTRIC,
		:BaseStats => [124,71,93,58,141,103],
		:Ability => PBAbilities::PUNKROCK
	}
},

PBSpecies::MILOTIC => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega",
		3 => "Delta"
	},

	:OnCreation => proc{
		chancemaps=[879,882] # Map IDs for Delta form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 3 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [105,70,89,91,130,155],
		:Ability => PBAbilities::REGENERATOR
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "Returned to the surface thanks to its now powerful psychic powers, he's the origin of a myth about a monster guarding Azurine Island.",
		:BaseStats => [106,66,66,81,126,101],
		:Type1 => PBTypes::PSYCHIC,
		:Type2 => PBTypes::DRAGON,
		:Ability => [PBAbilities::POISONHEAL,PBAbilities::BERSERK,PBAbilities::MAGICGUARD],
		:Movelist => [[0,PBMoves::WATERPULSE],[1,PBMoves::FLAIL],[1,PBMoves::WRAP],[1,PBMoves::SMOG],[1,PBMoves::SPLASH],[1,PBMoves::POISONSTING],[4,PBMoves::ACID],[8,PBMoves::TWISTER],[12,PBMoves::AQUARING],[16,PBMoves::LIGHTSCREEN],[20,PBMoves::TOXIC],[24,PBMoves::DRAGONBREATH],[28,PBMoves::REFLECT],[32,PBMoves::VENOSHOCK],[36,PBMoves::SAFEGUARD],[40,PBMoves::PSYSHOCK],[44,PBMoves::DIVE],[48,PBMoves::COIL],[52,PBMoves::DRAGONPULSE],[58,PBMoves::PSYCHIC]],
	}
},

PBSpecies::CHIMECHO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::GHOST,
		:BaseStats => [95,60,90,75,125,110],
		:Ability => PBAbilities::PSYCHICSURGE
	}
},

PBSpecies::CACTURNE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,155,80,75,115,80],
		:Ability => PBAbilities::SANDRUSH,
	}
},

PBSpecies::TORKOAL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,100,160,20,120,100],
		:Ability => PBAbilities::DROUGHT
	}
},

PBSpecies::TORTERRA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::ROCK,
		:BaseStats => [125,139,125,46,85,105],
		:Ability => PBAbilities::ROCKYPAYLOAD
	}
},

PBSpecies::INFERNAPE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [96,134,81,118,124,81],
		:Ability => PBAbilities::FLASHFIRE
	}
},

PBSpecies::EMPOLEON => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [84,116,118,60,131,121],
		:Ability => PBAbilities::BULLETPROOF
	}
},

PBSpecies::ROSERADE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,90,75,110,140,125],
		:Ability => PBAbilities::CONTRARY
	}
},

PBSpecies::KINGDRA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,110,95,120,135,95],
		:Ability => PBAbilities::MULTISCALE
	}
},

PBSpecies::NIDOKING => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega X",
		3 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::NIDOTITEX => 2,
		PBItems::NIDOTITEY => 3
	},

	"Mega X" => {
		:BaseStats => [81,142,107,85,95,95],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 860
	},

	"Mega Y" => {
		:BaseStats => [81,122,97,95,105,105],
		:Ability => PBAbilities::SHEERFORCE,
		:Weight => 860
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::MOTHIM => {
	:FormName => {3 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 3,

	"Mega" => {
		:BaseStats => [70,54,70,126,134,70],
		:Ability => PBAbilities::PROTEAN
	}
},

PBSpecies::BRONZONG => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [87,109,146,33,89,136],
		:Ability => PBAbilities::LEVITATE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::WEAVILE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		4 => "Delta"
	},

	:OnCreation => proc{
		chancemaps=[866] # Map IDs for Delta form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,150,75,155,65,95],
		:Ability => PBAbilities::SHARPNESS
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"Delta" => {
		:DexEntry => "It loves terrifying people by sharpening its claws on their house walls after midnight. Anybody touching its shard will black out instantly.",
		:BaseStats => [76,136,86,111,46,61],
		:Type1 => PBTypes::ROCK,
		:Type2 => PBTypes::GHOST,
		:Ability => [PBAbilities::CURSEDBODY,PBAbilities::TOUGHCLAWS],
		:Movelist => [[1,PBMoves::ASTONISH],[1,PBMoves::ANCIENTPOWER],[1,PBMoves::SHADOWSNEAK],[1,PBMoves::SCRATCH],[1,PBMoves::ROCKPOLISH],[1,PBMoves::SANDATTACK],[1,PBMoves::OMINOUSWIND],[1,PBMoves::CURSE],[1,PBMoves::GLARE],[1,PBMoves::SLASH],[1,PBMoves::CONFUSERAY],[6,PBMoves::SANDATTACK],[12,PBMoves::ASTONISH],[18,PBMoves::ACCELEROCK],[24,PBMoves::MEANLOOK],[30,PBMoves::ROCKTOMB],[36,PBMoves::HONECLAWS],[42,PBMoves::SHADOWCLAW],[48,PBMoves::STEALTHROCK],[54,PBMoves::HEX],[60,PBMoves::SLASH],[66,PBMoves::STONEEDGE],[72,PBMoves::PHANTOMFORCE]]
	}
},

PBSpecies::DUSKNOIR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [65,120,135,75,95,135],
		:Ability => PBAbilities::UNAWARE
	}
},

PBSpecies::FROSLASS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,90,70,125,135,90],
		:Ability => PBAbilities::SNOWWARNING
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SCRAFTY => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [85,120,135,78,35,135],
		:Ability => PBAbilities::INTIMIDATE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::REUNICLUS => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:BaseStats => [130,95,85,40,145,95],
		:Ability => PBAbilities::GOOEY
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BARBARACLE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [72,64,96,108,125,135],
		:Ability => PBAbilities::NEUROFORCE
	}
},

PBSpecies::TSAREENA => {
	:FormName => {
		1 => "Nuclear",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [87,145,108,92,70,108],
		:Ability => PBAbilities::QUEENLYMAJESTY
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

#todo##################### Multicore Variants #####################todo#

#? i should've done this before...

PBSpecies::CORPHISH => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		chancemaps=[586]
		forcedmaps=[206]
		# Map IDs for Rebornian form
		randomnum = rand(4)
		if $game_map && ((chancemaps.include?($game_map.map_id) && randomnum==0) || forcedmaps.include?($game_map.map_id))
			next 1
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "Due to Corphish's hardiness it is usually able to thrive in polluted waters, however not all Corphish are as strong as their neighbors. Due to the extreme strength of the Pulse pollutants in Azurine, some of the local Corphish adapt to take in the poisoned water.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::NORMAL,
		:BaseStats => [43,80,65,35,50,35],
		:Ability => [PBAbilities::ADAPTABILITY,PBAbilities::POISONPOINT,PBAbilities::POISONTOUCH],
		:Movelist => [[1,PBMoves::POISONSTING],[5,PBMoves::HARDEN],[7,PBMoves::VISEGRIP],[10,PBMoves::TOXICSPIKES],[14,PBMoves::THIEF],[17,PBMoves::PROTECT],[20,PBMoves::HORNATTACK],[23,PBMoves::KNOCKOFF],[26,PBMoves::SHADOWPUNCH],[31,PBMoves::PAINSPLIT],[34,PBMoves::TAUNT],[37,PBMoves::SWORDSDANCE],[39,PBMoves::DESTINYBOND],[43,PBMoves::CRABHAMMER],[48,PBMoves::TOXIC]],
		:EggMoves => [PBMoves::ASTONISH,PBMoves::BIND,PBMoves::COUNTER,PBMoves::CURSE,PBMoves::EARTHPOWER,PBMoves::MEFIRST,
									PBMoves::PAINSPLIT,PBMoves::REFLECTTYPE,PBMoves::SLEEPTALK,PBMoves::SPITE,PBMoves::YAWN]
	}
},

PBSpecies::CRAWDAUNT => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		chancemaps=[586]
		forcedmaps=[206]
		# Map IDs for Rebornian form
		randomnum = rand(4)
		if $game_map && ((chancemaps.include?($game_map.map_id) && randomnum==0) || forcedmaps.include?($game_map.map_id))
			next 1
		else
			next 0
		end
	},

	"Rebornian" => {
		:DexEntry => "Due to Corphish's hardiness it is usually able to thrive in polluted waters, however not all Corphish are as strong as their neighbors. Due to the extreme strength of the Pulse pollutants in Azurine, some of the local Corphish adapt to take in the poisoned water.",
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [60,120,80,55,70,80],
		:Ability => [PBAbilities::ADAPTABILITY,PBAbilities::POISONPOINT,PBAbilities::POISONTOUCH],
		:Movelist => [[0,PBMoves::POISONJAB],[1,PBMoves::SHADOWSNEAK],[1,PBMoves::PAINSPLIT],[1,PBMoves::PHANTOMFORCE],[5,PBMoves::HARDEN],[7,PBMoves::VISEGRIP],[10,PBMoves::TOXICSPIKES],[14,PBMoves::THIEF],[17,PBMoves::PROTECT],[20,PBMoves::HORNATTACK],[23,PBMoves::KNOCKOFF],[26,PBMoves::SHADOWPUNCH],[32,PBMoves::PAINSPLIT],[36,PBMoves::TAUNT],[40,PBMoves::SWORDSDANCE],[48,PBMoves::GUNKSHOT],[54,PBMoves::TOXIC],[57,PBMoves::SHADOWCLAW]]
	}
},

PBSpecies::KOFFING => {
	:FormName => {2 => "Cosmic"},

	:OnCreation => proc{
		mapNewKoffing=[497,498,499,500,501,502,503,504,505] # Map IDs for Rebornian form
		next $game_map && mapNewKoffing.include?($game_map.map_id) ? 2 : 0
	},

	"Cosmic" => {
		:DexEntry => "It releases a highly psychoactive gas, that is believed by many cultures to possess cosmic powers. Thanks to that, this Pokémon is popularly known as the \"shamanic Pokémon\" and it's often used on mystic and religious rituals. It appears to always be pleasantly intoxicated.",
		:Type2 => PBTypes::COSMIC,
		:BaseStats => [60,35,45,65,60,95], #? Cosmic increases by +30
		:Ability => [PBAbilities::LEVITATE,PBAbilities::NEUTRALIZINGGAS,PBAbilities::CURIOUSMEDICINE],
		:Movelist => [[1,PBMoves::POISONGAS],[1,PBMoves::TACKLE],[4,PBMoves::SMOG],[4,PBMoves::EMBER],[7,PBMoves::SMOKESCREEN],[12,PBMoves::CLEARSMOG],[15,PBMoves::PSYBEAM],[18,PBMoves::SLUDGE],[23,PBMoves::FLAMEBURST],[26,PBMoves::COSMICPOWER],[34,PBMoves::SLUDGEBOMB],[37,PBMoves::TOXIC],[42,PBMoves::MYSTICALFIRE],[52,PBMoves::COSMICDANCE]]
	}
},

PBSpecies::BALTOY => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		mapNewBaltoy=[651,652,653,654,655,656,657,658,659,661,662] # Map IDs for Rebornian form
		next $game_map && mapNewBaltoy.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => "This Pokémon is a fine example of ancient pottery. Rumors say that an artisan's spirit dwells inside it, spending centuries anxiously trying to gather its broken pieces.",
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [75,20,55,40,40,70],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CURSEDBODY,PBAbilities::SHADOWTAG],
		:Movelist => [[1,PBMoves::HARDEN],[1,PBMoves::ASTONISH],[1,PBMoves::RAPIDSPIN],[4,PBMoves::CURSE],[7,PBMoves::MUDSLAP],[10,PBMoves::MAGNITUDE],[13,PBMoves::CONFUSERAY],[16,PBMoves::HEX],[19,PBMoves::ANCIENTPOWER],[21,PBMoves::COSMICPOWER],[25,PBMoves::MOONLIGHT],[28,PBMoves::MUDBOMB],[31,PBMoves::EXTRASENSORY],[34,PBMoves::BITTERMALICE],[36,PBMoves::PERISHSONG],[38,PBMoves::EARTHPOWER],[40,PBMoves::SHADOWBALL],[40,PBMoves::PERISHSONG],[43,PBMoves::SANDSTORM],[46,PBMoves::DESTINYBOND],[46,PBMoves::PERISHSONG]]
	}
},

PBSpecies::CLAYDOL => {
	:FormName => {
		1 => "Rebornian",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	:OnCreation => proc{
		mapNewBaltoy=[651,652,653,654,655,656,657,658,659,661,662] # Map IDs for Rebornian form
		next $game_map && mapNewBaltoy.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => "After gathering all its missing pieces, Baltoy starts spinning and singing an ominous song that allows it to evolve. Claydol then starts to devour the souls of those who listened the sinister chant to satiate its bitter malice.",
		:Type1 => PBTypes::GROUND,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [110,50,110,50,70,120],
		:Ability => [PBAbilities::LEVITATE,PBAbilities::CURSEDBODY,PBAbilities::SHADOWTAG],
		:Movelist => [[1,PBMoves::HYPERBEAM],[1,PBMoves::TELEPORT],[1,PBMoves::RAPIDSPIN],[1,PBMoves::PERISHSONG],[1,PBMoves::COSMICPOWER],[1,PBMoves::BITTERMALICE],[1,PBMoves::HYPNOSIS],[1,PBMoves::NIGHTMARE],[40,PBMoves::EARTHPOWER],[43,PBMoves::SHADOWBALL],[46,PBMoves::SANDSTORM],[48,PBMoves::DESTINYBOND]]
	},

	"Mega" => {
		:BaseStats => [60,70,135,75,105,155],
		:Ability => PBAbilities::ANALYTIC
	}
},

###################### Mega Evolutions ######################

PBSpecies::KYOGRE => {
	:FormName => {1 => "Primal"},

	"Primal" => {
		:BaseStats => [100,150,90,90,180,160],
		:Ability => PBAbilities::PRIMORDIALSEA,
		:Height => 98,
		:Weight => 4300
	}
},

PBSpecies::GROUDON => {
	:FormName => {1 => "Primal"},

	"Primal" => {
		:BaseStats => [100,180,160,90,150,90],
		:Ability => PBAbilities::DESOLATELAND,
		:Height => 50,
		:Weight => 9997,
		:Type2 => PBTypes::FIRE
	}
},

PBSpecies::VENUSAUR => {
	:FormName => {
		1 => "Mega",
		2 => "Dyna"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::VENUSAURITE => 1,
		PBItems::VENUSAURITEG => 2
	},

	"Mega" => {
		:BaseStats => [80,100,123,80,122,120],
		:Ability => PBAbilities::THICKFAT,
		:Height => 24,
		:Weight => 1555
	},

	"Dyna" => {
		:BaseStats => [105,80,100,80,120,140],
		:Ability => PBAbilities::EFFECTSPORE
	}
},

PBSpecies::CHARIZARD => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y",
		3 => "Dyna",
		5 => "Rebornian"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::CHARIZARDITEG => 3,
		PBItems::CHARIZARDITEY => 2,
		PBItems::CHARIZARDITEX => 1
	},

	"Mega Y" => {
		:BaseStats => [78,104,78,100,159,115],
		:Ability => PBAbilities::DROUGHT,
		:Weight => 1005
	},

	"Mega X" => {
		:BaseStats => [78,130,111,100,130,85],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 1105,
		:Type2 => PBTypes::DRAGON
	},

	"Dyna" => {
		:BaseStats => [120,84,100,86,139,105],
		:Ability => PBAbilities::BERSERK,
		:Weight => 1105
	},

	"Rebornian" => {
		:DexEntry => "As Charizard grows old, the metallic compounds of its venomous fluids begins to sediment on the tip of its tail, making the needle in it bigger and sturdier. Just a little sting from this Pokémon's needle is enough to kill a person within seconds.",
		:Type1 => PBTypes::POISON,
		:BaseStats => [120,110,95,50,40,120],
		:Ability => [PBAbilities::POISONTOUCH,PBAbilities::LIQUIDOOZE,PBAbilities::INJECTION],
		:Movelist => [[0,PBMoves::DUALWINGBEAT],[1,PBMoves::WINGATTACK],[1,PBMoves::JETINJECTOR],[1,PBMoves::CLOSECOMBAT],[1,PBMoves::AIRSLASH],[1,PBMoves::DRAGONCLAW],[1,PBMoves::SHADOWCLAW],[1,PBMoves::FIREFANG],[1,PBMoves::POISONFANG],[1,PBMoves::JAWLOCK],[41,PBMoves::POISONJAB],[47,PBMoves::NEEDLEDRAIN],[50,PBMoves::DRILLPECK],[53,PBMoves::CRUNCH],[56,PBMoves::BRAVEBIRD],[62,PBMoves::FLAREBLITZ]],
		:Weight => 370,
		:kind => "Injection"
	}
},

PBSpecies::BLASTOISE => {
	:FormName => {
		1 => "Mega" ,
		2 => "Dyna"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::BLASTOISINITE => 1,
		PBItems::BLASTOISINITEG => 2
	},

	"Mega" => {
		:BaseStats => [79,103,120,78,135,115],
		:Ability => PBAbilities::MEGALAUNCHER,
		:Weight => 1011
	},

	"Dyna" => {
		:BaseStats => [119,83,130,48,145,105],
		:Ability => PBAbilities::LIGHTNINGROD,
		:Weight => 1011
	}
},

PBSpecies::INCINEROAR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,115,115,90,80,115],
		:Ability => PBAbilities::SHEERFORCE,
		:Weight => 500
	}
},

PBSpecies::ALAKAZAM => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [55,50,65,150,175,105],
		:Ability => PBAbilities::TRACE,
		:Weight => 480
	}
},

PBSpecies::GENGAR => {
	:FormName => {
		1 => "Mega" ,
		2 => "Dyna"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::GENGARITE => 1,
		PBItems::GENGARITEG => 2
	},

	"Mega" => {
		:BaseStats => [60,65,80,130,170,95],
		:Ability => PBAbilities::SHADOWTAG,
		:Weight => 405
	},

	"Dyna" => {
		:BaseStats => [90,65,80,110,145,110],
		:Ability => PBAbilities::INFILTRATOR,
		:Weight => 405
	}
},

PBSpecies::KANGASKHAN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,125,100,100,60,100],
		:Ability => PBAbilities::PARENTALBOND,
		:Weight => 1000
	}
},

PBSpecies::PINSIR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,155,120,105,65,90],
		:Ability => PBAbilities::AERILATE,
		:Weight => 590,
		:Type2 => PBTypes::FLYING
	}
},

PBSpecies::GYARADOS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
	},

	:DefaultForm => {
		PBItems::GYARADOSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GYARADOSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::BITE],[1,PBMoves::AURORABEAM],[1,PBMoves::WHIRLPOOL],[1,PBMoves::REFLECT],
		[1,PBMoves::THRASH],[1,PBMoves::ROAR],[1,PBMoves::DISABLE],[1,PBMoves::FOCUSENERGY],[1,PBMoves::WRAP],
		[1,PBMoves::BIND],[1,PBMoves::GROWL],[1,PBMoves::BITE],[1,PBMoves::SPLASH],[15,PBMoves::TACKLE],
		[20,PBMoves::LEER],[22,PBMoves::DRAGONRAGE],[23,PBMoves::NUCLEARWASTE],[24,PBMoves::FLAIL],
		[26,PBMoves::RAGE],[28,PBMoves::TWISTER],[29,PBMoves::RADIOACID],[30,PBMoves::SONICBOOM],
		[32,PBMoves::WATERPULSE],[34,PBMoves::SCARYFACE],[36,PBMoves::DRAGONTAIL],[38,PBMoves::BUBBLEBEAM],
		[40,PBMoves::ICEFANG],[42,PBMoves::BRINE],[44,PBMoves::RAINDANCE],[46,PBMoves::HYDROPUMP],
		[48,PBMoves::CRUNCH],[49,PBMoves::PROTONBEAM],[50,PBMoves::HURRICANE],[52,PBMoves::AQUATAIL],
		[54,PBMoves::DRAGONDANCE],[56,PBMoves::WATERFALL],[58,PBMoves::OUTRAGE],[60,PBMoves::HYPERBEAM]]
	},

	"Mega" => {
		:BaseStats => [95,155,109,81,70,130],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 3050,
		:Type2 => PBTypes::DARK
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [95,155,109,81,70,130],
		:Ability => PBAbilities::MOLDBREAKER,
		:Movelist => [[0,PBMoves::BITE],[1,PBMoves::AURORABEAM],[1,PBMoves::WHIRLPOOL],[1,PBMoves::REFLECT],
		[1,PBMoves::THRASH],[1,PBMoves::ROAR],[1,PBMoves::DISABLE],[1,PBMoves::FOCUSENERGY],[1,PBMoves::WRAP],
		[1,PBMoves::BIND],[1,PBMoves::GROWL],[1,PBMoves::BITE],[1,PBMoves::SPLASH],[15,PBMoves::TACKLE],
		[20,PBMoves::LEER],[22,PBMoves::DRAGONRAGE],[23,PBMoves::NUCLEARWASTE],[24,PBMoves::FLAIL],
		[26,PBMoves::RAGE],[28,PBMoves::TWISTER],[29,PBMoves::RADIOACID],[30,PBMoves::SONICBOOM],
		[32,PBMoves::WATERPULSE],[34,PBMoves::SCARYFACE],[36,PBMoves::DRAGONTAIL],[38,PBMoves::BUBBLEBEAM],
		[40,PBMoves::ICEFANG],[42,PBMoves::BRINE],[44,PBMoves::RAINDANCE],[46,PBMoves::HYDROPUMP],
		[48,PBMoves::CRUNCH],[49,PBMoves::PROTONBEAM],[50,PBMoves::HURRICANE],[52,PBMoves::AQUATAIL],
		[54,PBMoves::DRAGONDANCE],[56,PBMoves::WATERFALL],[58,PBMoves::OUTRAGE],[60,PBMoves::HYPERBEAM]],
		:Weight => 3050
	},
},

PBSpecies::AERODACTYL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,135,85,150,70,95],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 1270
	}
},

PBSpecies::MEWTWO => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::MEWTWONITEX => 1,
		PBItems::MEWTWONITEY => 2
	},

	"Mega X" => {
		:BaseStats => [106,190,100,130,154,100],
		:Ability => PBAbilities::STEADFAST,
		:Weight => 1105,
		:Type2 => PBTypes::FIGHTING
	},

	"Mega Y" => {
		:BaseStats => [106,150,70,140,194,120],
		:Ability => PBAbilities::INSOMNIA,
		:Weight => 330
	}
},

PBSpecies::AMPHAROS => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::AMPHAROSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::AMPHAROSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [90,95,105,45,165,110],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 615
	},

	"Mega" => {
		:BaseStats => [90,95,105,45,165,110],
		:Ability => PBAbilities::MOLDBREAKER,
		:Weight => 615,
		:Type2 => PBTypes::DRAGON
	}
},

PBSpecies::SCIZOR => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,150,140,75,65,100],
		:Ability => PBAbilities::TECHNICIAN,
		:Weight => 1250
	}
},

PBSpecies::HERACROSS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,185,115,75,40,105],
		:Ability => PBAbilities::SKILLLINK,
		:Weight => 625
	}
},

PBSpecies::HOUNDOOM => {
	:FormName => {
			1 => "Mega",
			2 => "Nuclear",
			3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::HOUNDOOMINITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::HOUNDOOMINITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [75,90,90,115,140,90],
		:Ability => PBAbilities::SOLARPOWER,
		:Weight => 495
	},

	"Mega" => {
		:BaseStats => [75,90,90,115,140,90],
		:Ability => PBAbilities::SOLARPOWER,
		:Weight => 495
	}
},

PBSpecies::TYRANITAR => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::TYRANITARITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::TYRANITARITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [100,164,150,71,95,120],
		:Ability => PBAbilities::SANDSTREAM,
		:Weight => 2550
	},

	"Mega" => {
		:BaseStats => [100,164,150,71,95,120],
		:Ability => PBAbilities::SANDSTREAM,
		:Weight => 2550
	}
},

PBSpecies::BLAZIKEN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,160,80,115,130,80],
		:Ability => PBAbilities::SPEEDBOOST,
		:Weight => 520
	}
},

PBSpecies::GARDEVOIR => {
	:FormName => {
		1 => "Mega",
		2 => "Void"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::GARDEVOIRITE => 1,
		PBItems::VOIDSTONE => 2
	},

	"Mega" => {
		:BaseStats => [68,85,65,100,165,135],
		:Ability => PBAbilities::PIXILATE,
		:Weight => 484
	},

	"Void" => {
		:BaseStats => [68,110,80,110,175,145],
		:Ability => PBAbilities::DUSKILATE,
		:Weight => 484,
		:Type1 => PBTypes::DARK
	}
},

PBSpecies::MAWILE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,105,125,50,55,95],
		:Ability => PBAbilities::HUGEPOWER,
		:Weight => 235
	}
},

PBSpecies::AGGRON => {
	:FormName => {
			1 => "Mega",
			2 => "Nuclear",
			3 => "MegaNuke",
			4 => "TOTEM"
	},

	:DefaultForm => {
		PBItems::AGGRONITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::AGGRONITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [70,140,230,50,60,80],
		:Ability => PBAbilities::FILTER,
		:Weight => 3950
	},

	"Mega" => {
		:BaseStats => [70,140,230,50,60,80],
		:Ability => PBAbilities::FILTER,
		:Weight => 3950,
		:Type2 => PBTypes::STEEL
	},

	"TOTEM" => {
		:BaseStats => [70,110,180,50,60,60],
		:Ability => [PBAbilities::FILTER]
	},
},

PBSpecies::MEDICHAM => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,100,85,100,80,85],
		:Ability => PBAbilities::PUREPOWER,
		:Weight => 315
	}
},

PBSpecies::MANECTRIC => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,75,80,135,135,80],
		:Ability => PBAbilities::INTIMIDATE,
		:Weight => 440
	}
},

PBSpecies::BANETTE => {
	:FormName => {
		1 => "Mega X",
		2 => "Mega Y"
	},

	:DefaultForm => 0,
	:MegaForm => {
		PBItems::BANETTITEX => 1,
		PBItems::BANETTITEY => 2
	},

	"Mega X" => {
		:BaseStats => [64,165,75,75,93,83],
		:Ability => PBAbilities::PRANKSTER,
		:Weight => 130
	},

	"Mega Y" => {
		:BaseStats => [64,130,75,110,83,83],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Weight => 130
	}
},

PBSpecies::ABSOL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,150,60,115,115,60],
		:Ability => PBAbilities::MAGICBOUNCE,
		:Weight => 490
	}
},

PBSpecies::GARCHOMP => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [108,170,115,92,120,95],
		:Ability => PBAbilities::SANDFORCE,
		:Weight => 950
	}
},

PBSpecies::LUCARIO => { #PORTED
	:FormName => {
		1 => "Rebornian",
		2 => "Mega",
		3 => "Mega Rebornian",
		4 => "Rebornian Ametrine"
	},

	:DefaultForm => {
		PBItems::LUCARIONITE => 0,
		PBItems::LUCARIONITER => 1
	},
	:MegaForm => {
		PBItems::LUCARIONITE => 2,
		PBItems::LUCARIONITER => 3
	},

	"Mega" => {
		:BaseStats => [70,145,88,112,140,70],
		:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 575
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [90,110,90,100,75,60],
		:Ability => [PBAbilities::BATTLEARMOR,PBAbilities::MOXIE,PBAbilities::INNERFOCUS],
		:Movelist => [[1,PBMoves::COPYCAT],[1,PBMoves::DETECT],[1,PBMoves::FEINT],[1,PBMoves::FINALGAMBIT],[1,PBMoves::FORCEPALM],[1,PBMoves::HELPINGHAND],[1,PBMoves::LIFEDEW],[1,PBMoves::METALCLAW],[1,PBMoves::NASTYPLOT],[1,PBMoves::NASTYPLOT],[1,PBMoves::QUICKATTACK],[1,PBMoves::REVERSAL],[1,PBMoves::ROCKSMASH],[1,PBMoves::SCREECH],[1,PBMoves::WORKUP],[12,PBMoves::COUNTER],[16,PBMoves::LASERFOCUS],[20,PBMoves::POWERUPPUNCH],[24,PBMoves::BULKUP],[28,PBMoves::BONEMERANG],[32,PBMoves::QUICKGUARD],[36,PBMoves::BONERUSH],[40,PBMoves::SWORDSDANCE],[44,PBMoves::SHADOWBONE],[48,PBMoves::STOMPINGTANTRUM],[52,PBMoves::DRAINPUNCH],[56,PBMoves::DRILLRUN],[60,PBMoves::CLOSECOMBAT]],
	},

	"Mega Rebornian" => {
		:Type2 => PBTypes::GROUND,
		:BaseStats => [96,131,93,112,121,67],
		:Ability => PBAbilities::ADAPTABILITY,
		:Weight => 575
	},

	"Rebornian Ametrine" => {
		:DexEntry => "This variant of lucario was first discovered when sightings of a lucario was found on ametrine mountain, and a riolu egg was left in an icy cavern. When the riolu hatched, they had no choice but to adapt to the frigid conditions, growing thicker fur and a sharp tail that it uses to hunt for prey or to attack.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [80,80,95,60,130,95],
		:Ability => [PBAbilities::SLUSHRUSH,PBAbilities::FURCOAT,PBAbilities::STEADFAST],
		:Movelist => [[0,PBMoves::ROAR],[0,PBMoves::AURASPHERE],[1,PBMoves::LIFEDEW],[1,PBMoves::LASERFOCUS],[1,PBMoves::FORESIGHT],[1,PBMoves::QUICKATTACK],[1,PBMoves::DETECT],[1,PBMoves::METALCLAW],[6,PBMoves::COUNTER],[11,PBMoves::FEINT],[15,PBMoves::HYPERVOICE],[15,PBMoves::POWERUPPUNCH],[19,PBMoves::SWORDSDANCE],[24,PBMoves::METALSOUND],[29,PBMoves::BONERUSH],[33,PBMoves::QUICKGUARD],[37,PBMoves::ICEBEAM],[37,PBMoves::THUNDERBOLT],[37,PBMoves::MEFIRST],[42,PBMoves::EARTHPOWER],[42,PBMoves::WORKUP],[47,PBMoves::POWERGEM],[47,PBMoves::CALMMIND],[51,PBMoves::HEALPULSE],[55,PBMoves::CLOSECOMBAT],[60,PBMoves::HYDROPUMP],[60,PBMoves::DRAGONPULSE],[60,PBMoves::BLIZZARD],[65,PBMoves::EXTREMESPEED]],
	}
},

PBSpecies::ABOMASNOW => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [90,132,105,30,132,105],
		:Ability => PBAbilities::SNOWWARNING,
		:Weight => 1850
	}
},

PBSpecies::BEEDRILL => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,150,40,145,15,80],
		:Ability => PBAbilities::ADAPTABILITY,
		:Height => 14,
		:Weight => 405
	}
},

PBSpecies::PIDGEOT => {
	:FormName => {
		1 => "Mega",
		2 => "Totem Mega"
	},

	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [83,80,80,121,135,80],
		:Ability => PBAbilities::NOGUARD,
		:Height => 22,
		:Weight => 505
	},

	"Totem Mega" => {
		:BaseStats => [83,80,80,121,135,80],
		:Ability => PBAbilities::NOGUARD,
		:Height => 22,
		:Weight => 505
	}
},

PBSpecies::TREVENANT => {
	:FormName => {1 => "Totem"},

	"Totem" => {
		:BaseStats => [85,110,76,56,65,82],
		:Ability => PBAbilities::HUGEPOWER,
		:Weight => 130
	}
},

PBSpecies::SLOWBRO => {
	:FormName => {
		1 => "Mega",
		2 => "Galarian"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,75,180,30,130,80],
		:Ability => PBAbilities::SHELLARMOR,
		:Height => 20,
		:Weight => 1200
	},

	"Galarian" => {
		:Type1 => PBTypes::POISON,
		:Ability => [PBAbilities::QUICKDRAW,PBAbilities::OWNTEMPO,PBAbilities::REGENERATOR],
		:Movelist => [[0,PBMoves::SHELLSIDEARM],[1,PBMoves::WITHDRAW],[1,PBMoves::SHELLSIDEARM],
			[1,PBMoves::TACKLE],[1,PBMoves::CURSE],[3,PBMoves::GROWL],[6,PBMoves::ACID],[9,PBMoves::YAWN],
			[12,PBMoves::CONFUSION],[15,PBMoves::DISABLE],[18,PBMoves::WATERPULSE],[21,PBMoves::HEADBUTT],
			[24,PBMoves::ZENHEADBUTT],[27,PBMoves::SLACKOFF],[30,PBMoves::RAINDANCE],[33,PBMoves::SURF],
			[36,PBMoves::PSYCHUP],[39,PBMoves::HEALPULSE],[42,PBMoves::AMNESIA],[45,PBMoves::PSYCHIC]]
	}
},

PBSpecies::STEELIX => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
		4 => "Gargantuan"
	},

	:DefaultForm => {
		PBItems::STEELIXITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::STEELIXITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Mega" => {
		:BaseStats => [75,125,230,30,55,95],
		:Ability => PBAbilities::SANDFORCE,
		:Height => 105,
		:Weight => 7400
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [75,125,230,30,55,95],
		:Ability => PBAbilities::SANDFORCE,
		:Height => 105,
		:Weight => 7400
	},

	"Gargantuan" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::SWAMPERT => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [100,150,110,70,90,110],
		:Ability => PBAbilities::SWIFTSWIM,
		:Height => 19,
		:Weight => 1020
	}
},

PBSpecies::SCEPTILE => {
	:FormName => {1 => "Mega",},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,110,75,145,145,85],
		:Ability => PBAbilities::LIGHTNINGROD,
		:Height => 19,
		:Weight => 1020,
		:Type2 => PBTypes::DRAGON
	},
},

PBSpecies::SABLEYE => {
	:FormName => {
		1 => "Mega",
		2 => "Rebornian",
		3 => "Also Rebornian",
	},

	:OnCreation => proc{
		chancemaps=[507] # Map IDs for Rebornian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,85,125,20,85,115],
		:Ability => PBAbilities::MAGICBOUNCE,
		:Height => 5,
		:Weight => 1610
	},

	"Rebornian" => {
		:DexEntry => "According to an old children's book, there was once a Sableye that used to hate taking showers. So, in order to deceive its trainer and escape shower, it entered a Substitute plush to disguise. No one knows where this Sableye form came from, so everybody takes this story for granted.",
		:BaseStats => [110,90,65,30,30,65],
		:Ability => [PBAbilities::KEENEYE,PBAbilities::PRANKSTER,PBAbilities::DISGUISE],
		:Height => 17,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NORMAL,
		:Movelist => [[1, PBMoves::LEER],[3, PBMoves::QUICKATTACK],[4, PBMoves::BABYDOLLEYES],[6, PBMoves::SHADOWSNEAK],[9, PBMoves::FAKEOUT],[11, PBMoves::NIGHTSHADE],[11, PBMoves::FEINTATTACK],[14, PBMoves::FAKETEARS],[16, PBMoves::SNARL],[19, PBMoves::SWIFT],[21, PBMoves::GLARE],[24, PBMoves::SHADOWPUNCH],[24, PBMoves::MACHPUNCH],[26, PBMoves::KNOCKOFF],[29, PBMoves::SUBSTITUTE],[31, PBMoves::CHIPAWAY],[34, PBMoves::SUCKERPUNCH],[36, PBMoves::DAZZLINGGLEAM],[39, PBMoves::FOULPLAY],[42, PBMoves::POWERGEM],[45, PBMoves::BATONPASS],[47, PBMoves::THRASH],[51, PBMoves::RECOVER],[60, PBMoves::NASTYPLOT],[68, PBMoves::PRISMATICLASER]]
	},

	"Also Rebornian" => {
		:BaseStats => [110,90,65,30,30,65],
		:Ability => [PBAbilities::DISGUISE],
		:Height => 17,
		:Weight => 1020,
		:Type1 => PBTypes::GHOST,
		:Type2 => PBTypes::NORMAL
	}
},

PBSpecies::SHARPEDO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,140,70,105,110,65],
		:Ability => PBAbilities::STRONGJAW,
		:Height => 25,
		:Weight => 1303
	}
},

PBSpecies::CAMERUPT => {
	:FormName => {
		1 => "Mega",
		2 => "PULSE"
	},

	:DefaultForm => 0,
	:MegaForm => 1,
	:PulseForm => 2,

	"Mega" => {
		:BaseStats => [70,120,100,20,145,105],
		:Ability => PBAbilities::SHEERFORCE,
		:Height => 25,
		:Weight => 3205
	},

	"PULSE" => {
		:BaseStats => [1,10,10,10,170,10],
		:Ability => PBAbilities::STURDY,
		:Weight => 2707,
		:Type2 => PBTypes::GHOST
	}
},

PBSpecies::ALTARIA => {
	:FormName => {
		1 => "Mega"
	},

	:OnCreation => proc{
		chancemaps=[697,700,710,711,713,714,715,716,797,804,808]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,110,110,80,110,105],
		:Ability => PBAbilities::PIXILATE,
		:Height => 15,
		:Weight => 2060,
		:Type2 => PBTypes::FAIRY
	}
},

PBSpecies::GLALIE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke",
	},

	:DefaultForm => {
		PBItems::GLALITITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GLALITITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [80,120,80,100,120,80],
		:Ability => PBAbilities::REFRIGERATE,
		:Height => 21,
		:Weight => 3502
	},

	"Mega" => {
		:BaseStats => [80,120,80,100,120,80],
		:Ability => PBAbilities::REFRIGERATE,
		:Height => 21,
		:Weight => 3502
	},
},

PBSpecies::SALAMENCE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,145,130,120,120,90],
		:Ability => PBAbilities::AERILATE,
		:Height => 18,
		:Weight => 1125
	}
},

PBSpecies::METAGROSS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,145,150,110,105,110],
		:Ability => PBAbilities::TOUGHCLAWS,
		:Height => 25,
		:Weight => 9429
	}
},

PBSpecies::LATIAS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,100,120,110,140,150],
		:Height => 18,
		:Weight => 520
	}
},

PBSpecies::LATIOS => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,130,100,110,160,120],
		:Height => 23,
		:Weight => 700
	}
},

PBSpecies::RAYQUAZA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,180,100,115,180,100],
		:Ability => PBAbilities::DELTASTREAM,
		:Height => 108,
		:Weight => 3920
	}
},

PBSpecies::ETERNATUS => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [255,115,250,130,125,250],
		:Ability => PBAbilities::PRESSURE,
		:Height => 1080,
		:Weight => 20920
	}
},

PBSpecies::ZACIAN => {
	:FormName => {
		0 => "Uncrowned",
		1 => "King"
	},

	"King" => {
		:DexEntry => "Able to cut down anything with a single strike, it became known as the Fairy King's Sword, and it inspired awe in friend and foe alike.",
		:BaseStats => [92,150,115,148,80,115],
		:Type2 => PBTypes::STEEL,
		:Weight => 3550
	}
},

PBSpecies::ZAMAZENTA => {
	:FormName => {
		0 => "Uncrowned",
		1 => "King"
	},

	"King" => {
		:DexEntry => "Its ability to deflect any attack led to it being known as the Fighting Master's Shield. It was feared and respected by all.",
		:BaseStats => [92,120,140,128,80,140],
		:Type2 => PBTypes::STEEL,
		:Weight => 7850
	}
},

PBSpecies::LOPUNNY => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [65,136,94,135,54,96],
		:Ability => PBAbilities::SCRAPPY,
		:Height => 13,
		:Weight => 283,
		:Type2 => PBTypes::FIGHTING
	}
},

PBSpecies::GALLADE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [68,165,95,110,65,115],
		:Ability => [PBAbilities::INNERFOCUS,PBAbilities::SHARPNESS],
		:Height => 16,
		:Weight => 564
	}
},

PBSpecies::AUDINO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [103,60,126,50,80,126],
		:Ability => PBAbilities::HEALER,
		:Height => 16,
		:Weight => 564,
		:Type2 => PBTypes::FAIRY
	}
},

PBSpecies::DIANCIE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [50,160,110,110,160,110],
		:Ability => PBAbilities::MAGICBOUNCE,
		:Height => 11,
		:Weight => 278
	}
},

PBSpecies::METALYNX => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,140,160,75,70,100],
		:Ability => PBAbilities::HEATPROOF
	}
},

PBSpecies::ARCHILLES => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,125,80,155,125,80],
		:Ability => PBAbilities::DROUGHT
	}
},

PBSpecies::ELECTRUXO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [95,80,105,110,125,135],
		:Ability => PBAbilities::DRIZZLE
	}
},

PBSpecies::EKANS => {
	:FormName => {2 => "Nuclear"},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::WRAP],[1,PBMoves::LEER],[1,PBMoves::POISONSTING],[4,PBMoves::BITE],
		[6,PBMoves::TAILWHIP],[8,PBMoves::ACID],[10,PBMoves::HEADBUTT],[12,PBMoves::GLARE],[17,PBMoves::SCREECH],
		[20,PBMoves::SLAM],[22,PBMoves::RADIOACID],[26,PBMoves::SPITUP],[26,PBMoves::STOCKPILE],
		[26,PBMoves::SWALLOW],[27,PBMoves::NUCLEARWASTE],[30,PBMoves::ACIDSPRAY],[32,PBMoves::MUDBOMB],
		[34,PBMoves::GASTROACID],[38,PBMoves::POISONJAB],[40,PBMoves::TOXIC],[42,PBMoves::SLUDGEBOMB],
		[44,PBMoves::THRASH],[48,PBMoves::BELCH],[52,PBMoves::HAZE],[55,PBMoves::COIL],[60,PBMoves::GUNKSHOT]]
	}
},

PBSpecies::ARBOK => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::ARBOKITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::ARBOKITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[1,PBMoves::CRUNCH],[1,PBMoves::SCARYFACE],[1,PBMoves::REFRESH],[1,PBMoves::SUCKERPUNCH],
		[1,PBMoves::CRUNCH],[1,PBMoves::ICEFANG],[1,PBMoves::THUNDERFANG],[1,PBMoves::FIREFANG],
		[1,PBMoves::SCARYFACE],[1,PBMoves::WRAP],[1,PBMoves::LEER],[1,PBMoves::POISONSTING],[4,PBMoves::BITE],
		[6,PBMoves::TAILWHIP],[8,PBMoves::ACID],[10,PBMoves::HEADBUTT],[12,PBMoves::GLARE],[17,PBMoves::SCREECH],
		[20,PBMoves::SLAM],[22,PBMoves::RADIOACID],[24,PBMoves::DISABLE],[26,PBMoves::SPITUP],
		[26,PBMoves::STOCKPILE],[26,PBMoves::SWALLOW],[27,PBMoves::NUCLEARWASTE],[28,PBMoves::MEGADRAIN],
		[30,PBMoves::ACIDSPRAY],[32,PBMoves::MUDBOMB],[34,PBMoves::GASTROACID],[36,PBMoves::SKULLBASH],
		[38,PBMoves::POISONJAB],[40,PBMoves::TOXIC],[42,PBMoves::SLUDGEBOMB],[44,PBMoves::THRASH],
		[46,PBMoves::LUNGE],[48,PBMoves::BELCH],[50,PBMoves::NUCLEARSLASH],[52,PBMoves::HAZE],[55,PBMoves::COIL],
		[60,PBMoves::GUNKSHOT]]
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [60,130,100,90,65,95],
		:Ability => PBAbilities::PETRIFY,
		:Movelist => [[1,PBMoves::CRUNCH],[1,PBMoves::SCARYFACE],[1,PBMoves::REFRESH],[1,PBMoves::SUCKERPUNCH],
		[1,PBMoves::CRUNCH],[1,PBMoves::ICEFANG],[1,PBMoves::THUNDERFANG],[1,PBMoves::FIREFANG],
		[1,PBMoves::SCARYFACE],[1,PBMoves::WRAP],[1,PBMoves::LEER],[1,PBMoves::POISONSTING],[4,PBMoves::BITE],
		[6,PBMoves::TAILWHIP],[8,PBMoves::ACID],[10,PBMoves::HEADBUTT],[12,PBMoves::GLARE],[17,PBMoves::SCREECH],
		[20,PBMoves::SLAM],[22,PBMoves::RADIOACID],[24,PBMoves::DISABLE],[26,PBMoves::SPITUP],
		[26,PBMoves::STOCKPILE],[26,PBMoves::SWALLOW],[27,PBMoves::NUCLEARWASTE],[28,PBMoves::MEGADRAIN],
		[30,PBMoves::ACIDSPRAY],[32,PBMoves::MUDBOMB],[34,PBMoves::GASTROACID],[36,PBMoves::SKULLBASH],
		[38,PBMoves::POISONJAB],[40,PBMoves::TOXIC],[42,PBMoves::SLUDGEBOMB],[44,PBMoves::THRASH],
		[46,PBMoves::LUNGE],[48,PBMoves::BELCH],[50,PBMoves::NUCLEARSLASH],[52,PBMoves::HAZE],[55,PBMoves::COIL],
		[60,PBMoves::GUNKSHOT]]
	},

	"Mega" => {
		:BaseStats => [60,130,100,90,65,95],
		:Type2 => PBTypes::DARK,
		:Ability => PBAbilities::PETRIFY
	}
},

PBSpecies::BAARIETTE => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::BAARITITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::BAARITITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR,
		:Movelist => [[0,PBMoves::KARATECHOP],[1,PBMoves::VITALTHROW],[1,PBMoves::TAUNT],[1,PBMoves::COUNTER],
		[1,PBMoves::KARATECHOP],[1,PBMoves::SEISMICTOSS],[1,PBMoves::LOWKICK],[1,PBMoves::LEER],
		[7,PBMoves::FOCUSENERGY],[13,PBMoves::STOMP],[15,PBMoves::BEATUP],[19,PBMoves::SCARYFACE],
		[21,PBMoves::NUCLEARSLASH],[25,PBMoves::REVENGE],[27,PBMoves::HALFLIFE],[31,PBMoves::FEINTATTACK],
		[35,PBMoves::SUBMISSION],[37,PBMoves::JUMPKICK],[40,PBMoves::SHADOWBALL],[43,PBMoves::CROSSCHOP],
		[45,PBMoves::ATOMICPUNCH],[47,PBMoves::FOULPLAY],[49,PBMoves::HIJUMPKICK],[51,PBMoves::COMEUPPANCE],
		[53,PBMoves::MEGAPUNCH],[53,PBMoves::MEGAKICK],[55,PBMoves::SUCKERPUNCH],[57,PBMoves::AXEKICK],
		[59,PBMoves::DYNAMICPUNCH]]
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [100,160,107,100,75,103],
		:Ability => PBAbilities::BLOODLUST,
		:Movelist => [[0,PBMoves::KARATECHOP],[1,PBMoves::VITALTHROW],[1,PBMoves::TAUNT],[1,PBMoves::COUNTER],
		[1,PBMoves::KARATECHOP],[1,PBMoves::SEISMICTOSS],[1,PBMoves::LOWKICK],[1,PBMoves::LEER],
		[7,PBMoves::FOCUSENERGY],[13,PBMoves::STOMP],[15,PBMoves::BEATUP],[19,PBMoves::SCARYFACE],
		[21,PBMoves::NUCLEARSLASH],[25,PBMoves::REVENGE],[27,PBMoves::HALFLIFE],[31,PBMoves::FEINTATTACK],
		[35,PBMoves::SUBMISSION],[37,PBMoves::JUMPKICK],[40,PBMoves::SHADOWBALL],[43,PBMoves::CROSSCHOP],
		[45,PBMoves::ATOMICPUNCH],[47,PBMoves::FOULPLAY],[49,PBMoves::HIJUMPKICK],[51,PBMoves::COMEUPPANCE],
		[53,PBMoves::MEGAPUNCH],[53,PBMoves::MEGAKICK],[55,PBMoves::SUCKERPUNCH],[57,PBMoves::AXEKICK],
		[59,PBMoves::DYNAMICPUNCH]]
	},

	"Mega" => {
		:BaseStats => [100,160,107,100,75,103],
		:Ability => PBAbilities::BLOODLUST
	}
},

PBSpecies::DRILGANN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,180,88,84,60,88],
		:Ability => [PBAbilities::SANDRUSH,PBAbilities::SANDFORCE]
	}
},

PBSpecies::S51A => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,95,90,110,150,90],
		:Ability => PBAbilities::MEGALAUNCHER
	}
},

PBSpecies::INFLAGETAH => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:DefaultForm => {
		PBItems::INFLAGETITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::INFLAGETITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [85,145,80,175,85,85],
		:Ability => PBAbilities::ACCELERATION
	},

	"Mega" => {
		:BaseStats => [85,145,80,175,85,85],
		:Ability => PBAbilities::ACCELERATION
	}
},

PBSpecies::SYRENTIDE => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [98,68,128,88,118,158],
		:Ability => PBAbilities::PIXILATE
	}
},

PBSpecies::GARGRYPH => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
 	:MegaForm => 1,

	"Mega" => {
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [70,105,70,150,130,115],
		:Ability => PBAbilities::WONDERSKIN
	}
},

PBSpecies::DRAMSAMA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [85,85,80,120,145,85],
		:Ability => PBAbilities::BADDREAMS
	}
},

PBSpecies::KIRICORN => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [80,123,72,128,127,80],
		:Ability => PBAbilities::MAGICBOUNCE
	}
},

PBSpecies::WHIMSICOTT => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [60,67,105,136,117,95],
		:Ability => [PBAbilities::REGENERATOR,PBAbilities::PRANKSTER]
	}
},

PBSpecies::NUCLEON => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [105,80,70,75,150,140],
		:Ability => PBAbilities::ATOMIZATE
	}
},

###################### Gigantamax ##########################

PBSpecies::BUTTERFREE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [60,30,60,125,140,80],
		:Ability => PBAbilities::TINTEDLENS
	}
},

PBSpecies::MACHAMP => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [105,170,100,75,50,105],
		:Ability => PBAbilities::NOGUARD
	}
},

PBSpecies::KINGLER => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [75,150,130,100,50,70],
		:Ability => PBAbilities::TOUGHCLAWS
	}
},

PBSpecies::SNORLAX => {
	:FormName => {
		1 => "Dyna",
		2 => "Rebornian"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [160,140,95,20,75,150],
		:Ability => PBAbilities::THICKFAT
	},

	"Rebornian" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [168,42,105,68,70,87],
		:Ability => [PBAbilities::IMMUNITY,PBAbilities::THICKFAT,PBAbilities::GLUTTONY],
		:Movelist => [[1,PBMoves::TACKLE],[4,PBMoves::DEFENSECURL],[9,PBMoves::AMNESIA],[12,PBMoves::LICK],[17,PBMoves::CHIPAWAY],[20,PBMoves::YAWN],[25,PBMoves::BODYSLAM],[28,PBMoves::REST],[28,PBMoves::SNORE],[33,PBMoves::SLEEPTALK],[35,PBMoves::GIGAIMPACT],[36,PBMoves::ROLLOUT],[41,PBMoves::BLOCK],[44,PBMoves::BELLYDRUM],[49,PBMoves::CRUNCH],[50,PBMoves::HEAVYSLAM],[57,PBMoves::EARTHPOWER]]
	}
},

PBSpecies::LAPRAS => {
	:FormName => {
		1 => "Dyna",
		2 => "Rebornian",
		3 => "Dyna Rebornian"
	},

	:OnCreation => proc{
		mapNewLapras=[586] # Map IDs for Rebornian form
		next $game_map && mapNewLapras.include?($game_map.map_id) ? 2 : 0
	},

	:DefaultForm => 0, #Not really
	:MegaForm => proc{|pokemon|
		next [1,3] if pokemon == "getAll"
		next pokemon.form == 2 ? 3 : 1
	},

	"Dyna" => {
		:BaseStats => [150,115,105,75,90,100],
		:Ability => PBAbilities::REFRIGERATE
	},

	"Rebornian" => {
		:DexEntry => "This species of lapras were first discovered near frozen polluted rivers making them adapt their body to survive the low temperatures and the polluted habitat. Its spikes contain a deadly poison capable of killing its prey in a minute. The stripes on their skin are caused due to them unconciously perfurating themselves but due to their poisonous resistancy it leaves those stripes as scars.",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::POISON,
		:BaseStats => [120,75,70,110,105,80],
		:Ability => [PBAbilities::REFRIGERATE,PBAbilities::REGENERATOR,PBAbilities::SNOWWARNING],
		:Movelist => [[1,PBMoves::SING],[1,PBMoves::CALMMIND],[1,PBMoves::ICYWIND],[1,PBMoves::GROWL],[1,PBMoves::WATERGUN],[4,PBMoves::MIST],[7,PBMoves::CONFUSERAY],[10,PBMoves::ICESHARD],[14,PBMoves::ACIDARMOR],[14,PBMoves::WATERPULSE],[15,PBMoves::LIFEDEW],[18,PBMoves::BODYSLAM],[19,PBMoves::ACIDSPRAY],[20,PBMoves::AVALANCHE],[22,PBMoves::DISABLE],[27,PBMoves::THUNDERBOLT],[27,PBMoves::PERISHSONG],[32,PBMoves::REFLECT],[32,PBMoves::LIGHTSCREEN],[32,PBMoves::ICEBEAM],[34,PBMoves::FLASHCANNON],[35,PBMoves::SLUDGEBOMB],[37,PBMoves::BRINE],[43,PBMoves::MIRRORCOAT],[43,PBMoves::SAFEGUARD],[47,PBMoves::HYDROPUMP],[47,PBMoves::SHADOWBALL],[47,PBMoves::VENOSHOCK],[50,PBMoves::TOXICSPIKES],[50,PBMoves::THUNDERWAVE],[50,PBMoves::SIGNALBEAM],[60,PBMoves::POWERGEM],[70,PBMoves::DRAGONPULSE],[80,PBMoves::RECOVER],[80,PBMoves::SHEERCOLD]]
	},

	"Dyna Rebornian" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::POISON,
		:BaseStats => [140,105,95,125,110,85],
		:Ability => PBAbilities::REFRIGERATE
	}
},

PBSpecies::RILLABOOM => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [130,140,110,95,60,90],
		:Ability => PBAbilities::GRASSYSURGE
	}
},

PBSpecies::INTELEON => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [80,115,75,130,155,75],
		:Ability => PBAbilities::DRIZZLE
	}
},

PBSpecies::CINDERACE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [80,156,85,139,85,85],
		:Ability => PBAbilities::LIBERO
	}
},

PBSpecies::PIKACHU => {
	:FormName => {
		2 => "Partner",
		3 => "Dyna",
		4 => "Rock Star",
		5 => "Pop Star",
		6 => "Libre",
		7 => "PhD",
		8 => "Belle"
	},

	:DefaultForm => 0,
	:MegaForm => 3,

	"Partner" => {
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::MOLDBREAKER],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
			[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
			[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
			[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
			[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
			[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
			[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
			[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
			[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
			[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
			[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
			[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
			[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Dyna" => {
		:BaseStats => [85,80,50,100,115,100],
		:Ability => PBAbilities::SIMPLE
	},
	"Rock Star" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::STEEL,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::GUTS],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
		[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
		[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
		[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
		[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
		[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
		[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
		[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
		[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
		[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
		[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
		[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Pop Star" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::TRIAGE],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
		[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
		[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
		[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
		[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
		[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
		[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
		[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
		[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
		[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
		[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
		[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Libre" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::HUGEPOWER],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
		[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
		[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
		[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
		[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
		[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
		[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
		[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
		[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
		[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
		[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
		[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"PhD" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::PSYCHIC,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::TECHNICIAN],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
		[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
		[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
		[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
		[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
		[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
		[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
		[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
		[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
		[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
		[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
		[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	},
	"Belle" => {
		:Type1 => PBTypes::ELECTRIC,
		:Type2 => PBTypes::ICE,
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::SERENEGRACE],
		:Movelist => [[1,PBMoves::ZIPPYZAP],[1,PBMoves::FLOATYFALL],[1,PBMoves::SPLISHYSPLASH],
		[1,PBMoves::PIKAPAPOW],[1,PBMoves::EXTREMESPEED],[1,PBMoves::ICICLECRASH],
		[1,PBMoves::ELECTRICTERRAIN],[1,PBMoves::FLYINGPRESS],[1,PBMoves::DRAININGKISS],
		[1,PBMoves::HEARTSTAMP],[1,PBMoves::METEORMASH],[1,PBMoves::LEER],[1,PBMoves::TACKLE],
		[1,PBMoves::SING],[1,PBMoves::YAWN],[1,PBMoves::SCRATCH],[1,PBMoves::TAILWHIP],
		[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::GROWL],[3,PBMoves::PLAYNICE],
		[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::DOUBLEKICK],
		[11,PBMoves::NUZZLE],[13,PBMoves::SANDATTACK],[15,PBMoves::QUICKATTACK],
		[17,PBMoves::FOCUSENERGY],[19,PBMoves::DOUBLETEAM],[21,PBMoves::SWIFT],
		[23,PBMoves::ELECTROBALL],[25,PBMoves::SLAM],[27,PBMoves::SPARK],[29,PBMoves::FEINT],
		[31,PBMoves::SLASH],[33,PBMoves::DISCHARGE],[35,PBMoves::AGILITY],
		[37,PBMoves::THUNDERBOLT],[41,PBMoves::IRONTAIL],[43,PBMoves::WILDCHARGE],
		[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::LIGHTSCREEN]],
		:GetEvo => []
	}
},

PBSpecies::PICHU => {
	:FormName => {1 => "Spiky-Eared"},

	"Spiky-Eared" => {
		:BaseStats => [45,80,50,110,75,60],
		:Ability => [PBAbilities::STATIC,PBAbilities::LIGHTNINGROD,PBAbilities::SEQUENCE,PBAbilities::MOODMAKER,PBAbilities::MOTORDRIVE],
		:Movelist => [[1,PBMoves::THUNDERSHOCK],[1,PBMoves::CHARM],[1,PBMoves::TAILWHIP],[3,PBMoves::PLAYNICE],
			[5,PBMoves::THUNDERWAVE],[7,PBMoves::SWEETKISS],[9,PBMoves::HELPINGHAND],[11,PBMoves::NUZZLE],[13,PBMoves::CHARGE],
			[15,PBMoves::QUICKATTACK],[17,PBMoves::ENDURE],[21,PBMoves::SWIFT],[25,PBMoves::SWAGGER],[27,PBMoves::SPARK],[31,PBMoves::DIZZYPUNCH],
			[33,PBMoves::THUNDERBOLT],[35,PBMoves::AGILITY],[37,PBMoves::TEETERDANCE],[39,PBMoves::PAINSPLIT],[41,PBMoves::IRONTAIL],
			[43,PBMoves::ENDEAVOR],[45,PBMoves::NASTYPLOT],[47,PBMoves::THUNDER],[50,PBMoves::PETALDANCE],[55,PBMoves::VOLTTACKLE]],
		:GetEvo => []
	}
},

PBSpecies::EEVEE => {
	:FormName => {
		1 => "Dyna",
		2 => "Partner"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [80,100,70,100,100,80],
		:Ability => PBAbilities::ADAPTABILITY
	},
	"Partner" => {
		:BaseStats => [65,75,70,75,65,85],
		:Ability => [PBAbilities::PROTEAN,PBAbilities::ADAPTABILITY,PBAbilities::ANTICIPATION,
			PBAbilities::TELEPATHY,PBAbilities::RUNAWAY],
		:Movelist => [[1,PBMoves::BUZZYBUZZ],[1,PBMoves::SIZZLYSLIDE],[1,PBMoves::BOUNCYBUBBLE],
			[1,PBMoves::BADDYBAD],[1,PBMoves::GLITZYGLOW],[1,PBMoves::SAPPYSEED],[1,PBMoves::FREEZYFROST],
			[1,PBMoves::SPARKLYSWIRL],[1,PBMoves::VEEVEEVOLLEY],[1,PBMoves::HELPINGHAND],[1,PBMoves::GROWL],
			[1,PBMoves::TACKLE],[1,PBMoves::TAILWHIP],[5,PBMoves::SANDATTACK],[7,PBMoves::BABYDOLLEYES],
			[9,PBMoves::FOCUSENERGY],[11,PBMoves::COPYCAT],[13,PBMoves::MUDSLAP],[16,PBMoves::QUICKATTACK],
			[19,PBMoves::DOUBLEKICK],[21,PBMoves::BITE],[23,PBMoves::COVET],[25,PBMoves::REFRESH],
			[27,PBMoves::SWIFT],[29,PBMoves::MIMIC],[31,PBMoves::TRUMPCARD],[33,PBMoves::TAKEDOWN],
			[35,PBMoves::CHARM],[37,PBMoves::BATONPASS],[39,PBMoves::CALMMIND],[41,PBMoves::DOUBLEEDGE],
			[45,PBMoves::LASTRESORT]],
		:GetEvo => []
	}
},

PBSpecies::MELMETAL => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [135,183,163,45,85,85],
		:Ability => PBAbilities::IRONFIST
	}
},

PBSpecies::CORVIKNIGHT => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [98,122,145,67,53,110],
		:Ability => PBAbilities::MIRRORARMOR
	}
},

PBSpecies::ORBEETLE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [60,75,130,105,95,140],
		:Ability => PBAbilities::PSYCHICSURGE
	}
},

PBSpecies::DREDNAW => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::DREDNAWTITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::DREDNAWTITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [90,155,110,94,48,88],
		:Ability => PBAbilities::STRONGJAW,
	},

	"Dyna" => {
		:BaseStats => [90,155,110,94,48,88],
		:Ability => PBAbilities::STRONGJAW
	}
},

PBSpecies::COALOSSAL => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::COALOSSITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::COALOSSITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [110,135,150,35,80,100],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 6200
	},

	"Dyna" => {
		:BaseStats => [110,135,150,35,80,100],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 6200
	}
},

PBSpecies::FLAPPLE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [70,130,105,90,110,80],
		:Ability => PBAbilities::OWNTEMPO
	}
},

PBSpecies::APPLETUN => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [110,95,110,20,140,110],
		:Ability => PBAbilities::THICKFAT
	}
},

PBSpecies::SANDACONDA => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::SANDACONDITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::SANDACONDITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [92,107,135,81,105,90],
		:Ability => PBAbilities::SANDRUSH,
	},

	"Dyna" => {
		:BaseStats => [72,127,125,91,105,90],
		:Ability => PBAbilities::SANDSTREAM
	}
},

PBSpecies::CENTISKORCH => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::CENTISKORCHITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::CENTISKORCHITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [110,135,85,115,90,90],
		:Ability => PBAbilities::FLASHFIRE,
	},

	"Dyna" => {
		:BaseStats => [110,135,85,115,90,90],
		:Ability => PBAbilities::FLASHFIRE,
	}
},

PBSpecies::GRIMMSNARL => {
	:FormName => {
			1 => "Dyna",
			2 => "Nuclear",
			3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::GRIMMSNARLITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GRIMMSNARLITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [115,140,95,80,75,105],
		:Ability => PBAbilities::PRANKSTER,
	},

	"Dyna" => {
		:BaseStats => [115,140,95,80,75,105],
		:Ability => PBAbilities::PRANKSTER
	}
},

PBSpecies::HATTERENE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [97,80,115,29,166,123],
		:Ability => PBAbilities::MAGICBOUNCE
	}
},

PBSpecies::ALCREMIE => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [95,60,95,74,130,141],
		:Ability => PBAbilities::SWEETVEIL
	}
},

PBSpecies::COPPERAJAH => {
	:FormName => {
		1 => "Dyna",
		2 => "Nuclear",
		3 => "DynaNuke"
	},

	:DefaultForm => {
		PBItems::COPPERITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::COPPERITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Nuclear" => { 
		:Type2 => PBTypes::NUCLEAR
	},

	"DynaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [142,160,99,30,80,89],
		:Ability => PBAbilities::HEAVYMETAL,
		:Weight => 13000
	},

	"Dyna" => {
		:BaseStats => [142,160,99,30,80,89],
		:Ability => PBAbilities::HEAVYMETAL,
		:Weight => 13000
	}
},

PBSpecies::TOXTRICITY => {
	:FormName => {
		0 => "Amped",
		1 => "Low Key",
		2 => "Dyna"
	},
	:OnCreation => proc{rand(2)},

	:DefaultForm => 0, #Not really
	:MegaForm => 2,

	"Dyna" => {
		:BaseStats => [105,98,80,105,134,80],
		:Ability => PBAbilities::GALVANIZE
	},

	"Low Key" => {
		:DexEntry => "Many youths admire the way this Pokémon listlessly picks fights and keeps its cool no matter what opponent it faces.",
		:Ability => [PBAbilities::PUNKROCK,PBAbilities::MINUS,PBAbilities::TECHNICIAN]
	}
},

PBSpecies::DURALUDON => {
	:FormName => {1 => "Dyna"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Dyna" => {
		:BaseStats => [100,95,115,75,160,90],
		:Ability => PBAbilities::MAGICGUARD
	}
},

PBSpecies::URSHIFU => {
	:FormName => {
		1 => "Rapid Strike",
		2 => "Dyna X",
		3 => "Dyna Y"
	},

	:DefaultForm => {
		PBItems::URSHIFITEX => 0,
		PBItems::URSHIFITEY => 1
	},
	:MegaForm => {
		PBItems::URSHIFITEX => 2,
		PBItems::URSHIFITEY => 3
	},

	"Rapid Strike" => {
		:DexEntry => "It's believed that this Pokémon modeled its fighting style on the flow of a river—sometimes rapid, sometimes calm.",
		:Type2 => PBTypes::WATER
	},

	"Dyna X" => {
		:BaseStats => [120,165,120,107,63,75]
	},

	"Dyna Y" => {
		:Type2 => PBTypes::WATER,
		:BaseStats => [100,150,100,127,63,110]
	}
},

PBSpecies::URAYNE => {
	:FormName => {1 => "Gamma"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Gamma" => {
		:BaseStats => [125,140,110,130,155,105],
		:Ability => PBAbilities::CHERNOBYL
	}
},

###################### PULSE Forms ######################

PBSpecies::GARBODOR => {
	:FormName => {
		1 => "Mega",
		2 => "Nuclear",
		3 => "MegaNuke"
	},

	:OnCreation => proc{
		chancemaps=[875,894]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
 	},

	:DefaultForm => {
		PBItems::GARBODORITE => 0,
		PBItems::FUSIONREACTOR => 2
	},
	:MegaForm => {
		PBItems::GARBODORITE => 1,
		PBItems::FUSIONREACTOR => 3
	},

	"Mega" => {
		:BaseStats => [80,135,107,85,60,107],
		:Ability => PBAbilities::GOOEY,
		:Height => 6033,
		:Weight => 2366
	},

	"MegaNuke" => {
		:Type2 => PBTypes::NUCLEAR,
		:BaseStats => [80,135,107,85,60,107],
		:Ability => PBAbilities::GOOEY,
		:Height => 6033,
		:Weight => 2366
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::TANGROWTH => {
	:FormName => {
		1 => "PULSE C",
		2 => "PULSE B",
		3 => "PULSE A"
	},

	:OnCreation => proc{
		maps=[281]
		chancemaps=[825,840,894]
		if $game_map && maps.include?($game_map.map_id)
			next 4
		elsif $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(3)
			next randomnum==0 ? 4 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		v = 1
		for move in pokemon.moves
			if move.type == PBTypes::POISON
				break
			elsif move.type == PBTypes::GROUND
				v = 2; break
			elsif move.type == PBTypes::ROCK
				v = 3; break
			end
		end
		next v
	},

	"PULSE C" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::FILTER,
		:Weight => 2675,
		:Type2 => PBTypes::POISON
	},

	"PULSE B" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::ARENATRAP,
		:Weight => 2675,
		:Type2 => PBTypes::GROUND
	},

	"PULSE A" => {
		:BaseStats => [100,70,200,10,70,160],
		:Ability => PBAbilities::STAMINA,
		:Weight => 2675,
		:Type2 => PBTypes::ROCK
	}
},

PBSpecies::ABRA => {
	:FormName => {
		1 => "PULSE",
		2 => "PULSE"
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		next pokemon.happiness==255 ? 2 : 1
	},

	"PULSE" => {
		:BaseStats => [25,20,115,140,195,155],
		:Ability => PBAbilities::MAGICGUARD,
		:Weight => 862,
		:Type2 => PBTypes::STEEL
	}
},

PBSpecies::AVALUGG => {
	:FormName => {
		1 => "PULSE",
		2 => "Hisui"
	},

	:OnCreation => proc{
		chancemaps=[749,750,870,894] # Map IDs for Hisuian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [105,160,255,10,97,255],
		:Ability => PBAbilities::SOLIDROCK,
		:Weight => 8780
	},

	"Hisui" => {
		:DexEntry => "The armor of ice covering its lower jaw puts steel to shame and can shatter rocks with ease. This Pokémon barrels along steep mountain paths, cleaving through the deep snow.",
		:Type2 => PBTypes::ROCK,
		:BaseStats => [95,127,184,38,34,36],
		:Ability => [PBAbilities::STRONGJAW,PBAbilities::STURDY,PBAbilities::ICEBODY],
		:Movelist => [[0,PBMoves::WIDEGUARD],[1,PBMoves::WIDEGUARD],[1,PBMoves::TACKLE],[3,PBMoves::HARDEN],
			[5,PBMoves::SHARPEN],[10,PBMoves::BITE],[12,PBMoves::POWDERSNOW],[15,PBMoves::RAPIDSPIN],
			[18,PBMoves::ICESHARD],[20,PBMoves::TAKEDOWN],[22,PBMoves::ICYWIND],[24,PBMoves::CURSE],
			[26,PBMoves::PROTECT],[30,PBMoves::ICEBALL],[33,PBMoves::IRONDEFENSE],[35,PBMoves::ICEFANG],
			[37,PBMoves::BLIZZARD],[39,PBMoves::CRUNCH],[41,PBMoves::EARTHPOWER],[43,PBMoves::RECOVER],
			[47,PBMoves::AVALANCHE],[49,PBMoves::ROCKSLIDE],[51,PBMoves::DOUBLEEDGE],[56,PBMoves::MOUNTAINGALE],
			[101,PBMoves::MIGHTYCLEAVE]],
		:Weight => 2624,
		:WildItemRare => :EXPCANDYM
	}
},

PBSpecies::SWALOT => {
	:FormName => {1 => "PULSE"},
	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [100,73,210,40,110,210],
		:Ability => PBAbilities::WATERABSORB,
		:Weight => 4621,
		:Type2 => PBTypes::WATER
	}
},

PBSpecies::MAGNEZONE => {
	:FormName => {
		1 => "PULSE"
	},

	:OnCreation => proc{
		chancemaps=[894]
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
 	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [70,70,160,70,230,140],
		:Ability => PBAbilities::LEVITATE,
		:Weight => 1673
	}
},

PBSpecies::HYPNO => {
	:FormName => {
		1 => "PULSE",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:PulseForm => 1,
	:MegaForm => 2,

	"PULSE" => {
		:BaseStats => [120,65,190,80,125,225],
		:Ability => PBAbilities::NOGUARD,
		:Weight => 208,
		:Type2 => PBTypes::DARK
	},

	"Mega" => {
		:BaseStats => [95,73,70,97,123,125],
		:Type2 => PBTypes::GHOST,
		:Ability => PBAbilities::NEUROFORCE
	}
},

PBSpecies::CLAWITZER => {
	:FormName => {1 => "PULSE"},
	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [252,1,60,252,120,70],
		:Ability => PBAbilities::CONTRARY,
		:Weight => 573,
		:Type2 => PBTypes::DRAGON
	}
},

PBSpecies::MRMIME => {
	:FormName => {
		1 => "PULSE",
		2 => "Galarian"
	},

	:OnCreation => proc{
		chancemaps=[526,866,894] # Map IDs for Galarian form
		if $game_map && chancemaps.include?($game_map.map_id)
			randomnum = rand(2)
			next randomnum==0 ? 2 : 0
		else
			next 0
		end
	},

	:DefaultForm => 0,
	:PulseForm => 1,

	"PULSE" => {
		:BaseStats => [252,1,190,252,1,190],
		:Ability => PBAbilities::WONDERGUARD,
		:Weight => 483,
		:Type1 => PBTypes::DARK,
		:Type2 => PBTypes::GHOST
	},

	"Galarian" => {
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::PSYCHIC,
		:EVs => [0,0,0,2,0,0],
		:BaseStats => [50,65,65,100,90,90],
		:Ability => [PBAbilities::VITALSPIRIT,PBAbilities::SCREENCLEANER,PBAbilities::STRONGHEEL,PBAbilities::ICEBODY],
		:Movelist => [[1,PBMoves::MISTYTERRAIN],[1,PBMoves::ICESHARD],[1,PBMoves::RAPIDSPIN],
			[1,PBMoves::ALLYSWITCH],[1,PBMoves::DOUBLEKICK],[1,PBMoves::MIRRORCOAT],[1,PBMoves::TICKLE],
			[1,PBMoves::CONFUSION],[1,PBMoves::BARRIER],[1,PBMoves::POUND],[4,PBMoves::COPYCAT],
			[8,PBMoves::MEDITATE],[10,PBMoves::ENCORE],[12,PBMoves::PROTECT],[14,PBMoves::DOUBLESLAP],
			[16,PBMoves::MIMIC],[20,PBMoves::HYPNOSIS],[22,PBMoves::REFLECT],[22,PBMoves::LIGHTSCREEN],
			[22,PBMoves::SAFEGUARD],[24,PBMoves::PSYBEAM],[26,PBMoves::ICYWIND],[29,PBMoves::RECYCLE],
			[32,PBMoves::TRICK],[34,PBMoves::IRONDEFENSE],[36,PBMoves::ROLEPLAY],[38,PBMoves::SUBSTITUTE],
			[40,PBMoves::BATONPASS],[42,PBMoves::ZENHEADBUTT],[44,PBMoves::CALMMIND],[46,PBMoves::SUCKERPUNCH],
			[48,PBMoves::DAZZLINGGLEAM],[48,PBMoves::FREEZEDRY],[50,PBMoves::PSYCHIC],
			[52,PBMoves::TEETERDANCE]],
		:EggMoves => [PBMoves::CHARM,PBMoves::CONFUSERAY,PBMoves::FAKEOUT,PBMoves::FOLLOWME,
			PBMoves::FUTURESIGHT,PBMoves::HEALINGWISH,PBMoves::HYPNOSIS,PBMoves::ICYWIND,PBMoves::LOVELYKISS,
			PBMoves::MAGICROOM,PBMoves::MIMIC,PBMoves::MINDREADER,PBMoves::MOONBLAST,PBMoves::NASTYPLOT,
			PBMoves::PERISHSONG,PBMoves::POWERSPLIT,PBMoves::POWERWHIP,PBMoves::PSYCHICTERRAIN,PBMoves::PURSUIT,
			PBMoves::QUICKATTACK,PBMoves::SMOG,PBMoves::SONICBOOM,PBMoves::TEETERDANCE,PBMoves::TICKLE,
			PBMoves::TRICK,PBMoves::WAKEUPSLAP],
		:GetEvo => [[PBSpecies::MRRIME,PBEvolution::Level,42]]
	}
},

PBSpecies::ARCEUS => {
	:FormName => {
		21 => "PULSE",
		22 => "PULSE",
		23 => "PULSE",
		24 => "PULSE",
		25 => "PULSE",
		26 => "PULSE",
		27 => "PULSE",
		28 => "PULSE",
		29 => "PULSE",
		30 => "PULSE",
		31 => "PULSE",
		32 => "PULSE",
		33 => "PULSE",
		34 => "PULSE",
		35 => "PULSE",
		36 => "PULSE",
		37 => "PULSE",
		38 => "PULSE",
		39 => "PULSE",
		40 => "PULSE",
		41 => "PULSE"
	},

	:DefaultForm => 0,
	:PulseForm => proc{|pokemon|
		next pokemon.form+21
	},

	"PULSE" => {
		:BaseStats => [255,125,155,160,125,155],
		:Weight => 9084,
	}
},

###################### Misc Forms ######################

PBSpecies::KECLEON => {
	:FormName => {
		1 => "Purple",
		2 => "Nuclear"
	},

	"Purple" => {
		:BaseStats => [130,120,90,95,60,130]
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::BRELOOM => {
	:FormName => {
		1 => "Bot",
		2 => "Mega"
	},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Bot" => {
		:BaseStats => [210,160,140,100,60,100],
		:Weight => 5328,
		:Type1 => PBTypes::STEEL,
		:Ability => [PBAbilities::AUTOMATRON]
	},

	"Mega" => {
		:BaseStats => [80,145,80,105,70,80],
		:Ability => [PBAbilities::NOGUARD],
	}
},

###################### Deso Megas ################################

PBSpecies::MIGHTYENA => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [70,125,70,125,60,70],
		:Ability => PBAbilities::STRONGJAW,
		:Type2 => PBTypes::GHOST
	}
},

PBSpecies::DARKRAI => {
	:FormName => {1 => "Perfection"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Perfection" => {
		:BaseStats => [70,90,95,170,165,100],
		:Ability => PBAbilities::BADDREAMS,
		:Type2 => PBTypes::GHOST,
		:Weight => 1011
	}
},

PBSpecies::TOXICROAK => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [83,136,70,115,116,70],
		:Ability => PBAbilities::ADAPTABILITY
	}
},

PBSpecies::CINCCINO => {
	:FormName => {1 => "Mega"},
	:DefaultForm => 0,
	:MegaForm => 1,

	"Mega" => {
		:BaseStats => [75,125,110,135,40,80],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::SKILLLINK
	}
},

PBSpecies::UMBREON => {
	:FormName => {
		1 => "Perfection",
		2 => "Nuclear"
	},

	:DefaultForm => 0,
	:MegaForm => 1,

	"Perfection" => {
		:BaseStats => [95,75,130,75,120,130],
		:Type2 => PBTypes::PSYCHIC,
		:Ability => PBAbilities::MAGICBOUNCE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

########################## Totem Forms ###########################

PBSpecies::AMBIPOM => {
	:FormName => {1 => "TOTEM"},

	"TOTEM" => {
		:BaseStats => [75,100,66,115,60,66],
		:Ability => [PBAbilities::TECHNICIAN]
	}
},

PBSpecies::CRUSTLE => {
	:FormName => {1 => "TOTEM"},

	"TOTEM" => {
		:BaseStats => [70,105,125,45,65,75],
		:Ability => [PBAbilities::WEAKARMOR]
	}
},

###################### Developer Team Forms ######################

PBSpecies::GLACEON => {
	:FormName => {
		1 => "Mismageon",
		2 => "Nuclear"
	},

	"Mismageon" => {
		:BaseStats => [65,60,110,105,130,105],
		:Type2 => PBTypes::GHOST
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},

PBSpecies::CINCCINO => {
	:FormName => {1 => "Meech"},

	"Meech" => {
		:BaseStats => [75,125,110,135,40,80],
		:Type2 => PBTypes::FAIRY,
		:Ability => PBAbilities::SKILLLINK
	}
},

PBSpecies::GOLURK => {
	:FormName => {1 => "Rebornian"},

	"Rebornian" => {
		:BaseStats => [89,131,85,55,40,85],
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::GROUND,
		:Ability => [PBAbilities::DRYSKIN,PBAbilities::NOGUARD,PBAbilities::FLAMEBODY],
		:Movelist => [[0,PBMoves::HIGHHORSEPOWER],[1,PBMoves::FOCUSPUNCH],[1,PBMoves::MUDSLAP],[1,PBMoves::FLAMEWHEEL],
					 [1,PBMoves::DEFENSECURL],[1,PBMoves::POUND],[12,PBMoves::FLAMECHARGE],[16,PBMoves::CURSE],
					 [20,PBMoves::FIREPUNCH],[24,PBMoves::STOMPINGTANTRUM],[28,PBMoves::IRONDEFENSE],[32,PBMoves::MEGAPUNCH],
					 [36,PBMoves::HEATCRASH],[40,PBMoves::HEAVYSLAM],[46,PBMoves::FLAREBLITZ],[50,PBMoves::RAGINGFURY],
					 [52,PBMoves::HAMMERARM],[58,PBMoves::EARTHQUAKE],[64,PBMoves::DYNAMICPUNCH]],
		:EggMoves => [PBMoves::BURNINGJEALOUSY,PBMoves::SCORCHINGSANDS,PBMoves::HEADLONGRUSH],
		:Weight => 350,
		:Height => 28
	}
},

PBSpecies::RIOLU => {
	:FormName => {1 => "Rebornian"},

	:OnCreation => proc{
		maps=[384,430] # Map IDs for Rebornian form: Celestinine Mountain 2F
		next $game_map && maps.include?($game_map.map_id) ? 1 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIGHTING,
		:Type2 => PBTypes::GROUND,
		:BaseStats => [40,70,50,70,25,30],
		:Ability => [PBAbilities::JUSTIFIED,PBAbilities::MOXIE,PBAbilities::LONGREACH],
		:Movelist => [[1,PBMoves::ENDURE],[1,PBMoves::QUICKATTACK],[4,PBMoves::FEINT],[8,PBMoves::MACHPUNCH],[12,PBMoves::COUNTER],[16,PBMoves::BULLDOZE],[20,PBMoves::ROCKSMASH],[24,PBMoves::SANDATTACK],[28,PBMoves::BONECLUB],[32,PBMoves::QUICKGUARD],[36,PBMoves::FORCEPALM],[40,PBMoves::SWORDSDANCE],[44,PBMoves::HELPINGHAND],[48,PBMoves::COPYCAT],[52,PBMoves::FINALGAMBIT],[56,PBMoves::REVERSAL]],
	}
},

PBSpecies::GRENINJA => {
	:FormName => {
		1 => "BattleBond",
	},

	"BattleBond" => {
		:BaseStats => [72,145,67,132,153,71],
		:Ability => PBAbilities::SHARPNESS,
		:Weight => 40
	},
},

PBSpecies::LARVESTA => {
	:FormName => {1 => "Cosmic"},

	"Cosmic" => {
		:DexEntry => ".",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::DARK,
		:BaseStats => [55,85,55,60,50,55],
		:Ability => [PBAbilities::ELEMENTALIST,PBAbilities::DARKAURA,PBAbilities::DUSKILATE],
		:Movelist => [[1,PBMoves::EMBER],[1,PBMoves::STRINGSHOT],[10,PBMoves::ABSORB],[20,PBMoves::TAKEDOWN],[30,PBMoves::FLAMECHARGE],[40,PBMoves::BUGBITE],[50,PBMoves::WEAKENINGJUMPSCARE],[60,PBMoves::FLAMEWHEEL],[70,PBMoves::BUGBUZZ],[80,PBMoves::AMNESIA],[90,PBMoves::THRASH],[100,PBMoves::FLAREBLITZ]],
		:EggMoves => [PBMoves::ACIDARMOR,PBMoves::BUBBLEBEAM,PBMoves::FLAMEBURST,PBMoves::MIST,PBMoves::MYSTICALFIRE,PBMoves::ACID,PBMoves::AFTERYOU,PBMoves::AQUATAIL,PBMoves::BIND,PBMoves::EARTHPOWER,PBMoves::ENDURE,PBMoves::GIGADRAIN,PBMoves::HEALBELL,PBMoves::HEATWAVE,PBMoves::PAINSPLIT,PBMoves::SIGNALBEAM,PBMoves::SNORE,PBMoves::SPITE,PBMoves::WATERPULSE,PBMoves::WHIRLPOOL,PBMoves::HYDROPUMP,PBMoves::FIREBLAST,PBMoves::FLAMETHROWER,PBMoves::OMINOUSWIND,PBMoves::SLUDGEBOMB,PBMoves::AURORABEAM,PBMoves::ICEBEAM,PBMoves::LAVAPLUME,PBMoves::SLUDGEWAVE,PBMoves::DISCHARGE,PBMoves::DAZZLINGGLEAM,PBMoves::TEETERDANCE,PBMoves::ROOST,PBMoves::HYPERVOICE,PBMoves::THUNDER,PBMoves::BLIZZARD,PBMoves::THUNDERWAVE,PBMoves::THUNDERBOLT,PBMoves::HYPERBEAM,PBMoves::DRAGONDANCE],
		:Weight => 120
	}
},

PBSpecies::VOLCARONA => {
	:FormName => {
		1 => "Cosmic",
		2 => "Paradox",
		3 => "Totem"
	},

	"Cosmic" => {
		:DexEntry => ".",
		:Type1 => PBTypes::COSMIC,
		:Type2 => PBTypes::DARK,
		:BaseStats => [98,62,89,109,127,95], #? Cosmic adds +30 to BST
		:Ability => [PBAbilities::DUSKILATE,PBAbilities::DARKAURA,PBAbilities::PROTEAN],
		:Movelist => [[1,PBMoves::COSMICDANCE],[1,PBMoves::QUIVERDANCE],[1,PBMoves::FIERYDANCE],[1,PBMoves::NASTYPLOT],[1,PBMoves::WHIRLWIND],[60,PBMoves::COSMICDANCE],[60,PBMoves::TRIATTACK],[60,PBMoves::STRENGTHSAP],[63,PBMoves::BUGBUZZ],[65,PBMoves::DARKPULSE],[67,PBMoves::TAUNT],[69,PBMoves::FIERYDANCE],[71,PBMoves::HURRICANE],[73,PBMoves::RAGEPOWDER],[75,PBMoves::HYPERVOICE],[75,PBMoves::MOONBLAST],[90,PBMoves::BOOMBURST]],
		:Weight => 100
	},

	"Paradox" => {
		:BaseStats => [82,102,69,101,112,104],
		:Type1 => PBTypes::POISON,
		:Type2 => PBTypes::GRASS
	},

	"Totem" => {
		:Ability => PBAbilities::SWARM
	}
},

PBSpecies::MIMIKYU => {
	:FormName => {
		2 => "Rebornian",
		3 => "Also Rebornian"
	},

	:OnCreation => proc{
		maps=[27] # Map IDs for Rebornian form: Pyrous Mountain (TOP)
		next $game_map && maps.include?($game_map.map_id) ? 2 : 0
	},

	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [55,50,105,96,90,80],
		:Movelist => [[1,PBMoves::APPLEACID],[1,PBMoves::SPLASH],[1,PBMoves::TACKLE],[1,PBMoves::EMBER],[1,PBMoves::COPYCAT],[6,PBMoves::SHADOWSNEAK],[12,PBMoves::DOUBLETEAM],[18,PBMoves::BABYDOLLEYES],[24,PBMoves::MIMIC],[30,PBMoves::NASTYPLOT],[36,PBMoves::SLASH],[42,PBMoves::FLAMETHROWER],[48,PBMoves::CHARM],[54,PBMoves::MOONBLAST],[60,PBMoves::PAINSPLIT]],
		:Weight => 450
	},

	"Also Rebornian" => {
		:Type1 => PBTypes::FIRE,
		:Type2 => PBTypes::FAIRY,
		:BaseStats => [55,50,105,96,90,80],
		:Weight => 450
	}
},

###################### Region Variants ######################

PBSpecies::MEGANIUM => {
	:FormName => {2 => "Mega"},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::FIRE,
		:BaseStats => [80,92,130,90,103,130],
		:Ability => PBAbilities::HEATGENERATOR
	}
},

PBSpecies::FERALIGATR => {
	:FormName => {2 => "Mega"},

	:DefaultForm => 0,
	:MegaForm => 2,

	"Mega" => {
		:Type2 => PBTypes::DARK,
		:BaseStats => [85,135,120,98,99,93],
		:Ability => PBAbilities::SHEERFORCE
	}
},

PBSpecies::FURFROU => {
		:FormName => {
			1 => "Star",
			2 => "Heart",
			3 => "Pharaoh",
			4 => "Matron",
			5 => "Dandy",
			6 => "Kabuki",
			7 => "La Reine",
			8 => "Debutante",
			9 => "Diamond",
		},
		"Star" => {
			:Type2 => PBTypes::ELECTRIC,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
				[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
				[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
				[48,PBMoves::RETALIATE],[72,PBMoves::ZINGZAP]]
		},
		"Heart" => {
			:Type2 => PBTypes::PSYCHIC,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::PSYCHICFANGS]]
		},
		"Pharaoh" => {
			:Type2 => PBTypes::GHOST,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::SHADOWBONE]]
		},
		"Matron" => {
			:Type2 => PBTypes::POISON,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::GUNKSHOT]]
		},
		"Dandy" => {
			:Type2 => PBTypes::DARK,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::KNOCKOFF]]
		},
		"Kabuki" => {
			:Type2 => PBTypes::FIGHTING,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::HIJUMPKICK]]
		},
		"La Reine" => {
			:Type2 => PBTypes::WATER,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::AQUATAIL]]
		},
		"Debutante" => {
			:Type2 => PBTypes::FAIRY,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::PLAYROUGH]]
		},
		"Diamond" => {
			:Type2 => PBTypes::ROCK,
			:BaseStats => [85,135,60,112,55,90],
			:Movelist => [[1,PBMoves::TACKLE],[1,PBMoves::GROWL],[5,PBMoves::TAILWHIP],[9,PBMoves::SANDATTACK],
			[12,PBMoves::BABYDOLLEYES],[15,PBMoves::ODORSLEUTH],[22,PBMoves::BITE],[27,PBMoves::HEADBUTT],
			[33,PBMoves::CHARM],[35,PBMoves::TAKEDOWN],[38,PBMoves::SUCKERPUNCH],[42,PBMoves::COTTONGUARD],
			[48,PBMoves::RETALIATE],[72,PBMoves::STONEEDGE]]
		},
},

PBSpecies::LILLIGANT => {
	:FormName => {
		1 => "Dev",
		2 => "Hisui",
		3 => "Rebornian"
	},

	:DefaultForm => 0,

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	},
	"Hisui" => {
		:DexEntry => "I suspect that its well-developed legs are the result of a life spent on mountains covered in deep snow. The scent it exudes from its flower crown heartens those in proximity.",
		:Type2 => PBTypes::FIGHTING,
		:BaseStats => [70,105,75,105,50,75],
		:Ability => [PBAbilities::CHLOROPHYLL,PBAbilities::LEAFGUARD,PBAbilities::HUSTLE,PBAbilities::LIFEFORCE,PBAbilities::NURSE,PBAbilities::STRONGHEEL],
		:Movelist => [[0,PBMoves::ROCKSMASH],[1,PBMoves::FOCUSENERGY],[1,PBMoves::TEETERDANCE],
			[1,PBMoves::ROCKSMASH],[1,PBMoves::ABSORB],[4,PBMoves::GROWTH],[8,PBMoves::LEAFAGE],
			[10,PBMoves::LEECHSEED],[13,PBMoves::STUNSPORE],[15,PBMoves::POISONPOWDER],
			[17,PBMoves::SLEEPPOWDER],[19,PBMoves::MEGADRAIN],[21,PBMoves::HELPINGHAND],[23,PBMoves::SYNTHESIS],
			[25,PBMoves::DEFOG],[27,PBMoves::AFTERYOU],[29,PBMoves::MAGICALLEAF],[31,PBMoves::CHARM],
			[33,PBMoves::MEGAKICK],[35,PBMoves::AROMATHERAPY],[37,PBMoves::GIGADRAIN],[39,PBMoves::DRAINPUNCH],
			[41,PBMoves::SUNNYDAY],[43,PBMoves::ENERGYBALL],[45,PBMoves::ENTRAINMENT],[47,PBMoves::LEAFBLADE],
			[49,PBMoves::RECOVER],[51,PBMoves::PETALBLIZZARD],[51,PBMoves::PETALDANCE],
			[53,PBMoves::VICTORYDANCE],[55,PBMoves::AXEKICK],[57,PBMoves::LEAFSTORM],[59,PBMoves::CLOSECOMBAT],
			[61,PBMoves::SOLARBLADE]],
		:Weight => 192,
		:Height => 12,
		:WildItemCommon => :LUMBERRY,
		:WildItemRare => :EXPCANDYM
	},
	"Rebornian" => {
		:DexEntry => ".",
		:Type1 => PBTypes::ICE,
		:Type2 => PBTypes::GHOST,
		:BaseStats => [85,50,85,100,100,80],
		:Ability => [PBAbilities::SNOWWARNING,PBAbilities::SERENEGRACE,PBAbilities::PETRIFY],
		:Movelist => [[0,PBMoves::FREEZEDRY],[1,PBMoves::FREEZEDRY],[1,PBMoves::WILLOWISP],[5,PBMoves::POWDERSNOW],
					 [9,PBMoves::CONFUSERAY],[13,PBMoves::NIGHTSHADE],[15,PBMoves::POISONPOWDER],[15,PBMoves::VENOMDRENCH],
					 [15,PBMoves::HAIL],[17,PBMoves::TRIATTACK],[21,PBMoves::HEX],[21,PBMoves::ICYWIND],
					 [28,PBMoves::QUIVERDANCE],[28,PBMoves::VICTORYDANCE],[29,PBMoves::FROSTBREATH],[37,PBMoves::SYNTHESIS],
					 [40,PBMoves::OMINOUSWIND],[42,PBMoves::ENERGYBALL],[42,PBMoves::SHADOWBALL],[46,PBMoves::PETALDANCE],
					 [50,PBMoves::SLUDGEBOMB],[50,PBMoves::PETALBLIZZARD],[55,PBMoves::BLIZZARD],[60,PBMoves::ANCIENTICESHARD],[60,PBMoves::MIDNIGHTPHOTOSYNTHESIS],[70,PBMoves::LASTRESPECTS],[90,PBMoves::BOOMBURST],[100,PBMoves::SHEERCOLD]],
		:Weight => 235,
		:Height => 14
	},
},

PBSpecies::DEDENNE => {
	:FormName => {
		1 => "Dev",
		2 => "Nuclear"
	},

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	},

	"Nuclear" => {
		:Type2 => PBTypes::NUCLEAR
	}
},


PBSpecies::SMEARGLE => {
	:FormName => {1 => "Dev"},

	"Dev" => {
		:Ability => PBAbilities::PRANKSTER
	}
},


PBSpecies::MARSHADOW => {
	:FormName => {1 => "Dev"},

	"Dev" => {
		:Ability => PBAbilities::SIMPLE
	}
},

PBSpecies::SILVALLY => {
	:FormName => {21 => "Dev"},

	"Dev" => {
		:Type1 => PBTypes::STEEL,
		:Type2 => PBTypes::STEEL,
		:Ability => PBAbilities::INTIMIDATE
	}
}
}

FormCopy = [
	[PBSpecies::FLABEBE,PBSpecies::FLOETTE],
	[PBSpecies::FLABEBE,PBSpecies::FLORGES],
	[PBSpecies::SHELLOS,PBSpecies::GASTRODON],
	[PBSpecies::DEERLING,PBSpecies::SAWSBUCK]
]
for form in FormCopy
	PokemonForms[form[1]] = PokemonForms[form[0]].clone
end
