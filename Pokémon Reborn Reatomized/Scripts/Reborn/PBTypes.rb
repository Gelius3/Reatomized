class PBTypes
NORMAL=0
FIGHTING=1
FLYING=2
POISON=3
GROUND=4
ROCK=5
BUG=6
GHOST=7
STEEL=8
QMARKS=9
FIRE=10
WATER=11
GRASS=12
ELECTRIC=13
PSYCHIC=14
ICE=15
DRAGON=16
DARK=17
FAIRY=18
NUCLEAR=19
COSMIC=20
STELLAR=21
def PBTypes.getCount; return 22; end
def PBTypes.maxValue; return 21; end
def PBTypes.getName(id)
return pbGetMessage(MessageTypes::Types,id)
end
end
