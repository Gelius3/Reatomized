#Start of Debug "main"
#Tag SUBFUNCTION to go where the functions are

class PokemonMenu_Scene
  def pbShowCommands(commands)
    ret=-1
    cmdwindow=@sprites["cmdwindow"]
    cmdwindow.viewport=@viewport
    cmdwindow.index=$PokemonTemp.menuLastChoice
    cmdwindow.resizeToFit(commands)
    cmdwindow.commands=commands
    cmdwindow.x=Graphics.width-cmdwindow.width
    cmdwindow.y=0
    cmdwindow.visible=true
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      pbUpdateSceneMap
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        $PokemonTemp.menuLastChoice=ret
        break
      end
    end
    return ret
  end

  def pbShowInfo(text)
    @sprites["infowindow"].resizeToFit(text,Graphics.height)
    @sprites["infowindow"].text=text
    @sprites["infowindow"].visible=true
    @infostate=true
  end

  def pbShowHelp(text)
    @sprites["helpwindow"].resizeToFit(text,Graphics.height)
    @sprites["helpwindow"].text=text
    @sprites["helpwindow"].visible=true
    @helpstate=true
    pbBottomLeft(@sprites["helpwindow"])
  end

  def pbStartScene
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    @sprites["cmdwindow"]=Window_CommandPokemon.new([])
    @sprites["infowindow"]=Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["infowindow"].visible=false
    @sprites["helpwindow"]=Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["helpwindow"].visible=false
    @sprites["cmdwindow"].visible=false
    @infostate=false
    @helpstate=false
    $game_temp.in_menu = true
    pbSEPlay("menu")
  end

  def pbHideMenu
    @sprites["cmdwindow"].visible=false
    @sprites["infowindow"].visible=false
    @sprites["helpwindow"].visible=false
  end

  def pbShowMenu
    @sprites["cmdwindow"].visible=true
    @sprites["infowindow"].visible=@infostate
    @sprites["helpwindow"].visible=@helpstate
  end

  def pbEndScene
    pbDisposeSpriteHash(@sprites)
    $game_temp.in_menu = false
    pbSEPlay("menuclose")
    @viewport.dispose
  end

  def pbRefresh
  end
end



class PokemonMenu
  def initialize(scene)
    @scene=scene
  end

  def pbShowMenu
    @scene.pbRefresh
    @scene.pbShowMenu
  end

  #Removed pbStartPokemonMenu for compatibility with AMB - AddOpt_DebugMenu (Reatomized)
end



def pbDebugMenu
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  sprites={}
  commands=CommandList.new
  commands.add("usepc",_INTL("Use PC"))
  commands.add("healparty",_INTL("Heal Party"))
  commands.add("additem",_INTL("Add Item"))
  commands.add("addbundle",_INTL("Add Item Bundle"))
  commands.add("pcadvanced",_INTL("Save/Load Teams in Box 47"))
  commands.add("setpartyhealth",_INTL("Set Party Health %"))
  commands.add("setpartylevel",_INTL("Set Party Level"))
  commands.add("madness",_INTL("Madness Options"))
  commands.add("switches",_INTL("Switches"))
  commands.add("variables",_INTL("Variables"))
  #commands.add("refreshmap",_INTL("Refresh Map"))
  commands.add("warp",_INTL("Warp to Map (press A for map id)"))
  #commands.add("clearbag",_INTL("Empty Bag"))
  commands.add("addpokemon",_INTL("Add Pokémon"))
  commands.add("addpresetmon",_INTL("Add Preset Pokémon"))
  commands.add("orderboxes",_INTL("Order PC Boxes"))
  commands.add("teamyeet",_INTL("Export my team to text"))
  #commands.add("fullopponentyeet",_INTL("Export trainers to text"))
  #commands.add("setplayer",_INTL("Set Player Character"))
  #commands.add("renameplayer",_INTL("Rename Player"))
  #commands.add("randomid",_INTL("Randomise Player's ID"))
  #commands.add("changeoutfit",_INTL("Change Player Outfit"))
  commands.add("setmoney",_INTL("Set Money"))
  commands.add("setcoins",_INTL("Set Coins"))
  commands.add("setbadges",_INTL("Set Badges"))
  #commands.add("toggleshoes",_INTL("Toggle Running Shoes Ownership"))
  #commands.add("togglepokegear",_INTL("Toggle Pokégear Ownership"))
  #commands.add("togglepokedex",_INTL("Toggle Pokédex Ownership"))
  #commands.add("dexlists",_INTL("Dex List Accessibility"))
  commands.add("daycare",_INTL("Day Care Options..."))
  commands.add("quickhatch",_INTL("Quick Hatch"))
  #commands.add("roamerstatus",_INTL("Roaming Pokémon Status"))
  #commands.add("roam",_INTL("Advance Roaming"))
  #commands.add("terraintags",_INTL("Set Terrain Tags"))
  commands.add("testwildbattle",_INTL("Test Wild Battle"))
  commands.add("testdoublewildbattle",_INTL("Test Double Wild Battle"))
  commands.add("testtrainerbattle",_INTL("Test Trainer Battle"))
  commands.add("testtrainerdoublebattle",_INTL("Test Trainer Double Battle"))
  commands.add("testdoubletrainerbattle",_INTL("Test Double Trainer Battle"))
  #commands.add("relicstone",_INTL("Relic Stone"))
  #commands.add("purifychamber",_INTL("Purify Chamber"))
  #commands.add("extracttext",_INTL("Extract Text"))
  #commands.add("compiletext",_INTL("Compile Text"))
  #commands.add("compiletrainers", _INTL("Compile Trainers"))
  commands.add("compiledata",_INTL("Compile All Data"))
  #commands.add("mapconnections",_INTL("Map Connections"))
  #commands.add("animeditor",_INTL("Animation Editor"))
  #commands.add("togglelogging",_INTL("Toggle Battle Logging"))
  #commands.add("scriptedbattle",_INTL("Start Scripted Battle"))
  #commands.add("debugbattle",_INTL("Battle The Debug Trainer"))
  commands.add("stealtrainer",_INTL("Get Trainer team in Box 48"))
  #commands.add("allbattles",_INTL("Mandatory Battle Testing"))
  commands.add("e20shortcut",_INTL("Fight specific fights (postgame)!"))
  commands.add("e19shortcut",_INTL("Fight specific fights (e19)!"))
  #commands.add("torresworkshop",_INTL("Torre stuff. Blobspy."))
  sprites["cmdwindow"]=Window_CommandPokemon.new(commands.list)
  cmdwindow=sprites["cmdwindow"]
  cmdwindow.viewport=viewport
  cmdwindow.resizeToFit(cmdwindow.commands)
  cmdwindow.height=Graphics.height if cmdwindow.height>Graphics.height
  cmdwindow.x=0
  cmdwindow.y=0
  cmdwindow.visible=true
  pbFadeInAndShow(sprites)
  ret=-1
  loop do
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        break
      end
    end
    break if ret==-1
    cmd=commands.getCommand(ret)
    if cmd=="switches"
      pbFadeOutIn(99999) { pbDebugScreen(0) }
    elsif cmd=="variables"
      pbFadeOutIn(99999) { pbDebugScreen(1) }
    elsif cmd=="refreshmap"
      $game_map.need_refresh = true; Kernel.pbMessage(_INTL("The map will refresh."))
    elsif cmd=="warp"
		  map=pbWarpToMap()
		  if map
			pbFadeOutAndHide(sprites)
			pbDisposeSpriteHash(sprites)
			viewport.dispose
			if $scene.is_a?(Scene_Map)
			  $game_temp.player_new_map_id=map[0]
			  $game_temp.player_new_x=map[1]
			  $game_temp.player_new_y=map[2]
			  $game_temp.player_new_direction=2
			  $scene.transfer_player
			  $game_map.refresh
			else
			  Kernel.pbCancelVehicles
			  $MapFactory.setup(map[0])
			  $game_player.moveto(map[1],map[2])
			  $game_player.turn_down
			  $game_map.update
			  $game_map.autoplay
			  $game_map.refresh
			end
	return
  end
    elsif cmd=="healparty"
		torDebugHealParty
    elsif cmd=="setpartyhealth"
		torDebugSetPartyHealth
    elsif cmd=="setpartylevel"
		torDebugSetPartyLevel
	elsif cmd=="additem"
		torDebugAddItem
    elsif cmd=="clearbag"
      $PokemonBag.clear; Kernel.pbMessage(_INTL("The Bag was cleared."))
    elsif cmd=="addpokemon"
		torDebugAddPokemon
    elsif cmd=="usepc"
      pbPokeCenterPC
    elsif cmd=="teamyeet"
      torselfteamtotext
    elsif cmd=="fullopponentyeet"
      torallopponentsteamtotext
    elsif cmd=="setplayer"
    elsif cmd=="renameplayer"
		torDebugRenamePlayer
    elsif cmd=="randomid"
		torDebugRandomID
    elsif cmd=="changeoutfit"
    elsif cmd=="setmoney"
		torDebugSetMoney
    elsif cmd=="setcoins"
		torDebugSetCoins
    elsif cmd=="setbadges"
   elsif cmd=="toggleshoes"
      $PokemonGlobal.runningShoes=!$PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Gave Running Shoes.")) if $PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Lost Running Shoes.")) if !$PokemonGlobal.runningShoes
    elsif cmd=="togglepokegear"
      $Trainer.pokegear=!$Trainer.pokegear
      Kernel.pbMessage(_INTL("Gave Pokégear.")) if $Trainer.pokegear
      Kernel.pbMessage(_INTL("Lost Pokégear.")) if !$Trainer.pokegear
    elsif cmd=="togglepokedex"
      $Trainer.pokedex=!$Trainer.pokedex
      Kernel.pbMessage(_INTL("Gave Pokédex.")) if $Trainer.pokedex
      Kernel.pbMessage(_INTL("Lost Pokédex.")) if !$Trainer.pokedex
    elsif cmd=="dexlists"
    elsif cmd=="daycare"
		torDebugDaycare
    elsif cmd=="quickhatch"
		torDebugQuickhatch
    elsif cmd=="roamerstatus"
    elsif cmd=="roam"
    elsif cmd=="terraintags"
    elsif cmd=="testwildbattle"
		torDebugWildSingles
    elsif cmd=="testdoublewildbattle"
		torDebugWildDoubles
    elsif cmd=="testtrainerbattle"
		torDebug1v1
    elsif cmd=="testtrainerdoublebattle"
		torDebug2v2
    elsif cmd=="testdoubletrainerbattle"
		torDebug1v2
    elsif cmd=="relicstone"
    elsif cmd=="purifychamber"
    elsif cmd=="extracttext"
    elsif cmd=="compiletext"
      pbCompileTextUI
    elsif cmd=="compiletrainers"
      begin
        pbCompileTrainers
        $cache.trainers=load_data("Data/trainers.dat")
        Kernel.pbMessage(_INTL("Trainers have been compiled."))
      rescue
        pbPrintException($!)
      end
    elsif cmd=="compiledata"
      msgwindow=Kernel.pbCreateMessageWindow
      pbCompileAllData(true) {|msg| Kernel.pbMessageDisplay(msgwindow,msg,false) }
      Kernel.pbMessageDisplay(msgwindow,_INTL("All game data was compiled."))
      Kernel.pbDisposeMessageWindow(msgwindow)
    elsif cmd=="mapconnections"
    elsif cmd=="animeditor"
    elsif cmd=="togglelogging"
    elsif cmd=="scriptedbattle"
    elsif cmd=="stealtrainer"
		torDebugStealTrainer
	elsif cmd=="debugbattle"
      begin
        pbDebugTestBattle
      rescue
        pbPrintException($!)
      end
	elsif cmd=="allbattles"
	elsif cmd=="e20shortcut"
		torDebuge20shortcut
	elsif cmd=="e19shortcut"
		torDebuge19shortcut
	elsif cmd=="orderboxes"
		torDebugOrderBoxes
	elsif cmd=="addpresetmon"
		torDebugAddMoPreset
	elsif cmd=="addbundle"
		torDebugAddItBundle
	elsif cmd=="madness"
		torDebugMadness
	elsif cmd=="pcadvanced"
		torDebugAdvancedPC
	elsif cmd=="torresworkshop"
		torPersonalWorkshop
	end
  end
  pbFadeOutAndHide(sprites)
  pbDisposeSpriteHash(sprites)
  viewport.dispose
