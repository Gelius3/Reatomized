class PokeBattle_Pokemon
  def form
    return @form || 0
  end

  def form=(value)
    @form=value
    self.calcStats
    pbSeenForm(self)
  end

  def getForm (pkmn)
   if pkmn.species == PBSpecies::GIRATINA
      maps = [] #Maps for Origin Form, currently not functional
      return (pkmn.item == PBItems::GRISEOUSORB || ($game_map && maps.include?($game_map.map_id))) ? 1 : 0
   end
   if pkmn.species == PBSpecies::PALKIA
      return (pkmn.item == PBItems::LUSTROUSGLOBE) ? 1 : 0
   end
   if pkmn.species == PBSpecies::DIALGA
      return (pkmn.item == PBItems::ADAMANTCRYSTAL) ? 1 : 0
   end
   if pkmn.species == PBSpecies::ZACIAN
      return (pkmn.item == PBItems::RUSTEDSWORD) ? 1 : 0
   end
   if pkmn.species == PBSpecies::ZAMAZENTA
      return (pkmn.item == PBItems::RUSTEDSHIELD) ? 1 : 0
   end
   if pkmn.species == PBSpecies::OGERPON
      case pkmn.item
         when PBItems::TEALMASK        then return 1
         when PBItems::WELLSPRINGMASK  then return 2
         when PBItems::HEARTHFLAMEMASK then return 3
         when PBItems::CORNERSTONEMASK then return 4
      else return 0
      end
   end
   if pkmn.species == PBSpecies::ARCEUS
      case pkmn.item
         when PBItems::FISTPLATE, PBItems::FIGHTINIUMZ2    then return 1
         when PBItems::SKYPLATE, PBItems::FLYINIUMZ2       then return 2
         when PBItems::TOXICPLATE, PBItems::POISONIUMZ2    then return 3
         when PBItems::EARTHPLATE, PBItems::GROUNDIUMZ2    then return 4
         when PBItems::STONEPLATE, PBItems::ROCKIUMZ2      then return 5
         when PBItems::INSECTPLATE, PBItems::BUGINIUMZ2    then return 6
         when PBItems::SPOOKYPLATE, PBItems::GHOSTIUMZ2    then return 7
         when PBItems::IRONPLATE, PBItems::STEELIUMZ2      then return 8
         when PBItems::FLAMEPLATE, PBItems::FIRIUMZ2       then return 10
         when PBItems::SPLASHPLATE, PBItems::WATERIUMZ2    then return 11
         when PBItems::MEADOWPLATE, PBItems::GRASSIUMZ2    then return 12
         when PBItems::ZAPPLATE, PBItems::ELECTRIUMZ2      then return 13
         when PBItems::MINDPLATE, PBItems::PSYCHIUMZ2      then return 14
         when PBItems::ICICLEPLATE, PBItems::ICIUMZ2       then return 15
         when PBItems::DRACOPLATE, PBItems::DRAGONIUMZ2    then return 16
         when PBItems::DREADPLATE, PBItems::DARKINIUMZ2    then return 17
         when PBItems::PIXIEPLATE, PBItems::FAIRIUMZ2      then return 18
         when PBItems::ATOMICPLATE                         then return 19
         when PBItems::COSMICPLATE                         then return 20
      else return 0
      end
   end
   if pkmn.species == PBSpecies::GENESECT
      case pkmn.item
         when PBItems::SHOCKDRIVE   then return 1
         when PBItems::BURNDRIVE    then return 2
         when PBItems::CHILLDRIVE   then return 3
         when PBItems::DOUSEDRIVE   then return 4
      else return 0
      end
   end
   if pkmn.species == PBSpecies::SILVALLY
      case pkmn.item
         when PBItems::FIGHTINGMEMORY  then return 1
         when PBItems::FLYINGMEMORY    then return 2
         when PBItems::POISONMEMORY    then return 3
         when PBItems::GROUNDMEMORY    then return 4
         when PBItems::ROCKMEMORY      then return 5
         when PBItems::BUGMEMORY       then return 6
         when PBItems::GHOSTMEMORY     then return 7
         when PBItems::STEELMEMORY     then return 8
         when PBItems::QMARKSMEMORY    then return 9
         when PBItems::FIREMEMORY      then return 10
         when PBItems::WATERMEMORY     then return 11
         when PBItems::GRASSMEMORY     then return 12
         when PBItems::ELECTRICMEMORY  then return 13
         when PBItems::PSYCHICMEMORY   then return 14
         when PBItems::ICEMEMORY       then return 15
         when PBItems::DRAGONMEMORY    then return 16
         when PBItems::DARKMEMORY      then return 17
         when PBItems::FAIRYMEMORY     then return 18
         when PBItems::ATOMICMEMORY    then return 19
         when PBItems::COSMICMEMORY    then return 20
      else return 0
      end
   end
   return pkmn.form
  end

  def getFormName
    return "Female" if self.form==0 && GenderDiffSpecies.include?(@species) && gender==1
    return "NuclearFemale" if self.form==1 && @species==PBSpecies::MEOWSTIC && gender==1
    formnames = PokemonForms.dig(@species,:FormName)
    return if !formnames
    return formnames[self.form]
  end

  def hasMegaForm?
    v=PokemonForms.dig(@species,:MegaForm)
    v=PokemonForms.dig(@species,:PulseForm) if (Reborn && !v)
    return false if !v
    if @species==PBSpecies::RAYQUAZA && !pbIsZCrystal?(@item)
      for i in @moves
        return true if i.id==PBMoves::DRAGONASCENT || i.id==PBMoves::DRAGONDESCENT
      end
    end
    if @species==PBSpecies::ETERNATUS && !pbIsZCrystal?(@item)
      for i in @moves
        return true if i.id==PBMoves::ETERNABEAM
      end
    end
    if @species==PBSpecies::TERAPAGOS && !pbIsZCrystal?(@item) && self.form == 1
      for i in @moves
        return true if i.id==PBMoves::TERASTARSTORM
      end
    end
    if VARIANTMEGAS[@species]
      v=VARIANTMEGAS[@species][@form]
      return v==@item if v.is_a?(Integer)
      return v.include?(@item) if v.is_a?(Array)
      return false
    else
	    return PBStuff::POKEMONTOMEGASTONE[@species].include?(@item)
    end
  end

  def hasUltraForm?
    return @species == PBSpecies::NECROZMA && @item == PBItems::ULTRANECROZIUMZ2 && (self.form==1 || self.form==2)
  end

  #when you learn a new coding trick and have to use it everywhere
  def hasZMove?
    pkmn=self
    canuse=false
    case pkmn.item
      when PBItems::NORMALIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::NORMAL}
      when PBItems::FIGHTINIUMZ  then canuse=pkmn.moves.any?{|move| move.type == PBTypes::FIGHTING}
      when PBItems::FLYINIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::FLYING}
      when PBItems::POISONIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::POISON}
      when PBItems::GROUNDIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::GROUND}
      when PBItems::ROCKIUMZ     then canuse=pkmn.moves.any?{|move| move.type == PBTypes::ROCK}
      when PBItems::BUGINIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::BUG}
      when PBItems::GHOSTIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::GHOST}
      when PBItems::STEELIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::STEEL}
      when PBItems::FIRIUMZ      then canuse=pkmn.moves.any?{|move| move.type == PBTypes::FIRE}
      when PBItems::WATERIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::WATER}
      when PBItems::GRASSIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::GRASS}
      when PBItems::ELECTRIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::ELECTIC}
      when PBItems::PSYCHIUMZ    then canuse=pkmn.moves.any?{|move| move.type == PBTypes::PSYCHIC}
      when PBItems::ICIUMZ       then canuse=pkmn.moves.any?{|move| move.type == PBTypes::ICE}
      when PBItems::DRAGONIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::DRAGON}
      when PBItems::DARKINIUMZ   then canuse=pkmn.moves.any?{|move| move.type == PBTypes::DARK}
      when PBItems::FAIRIUMZ     then canuse=pkmn.moves.any?{|move| move.type == PBTypes::FAIRY}
         
      when PBItems::ALORAICHIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::THUNDERBOLT} if pkmn.species==PBSpecies::RAICHU && pkmn.form
      when PBItems::DECIDIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::SPIRITSHACKLE} if pkmn.species==PBSpecies::DECIDUEYE
      when PBItems::INCINIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::DARKESTLARIAT} if pkmn.species==PBSpecies::INCINEROAR
      when PBItems::PRIMARIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::SPARKLINGARIA} if pkmn.species==PBSpecies::PRIMARINA
      when PBItems::EEVIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::LASTRESORT} if pkmn.species==PBSpecies::EEVEE
      when PBItems::PIKANIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::VOLTTACKLE} if pkmn.species==PBSpecies::PIKACHU
      when PBItems::SNORLIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::GIGAIMPACT} if pkmn.species==PBSpecies::SNORLAX
      when PBItems::MEWNIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::PSYCHIC} if pkmn.species==PBSpecies::MEW
      when PBItems::TAPUNIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::NATURESMADNESS} if pkmn.species==PBSpecies::TAPUKOKO || pkmn.species==PBSpecies::TAPULELE || pkmn.species==PBSpecies::TAPUFINI || pkmn.species==PBSpecies::TAPUBULU
      when PBItems::MARSHADIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::SPECTRALTHIEF} if pkmn.species==PBSpecies::MARSHADOW
      when PBItems::KOMMONIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::CLANGINGSCALES} if pkmn.species==PBSpecies::KOMMOO
      when PBItems::LYCANIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::STONEEDGE} if pkmn.species==PBSpecies::LYCANROC
      when PBItems::MIMIKIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::PLAYROUGH} if pkmn.species==PBSpecies::MIMIKYU
      when PBItems::SOLGANIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::SUNSTEELSTRIKE} if (pkmn.species==PBSpecies::NECROZMA && pkmn.form==1) || pkmn.species==PBSpecies::SOLGALEO
      when PBItems::LUNALIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::MOONGEISTBEAM} if (pkmn.species==PBSpecies::NECROZMA && pkmn.form==2) || pkmn.species==PBSpecies::LUNALA
      when PBItems::ULTRANECROZIUMZ then canuse=pkmn.moves.any?{|move| move.id == PBMoves::PHOTONGEYSER} if pkmn.species==PBSpecies::NECROZMA && pkmn.form!=0
    end
    return canuse
  end

  def isMega?
    v=PokemonForms.dig(@species,:MegaForm)
    if v.is_a?(Proc)
      return true if v.call("getAll").include?(self.form)
    elsif v.is_a?(Hash)
      return true if v.values.include?(self.form)
    else
      return true if v!=nil && self.form==v
    end
    return self.isPulse?
  end

  def makeMega
    @initialform = self.form
    @initialform = 0 if @species == PBSpecies::ARCEUS
    if @item==PBItems::PULSEHOLD
      v=PokemonForms.dig(@species,:PulseForm)
      self.form=v if v.is_a?(Integer)
      self.form=v.call(self) if v.is_a?(Proc)
    else
      v=PokemonForms.dig(@species,:MegaForm)
      self.form=v if v.is_a?(Integer)
      self.form=v[@item] if v.is_a?(Hash)
      self.form=v.call(self) if v.is_a?(Proc)
    end
  end

  def makeUnmega
    if @initialform
      self.form = @initialform
    else #Should never go here though
      v=PokemonForms.dig(@species,:DefaultForm)
      self.form=v if v.is_a?(Integer)
      self.form=v[@item] if v.is_a?(Hash)
    end
  end

  def megaName
		return ""
    v=PokemonForms.dig(@species,:FormName)
    return v if v!=nil
    return ""
  end

  def isUltra?
    v=PokemonForms.dig(@species,:UltraForm)
    return v!=nil && v==self.form
  end

  def makeUltra
    @initialform = self.form
    v=PokemonForms.dig(@species,:UltraForm)
    self.form=v if v!=nil
  end

  def makeUnultra(startform)
    self.form=startform
  end

  def ultraName
		return ""
    v=MultipleForms.call("getUltraName",self)
    return v if v!=nil
    return ""
  end

  def isPulse?
    v = PokemonForms.dig(@species,:FormName)
    return v!=nil && ["PULSE","PULSE A","PULSE B","PULSE C","Amalgaform"].include?(v[self.form])
    ##Alternative method if we ever need it
    #v=PokemonForms.dig(@species,:PulseForm)
    #return false if !v
    #if v.is_a?(Proc)
    #  return v.call("getAll").include?(self.form)
    #else
    #  return self.form==v
    #end
  end

  def isGmax? #Used to determine whether to display the Gmax symbol
    v = PokemonForms.dig(@species,:FormName)
    return v!=nil && ["Dyna","Dyna X","Dyna Y","DynaNuke","Dyna Rebornian"].include?(v[self.form])
  end

  def isDelta? #Used to determine whether to display the Delta symbol
    v = PokemonForms.dig(@species,:FormName)
    return v!=nil && ["Delta","Delta1","Delta2"].include?(v[self.form])
  end

  def isCelestial? #Used to determine whether to display the Celestial symbol
    v = PokemonForms.dig(@species,:FormName)
    return v!=nil && ["Celestial"].include?(v[self.form])
  end

  def isCosmic? #Used to determine whether to display the Cosmic symbol
    v = PokemonForms.dig(@species,:FormName)
    return v!=nil && ["Cosmic","Cyrus' Cosmic"].include?(v[self.form])
  end

  alias __mf_baseStats baseStats
  alias __mf_ability ability
  alias __mf_type1 type1
  alias __mf_type2 type2
  alias __mf_weight weight
	#alias __mf_height height
  alias __mf_getMoveList getMoveList
  alias __mf_wildHoldItems wildHoldItems
	alias __mf_baseExp baseExp
  alias __mf_evYield evYield
  alias __mf_initialize initialize

  def baseStats
    return self.__mf_baseStats if self.form == 0 && !(GenderDiffSpecies.include?(@species) && gender == 1)
    name = getFormName
    v = PokemonForms.dig(@species,name,:BaseStats)
    return v if v!=nil
    return self.__mf_baseStats
  end

  def ability
    return self.__mf_ability if self.form == 0 && !(GenderDiffSpecies.include?(@species) && gender == 1)
    name = getFormName
    v = PokemonForms.dig(@species,name,:Ability)
    if v!=nil
      return v if !v.is_a?(Array)
      return v[self.abilityIndex] if v[self.abilityIndex]
      return v[0]
    end
    return self.__mf_ability
  end

  def type1
    return self.__mf_type1 if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:Type1)
    return v if v!=nil
    return self.__mf_type1
  end

  def type2
    return self.__mf_type2 if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:Type2)
    return v if v!=nil
    return self.__mf_type2
  end

  def weight
    return self.__mf_weight if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:Weight)
    return v if v!=nil
    return self.__mf_weight
  end

	def height
    return self.__mf_height if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:Height)
    return v if v!=nil
    return self.__mf_height
  end

  def getMoveList
    return self.__mf_getMoveList if self.form == 0 && !(GenderDiffSpecies.include?(@species) && gender == 1)
    name = getFormName
    v = PokemonForms.dig(@species,name,:Movelist)
    return v if v!=nil
    return self.__mf_getMoveList
  end

  def wildHoldItems
    return self.__mf_wildHoldItems if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:WildHoldItems)
    return v if v!=nil
    return self.__mf_wildHoldItems
  end

  def baseExp
    #v=MultipleForms.call("baseExp",self)
    #return v if v!=nil
    return self.__mf_baseExp
  end

  def evYield
    return self.__mf_evYield if self.form == 0
		name = getFormName
		v = PokemonForms.dig(@species,name,:EVs)
    return v if v!=nil
    return self.__mf_evYield
  end

  def initialize(*args)
    __mf_initialize(*args)
		v = PokemonForms.dig(@species,:OnCreation)
    if v
			f = v.call
      self.form=f
      self.resetMoves
    end
  end

