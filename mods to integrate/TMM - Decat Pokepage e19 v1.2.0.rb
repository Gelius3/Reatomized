#####MODDED

#v0.4 Time to upload i guess


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
      cmdRelearn=-1
      cmdRename=-1
      cmdData=-1
      # Build the commands
      commands[cmdSummary=commands.length]=_INTL("Summary")
     
        # Commands for debug mode only
     
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
		commands[cmdData = commands.length] = _INTL("Data")
      end
	  commands[cmdDebug=commands.length]=_INTL("Debug")
      commands[commands.length]=_INTL("Cancel")
      #?command=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),commands)
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
				pbLearnMove(pkmn,move)
				pbRefreshSingle(pkmnid)
				end
			when 1
				move=pbChooseMoveEggs(pkmn)
				if move!=0
				pbLearnMove(pkmn,move)
				pbRefreshSingle(pkmnid)
				end
			when 2
				move=pbChooseMoveTutor(pkmn)
				if move!=0
				pbLearnMove(pkmn,move)
				pbRefreshSingle(pkmnid)
				end
			when 3
				move=pbChooseMoveTM(pkmn)
				if move!=0
				pbLearnMove(pkmn,move)
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


class PokemonScreen
	def pbPokemonDebug(pkmn,pkmnid)
	command=0
		loop do
		command=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),[
		_INTL("HP/Status"),
		_INTL("Level"),
		_INTL("Edge"),
		_INTL("Species"),
		_INTL("Moves"),
		_INTL("Gender"),
		_INTL("Ability"),
		_INTL("Nature"),
		_INTL("Shininess"),
		_INTL("Form"),
		_INTL("Happiness"),
		_INTL("EV/IV/pID"),
		_INTL("Hddn Pwr"),
		_INTL("Held Item"),
		_INTL("PP"),
		_INTL("Pokérus"),
		_INTL("Ownership"),
		_INTL("Nickname"),
		_INTL("Poké Ball"),
		_INTL("Egg"),
		_INTL("Duplicate"),
		_INTL("Delete"),
		_INTL("Cancel")
		],command)
			case command
			### Cancel ###
			when -1, 21
			break
			### HP/Status ###
			when 0
			cmd=0
				loop do
				cmd=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),[
				_INTL("Set HP"),
				_INTL("Set HP (% rounded up)"),
				_INTL("Status: Sleep"),
				_INTL("Status: Poison"),
				_INTL("Status: Burn"),
				_INTL("Status: Paralysis"),
				_INTL("Status: Frozen"),
				_INTL("Fainted"),
				_INTL("Heal")
				],cmd)
				# Break
					if cmd==-1
					break
					# Set HP
					elsif cmd==0
					params=ChooseNumberParams.new
					params.setRange(0,pkmn.totalhp)
					params.setDefaultValue(pkmn.hp)
					newhp=Kernel.pbMessageChooseNumber(
					_INTL("Set the Pokémon's HP (max. {1}).",pkmn.totalhp),params) { @scene.update }
						if newhp!=pkmn.hp
						pkmn.hp=newhp
						pbDisplay(_INTL("{1}'s HP was set to {2}.",pkmn.name,pkmn.hp))
						pbRefreshSingle(pkmnid)
						end
					elsif cmd==1
					params=ChooseNumberParams.new
					params.setRange(0,100)
					params.setDefaultValue(50)
					newhp=Kernel.pbMessageChooseNumber(
					_INTL("Set the Pokémon's HP ratio (max 100)."),params) { @scene.update }
						pkmn.hp=((newhp*pkmn.totalhp)/100).ceil
						pbDisplay(_INTL("{1}'s HP was set to {2}.",pkmn.name,pkmn.hp))
						pbRefreshSingle(pkmnid)
					# Set status
					elsif cmd>=2 && cmd<=6
						if pkmn.hp>0
						pkmn.status=cmd-1
						pkmn.statusCount=0
							if pkmn.status==PBStatuses::SLEEP
							params=ChooseNumberParams.new
							params.setRange(0,9)
							params.setDefaultValue(0)
							sleep=Kernel.pbMessageChooseNumber(
							_INTL("Set the Pokémon's sleep count."),params) { @scene.update }
							pkmn.statusCount=sleep
							end
						pbDisplay(_INTL("{1}'s status was changed.",pkmn.name))
						pbRefreshSingle(pkmnid)
						else
						pbDisplay(_INTL("{1}'s status could not be changed.",pkmn.name))
						end
					# Faint
					elsif cmd==7
					pkmn.hp=0
					pbDisplay(_INTL("{1}'s HP was set to 0.",pkmn.name))
					pbRefreshSingle(pkmnid)
					# Heal
					elsif cmd==8
					pkmn.heal
					pbDisplay(_INTL("{1} was fully healed.",pkmn.name))
					pbRefreshSingle(pkmnid)
					end
				end
			### Level ###
			when 1
			params=ChooseNumberParams.new
			params.setRange(1,PBExperience::MAXLEVEL)
			params.setDefaultValue(pkmn.level)
			level=Kernel.pbMessageChooseNumber(
			_INTL("Set the Pokémon's level (max. {1}).",PBExperience::MAXLEVEL),params) { @scene.update }
				if level!=pkmn.level
				pkmn.level=level
				pkmn.calcStats
				pbDisplay(_INTL("{1}'s level was set to {2}.",pkmn.name,pkmn.level))
				pbRefreshSingle(pkmnid)
				end
			### Edging ###
			when 2
				if pkmn.level>1 && pkmn.level<100
				pkmn.level=pkmn.level+1
				valeur=pkmn.exp
				pkmn.level=pkmn.level-1
				pkmn.exp=valeur-1
				pkmn.calcStats
				pbDisplay(_INTL("The Pokémon lost one experience point."))
				else
				pbDisplay(_INTL("Edging failed (your level must be between 2 and 99."))
				end
			### Species ###
			when 3
			species=pbChooseSpecies(pkmn.species)
				if species!=0
				oldspeciesname=PBSpecies.getName(pkmn.species)
				pkmn.species=species
				pkmn.calcStats
				oldname=pkmn.name
				pkmn.name=PBSpecies.getName(pkmn.species) if pkmn.name==oldspeciesname
				pbDisplay(_INTL("{1}'s species was changed to {2}.",oldname,PBSpecies.getName(pkmn.species)))
				pbSeenForm(pkmn)
				pbRefreshSingle(pkmnid)
			end
			### Moves ###
			when 4
			cmd=0
			txt1=PBMoves.getName($game_variables[290])
			txt2=PBMoves.getName($game_variables[291])
			txt3=PBMoves.getName($game_variables[292])
			txt4=PBMoves.getName($game_variables[293])
			
				loop do
				cmd=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),[
				_INTL("Teach move"),
				_INTL("Forget move"),
				_INTL("Teach last move ({1})",txt1),
				_INTL("Teach Saved Move 1 ({1})",txt2),
				_INTL("Teach Saved Move 2 ({1})",txt3),
				_INTL("Teach Saved Move 3 ({1})",txt4),
				_INTL("Save Move"),
				_INTL("Reset movelist"),
				_INTL("Reset initial moves")],cmd)
				# Break
					if cmd==-1
					break
					# Teach move
					elsif cmd==0
					move=pbChooseMoveList
						if move!=0
						pbLearnMove(pkmn,move)
						#$game_switches[581]
						pbRefreshSingle(pkmnid)
						$game_variables[290]=move
						txt1=PBMoves.getName($game_variables[290])
						end
					# Forget move
					elsif cmd==1
					move=pbChooseMove(pkmn,_INTL("Choose move to forget."))
						if move>=0
						movename=PBMoves.getName(pkmn.moves[move].id)
						pbDeleteMove(pkmn,move)
						pbDisplay(_INTL("{1} forgot {2}.",pkmn.name,movename))
						pbRefreshSingle(pkmnid)
						end
					# Teach "cached" move
					elsif cmd==2
						move=$game_variables[290]
						pbLearnMove(pkmn,move)
						pbRefreshSingle(pkmnid)
					# Teach saved move 1
					elsif cmd==3
						move=$game_variables[291]
						pbLearnMove(pkmn,move)
						pbRefreshSingle(pkmnid)
					# Teach saved move 2
					elsif cmd==4
						move=$game_variables[292]
						pbLearnMove(pkmn,move)
						pbRefreshSingle(pkmnid)
					# Teach saved move 3
					elsif cmd==5
						move=$game_variables[293]
						pbLearnMove(pkmn,move)
						pbRefreshSingle(pkmnid)
					# Save Move
					elsif cmd==6
					move=pbChooseMoveList
					params=ChooseNumberParams.new
					params.setRange(1,3)
					params.setDefaultValue(1)
					params.setCancelValue(-1)
					f=Kernel.pbMessageChooseNumber(
					_INTL("Which slot (1,2 or 3)"),params) { @scene.update }
						if f>=0
						$game_variables[290+f]=move
						txt2=PBMoves.getName($game_variables[291])
						txt3=PBMoves.getName($game_variables[292])
						txt4=PBMoves.getName($game_variables[293])
						end
					# Reset movelist
					elsif cmd==7
					pkmn.resetMoves
					pbDisplay(_INTL("{1}'s moves were reset.",pkmn.name))
					pbRefreshSingle(pkmnid)
					# Reset initial moves
					elsif cmd==8
					pkmn.pbRecordFirstMoves
					pbDisplay(_INTL("{1}'s moves were set as its first-known moves.",pkmn.name))
					pbRefreshSingle(pkmnid)
					end
				end
			
			### Gender ###
			when 5
				if pkmn.gender==2
				pbDisplay(_INTL("{1} is genderless.",pkmn.name))
				else
				cmd=0
					loop do
					oldgender=(pkmn.isMale?) ? _INTL("male") : _INTL("female")
					msg=[_INTL("Gender {1} is natural.",oldgender),
					_INTL("Gender {1} is being forced.",oldgender)][pkmn.genderflag ? 1 : 0]
					cmd=@scene.pbShowCommands(msg,[
					_INTL("Make male"),
					_INTL("Make female"),
					_INTL("Remove override")],cmd)
				# Break
						if cmd==-1
						break
						# Make male
						elsif cmd==0
						pkmn.setGender(0)
							if pkmn.isMale?
							pbDisplay(_INTL("{1} is now male.",pkmn.name))
							else
							pbDisplay(_INTL("{1}'s gender couldn't be changed.",pkmn.name))
							end
						# Make female
						elsif cmd==1
						pkmn.setGender(1)
							if pkmn.isFemale?
							pbDisplay(_INTL("{1} is now female.",pkmn.name))
							else
							pbDisplay(_INTL("{1}'s gender couldn't be changed.",pkmn.name))
							end
						# Remove override
						elsif cmd==2
						pkmn.genderflag=nil
						pbDisplay(_INTL("Gender override removed."))
						end
					pbSeenForm(pkmn)
					pbRefreshSingle(pkmnid)
					end
				end
			### Ability ###
			when 6
					form       = pkmn.form
				  tempabil   = pkmn.abilityIndex
				  abilid     = pkmn.ability
				  abillist   = pkmn.getAbilityList
				  name       = pkmn.getFormName
				  
				  if abillist.length == 1 || pkmn.species == PBSpecies::ZYGARDE
					@scene.pbDisplay(_INTL("It won't have any effect."))
					next false
				  end
				  commands=[]
				  command_option=[]
				  abils = []
				  for i in abillist.keys
					next if abillist[i] == abilid
					next if abils.include?(abillist[i])
					commands.push((i < 2 ? "" : "(H) ") + PBAbilities.getName(abillist[i]))
					command_option.push(i)
					abils.push(abillist[i])
				  end
				  
				  cmd=@scene.pbShowCommands("Which ability would you like to change to?",commands)
				  next false if cmd==-1
				  
				  pkmn.setAbility(command_option[cmd])
				  next true
			### Nature ###
			when 7
			cmd=0
				loop do
				oldnature=PBNatures.getName(pkmn.nature)
				commands=[]
					(PBNatures.getCount).times do |i|
					commands.push(PBNatures.getName(i))
					end
				commands.push(_INTL("Remove override"))
				msg=[_INTL("Nature {1} is natural.",oldnature),
				_INTL("Nature {1} is being forced.",oldnature)][pkmn.natureflag ? 1 : 0]
				cmd=@scene.pbShowCommands(msg,commands,cmd)
				# Break
					if cmd==-1
					break
					# Set nature override
					elsif cmd>=0 && cmd<PBNatures.getCount
					pkmn.setNature(cmd)
					pkmn.calcStats
					# Remove override
					elsif cmd==PBNatures.getCount
					pkmn.natureflag=nil
					end
				pbRefreshSingle(pkmnid)
				end
			### Shininess ###
			when 8
			cmd=0
				loop do
				oldshiny=(pkmn.isShiny?) ? _INTL("shiny") : _INTL("normal")
				msg=[_INTL("Shininess ({1}) is natural.",oldshiny),
				_INTL("Shininess ({1}) is being forced.",oldshiny)][pkmn.shinyflag!=nil ? 1 : 0]
				cmd=@scene.pbShowCommands(msg,[
				_INTL("Make shiny"),
				_INTL("Make normal"),
				_INTL("Remove override")],cmd)
				# Break
					if cmd==-1
					break
					# Make shiny
					elsif cmd==0
					pkmn.makeShiny
					# Make normal
					elsif cmd==1
					pkmn.makeNotShiny
					# Remove override
					elsif cmd==2
					pkmn.shinyflag=nil
					end
				pbRefreshSingle(pkmnid)
				end
			### Form ###
			when 9
			params=ChooseNumberParams.new
			params.setRange(0,100)
			params.setDefaultValue(pkmn.form)
			f=Kernel.pbMessageChooseNumber(
			_INTL("Set the Pokémon's form."),params) { @scene.update }
				if f!=pkmn.form
				pkmn.form=f
				pbDisplay(_INTL("{1}'s form was set to {2}.",pkmn.name,pkmn.form))
				pbSeenForm(pkmn)
				pbRefreshSingle(pkmnid)
				end
			### Happiness ###
			when 10
			params=ChooseNumberParams.new
			params.setRange(0,255)
			params.setDefaultValue(pkmn.happiness)
			h=Kernel.pbMessageChooseNumber(
			_INTL("Set the Pokémon's happiness (max. 255)."),params) { @scene.update }
				if h!=pkmn.happiness
				pkmn.happiness=h
				pbDisplay(_INTL("{1}'s happiness was set to {2}.",pkmn.name,pkmn.happiness))
				pbRefreshSingle(pkmnid)
				end
			### EV/IV/pID ###
			when 11
			stats=[_INTL("HP"),_INTL("Attack"),_INTL("Defense"),
			_INTL("Speed"),_INTL("Sp. Attack"),_INTL("Sp. Defense")]
			cmd=0
				loop do
				persid=sprintf("0x%08X",pkmn.personalID)
				cmd=@scene.pbShowCommands(_INTL("Personal ID is {1}.",persid),[
				_INTL("Set EVs"),
				_INTL("Set IVs"),
				_INTL("Randomise pID")],cmd)
					case cmd
					# Break
					when -1
					break
					# Set EVs
					when 0
					cmd2=0
						loop do
						evcommands=[]
							for i in 0...stats.length
							evcommands.push(stats[i]+" (#{pkmn.ev[i]})")
							end
						evcommands.push("EV Presets")
						cmd2=@scene.pbShowCommands(_INTL("Change which EV?"),evcommands,cmd2)
							if cmd2==-1
							break
							elsif cmd2>=0 && cmd2<stats.length
							params=ChooseNumberParams.new
							params.setRange(0,255)
							params.setDefaultValue(pkmn.ev[cmd2])
							params.setCancelValue(pkmn.ev[cmd2])
							f=Kernel.pbMessageChooseNumber(
							_INTL("Set the EV for {1} (max. 255).",stats[cmd2]),params) { @scene.update }
							pkmn.ev[cmd2]=f
							pkmn.totalhp
							pkmn.calcStats
							pbRefreshSingle(pkmnid)
							elsif cmd2>=stats.length
							evpresetscommands=0
							evpresetscommands=@scene.pbShowCommands(_INTL("Which preset do you fancy?"),[
							_INTL("252 HP and Atk"),
							_INTL("252 HP and Def"),
							_INTL("252 HP and SpAtk"),
							_INTL("252 HP and SpDef"),
							_INTL("252 HP and Speed"),
							_INTL("252 Atk and Speed"),
							_INTL("252 SpAtk and Speed"),
							_INTL("Uncommon Presets")],evpresetscommands)
								case evpresetscommands
								# Break
								when -1
								break
								when 0
								pkmn.ev[0]=252; pkmn.ev[1]=252; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								when 1
								pkmn.ev[0]=252; pkmn.ev[1]=0; pkmn.ev[2]=252; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 2
								pkmn.ev[0]=252; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=252; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 3
								pkmn.ev[0]=252; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 4
								pkmn.ev[0]=252; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=252; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 5
								pkmn.ev[0]=0; pkmn.ev[1]=252; pkmn.ev[2]=0; pkmn.ev[3]=252; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 6
								pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=252; pkmn.ev[4]=252; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
								when 7
								
								evbispresetscommands=0
									evbispresetscommands=@scene.pbShowCommands(_INTL("Which other preset?"),[
									_INTL("252 Atk and Def"),
									_INTL("252 Atk and SpDef"),
									_INTL("252 SpAtk and Def"),
									_INTL("252 SpAtk and SpDef"),
									_INTL("252 Atk and SpAtk"),
									_INTL("252 Def and Speed"),
									_INTL("252 SpDef and Speed"),
									_INTL("252 Def and SpDef"),
									_INTL("252 HP, 128 Def, 128 SpDef"),
									_INTL("PULSE2")],evbispresetscommands)
										case evbispresetscommands
										# Break
										when -1
										break
										when 0
										pkmn.ev[0]=0; pkmn.ev[1]=252; pkmn.ev[2]=252; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ; pbRefreshSingle(pkmnid);
										when 1
										pkmn.ev[0]=0; pkmn.ev[1]=252; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 2
										pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=252; pkmn.ev[3]=0; pkmn.ev[4]=252; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 3
										pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=252; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 4
										pkmn.ev[0]=0; pkmn.ev[1]=252; pkmn.ev[2]=0; pkmn.ev[3]=0; pkmn.ev[4]=252; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 5
										pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=252; pkmn.ev[3]=252; pkmn.ev[4]=0; pkmn.ev[5]=0; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 6
										pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=0; pkmn.ev[3]=252; pkmn.ev[4]=0; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 7
										pkmn.ev[0]=0; pkmn.ev[1]=0; pkmn.ev[2]=252; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 8
										pkmn.ev[0]=252; pkmn.ev[1]=0; pkmn.ev[2]=128; pkmn.ev[3]=0; pkmn.ev[4]=0; pkmn.ev[5]=128; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										when 9
										pkmn.ev[0]=252; pkmn.ev[1]=252; pkmn.ev[2]=252; pkmn.ev[3]=252; pkmn.ev[4]=252; pkmn.ev[5]=252; pkmn.calcStats ;pbRefreshSingle(pkmnid);
										end
										pkmn.calcStats ;
								
								
								
								end
								pkmn.calcStats ;
							end
						end
					# Set IVs
					when 1
					cmd2=0
						loop do
						ivcommands=[]
							for i in 0...stats.length
							ivcommands.push(stats[i]+" (#{pkmn.iv[i]})")
							end
						ivcommands.push("IV Presets")
						cmd2=@scene.pbShowCommands(_INTL("Change which IV?"),ivcommands,cmd2)
							if cmd2==-1
							break
							elsif cmd2>=0 && cmd2<stats.length
							params=ChooseNumberParams.new
							params.setRange(0,31)
							params.setDefaultValue(pkmn.iv[cmd2])
							params.setCancelValue(pkmn.iv[cmd2])
							f=Kernel.pbMessageChooseNumber(
							_INTL("Set the IV for {1} (max. 31).",stats[cmd2]),params) { @scene.update }
							pkmn.iv[cmd2]=f
							pkmn.totalhp
							pkmn.calcStats
							pbRefreshSingle(pkmnid)
							elsif cmd2>=stats.length
							ivpresetscommands=0
							ivpresetscommands=@scene.pbShowCommands(_INTL("Which preset do you fancy?"),[
							_INTL("Perfect Physical"),
							_INTL("Perfect Special"),
							_INTL("Trick Room"),
							_INTL("Mixed Offenses"),
							_INTL("Stakataka")],ivpresetscommands)
								case ivpresetscommands
								# Break
								when -1
								break
								when 0
								pkmn.iv[0]=31; pkmn.iv[1]=31; pkmn.iv[2]=31; pkmn.iv[3]=31; pkmn.iv[5]=31; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								when 1
								pkmn.iv[0]=31; pkmn.iv[2]=31; pkmn.iv[3]=31; pkmn.iv[4]=31; pkmn.iv[5]=31; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								when 2
								pkmn.iv[0]=31; pkmn.iv[1]=31; pkmn.iv[2]=31; pkmn.iv[3]=0; pkmn.iv[4]=31; pkmn.iv[5]=31; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								when 3
								pkmn.iv[0]=31; pkmn.iv[1]=31; pkmn.iv[2]=31; pkmn.iv[3]=31; pkmn.iv[4]=31; pkmn.iv[5]=31; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								when 4
								pkmn.iv[0]=31; pkmn.iv[1]=31; pkmn.iv[2]=0; pkmn.iv[3]=31; pkmn.iv[5]=31; pkmn.calcStats ; pbRefreshSingle(pkmnid);
								end
								pkmn.calcStats ;
							end
						end
					# Randomise pID
					when 2
					pkmn.personalID=rand(256)
					pkmn.personalID|=rand(256)<<8
					pkmn.personalID|=rand(256)<<16
					pkmn.personalID|=rand(256)<<24
					pkmn.calcStats
					pbRefreshSingle(pkmnid)
					end
				end
			### Hidden Power ###
			when 12
			HiddenPowerChanger(pkmn)
			### Held Item ###
			when 13
			item=pbListScreen(_INTL("Set Held Item"),ItemLister.new(0))
				if item && item>0
				pkmn.setItem(item)
				end
			### PPs ###
			when 14
			move=pbChooseMove(pkmn,_INTL("Choose move to edit PP on."))
			movid=pkmn.moves[move].id
				if movid>=0
				ppcommands=0
				ppcommands=@scene.pbShowCommands(_INTL("What do you want to do?"),[
				_INTL("Edit PPs"),
				_INTL("Set PP max to +0"),
				_INTL("Set PP max to +1"),
				_INTL("Set PP max to +2"),
				_INTL("Set PP max to +3")],ppcommands)
					case ppcommands
					# Break
					when -1
					break
					when 0
				
					params=ChooseNumberParams.new
					params.setRange(0,pkmn.moves[move].totalpp)
					params.setDefaultValue(pkmn.moves[move].pp)
					params.setCancelValue(pkmn.moves[move].totalpp)
					valeurmove=Kernel.pbMessageChooseNumber(
					_INTL("Set the PP value."),params) { @scene.update }
					pkmn.moves[move].pp=valeurmove
					when 1
					pkmn.moves[move].ppup=0
					when 2
					pkmn.moves[move].ppup=1
					pkmn.moves[move].pp=pkmn.moves[move].totalpp
					pbDisplay(_INTL("#{PBMoves.getName(pkmn.moves[move].id)}'s PP was set to #{pkmn.moves[move].totalpp}."))
					when 3
					pkmn.moves[move].ppup=2
					pkmn.moves[move].pp=pkmn.moves[move].totalpp
					pbDisplay(_INTL("#{PBMoves.getName(pkmn.moves[move].id)}'s PP was set to #{pkmn.moves[move].totalpp}."))
					when 4
					pkmn.moves[move].ppup=3
					pkmn.moves[move].pp=pkmn.moves[move].totalpp
					pbDisplay(_INTL("#{PBMoves.getName(pkmn.moves[move].id)}'s PP was set to #{pkmn.moves[move].totalpp}."))
					end
				end
			### Pokérus ###
			when 15
			cmd=0
				loop do
				pokerus=(pkmn.pokerus) ? pkmn.pokerus : 0
				msg=[_INTL("{1} doesn't have Pokérus.",pkmn.name),
				_INTL("Has strain {1}, infectious for {2} more days.",pokerus/16,pokerus%16),
				_INTL("Has strain {1}, not infectious.",pokerus/16)][pkmn.pokerusStage]
				cmd=@scene.pbShowCommands(msg,[
				_INTL("Give random strain"),
				_INTL("Make not infectious"),
				_INTL("Clear Pokérus")],cmd)
				# Break
					if cmd==-1
					break
					# Give random strain
					elsif cmd==0
					pkmn.givePokerus
					# Make not infectious
					elsif cmd==1
					strain=pokerus/16
					p=strain<<4
					pkmn.pokerus=p
					# Clear Pokérus
					elsif cmd==2
					pkmn.pokerus=0
					end
				end
			### Ownership ###
			when 16
			cmd=0
				loop do
				gender=[_INTL("Male"),_INTL("Female"),_INTL("Unknown")][pkmn.otgender]
				msg=[_INTL("Player's Pokémon\n{1}\n{2}\n{3} ({4})",pkmn.ot,gender,pkmn.publicID,pkmn.trainerID),
				_INTL("Foreign Pokémon\n{1}\n{2}\n{3} ({4})",pkmn.ot,gender,pkmn.publicID,pkmn.trainerID)
				][pkmn.isForeign?($Trainer) ? 1 : 0]
				cmd=@scene.pbShowCommands(msg,[
				_INTL("Make player's"),
				_INTL("Set OT's name"),
				_INTL("Set OT's gender"),
				_INTL("Random foreign ID"),
				_INTL("Set foreign ID")],cmd)
				# Break
					if cmd==-1
					break
					# Make player's
					elsif cmd==0
					pkmn.trainerID=$Trainer.id
					pkmn.ot=$Trainer.name
					pkmn.otgender=$Trainer.gender
					# Set OT's name
					elsif cmd==1
					newot=pbEnterPlayerName(_INTL("{1}'s OT's name?",pkmn.name),1,12)
					pkmn.ot=newot
					# Set OT's gender
					elsif cmd==2
					cmd2=@scene.pbShowCommands(_INTL("Set OT's gender."),
					[_INTL("Male"),_INTL("Female"),_INTL("Unknown")])
					pkmn.otgender=cmd2 if cmd2>=0
					# Random foreign ID
					elsif cmd==3
					pkmn.trainerID=$Trainer.getForeignID
					# Set foreign ID
					elsif cmd==4
					params=ChooseNumberParams.new
					params.setRange(0,65535)
					params.setDefaultValue(pkmn.publicID)
					val=Kernel.pbMessageChooseNumber(
					_INTL("Set the new ID (max. 65535)."),params) { @scene.update }
					pkmn.trainerID=val
					pkmn.trainerID|=val<<16
					end
				end
			### Nickname ###
			when 17
			cmd=0
				loop do
				speciesname=PBSpecies.getName(pkmn.species)
				msg=[_INTL("{1} has the nickname {2}.",speciesname,pkmn.name),
				_INTL("{1} has no nickname.",speciesname)][pkmn.name==speciesname ? 1 : 0]
				cmd=@scene.pbShowCommands(msg,[
				_INTL("Rename"),
				_INTL("Erase name")],cmd)
				# Break
					if cmd==-1
					break
					# Rename
					elsif cmd==0
					newname=pbEnterPokemonName(_INTL("{1}'s nickname?",speciesname),0,15,"",pkmn)
					pkmn.name=(newname=="") ? speciesname : newname
					pbRefreshSingle(pkmnid)
					# Erase name
					elsif cmd==1
					pkmn.name=speciesname
					end
				end
			### Poké Ball ###
			when 18
			cmd=0
				loop do
				oldball=PBItems.getName(pbBallTypeToBall(pkmn.ballused))
				commands=[]; balls=[]
					for key in $BallTypes.keys
					item=getID(PBItems,$BallTypes[key])
					balls.push([key,PBItems.getName(item)]) if item && item>0
					end
				balls.sort! {|a,b| a[1]<=>b[1]}
					for i in 0...commands.length
					cmd=i if pkmn.ballused==balls[i][0]
					end
					for i in balls
					commands.push(i[1])
					end
				cmd=@scene.pbShowCommands(_INTL("{1} used.",oldball),commands,cmd)
					if cmd==-1
					break
					else
					pkmn.ballused=balls[cmd][0]
					end
				end
			### Egg ###
			when 19
			cmd=0
				loop do
				msg=[_INTL("Not an egg"),
				_INTL("Egg with eggsteps: {1}.",pkmn.eggsteps)][pkmn.isEgg? ? 1 : 0]
				cmd=@scene.pbShowCommands(msg,[
				_INTL("Make egg"),
				_INTL("Make Pokémon"),
				_INTL("Set eggsteps to 1")],cmd)
				# Break
					if cmd==-1
					break
					# Make egg
					elsif cmd==0
						if pbHasEgg?(pkmn.species) ||
						pbConfirm(_INTL("{1} cannot be an egg. Make egg anyway?",PBSpecies.getName(pkmn.species)))
						pkmn.level=EGGINITIALLEVEL
						pkmn.calcStats
						pkmn.name=_INTL("Egg")
						dexdata=pbOpenDexData
						pbDexDataOffset(dexdata,pkmn.species,21)
						pkmn.eggsteps=dexdata.fgetw
						dexdata.close
						pkmn.hatchedMap=0
						pkmn.obtainMode=1
						pbRefreshSingle(pkmnid)
						end
					# Make Pokémon
					elsif cmd==1
					pkmn.name=PBSpecies.getName(pkmn.species)
					pkmn.eggsteps=0
					pkmn.hatchedMap=0
					pkmn.obtainMode=0
					pbRefreshSingle(pkmnid)
					# Set eggsteps to 1
					elsif cmd==2
					pkmn.eggsteps=1 if pkmn.eggsteps>0
					end
				end
			### Duplicate ###
			when 20
				if pbConfirm(_INTL("Are you sure you want to copy this Pokémon?"))
				clonedpkmn=torPasteMon(pkmn)
				pbStorePokemon(clonedpkmn)
				pbHardRefresh
				pbDisplay(_INTL("The Pokémon was duplicated."))
				break
				end
			### Delete ###
			when 21
				if pbConfirm(_INTL("Are you sure you want to delete this Pokémon?"))
				@party[pkmnid]=nil
				@party.compact!
				pbHardRefresh
				pbDisplay(_INTL("The Pokémon was deleted."))
				break
				end
			end
		end
	end
