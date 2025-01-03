//shield
/datum/advclass/combat/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, drawn from the ranks of temple acolytes who demonstrated martial talent. Protected by armor and zeal, they are a force to be reckoned with."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Aasimar"
	)
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()

	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	wrists = /obj/item/clothing/neck/roguetown/psycross/silver
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather

	switch(H.patron?.name)
		if("Astrata")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if("Dendor")
			head = /obj/item/clothing/head/roguetown/antlerhood
			neck = /obj/item/clothing/neck/roguetown/coif
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
			beltr = /obj/item/rogueweapon/knife/stone
		if("Necra")
			head = /obj/item/clothing/head/roguetown/padded/deathface
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			neck = /obj/item/clothing/neck/roguetown/coif
		if("Eora")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/eora
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			H.virginity = FALSE
		if("Ravox")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
			neck = /obj/item/clothing/neck/roguetown/gorget
		if("Noc")
			wrists = /obj/item/clothing/neck/roguetown/psycross/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if("Pestra")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if("Malum")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/malum_steel
			cloak = /obj/item/clothing/cloak/stabard/templar/malum
			neck = /obj/item/clothing/neck/roguetown/gorget
		if("Abyssor")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver
			cloak = /obj/item/clothing/cloak/stabard/templar/abyssor
		else // Failsafe
			cloak = /obj/item/clothing/cloak/tabard/crusader // Give us a generic crusade tabard

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)

	H.virginity = TRUE
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Even if it has limited slots, it is a common drifter role available to anyone. Their armor also is not heavy, so medium armor training is enough

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells_cleric(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

