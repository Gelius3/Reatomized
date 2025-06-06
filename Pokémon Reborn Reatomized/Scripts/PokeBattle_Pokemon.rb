# This class stores data on each Pokemon.  Refer to $Trainer.party for an array
# of each Pokemon in the Trainer's current party.
class PokeBattle_Pokemon
  attr_reader(:totalhp)       # Current Total HP
  attr_reader(:attack)        # Current Attack stat
  attr_reader(:defense)       # Current Defense stat
  attr_accessor(:speed)       # Current Speed stat
  attr_reader(:spatk)         # Current Special Attack stat
  attr_reader(:spdef)         # Current Special Defense stat
  attr_accessor(:iv)          # Array of 6 Individual Values for HP, Atk, Def,
                              #    Speed, Sp Atk, and Sp Def
  attr_accessor(:ev)          # Effort Values
  attr_accessor(:species)     # Species (National Pokedex number)
  attr_accessor(:personalID)  # Personal ID
  attr_accessor(:trainerID)   # 32-bit Trainer ID (the secret ID is in the upper
                              #    16 bits)
  attr_accessor(:hp)          # Current HP
  attr_accessor(:pokerus)     # Pokérus strain and infection time
  attr_accessor(:item)        # Held item
  attr_accessor(:itemRecycle) # Consumed held item (used in battle only)
  attr_accessor(:itemInitial) # Resulting held item (used in battle only)
  attr_accessor(:itemReallyInitialHonestlyIMeanItThisTime) # Original held item (used in battle only)
  attr_accessor(:belch)       # If pokemon has used belch this battle (used in battle only)
  attr_accessor(:spirit)      # If pokemon has exhausted Spirit ability this battle (used in battle only)
  attr_accessor(:piece)       # Piece roll given for Chess field
  attr_accessor(:mail)        # Mail
  attr_accessor(:fused)       # The Pokémon fused into this one
  attr_accessor(:name)        # Nickname
  attr_accessor(:exp)         # Current experience points
  attr_accessor(:happiness)   # Current happiness
  attr_accessor(:status)      # Status problem (PBStatuses)
  attr_accessor(:statusCount) # Sleep count/Toxic flag
  attr_accessor(:eggsteps)    # Steps to hatch egg, 0 if Pokémon is not an egg
  attr_accessor(:moves)       # Moves (PBMove)
  attr_accessor(:firstmoves)  # The moves known when this Pokémon was obtained
  attr_accessor(:ballused)    # Ball used
  attr_accessor(:markings)    # Markings
  attr_accessor(:obtainMode)  # Manner obtained:
                              #    0 - met, 1 - as egg, 2 - traded,
                              #    4 - fateful encounter
  attr_accessor(:obtainMap)   # Map where obtained
  attr_accessor(:obtainText)  # Replaces the obtain map's name if not nil
  attr_accessor(:obtainLevel) # Level obtained
  attr_accessor(:hatchedMap)  # Map where an egg was hatched
  attr_accessor(:language)    # Language
  attr_accessor(:ot)          # Original Trainer's name
  attr_accessor(:otgender)    # Original Trainer's gender:
                              #    0 - male, 1 - female, 2 - mixed, 3 - unknown
                              #    For information only, not used to verify
                              #    ownership of the Pokemon
  attr_accessor(:abilityflag) # Forces the first/second/hidden (0/1/2) ability
  attr_accessor(:genderflag)  # Forces male (0) or female (1)
  attr_accessor(:natureflag)  # Forces a particular nature
  attr_accessor(:shinyflag)   # Forces the shininess (true/false)
  #attr_accessor(:ribbons)     # Array of ribbons
  attr_accessor :cool,:beauty,:cute,:smart,:tough,:sheen # Contest stats
  attr_accessor(:obedient)
  attr_accessor(:hptype)
  attr_accessor :form

  attr_accessor(:landCritical)# Galarian Farfetch'd evo method (used in battle only)
  attr_accessor(:rageFist)    # Hit counter for Rage Fist
  attr_accessor(:corrosiveGas)# Corrosive Gas effect (used in battle only)
  attr_accessor(:initialform) # Form before Mega evolving (used in battle only)
  attr_accessor :totem
  attr_accessor(:mark)         # Marks like in the SwSh games
  attr_accessor :traiting      # Trait Inheritance ability
  attr_accessor :eventmon         # For event releases
  attr_accessor :eventmonability # event ability


  def traiting
    if @traiting == nil
      @traiting = 0
    end
    return @traiting
  end

  def eventmonability
    if @eventmonability == nil
      @eventmonability = 0
    end
    return @eventmonability
  end