end

#End of Debug "main", start of sub functions
#Tag SUBFUNCTION

def torPersonalWorkshop
txtstring=Kernel.pbMessageFreeText("Name?",_INTL(""),false,12)
txtascii=txtstring.ord
  Kernel.pbMessage(_INTL("The text is {1} and in ascii it's {2}.",txtstring,txtascii))


end

def torDebugMenuWarp
  map=pbWarpToMap()
  if map
	pbFadeOutAndHide(sprites)
	pbDisposeSpriteHash(sprites)
	viewport.dispose
	if $scene.is_a?(Scene_Map)
	  $game_temp.player_new_map_id=map[0]
	  $game_temp.player_new_x=map[1]
	  $game_temp.player_new_y=map[2]
	  $game_temp.player_new_direction=2
	  $scene.transfer_player
	  $game_map.refresh
	else
	  Kernel.pbCancelVehicles
	  $MapFactory.setup(map[0])
	  $game_player.moveto(map[1],map[2])
	  $game_player.turn_down
	  $game_map.update
	  $game_map.autoplay
	  $game_map.refresh
	end
	return
  end
end

def torDebugHealParty
	for i in $Trainer.party
	i.heal
	end
	Kernel.pbMessage(_INTL("Your Pokémon were healed."))

end

def torDebugSetPartyHealth

params=ChooseNumberParams.new
params.setRange(0,100)
params.setDefaultValue(25)
newhp=Kernel.pbMessageChooseNumber(_INTL("Set the Pokémon's HP ratio (max 100)."),params) 
	  for i in $Trainer.party
		i.hp=((newhp*i.totalhp)/100).ceil
	end

end

def torDebugSetPartyLevel
  leadersDefeated = $Trainer.numbadges
  lcap=LEVELCAPS[leadersDefeated] + $game_variables[595]
  if lcap>100
  lcap=lcap-50
  end
	  for i in $Trainer.party
		i.level=lcap
		i.calcStats
	end
i.calcStats
Kernel.pbMessage(_INTL("Your Pokémon were set to level cap."))
end

def torDebugAddItem
  item=pbListScreen(_INTL("ADD ITEM"),ItemLister.new(0))
  if item && item>0
	params=ChooseNumberParams.new
	params.setRange(1,BAGMAXPERSLOT)
	params.setInitialValue(1)
	params.setCancelValue(0)
	qty=Kernel.pbMessageChooseNumber(
	   _INTL("Choose the number of items."),params
	)
	if qty>0
	  if qty==1
		Kernel.pbReceiveItem(item)
	  else
		Kernel.pbMessage(_INTL("The item was added."))
		$PokemonBag.pbStoreItem(item,qty)
	  end
	end
  end
end

def torDebugAddPokemon
  species=pbChooseSpeciesOrdered(1)
  if species!=0
	params=ChooseNumberParams.new
	params.setRange(1,PBExperience::MAXLEVEL)
	params.setInitialValue(5)
	params.setCancelValue(0)
	level=Kernel.pbMessageChooseNumber(
	   _INTL("Set the Pokémon's level."),params)
	if level>0
	  pbAddPokemon(species,level)
	end
  end
end

def torDebugRenamePlayer
  trname=pbEnterPlayerName("Your name?",0,12,$Trainer.name)
  if trname==""
	trainertype=pbGetPlayerTrainerType
	gender=pbGetTrainerTypeGender(trainertype) 
	trname=pbSuggestTrainerName(gender)
  end
  $Trainer.name=trname
  Kernel.pbMessage(_INTL("The player's name was changed to {1}.",$Trainer.name))
end

