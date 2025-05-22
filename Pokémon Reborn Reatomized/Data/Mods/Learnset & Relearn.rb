#Fusion of Haru's Move Tutors mod and Torre's Pokemon Learnset Display mod (since they're not compatible otherwise)
#Also slightly modified for Reatomized

#### from Haru's Move Tutors mod
class PokeBattle_Pokemon
    attr_accessor :tutorMoves

    def getTutorMoveList
        ret = []
        return ret if self.tutorMoves == nil
        return ret if self.tutorMoves.length == 0
        for i in 0...self.tutorMoves.length
            ret.push(self.tutorMoves[i])
        end
        return ret
    end
end

def pbGetRelearnableMoves(pokemon)
    return [] if !pokemon || pokemon.isEgg? || (pokemon.isShadow? rescue false)
    returnMoves = []
    moves=[]
    pbEachNaturalMove(pokemon){|move,level|
       if level<=pokemon.level && !pokemon.knowsMove?(move)
         moves.push(move) if !moves.include?(move)
       end
    }
    tmoves=[]
    if pokemon.firstmoves
      for i in pokemon.firstmoves
        tmoves.push(i) if !pokemon.knowsMove?(i) && !moves.include?(i)
      end
    end
    tutorMoves = pokemon.getTutorMoveList

    returnMoves=tmoves+moves + tutorMoves
    return returnMoves|[] # remove duplicates
  end

def pbMoveTutorChoose(move,movelist=nil,bymachine=false)
    ret=false
    pbFadeOutIn(99999){
        scene=PokemonScreen_Scene.new
        movename=PBMoves.getName(move)
        screen=PokemonScreen.new(scene,$Trainer.party)
        annot=pbMoveTutorAnnotations(move,movelist)
        screen.pbStartScene(_INTL("Teach which Pokémon?"),false,annot)
        loop do
            chosen=screen.pbChoosePokemon
            if chosen>=0
            pokemon=$Trainer.party[chosen]
            if pokemon.isEgg?
                Kernel.pbMessage(_INTL("{1} can't be taught to an Egg.",movename))
            elsif (pokemon.isShadow? rescue false)
                Kernel.pbMessage(_INTL("Shadow Pokémon can't be taught any moves."))
            elsif movelist && !movelist.any?{|j| j==pokemon.species }
                Kernel.pbMessage(_INTL("{1} is not compatible with {2}.",pokemon.name,movename))
                Kernel.pbMessage(_INTL("{1} can't be learned.",movename))
            elsif !pbSpeciesCompatible?(pokemon.species,move,pokemon)
                Kernel.pbMessage(_INTL("{1} is not compatible with {2}.",pokemon.name,movename))
                Kernel.pbMessage(_INTL("{1} can't be learned.",movename))
            else
                if pbLearnMove(pokemon,move,false,bymachine)
                    if bymachine == false
                        if pokemon.tutorMoves == nil
                            pokemon.tutorMoves = Array.new()
                        end
                        pokemon.tutorMoves.push(move) if !pokemon.tutorMoves.include?(move)
                    end
                    ret=true
                    break
                end
            end
            else
            break
            end
        end
        screen.pbEndScene
    }
    return ret # Returns whether the move was learned by a Pokemon
end