end

def torPasteMon(poke)
# Proper way to copy a pokemon.
species=poke.species
level=poke.level
pokemon=PokeBattle_Pokemon.new(species,level)
pokemon.form=poke.form
pokemon.resetMoves
pokemon.setItem(poke.item)
pokemon.moves[0]=PBMove.new(poke.moves[0].id)
pokemon.moves[1]=PBMove.new(poke.moves[1].id)
pokemon.moves[2]=PBMove.new(poke.moves[2].id)
pokemon.moves[3]=PBMove.new(poke.moves[3].id)
pokemon.setAbility(poke.abilityflag)
pokemon.name=poke.name
pokemon.setGender(poke.gender)
pokemon.happiness=poke.happiness
	if poke.shinyflag   # if this is a shiny Pokémon
	pokemon.makeShiny
	else
	pokemon.makeNotShiny
	end
pokemon.setNature(poke.nature)
	for i in 0...6
	pokemon.iv[i]=poke.iv[i]
	end
	for i in 0...6
	pokemon.ev[i]=poke.ev[i]
	end
pokemon.calcStats
return pokemon
end


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
  tutorlist=[PBMoves::MAGICCOAT,PBMoves::MAGICROOM,PBMoves::WONDERROOM,PBMoves::TELEKINESIS,PBMoves::IRONDEFENSE,PBMoves::SNORE,PBMoves::BIND,PBMoves::SPITE,PBMoves::SNATCH,
PBMoves::HELPINGHAND,PBMoves::ALLYSWITCH,PBMoves::AFTERYOU,PBMoves::GRAVITY,PBMoves::MAGNETRISE,PBMoves::BLOCK,PBMoves::WORRYSEED,PBMoves::GIGADRAIN,PBMoves::WATERPLEDGE,
PBMoves::FIREPLEDGE,PBMoves::GRASSPLEDGE,PBMoves::GASTROACID,PBMoves::RECYCLE,PBMoves::ENDEAVOR,PBMoves::PAINSPLIT,PBMoves::VOLTTACKLE,PBMoves::ROLEPLAY,PBMoves::COVET,
PBMoves::ELECTROWEB,PBMoves::SKYATTACK,PBMoves::TRICK,PBMoves::DEFOG,PBMoves::LASERFOCUS,PBMoves::SKILLSWAP,PBMoves::WATERPULSE,PBMoves::LASTRESORT,PBMoves::SUPERFANG,
PBMoves::SHOCKWAVE,PBMoves::HEADBUTT,PBMoves::BOUNCE,PBMoves::HEALBELL,PBMoves::BUGBITE,PBMoves::DUALCHOP,PBMoves::THUNDERPUNCH,PBMoves::FIREPUNCH,PBMoves::ICEPUNCH,
PBMoves::UPROAR,PBMoves::HYPERVOICE,PBMoves::STOMPINGTANTRUM,PBMoves::LOWKICK,PBMoves::IRONTAIL,PBMoves::FOCUSPUNCH,PBMoves::DRILLRUN,PBMoves::SYNTHESIS,PBMoves::KNOCKOFF,
PBMoves::IRONHEAD,PBMoves::GIGADRAIN,PBMoves::LIQUIDATION,PBMoves::AQUATAIL,PBMoves::ICYWIND,PBMoves::SIGNALBEAM,PBMoves::THROATCHOP,PBMoves::DRAINPUNCH,PBMoves::TAILWIND,
PBMoves::ZENHEADBUTT,PBMoves::STEALTHROCK,PBMoves::GUNKSHOT,PBMoves::DRAGONPULSE,PBMoves::SEEDBOMB,PBMoves::FOULPLAY,PBMoves::SUPERPOWER,PBMoves::EARTHPOWER,PBMoves::OUTRAGE,
PBMoves::HEATWAVE,PBMoves::HYDROCANNON,PBMoves::BLASTBURN,PBMoves::FRENZYPLANT,PBMoves::DRACOMETEOR,PBMoves::CELEBRATE]
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
  tutorlist=[PBMoves::WORKUP,PBMoves::DRAGONCLAW,PBMoves::PSYSHOCK,PBMoves::CALMMIND,PBMoves::ROAR,PBMoves::TOXIC,PBMoves::HAIL,PBMoves::BULKUP,PBMoves::VENOSHOCK,
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
PBMoves::CUT,PBMoves::FLY,PBMoves::SURF,PBMoves::STRENGTH,PBMoves::WATERFALL,PBMoves::DIVE,PBMoves::ROCKSMASH,PBMoves::FLASH,PBMoves::ROCKCLIMB]
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
  commands.push("Abilities : #{abilities}")	

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