end

class PokeBattle_RealBattlePeer
  def pbOnEnteringBattle(battle,pokemon)
  end
end

def drawSpot(bitmap,spotpattern,x,y,red,green,blue)
  height=spotpattern.length
  width=spotpattern[0].length
  for yy in 0...height
    spot=spotpattern[yy]
    for xx in 0...width
      if spot[xx]==1
        xOrg=(x+xx)<<1
        yOrg=(y+yy)<<1
        color=bitmap.get_pixel(xOrg,yOrg)
        r=color.red+red
        g=color.green+green
        b=color.blue+blue
        color.red=[[r,0].max,255].min
        color.green=[[g,0].max,255].min
        color.blue=[[b,0].max,255].min
        bitmap.set_pixel(xOrg,yOrg,color)
        bitmap.set_pixel(xOrg+1,yOrg,color)
        bitmap.set_pixel(xOrg,yOrg+1,color)
        bitmap.set_pixel(xOrg+1,yOrg+1,color)
      end
    end
  end
end

def pbSpindaSpots(pokemon,bitmap)
  spot1=[
     [0,0,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,0,0]
  ]
  spot2=[
     [0,0,1,1,1,0,0],
     [0,1,1,1,1,1,0],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [0,1,1,1,1,1,0],
     [0,0,1,1,1,0,0]
  ]
  spot3=[
     [0,0,0,0,0,1,1,1,1,0,0,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,0,0,0,1,1,1,0,0,0,0,0]
  ]
  spot4=[
     [0,0,0,0,1,1,1,0,0,0,0,0],
     [0,0,1,1,1,1,1,1,1,0,0,0],
     [0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,0,1,1,1,1,1,0,0,0]
  ]
  id=pokemon.personalID
  h=(id>>28)&15
  g=(id>>24)&15
  f=(id>>20)&15
  e=(id>>16)&15
  d=(id>>12)&15
  c=(id>>8)&15
  b=(id>>4)&15
  a=(id)&15
  if pokemon.isShiny?
    drawSpot(bitmap,spot1,b+43,a+35,-120,-120,-20)
    drawSpot(bitmap,spot2,d+31,c+34,-120,-120,-20)
    drawSpot(bitmap,spot3,f+49,e+17,-120,-120,-20)
    drawSpot(bitmap,spot4,h+25,g+16,-120,-120,-20)
  else
    drawSpot(bitmap,spot1,b+43,a+35,0,-115,-75)
    drawSpot(bitmap,spot2,d+31,c+34,0,-115,-75)
    drawSpot(bitmap,spot3,f+49,e+17,0,-115,-75)
    drawSpot(bitmap,spot4,h+25,g+16,0,-115,-75)
  end