def torDebugAddItBundle
	bundlecmd=0
		loop do
			bundlecmds=[
				_INTL("TMs"),
				_INTL("Berries"),
				_INTL("Held items"),
				_INTL("Mega Stones"),
				_INTL("Crystals"),
				_INTL("Nothing")
				]
			bundlecmd=Kernel.pbShowCommands(nil,bundlecmds,-1,bundlecmd)
			break if bundlecmd<0
				case bundlecmd
				when 0
				tmcmd=0
					loop do
						tmcmds=[
						_INTL("E2"),
						_INTL("E3"),
						_INTL("E4"),
						_INTL("E5"),
						_INTL("E6"),
						_INTL("E7"),
						_INTL("E8"),
						_INTL("E9"),
						_INTL("E10"),
						_INTL("E11"),
						_INTL("E12"),
						_INTL("E13"),
						_INTL("E14"),
						_INTL("E15"),
						_INTL("E16"),
						_INTL("E17"),
						_INTL("E18"),
						_INTL("E19"),
						_INTL("E20"),
						]
					tmcmd=Kernel.pbShowCommands(nil,tmcmds,-1,tmcmd)
					break if tmcmd<0
						case tmcmd
						when 0
						Kernel.pbItemBall(PBItems::TM57); Kernel.pbItemBall(PBItems::TM60); Kernel.pbItemBall(PBItems::TM42); 
						Kernel.pbItemBall(PBItems::TM45); Kernel.pbItemBall(PBItems::TM54); Kernel.pbItemBall(PBItems::TM63); 
						Kernel.pbItemBall(PBItems::TM90); 
						when 1
						Kernel.pbItemBall(PBItems::TM96); Kernel.pbItemBall(PBItems::TM100); Kernel.pbItemBall(PBItems::TM20); 
						Kernel.pbItemBall(PBItems::TM77); Kernel.pbItemBall(PBItems::TM88);
						when 2
						Kernel.pbItemBall(PBItems::TM17); Kernel.pbItemBall(PBItems::TM46); Kernel.pbItemBall(PBItems::TM56); 
						Kernel.pbItemBall(PBItems::TM07); Kernel.pbItemBall(PBItems::TM21); Kernel.pbItemBall(PBItems::TM41); 
						Kernel.pbItemBall(PBItems::TM69); 
						when 3
						Kernel.pbItemBall(PBItems::TM76); Kernel.pbItemBall(PBItems::TM05); Kernel.pbItemBall(PBItems::TM48); 
						when 4
						Kernel.pbItemBall(PBItems::TM65); Kernel.pbItemBall(PBItems::TM49); 
						when 5
						Kernel.pbItemBall(PBItems::TM83); 
						Kernel.pbItemBall(PBItems::TM66); Kernel.pbItemBall(PBItems::TM09);
						when 6
						Kernel.pbItemBall(PBItems::TM34); Kernel.pbItemBall(PBItems::TM12); Kernel.pbItemBall(PBItems::TM37); 
						Kernel.pbItemBall(PBItems::TM94); Kernel.pbItemBall(PBItems::TM44); Kernel.pbItemBall(PBItems::TM32); 
						Kernel.pbItemBall(PBItems::TM85); 
						when 7
						Kernel.pbItemBall(PBItems::TM70); 
						when 8
						Kernel.pbItemBall(PBItems::TM10); Kernel.pbItemBall(PBItems::TM40); Kernel.pbItemBall(PBItems::TM51); 
						Kernel.pbItemBall(PBItems::TM86); Kernel.pbItemBall(PBItems::TM23);
						when 9
						Kernel.pbItemBall(PBItems::TM11); Kernel.pbItemBall(PBItems::TM18); Kernel.pbItemBall(PBItems::TM64); 
						Kernel.pbItemBall(PBItems::TM92); 
						when 10
						Kernel.pbItemBall(PBItems::TM97); Kernel.pbItemBall(PBItems::TM87);
						when 11
						Kernel.pbItemBall(PBItems::TM31); Kernel.pbItemBall(PBItems::TM39); Kernel.pbItemBall(PBItems::TM43); 
						Kernel.pbItemBall(PBItems::TM58); 
						when 12
						Kernel.pbItemBall(PBItems::TM35); Kernel.pbItemBall(PBItems::TM79); Kernel.pbItemBall(PBItems::TM95); 
						Kernel.pbItemBall(PBItems::TM82); 
						when 13
						Kernel.pbItemBall(PBItems::TM78); Kernel.pbItemBall(PBItems::TM01); Kernel.pbItemBall(PBItems::TM03); 
						Kernel.pbItemBall(PBItems::TM47); Kernel.pbItemBall(PBItems::TM74); Kernel.pbItemBall(PBItems::TM93); 
						Kernel.pbItemBall(PBItems::TM67); 
						when 14
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbItemBall(PBItems::TM62); Kernel.pbItemBall(PBItems::TM06); Kernel.pbItemBall(PBItems::TM22); 
						Kernel.pbItemBall(PBItems::TM27); Kernel.pbItemBall(PBItems::TM30); Kernel.pbItemBall(PBItems::TM33); 
						Kernel.pbItemBall(PBItems::TM50); Kernel.pbItemBall(PBItems::TM61); Kernel.pbItemBall(PBItems::TM68); 
						Kernel.pbItemBall(PBItems::TM81); Kernel.pbItemBall(PBItems::TM89); Kernel.pbItemBall(PBItems::TM59); 
						Kernel.pbItemBall(PBItems::TM16); Kernel.pbItemBall(PBItems::TM98); Kernel.pbItemBall(PBItems::TM15); 
						Kernel.pbMessage(_INTL("To use Hyper Beam, you need to be able to beat Mc Krezzy!"))
						Kernel.pbMessage(_INTL("To use Shadow Ball, you need to be able to beat the Kecleons!"))
						when 15
						Kernel.pbItemBall(PBItems::TM99); Kernel.pbItemBall(PBItems::TM84); Kernel.pbItemBall(PBItems::TM72); 
						Kernel.pbItemBall(PBItems::TM71); Kernel.pbItemBall(PBItems::TM36); Kernel.pbItemBall(PBItems::TM04); 
						Kernel.pbItemBall(PBItems::TM08); Kernel.pbItemBall(PBItems::TM75); Kernel.pbItemBall(PBItems::TM19); 
						Kernel.pbItemBall(PBItems::TM91); 
						when 16
						Kernel.pbItemBall(PBItems::TM55); Kernel.pbItemBall(PBItems::TM28); Kernel.pbItemBall(PBItems::TM52); 
						Kernel.pbItemBall(PBItems::TM53); Kernel.pbItemBall(PBItems::TM73); Kernel.pbItemBall(PBItems::TM29); 
						Kernel.pbItemBall(PBItems::TM13); Kernel.pbItemBall(PBItems::TM24); Kernel.pbItemBall(PBItems::TM26); 
						#Kernel.pbMessage(_INTL("To use Thunder Wave, you need to be able to beat Breloom Bot!"))
						when 17
						Kernel.pbItemBall(PBItems::TM14); Kernel.pbItemBall(PBItems::TM25); Kernel.pbItemBall(PBItems::TM38); 
						Kernel.pbItemBall(PBItems::TM80); 
						when 18
						Kernel.pbItemBall(PBItems::TM02); 
						end
					end
				when 1
				bercmd=0
					loop do
						bercmds=[
						_INTL("Early Game Berries"),
						_INTL("Rhodochrine/Peridot : Limited Berries (one)"),
						_INTL("Type Resist Berries"),
						_INTL("Route 1 Berries (Custap, Lum, Sitrus)"),
						_INTL("Resto : Pinch Beries"),
						_INTL("Resto : Super Heal Berries"),
						_INTL("Weird Berries")
						]
					bercmd=Kernel.pbShowCommands(nil,bercmds,-1,bercmd)
					break if bercmd<0
						case bercmd
						when 0
						Kernel.pbItemBall(PBItems::ORANBERRY,99); Kernel.pbItemBall(PBItems::PECHABERRY,99); Kernel.pbItemBall(PBItems::CHERIBERRY,99);
						Kernel.pbItemBall(PBItems::ASPEARBERRY,99); Kernel.pbItemBall(PBItems::RAWSTBERRY,99); Kernel.pbItemBall(PBItems::PERSIMBERRY,99);
						Kernel.pbItemBall(PBItems::CHESTOBERRY,99); 
						when 1
						Kernel.pbItemBall(PBItems::SITRUSBERRY,1); Kernel.pbItemBall(PBItems::LIECHIBERRY,1); Kernel.pbItemBall(PBItems::SALACBERRY,1);
						Kernel.pbItemBall(PBItems::PETAYABERRY,1); 
						when 2
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbItemBall(PBItems::BABIRIBERRY,99); Kernel.pbItemBall(PBItems::HABANBERRY,99); Kernel.pbItemBall(PBItems::RINDOBERRY,99);
						Kernel.pbItemBall(PBItems::CHARTIBERRY,99); Kernel.pbItemBall(PBItems::KASIBBERRY,99); Kernel.pbItemBall(PBItems::ROSELIBERRY,99);
						Kernel.pbItemBall(PBItems::CHILANBERRY,99); Kernel.pbItemBall(PBItems::KEBIABERRY,99); Kernel.pbItemBall(PBItems::SHUCABERRY,99);
						Kernel.pbItemBall(PBItems::CHOPLEBERRY,99); Kernel.pbItemBall(PBItems::OCCABERRY,99); Kernel.pbItemBall(PBItems::TANGABERRY,99);
						Kernel.pbItemBall(PBItems::COBABERRY,99); Kernel.pbItemBall(PBItems::PASSHOBERRY,99); Kernel.pbItemBall(PBItems::WACANBERRY,99);
						Kernel.pbItemBall(PBItems::COLBURBERRY,99); Kernel.pbItemBall(PBItems::PAYAPABERRY,99); Kernel.pbItemBall(PBItems::YACHEBERRY,99);
						when 3
						Kernel.pbItemBall(PBItems::CUSTAPBERRY,250); Kernel.pbItemBall(PBItems::LUMBERRY,250); Kernel.pbItemBall(PBItems::SITRUSBERRY,99);
						when 4
						Kernel.pbItemBall(PBItems::LIECHIBERRY,99); Kernel.pbItemBall(PBItems::PETAYABERRY,99); Kernel.pbItemBall(PBItems::SALACBERRY,99);
						Kernel.pbItemBall(PBItems::GANLONBERRY,99); Kernel.pbItemBall(PBItems::APICOTBERRY,99); Kernel.pbItemBall(PBItems::LANSATBERRY,99);
						when 5
						Kernel.pbItemBall(PBItems::IAPAPABERRY,99); Kernel.pbItemBall(PBItems::MAGOBERRY,99); Kernel.pbItemBall(PBItems::WIKIBERRY,99);
						Kernel.pbItemBall(PBItems::AGUAVBERRY,99); Kernel.pbItemBall(PBItems::FIGYBERRY,99); 
						when 6
						Kernel.pbItemBall(PBItems::KEEBERRY,99); Kernel.pbItemBall(PBItems::MARANGABERRY,99); Kernel.pbItemBall(PBItems::JABOCABERRY,99);
						Kernel.pbItemBall(PBItems::ROWAPBERRY,99); 
						end
					end
					
				when 2
				heldcmd=0
					loop do
						heldcmds=[
						_INTL("Choice Bundle"),
						_INTL("20% Bundle"),
						_INTL("Plates Bundle"),
						_INTL("Gem Bundle"),
						_INTL("Recovery & Defense Bundle"),
						_INTL("Mobility Bundle"),
						_INTL("Sash Bundle"),
						_INTL("Clown Bundle"),
						_INTL("Herbs Bundle"),
						_INTL("Terrain Seeds Bundle"),
						_INTL("Weather Items Bundle"),
						_INTL("Victini Quest Bundle"),
						]
					heldcmd=Kernel.pbShowCommands(nil,heldcmds,-1,heldcmd)
					break if heldcmd<0
						case heldcmd
						when 0
						Kernel.pbItemBall(PBItems::CHOICESPECS,10); Kernel.pbItemBall(PBItems::CHOICEBAND,10); Kernel.pbItemBall(PBItems::CHOICESCARF,2);
						when 1
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbItemBall(PBItems::BLACKBELT,10); Kernel.pbItemBall(PBItems::BLACKGLASSES,10); Kernel.pbItemBall(PBItems::CHARCOAL,10);
						Kernel.pbItemBall(PBItems::DRAGONFANG,10); Kernel.pbItemBall(PBItems::HARDSTONE,10); Kernel.pbItemBall(PBItems::MAGNET,10);
						Kernel.pbItemBall(PBItems::METALCOAT,10); Kernel.pbItemBall(PBItems::MIRACLESEED,10); Kernel.pbItemBall(PBItems::MYSTICWATER,10);
						Kernel.pbItemBall(PBItems::NEVERMELTICE,10); Kernel.pbItemBall(PBItems::SILKSCARF,10); Kernel.pbItemBall(PBItems::POISONBARB,10);
						Kernel.pbItemBall(PBItems::SHARPBEAK,10); Kernel.pbItemBall(PBItems::SILVERPOWDER,10); Kernel.pbItemBall(PBItems::SOFTSAND,10);
						Kernel.pbItemBall(PBItems::SPELLTAG,10); Kernel.pbItemBall(PBItems::TWISTEDSPOON,10); Kernel.pbItemBall(PBItems::PIXIEPLATE,10);
						when 2
						Kernel.pbItemBall(PBItems::DRACOPLATE,10); Kernel.pbItemBall(PBItems::DREADPLATE,10); Kernel.pbItemBall(PBItems::EARTHPLATE,10);
						Kernel.pbItemBall(PBItems::FISTPLATE,10); Kernel.pbItemBall(PBItems::FLAMEPLATE,10); Kernel.pbItemBall(PBItems::ICICLEPLATE,10);
						Kernel.pbItemBall(PBItems::INSECTPLATE,10); Kernel.pbItemBall(PBItems::IRONPLATE,10); Kernel.pbItemBall(PBItems::MEADOWPLATE,10);
						Kernel.pbItemBall(PBItems::MINDPLATE,10); Kernel.pbItemBall(PBItems::SKYPLATE,10); Kernel.pbItemBall(PBItems::SPLASHPLATE,10);
						Kernel.pbItemBall(PBItems::SPOOKYPLATE,10); Kernel.pbItemBall(PBItems::STONEPLATE,10); Kernel.pbItemBall(PBItems::TOXICPLATE,10);
						Kernel.pbItemBall(PBItems::ZAPPLATE,10);  Kernel.pbItemBall(PBItems::PIXIEPLATE,10);
						when 3
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbItemBall(PBItems::NORMALGEM,99); Kernel.pbItemBall(PBItems::FIREGEM,99); Kernel.pbItemBall(PBItems::WATERGEM,99);
						Kernel.pbItemBall(PBItems::GRASSGEM,99); Kernel.pbItemBall(PBItems::ELECTRICGEM,99); Kernel.pbItemBall(PBItems::FLYINGGEM,199);
						Kernel.pbItemBall(PBItems::GROUNDGEM,99); Kernel.pbItemBall(PBItems::ROCKGEM,99); Kernel.pbItemBall(PBItems::STEELGEM,99);
						Kernel.pbItemBall(PBItems::POISONGEM,99); Kernel.pbItemBall(PBItems::FAIRYGEM,99); Kernel.pbItemBall(PBItems::DRAGONGEM,99);
						Kernel.pbItemBall(PBItems::PSYCHICGEM,99); Kernel.pbItemBall(PBItems::DARKGEM,99); Kernel.pbItemBall(PBItems::FIGHTINGGEM,99);
						Kernel.pbItemBall(PBItems::BUGGEM,99); Kernel.pbItemBall(PBItems::ICEGEM,99); Kernel.pbItemBall(PBItems::GHOSTGEM,99);
						when 4
						Kernel.pbItemBall(PBItems::LEFTOVERS,10); Kernel.pbItemBall(PBItems::BLACKSLUDGE,10); Kernel.pbItemBall(PBItems::EVIOLITE,10);
						when 5
						Kernel.pbItemBall(PBItems::EJECTBUTTON,99); Kernel.pbItemBall(PBItems::REDCARD,99);
						
						when 6
						Kernel.pbItemBall(PBItems::FOCUSSASH,150);
						when 7
						Kernel.pbItemBall(PBItems::AIRBALLOON,150);
						when 8
						Kernel.pbItemBall(PBItems::WHITEHERB,99); Kernel.pbItemBall(PBItems::POWERHERB,99); Kernel.pbItemBall(PBItems::MENTALHERB,99); 
						when 9
						Kernel.pbItemBall(PBItems::TELLURICSEED,99);  Kernel.pbItemBall(PBItems::ELEMENTALSEED,99); Kernel.pbItemBall(PBItems::SYNTHETICSEED,99); 
						Kernel.pbItemBall(PBItems::MAGICALSEED,99);  
						when 10
						Kernel.pbItemBall(PBItems::SMOOTHROCK,29);  Kernel.pbItemBall(PBItems::DAMPROCK,29); Kernel.pbItemBall(PBItems::HEATROCK,29); 
						Kernel.pbItemBall(PBItems::ICYROCK,29);   Kernel.pbItemBall(PBItems::AMPLIFIELDROCK,29); 
						
						when 11
						Kernel.pbItemBall(PBItems::PECHABERRY,1);  Kernel.pbItemBall(PBItems::BERRYJUICE,1); Kernel.pbItemBall(PBItems::BALMMUSHROOM,1); 
						Kernel.pbItemBall(PBItems::TARTAPPLE,1);  Kernel.pbItemBall(PBItems::SWEETAPPLE,1); Kernel.pbItemBall(PBItems::STICK,1); 
						$game_switches[463] = true
						$game_switches[464] = false
						Kernel.pbMessage(_INTL("You have rage powder now."))
						end
					end
				
				when 3
				megacmd=0
					loop do
						megacmds=[
						_INTL("Main Game Bundlite"),
						_INTL("Legends Bundlite"),
						]
					megacmd=Kernel.pbShowCommands(nil,megacmds,-1,megacmd)
					break if megacmd<0
						case megacmd
						when 0
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbMessage(_INTL("Reminder : Meganium and Yanmega do not need Mega Stones to evolve. :blobcatgooglythumbsup:"))
						Kernel.pbItemBall(PBItems::GENGARITE,1);  Kernel.pbItemBall(PBItems::GARDEVOIRITE,1); Kernel.pbItemBall(PBItems::CHARIZARDITEX,1); 
						Kernel.pbItemBall(PBItems::CHARIZARDITEY,1);  Kernel.pbItemBall(PBItems::AMPHAROSITE,1); Kernel.pbItemBall(PBItems::VENUSAURITE,1);
						Kernel.pbItemBall(PBItems::BLASTOISINITE,1);  Kernel.pbItemBall(PBItems::BLAZIKENITE,1); Kernel.pbItemBall(PBItems::MEDICHAMITE,1);
						Kernel.pbItemBall(PBItems::HOUNDOOMINITE,1);  Kernel.pbItemBall(PBItems::AGGRONITE,1); Kernel.pbItemBall(PBItems::BANETTITE,1);
						Kernel.pbItemBall(PBItems::TYRANITARITE,1);  Kernel.pbItemBall(PBItems::SCIZORITE,1); Kernel.pbItemBall(PBItems::PINSIRITE,1);
						Kernel.pbItemBall(PBItems::AERODACTYLITE,1);  Kernel.pbItemBall(PBItems::LUCARIONITE,1); Kernel.pbItemBall(PBItems::ABOMASITE,1);
						Kernel.pbItemBall(PBItems::KANGASKHANITE,1);  Kernel.pbItemBall(PBItems::GYARADOSITE,1); Kernel.pbItemBall(PBItems::ABSOLITE,1);
						Kernel.pbItemBall(PBItems::HERACRONITE,1);  Kernel.pbItemBall(PBItems::MAWILITE,1); Kernel.pbItemBall(PBItems::MANECTITE,1);
						Kernel.pbItemBall(PBItems::GARCHOMPITE,1);  Kernel.pbItemBall(PBItems::SWAMPERTITE,1); Kernel.pbItemBall(PBItems::SCEPTILITE,1);
						Kernel.pbItemBall(PBItems::SABLENITE,1);  Kernel.pbItemBall(PBItems::ALTARIANITE,1); Kernel.pbItemBall(PBItems::GALLADITE,1);
						Kernel.pbItemBall(PBItems::AUDINITE,1);  Kernel.pbItemBall(PBItems::METAGROSSITE,1); Kernel.pbItemBall(PBItems::SHARPEDONITE,1);
						Kernel.pbItemBall(PBItems::STEELIXITE,1);  Kernel.pbItemBall(PBItems::SLOWBRONITE,1); Kernel.pbItemBall(PBItems::PIDGEOTITE,1);
						Kernel.pbItemBall(PBItems::GLALITITE,1);  Kernel.pbItemBall(PBItems::CAMERUPTITE,1); Kernel.pbItemBall(PBItems::LOPUNNITE,1);
						Kernel.pbItemBall(PBItems::SALAMENCITE,1);  Kernel.pbItemBall(PBItems::BEEDRILLITE,1); 
						
						when 1
						Kernel.pbItemBall(PBItems::MEWTWONITEX,1);  Kernel.pbItemBall(PBItems::MEWTWONITEY,1); Kernel.pbItemBall(PBItems::DIANCITE,1);
						Kernel.pbItemBall(PBItems::LATIASITE,1);  Kernel.pbItemBall(PBItems::LATIOSITE,1); 
						end
					end
				when 4
				zcmd=0
					loop do
						zcmds=[
						_INTL("Type Crystals"),
						_INTL("Unique Crystals"),
						_INTL("Uber Crystals"),
						_INTL("just gimme eevium and kommonium lol"),
						]
					zcmd=Kernel.pbShowCommands(nil,zcmds,-1,zcmd)
					break if zcmd<0
						case zcmd
						when 0
						Kernel.pbMessage(_INTL("This will be long. You should keep Cancel pressed for a bit..."))
						Kernel.pbItemBall(PBItems::NORMALIUMZ,1);  Kernel.pbItemBall(PBItems::FIRIUMZ,1); Kernel.pbItemBall(PBItems::WATERIUMZ,1); 
						Kernel.pbItemBall(PBItems::GRASSIUMZ,1);  Kernel.pbItemBall(PBItems::ELECTRIUMZ,1); Kernel.pbItemBall(PBItems::GROUNDIUMZ,1); 
						Kernel.pbItemBall(PBItems::ROCKIUMZ,1);  Kernel.pbItemBall(PBItems::STEELIUMZ,1); Kernel.pbItemBall(PBItems::FLYINIUMZ,1); 
						Kernel.pbItemBall(PBItems::POISONIUMZ,1);  Kernel.pbItemBall(PBItems::DRAGONIUMZ,1); Kernel.pbItemBall(PBItems::FAIRIUMZ,1); 
						Kernel.pbItemBall(PBItems::FIGHTINIUMZ,1);  Kernel.pbItemBall(PBItems::DARKINIUMZ,1); Kernel.pbItemBall(PBItems::PSYCHIUMZ,1); 
						Kernel.pbItemBall(PBItems::GHOSTIUMZ,1);  Kernel.pbItemBall(PBItems::ICIUMZ,1); Kernel.pbItemBall(PBItems::BUGINIUMZ,1); 
						when 1
						Kernel.pbItemBall(PBItems::EEVIUMZ,1);  Kernel.pbItemBall(PBItems::KOMMONIUMZ,1); Kernel.pbItemBall(PBItems::PIKANIUMZ,1); 
						Kernel.pbItemBall(PBItems::ALORAICHIUMZ,1);  Kernel.pbItemBall(PBItems::SNORLIUMZ,1); Kernel.pbItemBall(PBItems::DECIDIUMZ,1); 
						Kernel.pbItemBall(PBItems::INCINIUMZ,1);  Kernel.pbItemBall(PBItems::PRIMARIUMZ,1); Kernel.pbItemBall(PBItems::LYCANIUMZ,1); 
						Kernel.pbItemBall(PBItems::MIMIKIUMZ,1); 
						when 2
						Kernel.pbItemBall(PBItems::MARSHADIUMZ,1);  Kernel.pbItemBall(PBItems::TAPUNIUMZ,1); Kernel.pbItemBall(PBItems::SOLGANIUMZ,1); 
						Kernel.pbItemBall(PBItems::ULTRANECROZIUMZ,1);  Kernel.pbItemBall(PBItems::LUNALIUMZ,1); Kernel.pbItemBall(PBItems::MEWNIUMZ,1); 
						when 3
						Kernel.pbMessage(_INTL("Nerd."))
						Kernel.pbItemBall(PBItems::EEVIUMZ,1);  Kernel.pbItemBall(PBItems::KOMMONIUMZ,1); 
						end
					end
				when 5
				bundlecmd=-1
				end
		end