################################################################################
# Ownership, obtained information
################################################################################
# Returns the gender of this Pokémon's original trainer (2=unknown).
  def otgender
    @otgender=2 if !@otgender
    return @otgender
  end

# Returns whether the specified Trainer is NOT this Pokemon's original trainer.
  def isForeign?(trainer)
    return @trainerID!=trainer.id || @ot!=trainer.name
  end

# Returns the public portion of the original trainer's ID.
  def publicID
    return @trainerID&0xFFFF
  end

# Returns this Pokémon's level when this Pokémon was obtained.
  def obtainLevel
    @obtainLevel=0 if !@obtainLevel
    return @obtainLevel
  end

# Returns the time when this Pokémon was obtained.
  def timeReceived
    return @timeReceived ? Time.at(@timeReceived) : Time.gm(2000)
  end

# Sets the time when this Pokémon was obtained.
  def timeReceived=(value)
    # Seconds since Unix epoch
    if shouldDivergeTime?
      timediverge=$idk[:settings].unrealTimeDiverge
      $idk[:settings].unrealTimeDiverge=0
      value=Time.new
    end
    if value.is_a?(Time)
      @timeReceived=value.to_i
    else
      @timeReceived=value
    end
    $idk[:settings].unrealTimeDiverge=timediverge if timediverge
  end

# Returns the time when this Pokémon hatched.
  def timeEggHatched
    if obtainMode==1
      return @timeEggHatched ? Time.at(@timeEggHatched) : Time.gm(2000)
    else
      return Time.gm(2000)
    end
  end

# Sets the time when this Pokémon hatched.
  def timeEggHatched=(value)
    # Seconds since Unix epoch
    if shouldDivergeTime?
      timediverge=$idk[:settings].unrealTimeDiverge
      $idk[:settings].unrealTimeDiverge=0
      value=Time.new
    end
    if value.is_a?(Time)
      @timeEggHatched=value.to_i
    else
      @timeEggHatched=value
    end
    $idk[:settings].unrealTimeDiverge=timediverge if timediverge
  end

  def personalID=(value)
    @personalID = value
    calcStats
  end

################################################################################
# Level
################################################################################
# Returns this Pokemon's level.
  attr_accessor(:poklevel)

  def level
    if @poklevel == nil
      @poklevel = PBExperience.pbGetLevelFromExperience(@exp,self.growthrate)
    end
    return @poklevel
  end

# Sets this Pokemon's level by changing its Exp. Points.
  def level=(value)
    if value<1 || (value>PBExperience::MAXLEVEL && $game_switches[:Offset_Trainer_Levels]==false && $game_switches[:Percent_Trainer_Levels]==false)
      raise ArgumentError.new(_INTL("The level number ({1}) is invalid.",value))
    end
    self.exp=PBExperience.pbGetStartExperience(value,self.growthrate)
    self.poklevel = value.to_i
  end

# Returns whether this Pokemon is an egg.
  def isEgg?
    return @eggsteps>0
  end

  def egg?; return isEgg?; end   # DEPRECATED

# Returns this Pokemon's growth rate.
  def growthrate
    return $cache.pkmn_dex[@species][:GrowthRate]
  end

# Returns this Pokemon's base Experience value.
  def baseExp
    return $cache.pkmn_dex[@species][:BaseEXP]
  end

################################################################################
# Gender
################################################################################
# Returns this Pokemon's gender. 0=male, 1=female, 2=genderless
  def gender
    return @genderflag if @genderflag!=nil
    genderbyte=$cache.pkmn_dex[@species][:GenderRatio]
    case genderbyte
      when 255
        return 2 # genderless
      when 254
        return 1 # always female
      when 0
        return 0 # always male
      else
        lowbyte=@personalID&0xFF
        return PokeBattle_Pokemon.isFemale(lowbyte,genderbyte) ? 1 : 0
    end
  end

# Helper function that determines whether the input values would make a female.
  def self.isFemale(b,genderRate)
    return true if genderRate==254    # AlwaysFemale
    return false if genderRate==255   # Genderless
    return false if genderRate==0   # Genderless
    return b<=genderRate
  end

# Returns whether this Pokémon is male.
  def isMale?
    return self.gender==0
  end