end

# This hash includes Pokemon that have multiple base forms and at least one Mega
# The indices of the items in the arrays correspond to the form nos. that should use them to Mega Evolve, e.g., Lucarionite is at index 0 for Regular Lucario and Lucarionite-R is at index 1 for Rebornian Lucario
# If a form does not Mega Evolve at all, you don't need to place anything at its corresponding index
VARIANTMEGAS = {
  PBSpecies::SCEPTILE => [PBItems::SCEPTILITE, PBItems::SCEPTILITER],
  PBSpecies::LUCARIO => [PBItems::LUCARIONITE, PBItems::LUCARIONITER],
  PBSpecies::URSHIFU => [PBItems::URSHIFITEX, PBItems::URSHIFITEY],
  PBSpecies::OGERPON => [nil, PBItems::TEALMASK, PBItems::WELLSPRINGMASK, PBItems::HEARTHFLAMEMASK, PBItems::CORNERSTONEMASK],
  PBSpecies::ARBOK => [PBItems::ARBOKITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::GYARADOS => [PBItems::GYARADOSITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::AMPHAROS => [PBItems::AMPHAROSITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::STEELIX => [PBItems::STEELIXITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::HOUNDOOM => [PBItems::HOUNDOOMINITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::TYRANITAR => [PBItems::TYRANITARITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::AGGRON => [PBItems::AGGRONITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::GLALIE => [PBItems::GLALITITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::GARBODOR => [PBItems::GARBODORITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::DREDNAW => [PBItems::DREDNAWTITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::COALOSSAL => [PBItems::COALOSSITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::SANDACONDA => [PBItems::SANDACONDITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::CENTISKORCH => [PBItems::CENTISKORCHITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::GRIMMSNARL => [PBItems::GRIMMSNARLITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::COPPERAJAH => [PBItems::COPPERITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::BAARIETTE => [PBItems::BAARITITE,nil,PBItems::FUSIONREACTOR],
  PBSpecies::INFLAGETAH => [PBItems::INFLAGETITE,nil,PBItems::FUSIONREACTOR],

  PBSpecies::VENUSAUR => [[PBItems::VENUSAURITE,PBItems::VENUSAURITEG]],
  PBSpecies::CHARIZARD => [[PBItems::CHARIZARDITEX,PBItems::CHARIZARDITEY,PBItems::CHARIZARDITEG]],
  PBSpecies::BLASTOISE => [[PBItems::BLASTOISINITE,PBItems::BLASTOISINITEG]],
  PBSpecies::PIDGEOT => [PBItems::PIDGEOTITE],
  PBSpecies::PIKACHU => [PBItems::PIKACHUTITE],
  PBSpecies::SANDSLASH => [PBItems::SANDSLASHNITE],
  PBSpecies::NIDOQUEEN => [[PBItems::NIDOTITEX,PBItems::NIDOTITEY]],
  PBSpecies::NIDOKING => [[PBItems::NIDOTITEX,PBItems::NIDOTITEY]],
  PBSpecies::NINETALES => [PBItems::NINETALITE],
  PBSpecies::DUGTRIO => [PBItems::DUGTRIONITE],
  PBSpecies::MEOWTH => [PBItems::MEOWTHITE],
  PBSpecies::ARCANINE => [PBItems::ARCANITE],
  PBSpecies::SLOWBRO => [PBItems::SLOWBRONITE],
  PBSpecies::MAROWAK => [PBItems::MAROWAKITE],
  PBSpecies::EEVEE => [PBItems::EEVEETITE],
  PBSpecies::SNORLAX => [PBItems::SNORLAXITE],
  PBSpecies::MEGANIUM => [PBItems::MEGANIUMITE],
  PBSpecies::TYPHLOSION => [[PBItems::TYPHLOSINITEX,PBItems::TYPHLOSINITEY]],
  PBSpecies::FERALIGATR => [PBItems::FERALIGATITE],
  PBSpecies::NOCTOWL => [PBItems::NOCTOWLITE],
  PBSpecies::SHUCKLE => [PBItems::SHUCKLENITE],
  PBSpecies::CORSOLA => [PBItems::CORSOLITE],
  PBSpecies::BRELOOM => [PBItems::BRELOOMITE],
  PBSpecies::SABLEYE => [PBItems::SABLENITE],
  PBSpecies::ALTARIA => [PBItems::ALTARIANITE],
  PBSpecies::ZANGOOSE => [PBItems::ZANGOOSITE],
  PBSpecies::CLAYDOL => [PBItems::CLAYDOLITE],
  PBSpecies::MILOTIC => [PBItems::MILOTICITE],
  PBSpecies::INFERNAPE => [PBItems::INFERNAPITE],
  PBSpecies::MISMAGIUS => [PBItems::MISMAGIUSITE],
  PBSpecies::BRONZONG => [PBItems::BRONZONGITE],
  PBSpecies::WEAVILE => [PBItems::WEAVILITE],
  PBSpecies::FROSLASS => [PBItems::FROSLASSITE],
  PBSpecies::SAMUROTT => [PBItems::SAMUROTTITE],
  #PBSpecies::LILLIGANT => [PBItems::LILLIGANTITE],
  PBSpecies::SCRAFTY => [PBItems::SCRAFTINITE],
  PBSpecies::COFAGRIGUS => [PBItems::COFAGRIGITE],
  PBSpecies::REUNICLUS => [PBItems::REUNICLUSITE],
  PBSpecies::TSAREENA => [PBItems::TSAREENITE],
  PBSpecies::TANGROWTH => [PBItems::PULSEHOLD],
  PBSpecies::MAGNEZONE => [PBItems::PULSEHOLD],
  PBSpecies::AVALUGG => [PBItems::PULSEHOLD],
  PBSpecies::MUK => [PBItems::PULSEHOLD],
  PBSpecies::MRMIME => [PBItems::PULSEHOLD],
}

GenderDiffSpecies = [PBSpecies::MEOWSTIC, PBSpecies::INDEEDEE, PBSpecies::BASCULEGION, PBSpecies::OINKOLOGNE, PBSpecies::KINGAMBIT]