end

def torDebugAdvancedPC
advancedpccmd=0
loop do
	advancedpccmds=[
		_INTL("Save Team in Slot 1"),
		_INTL("Load Team in Slot 1"),
		_INTL("Save Team in Slot 2"),
		_INTL("Load Team in Slot 2"),
		_INTL("Save Team in Slot 3"),
		_INTL("Load Team in Slot 3"),
		_INTL("Save Team in Slot 4"),
		_INTL("Load Team in Slot 4"),
		_INTL("Save Team in Slot 5"),
		_INTL("Load Team in Slot 5")
		]
			advancedpccmd=Kernel.pbShowCommands(nil,advancedpccmds,-1,advancedpccmd)

		break if advancedpccmd<0
			case advancedpccmd
			when 0 #Save 1
			torsaveteamin47(1)
			break
			when 1 #Load 1
			torloadteamin47(1)
			break
			when 2 #Save 2
			torsaveteamin47(2)
			when 3 #Load 2
			torloadteamin47(2)
			break
			when 4 #Save 3
			torsaveteamin47(3)
			when 5 #Load 3
			torloadteamin47(3)
			break
			when 6 #Save 4
			torsaveteamin47(4)
			when 7 #Load 4
			torloadteamin47(4)
			break
			when 8 #Save 5
			torsaveteamin47(5)
			when 9 #Load 5
			torloadteamin47(5)
			break
			end
	end