# Returns whether this Pokémon is female.
  def isFemale?
    return self.gender==1
  end

# Sets this Pokémon's gender to a particular gender (if possible).
  def setGender(value)
    genderbyte=$cache.pkmn_dex[@species][:GenderRatio]
    if genderbyte!=255 && genderbyte!=0 && genderbyte!=254
      @genderflag=value
    end
  end

  def makeMale; setGender(0); end
  def makeFemale; setGender(1); end
  def makeGenderless; setGender(2); end
################################################################################
# Ability
################################################################################
# Returns the index of this Pokémon's ability.
  def abilityIndex
    abil=@abilityflag!=nil ? @abilityflag : (@personalID%10)
    abil = 0 if abil.nil?
    return abil
  end

# Returns the ID of this Pokemon's ability.
  def ability
    abil=abilityIndex
    ret1=$cache.pkmn_dex[@species][:Abilities][0]
    ret2=$cache.pkmn_dex[@species][:Abilities][1]
    ret3=$cache.pkmn_dex[@species][:Abilities][2]
    ret4=$cache.pkmn_dex[@species][:Abilities][3]
    ret5=$cache.pkmn_dex[@species][:Abilities][4]
    ret6=$cache.pkmn_dex[@species][:Abilities][5]
    ret7=$cache.pkmn_dex[@species][:Abilities][6]
    ret8=$cache.pkmn_dex[@species][:Abilities][7]
    ret9=$cache.pkmn_dex[@species][:Abilities][8]
    h1=$cache.pkmn_dex[@species][:HiddenAbilities]

    chosenabil = [ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,h1][abil]
    if chosenabil==0 #Just for fixing old mons who might swap abilities from the code change
      abil=(@personalID&1)
      @abilityflag=abil
      chosenabil = [ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,h1][abil]
    end
    return chosenabil if chosenabil && chosenabil > 0
    return ret1
  end

# Sets this Pokémon's ability to a particular ability (if possible).
  def setAbility(value)
    if getAbilityList.has_key?(value)
      @abilityflag=value
    else
      @abilityflag=9
    end
  end

# Returns the list of abilities this Pokémon can have.
  def getAbilityList
    abils=[]
    ret = {}

    abils.push($cache.pkmn_dex[@species][:Abilities][0])
    abils.push($cache.pkmn_dex[@species][:Abilities][1])
    abils.push($cache.pkmn_dex[@species][:Abilities][2])
    abils.push($cache.pkmn_dex[@species][:Abilities][3])
    abils.push($cache.pkmn_dex[@species][:Abilities][4])
    abils.push($cache.pkmn_dex[@species][:Abilities][5])
    abils.push($cache.pkmn_dex[@species][:Abilities][6])
    abils.push($cache.pkmn_dex[@species][:Abilities][7])
    abils.push($cache.pkmn_dex[@species][:Abilities][8])
    abils.push($cache.pkmn_dex[@species][:HiddenAbilities])
    
    if @form != 0 || (GenderDiffSpecies.include?(@species) && gender==1)
      v = PokemonForms.dig(@species,getFormName,:Ability)
      abils = [v] if v!=nil && !v.is_a?(Array)
      abils = v if v.is_a?(Array)
    end
    
    for i in 0...abils.length
      next if !abils[i] || abils[i]<=0
      ret[i] = abils[i]
    end
    puts "#{ret}"
    return ret
  end

################################################################################
# Nature
################################################################################
# Returns the ID of this Pokémon's nature.
  def nature
    return @natureflag if @natureflag!=nil
    return @personalID%25
  end

# Sets this Pokémon's nature to a particular nature.
  def setNature(value)
    if value.is_a?(String) || value.is_a?(Symbol)
      value=(PBNatures::value)
    end
    @natureflag=value
    self.calcStats
  end

################################################################################
# Shininess
################################################################################
# Returns whether this Pokemon is shiny (differently colored).
  def isShiny?
    return @shinyflag if @shinyflag!=nil
    a=@personalID^@trainerID
    b=a&0xFFFF
    c=(a>>16)&0xFFFF
    d=b^c
    return (d<SHINYPOKEMONCHANCE)
  end

# Makes this Pokemon shiny.
  def makeShiny
    @shinyflag=true
  end

# Makes this Pokemon not shiny.
  def makeNotShiny
    @shinyflag=false
  end

