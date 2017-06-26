class ItemWire : CA_Magazine
{
	scope = public;
	count = 1;
	type = WeaponSlotItem;
	
	model = "\dayz_equip\models\Fence_wire_kit.p3d";
	picture = "\dayz_equip\textures\equip_fencewire_kit_CA.paa";
	displayName = $STR_EQUIP_NAME_23;
	descriptionShort = $STR_EQUIP_DESC_23;

	/*
	//Due to issues with some players and graphic glitches this item has been removed.
	class ItemActions
	{
		class Build
		{
			text = $STR_ACTION_BUILD;
			script = "; [_id,'Build'] spawn player_build;";
			require[] = {"ItemToolbox"};
			consume[] = {"ItemWire"};
			create = "Wire_cat1";
			byPass = "byPassRoadCheck";
		};
	};
	*/
};