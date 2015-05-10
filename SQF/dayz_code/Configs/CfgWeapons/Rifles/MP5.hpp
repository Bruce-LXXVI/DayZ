class MP5_DZ : MP5A5
{
	displayName = $STR_DZ_WPN_MP5_NAME;
	
	magazines[] =
	{
		30Rnd_9x19_MP5,
		30Rnd_9x19_MP5SD
	};
	
	class Attachments
	{
		attachments[] =
		{
			"Attachment_Sup9"
		};
		
		Attachment_Sup9 = "MP5_SD_DZ";
	};
};

class MP5_SD_DZ : MP5SD
{
	displayName = $STR_DZ_WPN_MP5_SD_NAME;
	
	model = "z\addons\dayz_communityweapons\mp5\mp5_sd.p3d";
	
	magazines[] =
	{
		30Rnd_9x19_MP5SD,
		30Rnd_9x19_MP5
	};
	
	class ItemActions
	{
		class RemoveSuppressor
		{
			text = $STR_DZ_ATT_SUP9_RMVE;
			script = "; ['Attachment_Sup9',_id,'MP5_DZ'] call player_removeAttachment";
		};
	};
};