end

def torDebugMadness
		loop do
		madcmds=[
		_INTL("Set Party to Cap (Half)"),
		_INTL("smh"),
		]
		madcmd=0
		madcmd=Kernel.pbShowCommands(nil,madcmds,-1,madcmd)
		break if madcmd<0
		case madcmd
			when 0
			  leadersDefeated = $Trainer.numbadges
			  lcap=LEVELCAPS[leadersDefeated] + $game_variables[595]
			  if lcap>100
			  lcap=lcap-50
			  end
				  for i in $Trainer.party
					i.level=(lcap/2).floor
					i.calcStats
				end
				i.calcStats
				Kernel.pbMessage(_INTL("Your Pokémon were set to half level cap. Nerd."))
			when 1
				Kernel.pbMessage(_INTL("Ok."))
			end
		end
end

def torDebuge19shortcut
	scenariocmd=0
	loop do
	scenariocmds=[
	_INTL("Glass Gauntlet 3"),
	_INTL("Glass Gauntlet 2"),
	_INTL("Lin 3 (Anna)"),
	_INTL("Lin 2 (Anna)"),
	_INTL("Lin 2 (Lin)"),
	_INTL("Lin 1 (Conk)"),
	_INTL("Lin 1 (Toge)"),
	_INTL("Elite 4 Anna"),
	_INTL("Elite 4 Elias"),
	_INTL("Elite 4 Tag Team"),
	_INTL("Elite 4 Heather"),
	_INTL("Mega Ring fights"),
	_INTL("Fiore 3 (Julia)"),
	_INTL("Fiore 3 (Flobot)"),
	_INTL("Fiore 2"),
	]
	scenariocmd=Kernel.pbShowCommands(nil,scenariocmds,-1,scenariocmd)
	break if scenariocmd<0
		case scenariocmd
		when 0
		$game_variables[161] = 17
		pbDoubleTrainerBattle(PBTrainers::QMARK,"?????",1,_I("???"),PBTrainers::QMARK,"?????",2,_I("???"))
		$game_variables[161] = 0
		when 1
		$game_variables[161] = 17
		pbTrainerBattle(PBTrainers::QMARK,"?????",_I("???"),false,0)
		$game_variables[161] = 0
		when 2
		$game_switches[1303] = true
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::CHILDLIN,"Lin",_I("huh??????"),false,0,true)
		$game_variables[161] = 0
		$game_switches[1303] = false
		when 3
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("I've waited for so long."),false,3)
		$game_variables[161] = 0
		when 4
		$game_switches[1000] = true
		$game_switches[1303] = true
		$game_variables[161] = 35
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("I've waited for so long."),false,2)
		$game_variables[161] = 0
		$game_switches[1000] = false
		$game_switches[1303] = false
		when 5
		$game_switches[1000] = true
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("Before you sleep, creature, you have one more task."),false,0)
		$game_switches[1000] = false
		when 6
		$game_switches[1000] = true
		pbTrainerBattle(PBTrainers::LIN,"Lin",_I("Before you sleep, creature, you have one more task."),false,1)
		$game_switches[1000] = false
		when 7
		$game_switches[1000] = true
		$game_variables[161] = 34
		pbTrainerBattle(PBTrainers::ANNA,"Anna",_I("If stars never fell, how would anyone make their wishes?"),false,0)
		$game_variables[161] = 0
		$game_switches[1000] = false
		when 8
		Kernel.pbMessage(_INTL("Godspeed!"))
		$game_variables[161] = 29
		pbTrainerBattle(PBTrainers::ELIAS,"Elias",_I("So be it."),false,0)
		$game_variables[161] = 0
		when 9
		$game_variables[161] = 33
		pbTrainerBattle(PBTrainers::BENNETTLAURA,"Bennett & Laura",_I("BENNETT: Impressive. I'll make note to study this later."),true,0)
		$game_variables[161] = 0
		when 10
		$game_variables[161] = 27
		pbTrainerBattle(PBTrainers::HEATHER,"Heather",_I("No! No! Nonononononono!!!"),false,0)
		$game_variables[161] = 0
		when 11
		pbDoubleTrainerBattle(PBTrainers::CUEBALL,"Colin",0,_I("I don't think this was in the plan."),PBTrainers::CUEBALL,"Matthew",0,_I("Uhh... Boss?"))
		pbTrainerBattle(PBTrainers::MASTERMIND,"Eustace",_I("Wha-- Adults ruin everything!"),false)
		when 12
		pbRegisterPartner(PBTrainers::JULIA,"Julia",1)
		pbDoubleTrainerBattle(PBTrainers::NWOrderly,"John",0,_I("I did my best, sir."),PBTrainers::Solaris,"Solaris",1,_I("Your purpose is asinine, but I must respect your ability."))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		when 13
		pbRegisterPartner(PBTrainers::FLORINIA,"Florinia",1)
		pbDoubleTrainerBattle(PBTrainers::NWOrderly,"John",0,_I("I did my best, sir."),PBTrainers::Solaris,"Solaris",1,_I("Your purpose is asinine, but I must respect your ability."))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		when 14
		pbRegisterPartner(PBTrainers::FLORINIA,"Florinia",1)
		pbDoubleTrainerBattle(PBTrainers::BLAKE,"Blake",1,_I("Tch, fuck this."),PBTrainers::Hotshot,"Fern",6,_I("You're gonna regret crossing me-- both of you will!"))
		Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
		a=0; b="lol"; c=a+b;
		end
	end