################################################################################
# Marks
################################################################################
#Returns the mark of this pokemon.
  def hasMarks?
    return @mark if @mark!=false
  end

# Gives Destiny Mark marker to the Pokemon.
  def giveMark
    @mark << "Destiny Mark"
  end

################################################################################
# Pokérus
################################################################################
# Gives this Pokemon Pokérus (either the specified strain or a random one).
  def givePokerus(strain=0)
    return if self.pokerusStage==2 # Can't re-infect a cured Pokémon
    if strain<=0 || strain>=16
      strain=1+rand(15)
    end
    time=1+(strain%4)
    @pokerus=time
    @pokerus|=strain<<4
  end

# Resets the infection time for this Pokemon's Pokérus (even if cured).
  def resetPokerusTime
    return if @pokerus==0
    strain=@pokerus%16
    time=1+(strain%4)
    @pokerus=time
    @pokerus|=strain<<4
  end

# Reduces the time remaining for this Pokemon's Pokérus (if infected).
  def lowerPokerusCount
    return if self.pokerusStage!=1
    @pokerus-=1
  end

# Returns the Pokérus infection stage for this Pokemon.
  def pokerusStage
    return 0 if !@pokerus || @pokerus==0        # Not infected
    return 2 if @pokerus>0 && (@pokerus%16)==0  # Cured
    return 1                                    # Infected
  end

################################################################################
# Types
################################################################################
# Returns whether this Pokémon has the specified type.
  def hasType?(type,ignorefusion:false)
    if type.is_a?(Symbol) || type.is_a?(String)
      type = getID(PBTypes,type)
    end
    ret = (self.type1==type || self.type2==type)
    return ret
  end

# Returns this Pokémon's first type.
  def type1
    begin
      return self.form % 21 if @species == PBSpecies::SILVALLY || @species == PBSpecies::ARCEUS
      return $cache.pkmn_dex[@species][:Type1]
    rescue
      0
    end
  end

# Returns this Pokémon's second type.
  def type2
    return self.form % 21 if @species == PBSpecies::SILVALLY || @species == PBSpecies::ARCEUS
    return $cache.pkmn_dex[@species][:Type2]
  end

################################################################################
# Moves
################################################################################
# Returns the number of moves known by the Pokémon.
  def numMoves
    ret=0
    for i in 0...4
      ret+=1 if @moves[i].id!=0
    end
    return ret
  end

# Returns true if the Pokémon knows the given move.
  def knowsMove?(move)
    if move.is_a?(String) || move.is_a?(Symbol)
      move=getID(PBMoves,move)
    end
    return false if !move || move<=0
    for i in 0...4
      return true if @moves[i].id==move
    end
    return false
  end

# Returns the list of moves this Pokémon can learn by levelling up.
  def getMoveList
    movelist=[]
    for k in 0...$cache.pkmn_moves[@species].length
      movelist.push([$cache.pkmn_moves[@species][k][0],$cache.pkmn_moves[@species][k][1]])
    end
    return movelist
  end

# Returns the list of this pokemon's possible eggmoves
  def getEggMoveList
    movelist=[]
    moves = $cache.pkmn_egg[pbGetBabySpecies(@species)]
    for i in moves
      movelist.push(i)
    end
    moves = $cache.pkmn_egg[pbGetLessBabySpecies(@species)]
    for i in moves
      movelist.push(i)
    end
    moves = $cache.pkmn_egg[@species]
    for i in moves
      movelist.push(i)
    end
    return movelist
  end

# Sets this Pokémon's movelist to the default movelist it originally had.
  def resetMoves
    moves=self.getMoveList
    movelist=[]
    for i in moves
      if i[0]<=self.level
        movelist[movelist.length]=i[1]
      end
    end
    movelist|=[] # Remove duplicates
    listend=movelist.length-4
    listend=0 if listend<0
    j=0
    for i in listend...listend+4
      moveid=(i>=movelist.length) ? 0 : movelist[i]
      @moves[j]=PBMove.new(moveid)
      j+=1
    end
  end

# Silently learns the given move. Will erase the first known move if it has to.
  def pbLearnMove(move)
    if move.is_a?(String) || move.is_a?(Symbol)
      move=getID(PBMoves,move)
    end
    return if move<=0
    for i in 0...4
      if @moves[i].id==move
        j=i+1; while j<4
          break if @moves[j].id==0
          tmp=@moves[j]
          @moves[j]=@moves[j-1]
          @moves[j-1]=tmp
          j+=1
        end
        return
      end
    end
    for i in 0...4
      if @moves[i].id==0
        @moves[i]=PBMove.new(move)
        return
      end
    end
    @moves[0]=@moves[1]
    @moves[1]=@moves[2]
    @moves[2]=@moves[3]
    @moves[3]=PBMove.new(move)
  end

