using Pkg
Pkg.activate(@__DIR__) 
Pkg.instantiate() 

abstract type AbstractType end

struct Normal <: AbstractType end
struct Fire <: AbstractType end
struct Water <: AbstractType end
struct Electric <: AbstractType end
struct Grass <: AbstractType end
struct Ice <: AbstractType end
struct Fighting <: AbstractType end
struct Poison <: AbstractType end
struct Ground <: AbstractType end

const no_effect = 0.0
const not_very_effective = 0.5
const normal_effective = 1.0
const super_effective = 2.0

# every case with the later defind exeptions
function eff(attacker::AbstractType, defender::AbstractType)
    return normal_effective
end

# interaction between same types
function eff(attacker::X, defender::X) where {X <: AbstractType}
    return not_very_effective
end
function eff(attacker::Normal, defender::Normal)
    return normal_effective
end
function eff(attacker::Fighting, defender::Fighting)
    return normal_effective
end
function eff(attacker::Ground, defender::Ground)
    return normal_effective
end

# attack Fire
function eff(attacker::Fire, defender::Water)
    return not_very_effective
end
function eff(attacker::Fire, defender::Grass)
    return super_effective
end
function eff(attacker::Fire, defender::Ice)
    return super_effective
end

#attack Water
function eff(attacker::Water, defender::Fire)
    return super_effective
end
function eff(attacker::Water, defender::Grass)
    return not_very_effective
end
function eff(attacker::Water, defender::Ground)
    return super_effective
end

#attack Electric
function eff(attacker::Electric, defender::Water)
    return super_effective
end
function eff(attacker::Electric, defender::Grass)
    return not_very_effective
end
function eff(attacker::Electric, defender::Ground)
    return no_effect
end

#attack Grass
function eff(attacker::Grass, defender::Fire)
    return not_very_effective
end
function eff(attacker::Grass, defender::Water)
    return super_effective
end
function eff(attacker::Grass, defender::Poison)
    return not_very_effective
end
function eff(attacker::Grass, defender::Ground)
    return super_effective
end

#attack Ice
function eff(attacker::Ice, defender::Fire)
    return not_very_effective
end
function eff(attacker::Ice, defender::Water)
    return not_very_effective
end
function eff(attacker::Ice, defender::Grass)
    return super_effective
end
function eff(attacker::Ice, defender::Ground)
    return super_effective
end

#attack Fighting
function eff(attacker::Fighting, defender::Normal)
    return super_effective
end
function eff(attacker::Fighting, defender::Ice)
    return super_effective
end
function eff(attacker::Fighting, defender::Poison)
    return not_very_effective
end

#attack Poison
function eff(attacker::Poison, defender::Grass)
    return super_effective
end
function eff(attacker::Fighting, defender::Ground)
    return not_very_effective
end

#attack Ground
function eff(attacker::Ground, defender::Fire)
    return super_effective
end
function eff(attacker::Ground, defender::Electric)
    return super_effective
end
function eff(attacker::Ground, defender::Grass)
    return not_very_effective
end
function eff(attacker::Ground, defender::Poison)
    return super_effective
end

function eff_string(eff)
    if eff == 0.5
        return "The attack was not very effective"
    elseif eff == 1
        return "The attack was normaleffective"
    elseif eff == 2
        return "The attack was super effective"
    elseif eff == 0
        return "The attack had no effect"
    else 
        error("Invalid attack effectiveness. Valid inputs are: 0.5, 1, 2 or 0")
    end    
end

function attack(attacker, defender)
    effectiveness = eff(attacker(), defender())
    eff_value = eff_string(effectiveness)
    println("A Pokemon Type $attacker attacked a Pokemon Type $defender.
$eff_value.")
end