end

def torDebuge20shortcut
		scenariocmd=0
		loop do
		scenariocmds=[
		_INTL("Tier 8 : Lin Boss - Part 2"),
		_INTL("Tier 8 : Lin Boss - Part 3"),
		_INTL("Tier 7 : Titania & Groudon"),
		_INTL("Tier 7 : Amaria & Kyogre"),
		_INTL("Tier 8 : Anna Boss - Part 2"),
		_INTL("Tier 8 : Anna Boss - Part 3"),
		_INTL("Tao 1 - with Zero"),
		_INTL("Tao 2 - with Zero"),
		_INTL("Tao 1 - with Pirate Taka"),
		_INTL("Tao 2 - with Pirate Taka"),
		_INTL("Tao 1 - with Reborn Taka"),
		_INTL("Tao 2 - with Reborn Taka"),
		]
		scenariocmd=Kernel.pbShowCommands(nil,scenariocmds,-1,scenariocmd)
		break if scenariocmd<0
			case scenariocmd
			when 0 # Lin 2
			$game_variables[192] = 1
			$game_variables[161] = 35
			pbTrainerBattle(PBTrainers::CHILDLIN,"Lin",_I("well i hope YOU'RE having a good time at least."),true,2,true)
			$game_variables[192] = 0
			$game_variables[161] = 0
			when 1
			$game_switches[1000] = true
			$game_variables[161] = 35
			$game_switches[1303] = true
			pbTrainerBattle(PBTrainers::ARCEUS,"Arceus",_I("Caraa~"),false,0,true)
			$game_switches[1303] = false
			$game_switches[1000] = false
			$game_variables[161] = 0
			when 2
			$game_variables[161] = 2
			pbDoubleTrainerBattle(PBTrainers::UMBTITANIA,"Titania",2,_I("XXXXXXXXX!!!"),PBTrainers::GROUDON,"Groudon",0,_I("Graaagh!!!"),true)
			$game_variables[161] = 0
			when 3
			$game_variables[161] = 21
			pbDoubleTrainerBattle(PBTrainers::UMBAMARIA,"Amaria",2,_I("XXXXXXXXX!!!"),PBTrainers::KYOGRE,"Kyogre",0,_I("Gyoorrrgh!!!"))
			$game_variables[161] = 0
			when 4 # Anna
			$game_switches[1942] = true
			$game_variables[192] = 0
			pbTrainerBattle(PBTrainers::ANNA2,"Anna",_I("WHY?!? i just... wanted..."),false,0)
			$game_switches[1942] = false
			when 5 #Arceus Anna
			$game_switches[1000] = true
			$game_switches[1303] = true
			pbTrainerBattle(PBTrainers::ARCEUS,"Arceus",_I("Caraa~"),false,1)
			$game_switches[1000] = false
			$game_switches[1303] = false
			when 6 #Tao 1 Zero
			pbRegisterPartner(PBTrainers::ZEL3,"Zero",0)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 7
			pbRegisterPartner(PBTrainers::ZEL3,"Zero",0)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 8
			pbRegisterPartner(PBTrainers::ZTAKA2,"Taka",0)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 9
			pbRegisterPartner(PBTrainers::ZTAKA2,"Taka",0)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 10
			pbRegisterPartner(PBTrainers::Taka2,"Taka",1)
			$game_variables[161] = 13
			pbDoubleTrainerBattle(PBTrainers::ZEKROM,"Zekrom",0,_I("Zaaaaaaaaaahk!"),PBTrainers::RESHIRAM,"Reshiram",0,_I("Yrrrraaaah!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			when 11
			pbRegisterPartner(PBTrainers::Taka2,"Taka",1)
			$game_variables[161] = 35
			pbDoubleTrainerBattle(PBTrainers::KYUREM1,"Kyurem",0,_I("Kyuuu!!!"),PBTrainers::KYUREM2,"Fusion Simulations",0,_I("Raaaaaaam!!!"))
			Kernel.pbMessage(_INTL("Crashing your game, just in case you already had a partner and erased it"))
			a=0; b="lol"; c=a+b;
			end
		end
end

def torDebugAddMoPreset
	monzcmd=0
		loop do
		monzcmds=[
		_INTL("Smeargle with 4 Terrain Moves"),
		_INTL("Jigglypuff (Mega Quest)"),
		_INTL("Loudred (Mega Quest)"),
		_INTL("Makuhita (Mega Quest)"),
		_INTL("Roggenrola (Mega Quest)"),
		_INTL("Vanillite (Mega Quest)"),
		]
		monzcmd=Kernel.pbShowCommands(nil,monzcmds,-1,monzcmd)
		break if monzcmd<0
			case monzcmd
			when 0
			poke=PokeBattle_Pokemon.new(:SMEARGLE,100);poke.pbLearnMove(:MISTYTERRAIN);poke.pbLearnMove(:PSYCHICTERRAIN);
			poke.pbLearnMove(:GRASSYTERRAIN);poke.pbLearnMove(:ELECTRICTERRAIN);pbAddPokemon(poke)
			when 1
			poke=PokeBattle_Pokemon.new(:JIGGLYPUFF,30);poke.ot="Santiago";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 2
			poke=PokeBattle_Pokemon.new(:LOUDRED,35);poke.ot="Lillin";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 3
			poke=PokeBattle_Pokemon.new(:MAKUHITA,40);poke.ot="Felicia";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 4
			poke=PokeBattle_Pokemon.new(:ROGGENROLA,24);poke.ot="Mr.McKrezzy";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			when 5
			poke=PokeBattle_Pokemon.new(:VANILLITE,35);poke.ot="Eustace";	poke.trainerID=$Trainer.getForeignID;pbAddPokemon(poke)
			end
		end
end

def torDebugOrderBoxes
			params=ChooseNumberParams.new
			params.setRange(2,140)
			params.setDefaultValue(10)
			maxbox=Kernel.pbMessageChooseNumber(
			_INTL("This orders Pokemon by dex numbers between boxes 2 and X. Decide X in [3;140]"),params)
			torBoxSorter(2,maxbox)
end

def torDebugRandomID
      $Trainer.id=rand(256)
      $Trainer.id|=rand(256)<<8
      $Trainer.id|=rand(256)<<16
      $Trainer.id|=rand(256)<<24
      Kernel.pbMessage(_INTL("The player's ID was changed to {1} (2).",$Trainer.publicID,$Trainer.id))
end

def torDebugSetMoney
      params=ChooseNumberParams.new
      params.setMaxDigits(6)
      params.setDefaultValue($Trainer.money)
      $Trainer.money=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's money."),params)
      Kernel.pbMessage(_INTL("You now have ${1}.",$Trainer.money))

end

def torDebugSetCoins
      params=ChooseNumberParams.new
      params.setRange(0,MAXCOINS)
      params.setDefaultValue($PokemonGlobal.coins)
      $PokemonGlobal.coins=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's Coin amount."),params)
      Kernel.pbMessage(_INTL("You now have {1} Coins.",$PokemonGlobal.coins))
end

def torDebugStealTrainer
		trainerchoice=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
		if !trainerchoice
		else
		trainerdata=trainerchoice[1]
		boxtrack=0
			for poke in trainerdata[3]
			opponent=PokeBattle_Trainer.new(trainerdata[1],trainerdata[0])
			species=poke[TPSPECIES]
			level=poke[TPLEVEL]
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level,opponent)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke[TPFORM]
			pokemon.resetMoves
			pokemon.setItem(poke[TPITEM])
				if poke[TPMOVE1]>0 || poke[TPMOVE2]>0 || poke[TPMOVE3]>0 || poke[TPMOVE4]>0
				k=0
					for move in [TPMOVE1,TPMOVE2,TPMOVE3,TPMOVE4]
					pokemon.moves[k]=PBMove.new(poke[move])
					k+=1
					end
				end
			pokemon.setAbility(poke[TPABILITY])
			pokemon.setGender(poke[TPGENDER])
				if poke[TPSHINY]   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke[TPNATURE])
			iv=poke[TPIV]
				if iv==32
					for i in 0...6
					pokemon.iv[i]=31
					end
				pokemon.iv[3]=0
				else
					for i in 0...6
					pokemon.iv[i]=iv&0x1F
					end
				end
			evsum = poke[TPHPEV].to_i+poke[TPATKEV].to_i+poke[TPDEFEV].to_i+poke[TPSPEEV].to_i+poke[TPSPAEV].to_i+poke[TPSPDEV].to_i
				if evsum>0 
				pokemon.ev=[poke[TPHPEV].to_i,
				poke[TPATKEV].to_i,
				poke[TPDEFEV].to_i,
				poke[TPSPEEV].to_i,
				poke[TPSPAEV].to_i,
				poke[TPSPDEV].to_i]
				elsif evsum == 0
					for i in 0...6
					pokemon.ev[i]=[85,level*3/2].min
					end
				end
			pokemon.calcStats
			$PokemonStorage[47,boxtrack]=pokemon
			boxtrack=boxtrack+1
			end
			if boxtrack<5
			imax=7-boxtrack
				for i in 1...imax
				$PokemonStorage.pbDelete(47,boxtrack)
				boxtrack=boxtrack+1
				end
			end
		end