# Deletes the given move from the Pokémon.
  def pbDeleteMove(move)
    if move.is_a?(String) || move.is_a?(Symbol)
      move=getID(PBMoves,move)
    end
    return if !move || move<=0
    newmoves=[]
    for i in 0...4
      newmoves.push(@moves[i]) if @moves[i].id!=move
    end
    newmoves.push(PBMove.new(0))
    for i in 0...4
      @moves[i]=newmoves[i]
    end
  end

# Deletes the move at the given index from the Pokémon.
  def pbDeleteMoveAtIndex(index)
    newmoves=[]
    for i in 0...4
      newmoves.push(@moves[i]) if i!=index
    end
    newmoves.push(PBMove.new(0))
    for i in 0...4
      @moves[i]=newmoves[i]
    end
  end

# Deletes all moves from the Pokémon.
  def pbDeleteAllMoves
    for i in 0...4
      @moves[i]=PBMove.new(0)
    end
  end

# Copies currently known moves into a separate array, for Move Relearner.
  def pbRecordFirstMoves
    @firstmoves=[]
    for i in 0...4
      @firstmoves.push(@moves[i].id) if @moves[i].id>0
    end
  end

################################################################################
# Other
################################################################################
# Returns whether this Pokémon has a hold item.
  def hasItem?(value=0)
    if value==0
      return self.item>0
    else
      if value.is_a?(String) || value.is_a?(Symbol)
        value=getID(PBItems,value)
      end
      return self.item==value
    end
    return false
  end

# Brought Over from Battler because I'm lazy
  def isAirborne?
    return false if (self.item == PBItems::IRONBALL)
    return true if (self.type1 == PBTypes::FLYING || self.type2 == PBTypes::FLYING)
    return true if (self.ability == PBAbilities::LEVITATE)
    return true if (self.item == PBItems::AIRBALLOON)
    return false
  end

# Sets this Pokémon's item. Accepts symbols.
  def setItem(value)
    if value.is_a?(String) || value.is_a?(Symbol)
      value=getID(PBItems,value)
    end
    self.item=value
  end

# Returns the items this species can be found holding in the wild.
  def wildHoldItems
    return [$cache.pkmn_dex[@species][:WildItemCommon],$cache.pkmn_dex[@species][:WildItemUncommon],$cache.pkmn_dex[@species][:WildItemRare]]
  end

# Returns this Pokémon's mail.
  def mail
    return nil if !@mail
    if @mail.item==0 || !self.hasItem? || @mail.item!=self.item
      @mail=nil
      return nil
    end
    return @mail
  end

# Returns this Pokémon's language.
  def language; @language ? @language : 0; end

# Returns the markings this Pokémon has.
  def markings
    @markings=0 if !@markings
    return @markings
  end

# Returns a string stating the Unown form of this Pokémon.
  def unownShape
    return "ABCDEFGHIJKLMNOPQRSTUVWXYZ?!"[@form,1]
  end

# Returns the weight of this Pokémon.
  def weight
    return $cache.pkmn_dex[@species][:Weight]
  end

# Returns the height of this Pokémon.
def height
  return $cache.pkmn_dex[@species][:Height]
end

# Returns the EV yield of this Pokémon.
  def evYield
    return $cache.pkmn_dex[@species][:EVs]
  end

# Sets this Pokémon's HP.
  def hp=(value)
    value=0 if value<0
    @hp=value
    if @hp==0
      @status=0
      @statusCount=0
    end
  end

# Heals all HP of this Pokémon.
  def healHP
    return if egg?
    @hp=@totalhp
  end

# Heals the status problem of this Pokémon.
  def healStatus
    return if egg?
    @status=0
    @statusCount=0
  end

# Heals all PP of this Pokémon.
  def healPP(index=-1)
    return if egg?
    if index>=0
      @moves[index].pp=@moves[index].totalpp
    else
      for i in 0...4
        @moves[i].pp=@moves[i].totalpp
      end
    end
  end

# Heals all HP, PP, and status problems of this Pokémon.
  def heal
    return if egg?
    healHP
    healStatus
    healPP
  end