#### from Torre's Pokemon Learnset Display mod
def pbChooseMoveLearnset(pkmn,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  movelist=pkmn.getMoveList
  movesdisplay=[]
  for move in movelist
    level=move[0]
    name=PBMoves.getName(move[1])
    commands.push([move[1],"#{level} - #{name}"]) if name!=nil && name!=""
  end
  #commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def pbChooseMoveEggs(pkmn,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  movelist=swm_getAllEggMoves(pkmn)
  movesdisplay=[]
  for move in movelist
    #level=move[0]
    name=PBMoves.getName(move)
    commands.push([move,"#{name}"]) if name!=nil && name!=""
  end
  #commands.sort! {|a,b| a[1]<=>b[1]}
  if commands.length==0
  pbDisplay(_INTL("There are no legal moves."))
  cmdwin.dispose
  return 0
  end
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def swm_getAllEggMoves(pokemon) # from Waynolt's LearnEggMoves mod
  moves=[]
  babies=swm_getPossibleBabies(pokemon.species)
  for baby in babies
    tmp=swm_getEggMoves(baby, pokemon.form)
    moves.push(*tmp)
  end
  moves|=[] # remove duplicates
  retval=[]
  for move in moves
    # next if level>pokemon.level # No need to check for level... we're talking egg moves here, remember?
    next if pokemon.knowsMove?(move)
    retval.push(move)
  end
  return retval
end

def pbChooseMoveTutor(pkmn,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  movelist=tor_getAllTutors(pkmn)
  movesdisplay=[]
  for move in movelist
    #level=move[0]
    name=PBMoves.getName(move)
    commands.push([move,"#{name}"]) if name!=nil && name!=""
  end
  #commands.sort! {|a,b| a[1]<=>b[1]}
  if commands.length==0
  pbDisplay(_INTL("There are no legal moves."))
  cmdwin.dispose
  return 0
  end
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def tor_getAllTutors(pokemon)
  tutorlist=
[PBMoves::MAGICCOAT,PBMoves::MAGICROOM,PBMoves::WONDERROOM,PBMoves::TELEKINESIS,PBMoves::IRONDEFENSE,PBMoves::SNORE,PBMoves::BIND,PBMoves::SPITE,PBMoves::SNATCH,
PBMoves::HELPINGHAND,PBMoves::ALLYSWITCH,PBMoves::AFTERYOU,PBMoves::GRAVITY,PBMoves::MAGNETRISE,PBMoves::BLOCK,PBMoves::WORRYSEED,PBMoves::GIGADRAIN,PBMoves::WATERPLEDGE,
PBMoves::FIREPLEDGE,PBMoves::GRASSPLEDGE,PBMoves::GASTROACID,PBMoves::RECYCLE,PBMoves::ENDEAVOR,PBMoves::PAINSPLIT,PBMoves::VOLTTACKLE,PBMoves::ROLEPLAY,PBMoves::COVET,
PBMoves::ELECTROWEB,PBMoves::SKYATTACK,PBMoves::TRICK,PBMoves::DEFOG,PBMoves::LASERFOCUS,PBMoves::SKILLSWAP,PBMoves::WATERPULSE,PBMoves::LASTRESORT,PBMoves::SUPERFANG,
PBMoves::SHOCKWAVE,PBMoves::HEADBUTT,PBMoves::BOUNCE,PBMoves::HEALBELL,PBMoves::BUGBITE,PBMoves::DUALCHOP,PBMoves::THUNDERPUNCH,PBMoves::FIREPUNCH,PBMoves::ICEPUNCH,
PBMoves::UPROAR,PBMoves::HYPERVOICE,PBMoves::STOMPINGTANTRUM,PBMoves::LOWKICK,PBMoves::IRONTAIL,PBMoves::FOCUSPUNCH,PBMoves::DRILLRUN,PBMoves::SYNTHESIS,PBMoves::KNOCKOFF,
PBMoves::IRONHEAD,PBMoves::GIGADRAIN,PBMoves::LIQUIDATION,PBMoves::AQUATAIL,PBMoves::ICYWIND,PBMoves::SIGNALBEAM,PBMoves::THROATCHOP,PBMoves::DRAINPUNCH,PBMoves::TAILWIND,
PBMoves::ZENHEADBUTT,PBMoves::STEALTHROCK,PBMoves::GUNKSHOT,PBMoves::DRAGONPULSE,PBMoves::SEEDBOMB,PBMoves::FOULPLAY,PBMoves::SUPERPOWER,PBMoves::EARTHPOWER,PBMoves::OUTRAGE,
PBMoves::HEATWAVE,PBMoves::HYDROCANNON,PBMoves::BLASTBURN,PBMoves::FRENZYPLANT,PBMoves::DRACOMETEOR,PBMoves::CELEBRATE] +
# Reatomized new tutors
arrayToConstant(PBMoves,
[:MYSTICALPOWER,:POWERSHIFT,:RAGINGFURY,:HEADLONGRUSH,:ESPERWING,:MOUNTAINGALE,:WAVECRASH,:COACHING,:TERRAINPULSE,:RISINGVOLTAGE,:EXPANDINGFORCE,:BURNINGJEALOUSY,:LASHOUT,:SCORCHINGSANDS,:SKITTERSMACK,:SCALESHOT,:STEELROLLER,:STEELBEAM,:METEORBEAM,:FLIPTURN,:GRASSYGLIDE,:TRIPLEAXEL,:DUALWINGBEAT,:MIMIC,:ICEBALL,:SUCKERPUNCH,:EXTREMESPEED])
  moves=[]
  for tutor in tutorlist
	if pbSpeciesCompatible?(pokemon.species,tutor,pokemon)
	moves.push(tutor)
	end
  end
  moves|=[] # remove duplicates
  retval=[]
  for move in moves
    # next if level>pokemon.level # No need to check for level... we're talking egg moves here, remember?
    # next if pokemon.knowsMove?(move)
    retval.push(move)
  end
  return retval
end

def pbChooseMoveTM(pkmn,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  movelist=tor_getAllTMs(pkmn)
  movesdisplay=[]
  for move in movelist
    #level=move[0]
    name=PBMoves.getName(move)
    commands.push([move,"#{name}"]) if name!=nil && name!=""
  end
  #commands.sort! {|a,b| a[1]<=>b[1]}
  if commands.length==0
  pbDisplay(_INTL("There are no legal moves."))
  cmdwin.dispose
  return 0
  end
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def tor_getAllTMs(pokemon)
  tutorlist=
[PBMoves::WORKUP,PBMoves::DRAGONCLAW,PBMoves::PSYSHOCK,PBMoves::CALMMIND,PBMoves::ROAR,PBMoves::TOXIC,PBMoves::HAIL,PBMoves::BULKUP,PBMoves::VENOSHOCK,
PBMoves::HIDDENPOWER,PBMoves::SUNNYDAY,PBMoves::TAUNT,PBMoves::ICEBEAM,PBMoves::BLIZZARD,PBMoves::HYPERBEAM,PBMoves::LIGHTSCREEN,PBMoves::PROTECT,PBMoves::RAINDANCE,
PBMoves::ROOST,PBMoves::SAFEGUARD,PBMoves::FRUSTRATION,PBMoves::SOLARBEAM,PBMoves::SMACKDOWN,PBMoves::THUNDERBOLT,PBMoves::THUNDER,PBMoves::EARTHQUAKE,PBMoves::RETURN,
PBMoves::LEECHLIFE,PBMoves::PSYCHIC,PBMoves::SHADOWBALL,PBMoves::BRICKBREAK,PBMoves::DOUBLETEAM,PBMoves::REFLECT,PBMoves::SLUDGEWAVE,PBMoves::FLAMETHROWER,PBMoves::SLUDGEBOMB,
PBMoves::SANDSTORM,PBMoves::FIREBLAST,PBMoves::ROCKTOMB,PBMoves::AERIALACE,PBMoves::TORMENT,PBMoves::FACADE,PBMoves::FLAMECHARGE,PBMoves::REST,PBMoves::ATTRACT,PBMoves::THIEF,
PBMoves::LOWSWEEP,PBMoves::ROUND,PBMoves::ECHOEDVOICE,PBMoves::OVERHEAT,PBMoves::STEELWING,PBMoves::FOCUSBLAST,PBMoves::ENERGYBALL,PBMoves::FALSESWIPE,PBMoves::SCALD,
PBMoves::FLING,PBMoves::CHARGEBEAM,PBMoves::SKYDROP,PBMoves::BRUTALSWING,PBMoves::QUASH,PBMoves::WILLOWISP,PBMoves::ACROBATICS,PBMoves::EMBARGO,PBMoves::EXPLOSION,
PBMoves::SHADOWCLAW,PBMoves::PAYBACK,PBMoves::SMARTSTRIKE,PBMoves::GIGAIMPACT,PBMoves::ROCKPOLISH,PBMoves::AURORAVEIL,PBMoves::STONEEDGE,PBMoves::VOLTSWITCH,PBMoves::THUNDERWAVE,
PBMoves::GYROBALL,PBMoves::SWORDSDANCE,PBMoves::STRUGGLEBUG,PBMoves::PSYCHUP,PBMoves::BULLDOZE,PBMoves::FROSTBREATH,PBMoves::ROCKSLIDE,PBMoves::XSCISSOR,PBMoves::DRAGONTAIL,
PBMoves::INFESTATION,PBMoves::POISONJAB,PBMoves::DREAMEATER,PBMoves::GRASSKNOT,PBMoves::SWAGGER,PBMoves::SLEEPTALK,PBMoves::UTURN,PBMoves::SUBSTITUTE,PBMoves::FLASHCANNON,
PBMoves::TRICKROOM,PBMoves::WILDCHARGE,PBMoves::SECRETPOWER,PBMoves::SNARL,PBMoves::NATUREPOWER,PBMoves::DARKPULSE,PBMoves::POWERUPPUNCH,
PBMoves::DAZZLINGGLEAM,PBMoves::CONFIDE,
PBMoves::CUT,PBMoves::FLY,PBMoves::SURF,PBMoves::STRENGTH,PBMoves::WATERFALL,PBMoves::DIVE,PBMoves::ROCKSMASH,PBMoves::FLASH,PBMoves::ROCKCLIMB] +
# Reatomized new TMs
arrayToConstant(PBMoves,
[:MEGAPUNCH,:MEGAKICK,:PAYDAY,:PINMISSILE,:MAGICALLEAF,:SOLARBLADE,:FIRESPIN,:DIG,:SCREECH,:SELFDESTRUCT,:SCARYFACE,:CHARM,:WHIRLPOOL,:BEATUP,:REVENGE,:IMPRISON,:WEATHERBALL,:FAKETEARS,:SANDTOMB,:BULLETSEED,:ICICLESPEAR,:ROCKBLAST,:MUDSHOT,:BRINE,:ASSURANCE,:POWERSWAP,:GUARDSWAP,:SPEEDSWAP,:AVALANCHE,:THUNDERFANG,:ICEFANG,:FIREFANG,:PSYCHICFANGS,:CRUNCH,:PSYCHOCUT,:CROSSPOISON,:LEAFBLADE,:AIRSLASH,:RAZORSHELL,:HEX,:TAILSLAP,:PHANTOMFORCE,:DRAININGKISS,:GRASSYTERRAIN,:MISTYTERRAIN,:ELECTRICTERRAIN,:PSYCHICTERRAIN,:MYSTICALFIRE,:EERIEIMPULSE,:BREAKINGSWIPE,:BODYSLAM,:HYDROPUMP,:HURRICANE,:POWERWHIP,:MEGAHORN,:FLAREBLITZ,:LEAFSTORM,:CLOSECOMBAT,:BRAVEBIRD,:AGILITY,:FOCUSENERGY,:METRONOME,:AMNESIA,:TRIATTACK,:REVERSAL,:SPIKES,:ENDURE,:BATONPASS,:ENCORE,:FUTURESIGHT,:BLAZEKICK,:COSMICPOWER,:MUDDYWATER,:DRAGONDANCE,:TOXICSPIKES,:AURASPHERE,:BUGBUZZ,:POWERGEM,:NASTYPLOT,:ELECTROBALL,:STOREDPOWER,:HEATCRASH,:HEAVYSLAM,:PLAYROUGH,:VENOMDRENCH,:DARKESTLARIAT,:HIGHHORSEPOWER,:POLLENPUFF,:BODYPRESS,:RETALIATE,:ICESPINNER,:SNOWSCAPE,:POUNCE,:TRAILBLAZE,:CHILLINGWATER,:SWIFT])
  moves=[]
  for tutor in tutorlist
	if pbSpeciesCompatible?(pokemon.species,tutor,pokemon)
	moves.push(tutor)
	end
  end
  moves|=[] # remove duplicates
  retval=[]
  for move in moves
    # next if level>pokemon.level # No need to check for level... we're talking egg moves here, remember?
    # next if pokemon.knowsMove?(move)
    retval.push(move)
  end
  return retval
end

def pbDisplayBSTData(pkmn,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  name = pkmn.getFormName
  if !name
  name="Base Form"
  end
  commands.push("Species : #{PBSpecies.getName(pkmn.species)}")
  commands.push("Dex n° : #{pkmn.species}")
  commands.push("Form : #{name}")
  typing=""
  typing+="#{PBTypes.getName(pkmn.type1)}"
  if pkmn.type2!=pkmn.type1
  typing+=" / #{PBTypes.getName(pkmn.type2)}"
  end
  commands.push("#{typing}")
  commands.push(" ")
  bst=0
  bsstat=[]

  for i in 0..5
	  if name!="Base Form" && PokemonForms.dig(pkmn.species,name,:BaseStats)
	  bsstat[i]=PokemonForms.dig(pkmn.species,name,:BaseStats)[i]

	  else
	  bsstat[i]=$cache.pkmn_dex[pkmn.species][:BaseStats][i]

	  end
  bst=bst+bsstat[i]
  end
  commands.push("HP : #{bsstat[0]}")
  commands.push("Atk : #{bsstat[1]}")
  commands.push("Def : #{bsstat[2]}")
  commands.push("SpA : #{bsstat[4]}")
  commands.push("SpD : #{bsstat[5]}")
  commands.push("Spe : #{bsstat[3]}")
  commands.push("BST : #{bst}")


	if name!="Base Form" && PokemonForms.dig(pkmn.species,name,:Ability)
	ablist=PokemonForms.dig(pkmn.species,name,:Ability)
    ablist = [ablist] if !ablist.is_a?(Array)
	else
	ablist=pkmn.getAbilityList
	end
  abilities=PBAbilities.getName(ablist[0])
  abcount=0
  for ab in ablist
	  if abcount>0
	  abilities+=" / #{PBAbilities.getName(ablist[abcount])}"
	  end
	  abcount=abcount+1
  end
  commands.push(" ")
  commands.push("Abilities: #{abilities}")

  #commands.sort! {|a,b| a[1]<=>b[1]}
  if commands.length==0
  pbDisplay(_INTL("There are no legal moves."))
  cmdwin.dispose
  return 0
  end
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,false) 
  cmdwin.dispose
  return ret>=0 ? commands[ret] : 0
end



#### bringing them together
class PokemonScreen
  def pbPokemonScreen
    @scene.pbStartScene(@party,
       @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."),nil)
    loop do
      @scene.pbSetHelpText(
         @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."))
      pkmnid=@scene.pbChoosePokemon(false,true)
      if pkmnid.is_a?(Array) && pkmnid[0]==1  # Switch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid = pkmnid[1]
        pkmnid = @scene.pbChoosePokemon(true,true,1)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
        next
      end
      if pkmnid<0
        break
      end
      pkmn=@party[pkmnid]
      commands=[]
      cmdSummary=-1
      cmdSwitch=-1
      cmdItem=-1
      cmdDebug=-1
      cmdMail=-1
      cmdRename=-1
      cmdRelearn=-1
      cmdData=-1
      # Build the commands
      commands[cmdSummary=commands.length]=_INTL("Summary")
      if $game_switches[1362]
        acmdTMX=-1
        commands[acmdTMX=commands.length]=_INTL("Use TMX")
      end
      cmdMoves=[-1,-1,-1,-1]
      for i in 0...pkmn.moves.length
        move=pkmn.moves[i]
        # Check for hidden moves and add any that were found
        if !pkmn.isEgg? && (
           (move.id == PBMoves::MILKDRINK) ||
           (move.id == PBMoves::SOFTBOILED) ||
           HiddenMoveHandlers.hasHandler(move.id)
           )
          commands[cmdMoves[i]=commands.length]=PBMoves.getName(move.id)
        end
      end
      commands[cmdSwitch=commands.length]=_INTL("Switch") if @party.length>1
      if !pkmn.isEgg?
        if pkmn.mail
          commands[cmdMail=commands.length]=_INTL("Mail")
        else
          commands[cmdItem=commands.length]=_INTL("Item")
        end
        commands[cmdRename = commands.length] = _INTL("Rename")
        commands[cmdRelearn=commands.length] = _INTL("Relearn") #! Haru <3
        commands[cmdData = commands.length] = _INTL("Data") #! Torre <3
      end
      if $DEBUG || (defined?($idk[:settings].amb_showDebugMenu) && $idk[:settings].amb_showDebugMenu > 1) # from Aironfaar's AddOpt_DebugMenu mod
        # Commands for debug mode only
        commands[cmdDebug=commands.length]=_INTL("Debug")
      end
      commands[commands.length]=_INTL("Cancel")
      command=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),commands)
      havecommand=false
      for i in 0...4
        if cmdMoves[i]>=0 && command==cmdMoves[i]
          havecommand=true
          if isConst?(pkmn.moves[i].id,PBMoves,:SOFTBOILED) ||
             isConst?(pkmn.moves[i].id,PBMoves,:MILKDRINK)
            if pkmn.hp<=(pkmn.totalhp/5.0).floor
              pbDisplay(_INTL("Not enough HP..."))
              break
            end
            @scene.pbSetHelpText(_INTL("Use on which Pokémon?"))
            oldpkmnid=pkmnid
            loop do
              @scene.pbPreSelect(oldpkmnid)
              pkmnid=@scene.pbChoosePokemon(true)
              break if pkmnid<0
              newpkmn=@party[pkmnid]
              if newpkmn.isEgg? || newpkmn.hp==0 || newpkmn.hp==newpkmn.totalhp || pkmnid==oldpkmnid
                pbDisplay(_INTL("This item can't be used on that Pokémon."))
              else
                pkmn.hp-=(pkmn.totalhp/5.0).floor
                hpgain=pbItemRestoreHP(newpkmn,(pkmn.totalhp/5.0).floor)
                @scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.",newpkmn.name,hpgain))
                pbRefresh
              end
            end
            break
          elsif Kernel.pbCanUseHiddenMove?(pkmn,pkmn.moves[i].id)
            @scene.pbEndScene
            if isConst?(pkmn.moves[i].id,PBMoves,:FLY)
              scene=PokemonRegionMapScene.new(-1,false)
              screen=PokemonRegionMap.new(scene)
              ret=screen.pbStartFlyScreen
              if ret
                $PokemonTemp.flydata=ret
                $game_system.bgs_stop
                $game_screen.weather(0,0,0)
                return [pkmn,pkmn.moves[i].id]
              end
              @scene.pbStartScene(@party,
                 @party.length>1 ? _INTL("Choose a Pokémon.") : _INTL("Choose Pokémon or cancel."))
              break
            end
            return [pkmn,pkmn.moves[i].id]
          else
            break
          end
        end
      end
      if $game_switches[1362]
        if acmdTMX>=0 && command==acmdTMX
          aRetArr = passwordUseTMX(pkmn)
          if aRetArr.length > 0
            havecommand=true
            return aRetArr
          end
        end
      end
      next if havecommand
      if cmdSummary>=0 && command==cmdSummary
        @scene.pbSummary(pkmnid)
      elsif cmdSwitch>=0 && command==cmdSwitch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid=pkmnid
        pkmnid=@scene.pbChoosePokemon(true)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
      elsif cmdDebug>=0 && command==cmdDebug
        pbPokemonDebug(pkmn,pkmnid)
      elsif cmdRelearn>=0 && command==cmdRelearn
        if !pbHasRelearnableMove?(pkmn)
            Kernel.pbMessage(_INTL("{1} has no moves to learn!",pkmn.name))
        else
            pbRelearnMoveScreen(pkmn)
        end
      elsif cmdMail>=0 && command==cmdMail
        command=@scene.pbShowCommands(_INTL("Do what with the mail?"),[_INTL("Read"),_INTL("Take"),_INTL("Cancel")])
        case command
          when 0 # Read
            pbFadeOutIn(99999){
               pbDisplayMail(pkmn.mail,pkmn)
            }
          when 1 # Take
            pbTakeMail(pkmn)
            pbRefreshSingle(pkmnid)
        end
      elsif cmdItem>=0 && command==cmdItem
        command=@scene.pbShowCommands(_INTL("Do what with an item?"),[_INTL("Use"),_INTL("Give"),_INTL("Take"),_INTL("Cancel")])
        case command
          when 0 # Use
          item=@scene.pbChooseItem($PokemonBag,from_bag: true)
          if item>0
            pbUseItemOnPokemon(item,pkmn,self)
            pbRefreshSingle(pkmnid)
          end            
          when 1 # Give
            item=@scene.pbChooseItem($PokemonBag,from_bag: true)
            if item>0
              if pbIsZCrystal2?(item)
                pbUseItemOnPokemon(item,pkmn,self)
              else
                pbGiveMail(item,pkmn,pkmnid)
              end
              pbRefreshSingle(pkmnid)
            end
          when 2 # Take
            pbTakeMail(pkmn)
            pbRefreshSingle(pkmnid)
        end
      elsif cmdRename>=0 && command==cmdRename
        species=PBSpecies.getName(pkmn.species)
        $game_variables[5]=Kernel.pbMessageFreeText("#{species}'s nickname?",_INTL(""),false,12)
        if pbGet(5)==""
          pkmn.name=PBSpecies.getName(pkmn.species)
          pbSet(5,pkmn.name)
        end
        pkmn.name=pbGet(5)
        pbDisplay(_INTL("{1} was renamed to {2}.",species,pkmn.name))
      elsif cmdData>=0 && command==cmdData
        cmdsubData=0
        loop do
        cmdsubData=@scene.pbShowCommands(_INTL("What do you wish to know?"),[
        _INTL("Level Learnset"),
        _INTL("Egg Moves"),
        _INTL("Tutor Moves"),
        _INTL("TMs"),
        _INTL("Display BST"),
        _INTL("Nothing")],cmdsubData)
        case cmdsubData
        # Break
        when -1,5
          break
        when 0
          move=pbChooseMoveLearnset(pkmn)
          if move!=0
          #pbLearnMove(pkmn,move)
          pbRefreshSingle(pkmnid)
          end
        when 1
          move=pbChooseMoveEggs(pkmn)
          if move!=0
          #pbLearnMove(pkmn,move)
          pbRefreshSingle(pkmnid)
          end
        when 2
          move=pbChooseMoveTutor(pkmn)
          if move!=0
          #pbLearnMove(pkmn,move)
          pbRefreshSingle(pkmnid)
          end
        when 3
          move=pbChooseMoveTM(pkmn)
          if move!=0
          #pbLearnMove(pkmn,move)
          pbRefreshSingle(pkmnid)
          end
        when 4
          bst=pbDisplayBSTData(pkmn)
        end
        end
      end
    end
    @scene.pbEndScene
    return nil
  end
end