end

def torDebug1v2
      battle1=pbListScreen(_INTL("DOUBLE TRAINER 1"),TrainerBattleLister.new(0,false))
      if battle1
        battle2=pbListScreen(_INTL("DOUBLE TRAINER 2"),TrainerBattleLister.new(0,false))
        if battle2
          trainerdata1=battle1[1]
          trainerdata2=battle2[1]
          pbDoubleTrainerBattle(trainerdata1[0],trainerdata1[1],trainerdata1[4],"...",
                                trainerdata2[0],trainerdata2[1],trainerdata2[4],"...",
                                true)
        end
      end
end

def torDebug2v2
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",true,trainerdata[4],true)
      end
end

def torDebug1v1
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",false,trainerdata[4],true)
      end
end

def torDebugDaycare
      daycarecmd=0
      loop do
        daycarecmds=[
           _INTL("Summary"),
           _INTL("Deposit Pokémon"),
           _INTL("Withdraw Pokémon"),
           _INTL("Generate egg"),
           _INTL("Collect egg"),
           _INTL("Dispose egg")
        ]
        daycarecmd=Kernel.pbShowCommands(nil,daycarecmds,-1,daycarecmd)
        break if daycarecmd<0
        case daycarecmd
          when 0 # Summary
            if $PokemonGlobal.daycare
              num=pbDayCareDeposited
              Kernel.pbMessage(_INTL("{1} Pokémon are in the Day Care.",num))
              if num>0
                txt=""
                for i in 0...num
                  next if !$PokemonGlobal.daycare[i][0]
                  pkmn=$PokemonGlobal.daycare[i][0]
                  initlevel=$PokemonGlobal.daycare[i][1]
                  gender=[_INTL("♂"),_INTL("♀"),_INTL("genderless")][pkmn.gender]
                  txt+=_INTL("{1}) {2} ({3}), Lv.{4} (deposited at Lv.{5})",
                     i,pkmn.name,gender,pkmn.level,initlevel)
                  txt+="\n" if i<num-1
                end
                Kernel.pbMessage(txt)
              end
              if $PokemonGlobal.daycareEgg==1
                Kernel.pbMessage(_INTL("An egg is waiting to be picked up."))
              elsif pbDayCareDeposited==2
                if pbDayCareGetCompat==0
                  Kernel.pbMessage(_INTL("The deposited Pokémon can't breed."))
                else
                  Kernel.pbMessage(_INTL("The deposited Pokémon can breed."))
                end
              end
            end
          when 1 # Deposit Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't deposit Pokémon."))
            elsif pbDayCareDeposited==2
              Kernel.pbMessage(_INTL("Two Pokémon are deposited already."))
            elsif $Trainer.party.length==0
              Kernel.pbMessage(_INTL("Party is empty, can't desposit Pokémon."))
            else
              pbChooseNonEggPokemon(1,3)
              if pbGet(1)>=0
                pbDayCareDeposit(pbGet(1))
                Kernel.pbMessage(_INTL("Deposited {1}.",pbGet(3)))
              end
            end
          when 2 # Withdraw Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't withdraw Pokémon."))
            elsif pbDayCareDeposited==0
              Kernel.pbMessage(_INTL("No Pokémon are in the Day Care."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't withdraw Pokémon."))
            else
              pbDayCareChoose(_INTL("Which one do you want back?"),1)
              if pbGet(1)>=0
                pbDayCareGetDeposited(pbGet(1),3,4)
                pbDayCareWithdraw(pbGet(1))
                Kernel.pbMessage(_INTL("Withdrew {1}.",pbGet(3)))
              end
            end
          when 3 # Generate egg
            if $PokemonGlobal.daycareEgg==1
              Kernel.pbMessage(_INTL("An egg is already waiting."))
            elsif pbDayCareDeposited!=2
              Kernel.pbMessage(_INTL("There aren't 2 Pokémon in the Day Care."))
            elsif pbDayCareGetCompat==0
              Kernel.pbMessage(_INTL("The Pokémon in the Day Care can't breed."))
            else
              $PokemonGlobal.daycareEgg=1
              Kernel.pbMessage(_INTL("An egg is now waiting in the Day Care."))
            end
          when 4 # Collect egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't collect the egg."))
            else
              pbDayCareGenerateEgg
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Collected the {1} egg.",
                 PBSpecies.getName($Trainer.party[$Trainer.party.length-1].species)))
            end
          when 5 # Dispose egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            else
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Disposed of the egg."))
            end
        end
      end
end

def torDebugQuickhatch
      for pokemon in $Trainer.party
        pokemon.eggsteps=1 if pokemon.isEgg?
      end
      Kernel.pbMessage(_INTL("All eggs on your party now require one step to hatch."))
end

