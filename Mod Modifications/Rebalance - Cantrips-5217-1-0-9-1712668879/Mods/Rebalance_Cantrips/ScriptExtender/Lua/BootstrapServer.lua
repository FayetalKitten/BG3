Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function (character)
	local entity = Ext.Entity.Get(character)
	local intCaster = false
	local wisCaster = false
	local chaCaster = false
	local highElfCantrip = ""
	if entity.CharacterCreationStats then
		if (entity.CharacterCreationStats.Abilities[5] > entity.CharacterCreationStats.Abilities[6]) and (entity.CharacterCreationStats.Abilities[5] > entity.CharacterCreationStats.Abilities[7]) then
		intCaster = true
		elseif (entity.CharacterCreationStats.Abilities[6] > entity.CharacterCreationStats.Abilities[5]) and (entity.CharacterCreationStats.Abilities[6] > entity.CharacterCreationStats.Abilities[7]) then
			wisCaster = true
		elseif (entity.CharacterCreationStats.Abilities[7] > entity.CharacterCreationStats.Abilities[5]) and (entity.CharacterCreationStats.Abilities[7] > entity.CharacterCreationStats.Abilities[6]) then
			chaCaster = true
		else
			intCaster = true
		end
	end
	for i,entry in pairs(entity.LevelUp.field_18) do
		for j,spell in pairs(entry.Upgrades.Spells) do
			if spell.field_78 == "HighElfCantrip" then
				highElfCantrip = spell.Spells[1]
			end
		end
	end
	if not (highElfCantrip == "") and (intCaster or wisCaster or chaCaster) then
		for i,spell in pairs(entity.SpellBook.Spells) do
			if (spell.Id.OriginatorPrototype == highElfCantrip) then
				if intCaster then entity.SpellBook.Spells[i].SpellCastingAbility = "Intelligence"
				elseif wisCaster then entity.SpellBook.Spells[i].SpellCastingAbility = "Wisdom"
				elseif chaCaster then entity.SpellBook.Spells[i].SpellCastingAbility = "Charisma" 
				end
				entity:Replicate("SpellBook")
			end
		end
	end
end)