# Changes the happiness of this Pokémon depending on what happened to change it.
  def changeHappiness(method)
    gain=0; luxury=false
    case method
      when "walking"
        gain=1
        gain+=1 if @happiness<200
        gain+=1 if @obtainMap==$game_map.map_id
      when "level up"
        gain=3
        gain=4 if @happiness<200
        gain=5 if @happiness<100
      when "groom"
        gain=5
        gain=16 if @happiness<200
        luxury=true
      when "groom2"
        gain=8
        gain=13 if @happiness<200
        luxury=true
      when "groom3"
        gain=255
        luxury=true
      when "faint"
        gain=-1
      when "vitamin"
        gain=2
        gain=3 if @happiness<200
        gain=5 if @happiness<100
        luxury=true
      when "wing"
        gain=1
        gain=2 if @happiness<200
        gain=3 if @happiness<100
      when "EV berry"
        gain=2
        gain=5 if @happiness<200
        gain=10 if @happiness<100
        luxury=true
      when "powder"
        gain=-10
        gain=-5 if @happiness<200
      when "Energy Root"
        gain=-15
        gain=-10 if @happiness<200
      when "Revival Herb"
        gain=-20
        gain=-15 if @happiness<200
      when "candy"
        gain=3
        gain=4 if @happiness<200
        gain=5 if @happiness<100
        luxury=true
      when "bluecandy"
        gain=220
        luxury=true
      when "badcandy"
        gain=-3
        gain=-4 if @happiness<200
        gain=-5 if @happiness<100
      else
        Kernel.pbMessage(_INTL("Unknown happiness-changing method."))
    end
    gain+=1 if luxury && self.ballused==pbGetBallType(:LUXURYBALL)
    if (self.item == PBItems::SOOTHEBELL) && gain>0
      gain=(gain*3.0/2).round
    end
    @happiness+=gain
    @happiness=[[255,@happiness].min,0].max
  end

  #! modded

  #TODO: finish markers like SwSh
  def generateMarker #! must order the markers by priority (lowest % to highest) in order to provide better chance for very rare marks.

    generatedMarker = []
    rolls = 1
    rolls += (hasConst?(PBItems,:MARKCHARM) && $PokemonBag.pbQuantity(:MARKCHARM)>0) ? 2 : 0 #? true gives +2, false gives 0.
    rolls += (hasConst?(PBItems,:DEVCHARM) && $PokemonBag.pbQuantity(:DEVCHARM)>0) ? 5 : 0 #? true gives +5, false gives 0.

    while rolls > 0
      # Generate a Pokemon with a Destiny Mark, with a 0.01% chance.
      generatedMarker << "Destiny Mark" if (rand(10000) == 1)
      # Generate a Pokemon with a Rare Mark, with a 0.1% chance.
      generatedMarker << "Rare Mark" if (rand(1000) == 1)
      # Generate a Pokemon with a Uncommon or Curry Mark, with a 2% chance.
      generatedMarker << "Uncommon Mark" if (rand(50) == 1)
      generatedMarker << "Curry Mark" if (rand(50) == 2)
      rolls -= 1
    end
    
    return generatedMarker
  end

  #! end of modded

################################################################################
# Stat calculations, Pokémon creation
################################################################################
# Returns this Pokémon's base stats.  An array of six values.
  def baseStats
    return $cache.pkmn_dex[@species][:BaseStats]
  end

# Returns the maximum HP of this Pokémon.
  def calcHP(base,level,iv,ev)
    return 1 if base==1
    return ((base*2+iv+(ev>>2))*level/100).floor+level+10
  end

# Returns the specified stat of this Pokémon (not used for total HP).
  def calcStat(base,level,iv,ev,pv)
    return ((((base*2+iv+(ev>>2))*level/100).floor+5)*pv/100).floor
  end

# Recalculates this Pokémon's stats.
  def calcStats
    nature=self.nature
    stats=[]
    pvalues=[100,100,100,100,100]
    nd5=(nature/5).floor
    nm5=(nature%5).floor
    if nd5!=nm5
      pvalues[nd5]=110
      pvalues[nm5]=90
    end
    level=self.level
    bs=self.baseStats
    for i in 0..5
      base=bs[i]
      if i==0
        stats[i]=calcHP(base,level,@iv[i],@ev[i])
      else
        stats[i]=calcStat(base,level,@iv[i],@ev[i],pvalues[i-1])
      end
    end
    diff=@totalhp-@hp
    @totalhp=stats[0]
    if @hp>0
      @hp=@totalhp-diff
      @hp=1 if @hp<=0
      @hp=@totalhp if @hp>@totalhp
    end
    @attack=stats[1]
    @defense=stats[2]
    @speed=stats[3]
    @spatk=stats[4]
    @spdef=stats[5]
  end