#MODDED STUFF FROM SWM FOR THE EGG MOVES Mod
def swm_getAllEggMoves(pokemon)
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
    # next if pokemon.knowsMove?(move)
    retval.push(move)
  end
  return retval
end

def swm_getPossibleBabies(species)
  babyspecies=pbGetBabySpecies(species)
  babies=[babyspecies, pbGetNonIncenseLowestSpecies(babyspecies)]
  if isConst?(babyspecies, PBSpecies,:MANAPHY) && hasConst?(PBSpecies, :PHIONE)
    babyspecies=getConst(PBSpecies, :PHIONE)
    babies.push(*[babyspecies, pbGetNonIncenseLowestSpecies(babyspecies)])
  end
  babyspecies=[]
  if (babyspecies == PBSpecies::NIDORANfE) && hasConst?(PBSpecies,:NIDORANmA)
    babyspecies=[(PBSpecies::NIDORANmA), (PBSpecies::NIDORANfE)]
  elsif (babyspecies == PBSpecies::NIDORANmA) && hasConst?(PBSpecies,:NIDORANfE)
    babyspecies=[(PBSpecies::NIDORANmA), (PBSpecies::NIDORANfE)]
  elsif (babyspecies == PBSpecies::VOLBEAT) && hasConst?(PBSpecies,:ILLUMISE)
    babyspecies=[PBSpecies::VOLBEAT, PBSpecies::ILLUMISE]
  elsif (babyspecies == PBSpecies::ILLUMISE) && hasConst?(PBSpecies,:VOLBEAT)
    babyspecies=[PBSpecies::VOLBEAT, PBSpecies::ILLUMISE]
  end
  for baby in babyspecies
    babies.push(*[baby, pbGetNonIncenseLowestSpecies(baby)])
  end
  return babies|[] # Remove duplicates