def torDebugWildSingles
      species=pbChooseSpeciesOrdered(1)
      if species!=0
        params=ChooseNumberParams.new
        params.setRange(1,PBExperience::MAXLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's level."),params)
        if level>0
          pbWildBattle(species,level)
        end
      end
end

def torDebugWildDoubles
      Kernel.pbMessage(_INTL("Choose the first Pokémon."))
      species1=pbChooseSpeciesOrdered(1)
      if species1!=0
        params=ChooseNumberParams.new
        params.setRange(1,PBExperience::MAXLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level1=Kernel.pbMessageChooseNumber(
           _INTL("Set the first Pokémon's level."),params)
        if level1>0
          Kernel.pbMessage(_INTL("Choose the second Pokémon."))
          species2=pbChooseSpeciesOrdered(1)
          if species2!=0
            params=ChooseNumberParams.new
            params.setRange(1,PBExperience::MAXLEVEL)
            params.setInitialValue(5)
            params.setCancelValue(0)
            level2=Kernel.pbMessageChooseNumber(
               _INTL("Set the second Pokémon's level."),params)
            if level2>0
              pbDoubleWildBattle(species1,level1,species2,level2)
            end
          end
        end
      end
end



def torsaveteamin47(slot)
	pcslot=0+6*(slot-1)
	inipcslot=pcslot
	for poke in $Trainer.party
			species=poke.species
			level=poke.level
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke.form
			pokemon.resetMoves
			pokemon.setItem(poke.item)
			pokemon.pbDeleteAllMoves
			
			for i in 0...4
				if (poke.moves[i].id>0)
					pokemon.pbLearnMove(poke.moves[i].id)
					pokemon.moves[i].ppup=poke.moves[i].ppup
					pokemon.moves[i].pp=poke.moves[i].pp
				end
			end
			kreal=0
			for k in 0..9
			pokemon.setAbility(k)
				if pokemon.ability==poke.ability
				kreal=k
				end
			end
			pokemon.setAbility(kreal)
			pokemon.setGender(poke.gender)
			pokemon.name=poke.name
			pokemon.status=poke.status
			pokemon.statusCount=poke.statusCount
			pokemon.hptype=poke.hptype
			pokemon.happiness=poke.happiness
			pokemon.obtainMode=poke.obtainMode
			pokemon.obtainMap=poke.obtainMap
			pokemon.obtainText=poke.obtainText
			pokemon.obtainLevel=poke.obtainLevel
			pokemon.timeReceived=(poke.timeReceived)
			
				if poke.shinyflag   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke.natureflag)
				for i in 0...6
				pokemon.iv[i]=poke.iv[i]
				end
				for i in 0...6
				pokemon.ev[i]=poke.ev[i]
				end
			pokemon.calcStats
			pokemon.hp=poke.hp
			pokemon.calcStats
			$PokemonStorage[46,pcslot]=pokemon
			pcslot=pcslot+1
			end
			if pcslot<5+inipcslot
			maxpcslot=inipcslot+6
			imax=7-pcslot
				for i in pcslot...maxpcslot
				$PokemonStorage.pbDelete(46,i)
				end
			
	end
end

def torloadteamin47(slot)
	pcslot=0+6*(slot-1)
	inipcslot=pcslot
	for j in 0...6
	$Trainer.party[j]=nil
	end
	$Trainer.party.compact!
	
	for l in 1...7
	poke=$PokemonStorage[46,pcslot]
		if poke!=nil
			species=poke.species
			level=poke.level
			pokegift=PokeBattle_Pokemon.new(species,level)
			pokemon=PokeBattle_Pokemon.new(species,level)
			pokemon.form=poke.form
			pokemon.resetMoves
			pokemon.setItem(poke.item)
			pokemon.pbDeleteAllMoves
			
			for i in 0...4
				if (poke.moves[i].id>0)
					pokemon.pbLearnMove(poke.moves[i].id)
					pokemon.moves[i].ppup=poke.moves[i].ppup
					pokemon.moves[i].pp=poke.moves[i].pp
				end
			end
			kreal=0
			for k in 0..9
			pokemon.setAbility(k)
				if pokemon.ability==poke.ability
				kreal=k
				end
			end
			pokemon.setAbility(kreal)
			pokemon.setGender(poke.gender)
			pokemon.name=poke.name
			pokemon.status=poke.status
			pokemon.statusCount=poke.statusCount
			pokemon.hptype=poke.hptype
			pokemon.happiness=poke.happiness
			pokemon.obtainMode=poke.obtainMode
			pokemon.obtainMap=poke.obtainMap
			pokemon.obtainText=poke.obtainText
			pokemon.obtainLevel=poke.obtainLevel
			pokemon.timeReceived=(poke.timeReceived)
			
				if poke.shinyflag   # if this is a shiny Pokémon
				pokemon.makeShiny
				else
				pokemon.makeNotShiny
				end
			pokemon.setNature(poke.natureflag)
				for i in 0...6
				pokemon.iv[i]=poke.iv[i]
				end
				for i in 0...6
				pokemon.ev[i]=poke.ev[i]
				end
			pokemon.calcStats
			pokemon.hp=poke.hp
			pokemon.calcStats
			pbStorePokemon(pokemon)
			pcslot=pcslot+1
			end
		end
end

def torselfteamtotext
# Exports your team in a file in the game folder.
    f = File.open("Team Data - My Own Team.txt","w")
    for poke in $Trainer.party
		#If the form isn't the base form, gives a warning. Also mentions the typings to easily notice stuff like Kyurems and Necrozmas.
        if poke.form!=0
			f.write("WATCH OUT, THIS POKEMON IS NOT IN ITS BASE FORM. ITS TYPING IS #{PBTypes.getName(poke.type1)} #{PBTypes.getName(poke.type2)}\n")
		end
		f.write(PBSpecies.getName(poke.species))
        if poke.item!=0
			f.write(" @ ")
			f.write(PBItems.getName(poke.item))
        end
		f.write("\n")
		f.write("Level: ")
		f.write(poke.poklevel)
		f.write("\n")
        f.write(PBNatures.getName(poke.nature))
		f.write(" Nature\n")
		f.write("Ability: ")
        f.write(PBAbilities.getName(poke.ability))
        f.write("\n")
        f.write("EVs: #{poke.ev[0]} HP / #{poke.ev[1]} Atk / #{poke.ev[2]} Def / #{poke.ev[4]} SpA / #{poke.ev[5]} SpD / #{poke.ev[3]} Spe\n")
        f.write("IVs: #{poke.iv[0]} HP / #{poke.iv[1]} Atk / #{poke.iv[2]} Def / #{poke.iv[4]} SpA / #{poke.iv[5]} SpD / #{poke.iv[3]} Spe\n")
        for move in poke.moves
			if move.id>0
			f.write("- ")
			f.write(PBMoves.getName(move.id))
			f.write("\n")
			end
        end
        f.write("\n")
		f.write("-----------------")
        f.write("\n\n")
    end
    f.close
	
end

def torallopponentsteamtotext
# Exports the entirety of the trainers in a trainer file
# Opens the file
f = File.open("Team Data - Opponents.txt","w")
# Loops around for every single trainer in the game (1135).
	for i in 0..1137
	# Grab the trainer from the list and its data
	trainerchoice=torFakeListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false),i)
	trainerdata=trainerchoice[1]
	# Write down basic information about the trainer, such as the name and number of the trainer.
	f.write("Trainer Info : #{PBTrainers.getName(trainerdata[0])} -  #{trainerdata[1]} - Team #{trainerdata[4]}\n\n")
		for poke in trainerdata[3]
		# Create the actual pokemon to be exported
		opponent=PokeBattle_Trainer.new(trainerdata[1],trainerdata[0])
		species=poke[TPSPECIES]
		level=poke[TPLEVEL]
		pokegift=PokeBattle_Pokemon.new(species,level)
		pokemon=PokeBattle_Pokemon.new(species,level,opponent)
		pokemon=PokeBattle_Pokemon.new(species,level)
		pokemon.form=poke[TPFORM]
		pokemon.resetMoves
		pokemon.setItem(poke[TPITEM])
			if poke[TPMOVE1]>0 || poke[TPMOVE2]>0 || poke[TPMOVE3]>0 || poke[TPMOVE4]>0
			k=0
				for move in [TPMOVE1,TPMOVE2,TPMOVE3,TPMOVE4]
				pokemon.moves[k]=PBMove.new(poke[move])
				k+=1
				end
			end
		pokemon.setAbility(poke[TPABILITY])
		pokemon.setGender(poke[TPGENDER])
			if poke[TPSHINY]   # if this is a shiny Pokémon
			pokemon.makeShiny
			else
			pokemon.makeNotShiny
			end
		pokemon.setNature(poke[TPNATURE])
		iv=poke[TPIV]
			if iv==32
				for i in 0...6
				pokemon.iv[i]=31
				end
			pokemon.iv[3]=0
			else
				for i in 0...6
				pokemon.iv[i]=iv&0x1F
				end
			end
		evsum = poke[TPHPEV].to_i+poke[TPATKEV].to_i+poke[TPDEFEV].to_i+poke[TPSPEEV].to_i+poke[TPSPAEV].to_i+poke[TPSPDEV].to_i
			if evsum>0 
			pokemon.ev=[poke[TPHPEV].to_i,
			poke[TPATKEV].to_i,
			poke[TPDEFEV].to_i,
			poke[TPSPEEV].to_i,
			poke[TPSPAEV].to_i,
			poke[TPSPDEV].to_i]
			elsif evsum == 0
				for i in 0...6
				pokemon.ev[i]=[85,level*3/2].min
				end
			end
		pokemon.calcStats
		#Now the pokemon is created. We export it with the same method as the other one.
		#If the form isn't the base form, gives a warning. Also mentions the typings to easily notice stuff like Kyurems and Necrozmas.
			if pokemon.form!=0
			f.write("WATCH OUT, THIS POKEMON IS NOT IN ITS BASE FORM. ITS TYPING IS #{PBTypes.getName(pokemon.type1)} #{PBTypes.getName(pokemon.type2)}\n")
			end
		f.write(PBSpecies.getName(pokemon.species))
			if pokemon.item!=0
				f.write(" @ ")
				f.write(PBItems.getName(pokemon.item))
			end
		f.write("\n")
		f.write("Level: ")
		f.write(pokemon.poklevel)
		f.write("\n")
		f.write(PBNatures.getName(pokemon.nature))
		f.write(" Nature\n")
		f.write("Ability: ")
		f.write(PBAbilities.getName(pokemon.ability))
		f.write("\n")
		f.write("EVs: #{pokemon.ev[0]} HP / #{pokemon.ev[1]} Atk / #{pokemon.ev[2]} Def / #{pokemon.ev[4]} SpA / #{pokemon.ev[5]} SpD / #{pokemon.ev[3]} Spe\n")
		f.write("IVs: #{pokemon.iv[0]} HP / #{pokemon.iv[1]} Atk / #{pokemon.iv[2]} Def / #{pokemon.iv[4]} SpA / #{pokemon.iv[5]} SpD / #{pokemon.iv[3]} Spe\n")
			for move in pokemon.moves
				if move.id>0
				f.write("- ")
				f.write(PBMoves.getName(move.id))
				f.write("\n")
				end
			end
		f.write("\n")
		f.write("-----------------")
		f.write("\n\n")
		end
	end
f.close
end

def torBoxSorter(boxbeginning,boxend)
	if boxbeginning>boxend
	else
	box11=torBoxToInt(boxbeginning,1)
	box1n=torBoxToInt(boxbeginning,30)
	boxnn=torBoxToInt(boxend,30)
		for i in box11..box1n
		ibox=torIntToBox(i)[0]
		islot=torIntToBox(i)[1]
		wbox=ibox
		wslot=islot
			if $PokemonStorage[ibox-1,islot-1]
			idinitial=$PokemonStorage[ibox-1,islot-1].species
			idminimum=idinitial
			else
			idinitial=999
			idminimum=999
			end
			for j in i..boxnn
			jbox=torIntToBox(j)[0]
			jslot=torIntToBox(j)[1]
				if $PokemonStorage[jbox-1,jslot-1]
				idcurrent=$PokemonStorage[jbox-1,jslot-1].species
				else
				idcurrent=999
				end
				if idcurrent<idminimum
				idminimum=idcurrent
				wbox=jbox
				wslot=jslot
				end
			end
		poke1=$PokemonStorage[ibox-1,islot-1]
		poke2=$PokemonStorage[wbox-1,wslot-1]
		nom1=""
		nom2=""
			if poke1
			nom1=poke1.name
			end
			if poke2
			nom2=poke2.name
			end
			$PokemonStorage[ibox-1,islot-1]=poke2
			$PokemonStorage[wbox-1,wslot-1]=poke1
		end
	torBoxSorter(boxbeginning+1,boxend)
	end

end

def torBoxToInt(box,spot)
return 30*box+spot
end

def torIntToBox(int)
#box 1 is 1 to 30, but slot 1 is 0 (0,0) so watch out, me
retour=[]
retour[0]=int.div(30)
retour[1]=int-30*retour[0]
	if retour[1]==0
	retour[0]=retour[0]-1
	retour[1]=30
	end
return retour 

end

def torFakeListScreen(title,lister,i)
# Code that "simulates" the opening of a debugging trainer list, and instead pre-picks the value according to i.
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],256)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=256
  title.y=0
  title.width=Graphics.width-256
  title.height=64
  title.viewport=viewport
  title.z=2
  lister.setViewport(viewport)
  selectedmap=-1
  commands=lister.commands
  selindex=lister.startIndex
  if commands.length==0
    value=lister.value(-1)
    lister.dispose
    return value
  end
  list.commands=commands
  list.index=selindex
  value=lister.value(i)
  lister.dispose
  title.dispose
  list.dispose
  Input.update
  return value
end