# Creates a new Pokémon object.
#    species   - Pokémon species.
#    level     - Pokémon level.
#    player    - PokeBattle_Trainer object for the original trainer.
#    withMoves - If false, this Pokémon has no moves.
  def initialize(species,level,player=nil,withMoves=true)
    if species.is_a?(String) || species.is_a?(Symbol)
      species=getID(PBSpecies,species)
    end
    if $game_switches[:Just_Budew]
      species = PBSpecies::BUDEW
    elsif $game_switches[:Just_Vulpix]
      species = PBSpecies::VULPIX
    end
    cname=getConstantName(PBSpecies,species) rescue nil
    if !species || species<1 || species>PBSpecies.maxValue || !cname
      raise ArgumentError.new(_INTL("The species number (no. {1} of {2}) is invalid.",
         species,PBSpecies.maxValue))
      return nil
    end
    group1=$cache.pkmn_dex[species][:EggGroups][0]
    group2=$cache.pkmn_dex[species][:EggGroups][1]
    time=pbGetTimeNow
    @timeReceived=time.getgm.to_i # Use GMT
    @species=species
    # Individual Values
    @personalID=rand(256)
    @personalID|=rand(256)<<8
    @personalID|=rand(256)<<16
    @personalID|=rand(256)<<24
    @hp=1
    @totalhp=1
    @ev=[0,0,0,0,0,0]
    @iv=[]
    if !(group1==15 || group2==15) && (species != PBSpecies::MANAPHY) #undiscovered group or manaphy
      @iv[0]=rand(32)
      @iv[1]=rand(32)
      @iv[2]=rand(32)
      @iv[3]=rand(32)
      @iv[4]=rand(32)
      @iv[5]=rand(32)
    else
      stat1, stat2, stat3 = [0,1,2,3,4,5].sample(3)
      for i in 0..5
        if [stat1,stat2,stat3].include?(i)
          @iv[i]=31
        else
          @iv[i]=rand(32)
        end
      end
    end
    if $game_switches[:Full_IVs] == true
      for i in 0..5
        @iv[i]=31
      end
    elsif $game_switches[:Empty_IVs_Password] == true
      for i in 0..5
        @iv[i]=0
      end
    end
    if player
      @trainerID=player.id
      @ot=player.name
      @otgender=player.gender
      @language=player.language
    else
      @trainerID=0
      @ot=""
      @otgender=2
    end
    #if $game_switches[:NB_Pokemon_Only] == true
    #  makeGenderless
    #end
    @happiness=$cache.pkmn_dex[@species][:Happiness]
    @name=PBSpecies.getName(@species)
    @form = 0
    @totem = false
    @eventmon = false
    @traiting = 0
    @eventmonability = 0
    @mark=generateMarker()
    @eggsteps=0
    @status=0
    @statusCount=0
    @item=0
    @mail=nil
    @fused=nil
    #@ribbons=[]
    @moves=[]
    self.ballused=0
    self.level=level
    @poklevel = level
    calcStats
    @hp=@totalhp
    if $game_map
      @obtainMap=$game_map.map_id
      @obtainText=nil
      @obtainLevel=level
    else
      @obtainMap=0
      @obtainText=nil
      @obtainLevel=level
    end
    @obtainMode=0   # Met
    @obtainMode=4 if $game_switches[:Fateful_Encounter]
    @hatchedMap=0
    if withMoves
      # Generating move list
      movelist=[]
      for k in 0...$cache.pkmn_moves[species].length
        alevel=$cache.pkmn_moves[species][k][0]
        move=$cache.pkmn_moves[species][k][1]
        if alevel<=level
          movelist[k]=move
        end
      end
      movelist.reverse!
      movelist.uniq!
      # Use the first 4 items in the move list
      movelist = movelist[0,4]
      movelist.reverse!
      for i in 0...4
        moveid=(i>=movelist.length) ? 0 : movelist[i]
        @moves[i]=PBMove.new(moveid)
      end
    end
  end
end