end

def swm_getEggMoves(babyspecies, form)
  moves=[]
  egg=PokeBattle_Pokemon.new(babyspecies,EGGINITIALLEVEL,$Trainer)
  egg.form = form
  name = egg.getFormName
	formcheck = PokemonForms.dig(egg.species,name,:EggMoves)
  if formcheck!=nil
    for move in formcheck
      atk = getID(PBMoves,move)
      moves.push(atk)
    end
  else 
    movelist = $cache.pkmn_egg[babyspecies]
    if movelist
      for i in movelist
        atk = getID(PBMoves,i)
        moves.push(atk)
      end
    end
  end
  # Volt Tackle
  moves.push(PBMoves::VOLTTACKLE) if [PBSpecies::PICHU, PBSpecies::PIKACHU, PBSpecies::RAICHU].include?(babyspecies)
  return moves|[] # remove duplicates
end


#MODDED
def pbLearnMove(pokemon,move,ignoreifknown=false,bymachine=false)
  return false if !pokemon
  movename=PBMoves.getName(move)
  if pokemon.isEgg? && !$DEBUG
    Kernel.pbMessage(_INTL("{1} can't be taught to an Egg.",movename))
    return false
  end
  if pokemon.respond_to?("isShadow?") && pokemon.isShadow?
    Kernel.pbMessage(_INTL("{1} can't be taught to this Pokémon.",movename))
    return false
  end
  pkmnname=pokemon.name
  for i in 0...4
    if pokemon.moves[i].id==move
      Kernel.pbMessage(_INTL("{1} already knows\r\n{2}.",pkmnname,movename)) if !ignoreifknown
      return false
    end
    if pokemon.moves[i].id==0
      pokemon.moves[i]=PBMove.new(move)
	  #MODDED
	  if $game_switches[581]
	  pokemon.moves[i].ppup=3
	  pokemon.moves[i].pp=pokemon.moves[i].totalpp
	  end
      Kernel.pbMessage(_INTL("{1} learned {2}!\\se[itemlevel]",pkmnname,movename))
      return true
    end
  end
  loop do
    Kernel.pbMessage(_INTL("{1} is trying to\r\nlearn {2}.\1",pkmnname,movename))
    Kernel.pbMessage(_INTL("But {1} can't learn more than four moves.\1",pkmnname))
    if Kernel.pbConfirmMessage(_INTL("Delete a move to make\r\nroom for {1}?",movename))
      Kernel.pbMessage(_INTL("Which move should be forgotten?"))
      forgetmove=pbForgetMove(pokemon,move)
      if forgetmove>=0
        oldmovename=PBMoves.getName(pokemon.moves[forgetmove].id)
        oldmovepp=pokemon.moves[forgetmove].pp
        pokemon.moves[forgetmove]=PBMove.new(move) # Replaces current/total PP
        pokemon.moves[forgetmove].pp=[oldmovepp,pokemon.moves[forgetmove].totalpp].min if bymachine
	      #MODDED
		  if $game_switches[581]
		  pokemon.moves[forgetmove].ppup=3
		  pokemon.moves[forgetmove].pp=pokemon.moves[forgetmove].totalpp
		  end
        Kernel.pbMessage(_INTL("\\se[]1,\\wt[4] 2,\\wt[4] and...\\wt[8] ...\\wt[8] ...\\wt[8] Poof!\\se[balldrop]\1"))
        Kernel.pbMessage(_INTL("{1} forgot how to\r\nuse {2}.\1",pkmnname,oldmovename))
        Kernel.pbMessage(_INTL("And...\1"))
        Kernel.pbMessage(_INTL("\\se[]{1} learned {2}!\\se[itemlevel]",pkmnname,movename))
        return true
      elsif Kernel.pbConfirmMessage(_INTL("Should {1} stop learning {2}?",pkmnname,movename))
        Kernel.pbMessage(_INTL("{1} did not learn {2}.",pkmnname,movename))
        return false
      end
    elsif Kernel.pbConfirmMessage(_INTL("Should {1} stop learning {2}?",pkmnname,movename))
      Kernel.pbMessage(_INTL("{1} did not learn {2}.",pkmnname,movename))
      return false
    end
  end
end

