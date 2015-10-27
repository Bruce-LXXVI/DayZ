private ["_bias","_vectorup","_elevation", "_countpos","_lootChance","_index","_weights","_cntWeights","_itemType","_qty","_rnd","_iPos","_obj","_type","_config","_pos","_itemTypes","_positions","_bias", "_pos", "_pos_index", "_i", "_x", "_index", "_existing_loopiles_count", "_deleted_loopiles", "_local"];
_obj = _this;

/// don't populate if the object tilts too much
_vectorup = vectorUp _obj;
if (abs(([0,0,_vectorup select 2] distance _vectorup) atan2 (_vectorup select 2)) > 20) exitWith {0};

_type = typeOf _obj;
_config = configFile >> dayz_CBLConfigName >> _type;
_type = toLower _type;
_itemTypes = [] + getArray (_config >> "lootType");
_lootChance = getNumber (_config >> "lootChance");
_qty = 0; // effective quantity of spawned weaponholder
_pos = [] + getArray (_config >> "lootPos");
_countpos = count _pos;
_posidx = [];
for "_i" from _countpos-1 to 0 step -1 do {
	_posidx set [_i, _i];
};
_rnd = 0.5;
_existing_loopiles_count = 0;
_deleted_loopiles = 0;
_local = _obj getVariable [ "", false ];
_iPos=[];
for "_i" from _countpos to 1 step -1 do {
	_x = _posidx select floor random _i;
	_posidx = _posidx - [_x];
	_x = _pos select _x;
	if ((count _x == 3) AND {(dayz_currentWeaponHolders < dayz_maxMaxWeaponHolders)}) then {	
		_iPos = _obj modelToWorld _x;
		_delLootPiles = [];
		// local building (from towngenerator) -> don't delete previous, don't add another lootpile if previous exists
		_existing_loopiles_count = {
			if (!_local) then { 
				_delLootPiles set [ count _delLootPiles, _x];
				_deleted_loopiles=_deleted_loopiles+1;
				false
			}
			else { true }
		} count (_iPos nearObjects ["reammoBox", 2]);
		if ((random 1) <= _lootChance) then {
			_index = dayz_CBLBase find _type;

			while {_index < 0} do {
				diag_log format["[PLAYZ] NOT FOUND: _type=%1 | _index=%2", _type, _index];
				//_type = dayz_CBLBase call BIS_fnc_selectRandom;
				_type = toLower (["ResidentialNamalsk", "IndustrialNamalsk", "HeliCrashNamalsk", "MilitaryNamalskWinter", "MilitarySpecialNamalsk", "MilitarySpecialNamalskWinter"] call BIS_fnc_selectRandom);
				_index = dayz_CBLBase find _type;
				diag_log format["[PLAYZ] USING INSTEAD: _type=%1 | _index=%2", _type, _index];
			};

			_weights = [0];
			if( (count dayz_CBLChances) > _index ) then {
				_weights = dayz_CBLChances select _index;
				//diag_log format["[PLAYZ] _index=%1 | _weights=%2", _index, _weights];
			};
			_cntWeights = count _weights;
			_index = floor(random _cntWeights);
			_index = _weights select _index;
			
			if( (count _itemTypes) > _index ) then {
				_itemType = _itemTypes select _index;
			} else {
				diag_log format["[PLAYZ] INDEX OUT OF BOUNDS: _index=%1 | _itemTypes=%2", _index, _itemTypes];
				_index = 0;
				_itemTypes = [["", "trash", 1]];
				_itemType = _itemTypes select _index;
				diag_log format["[PLAYZ] USING INSTEAD: _index=%1 | _itemTypes=%2", _index, _itemTypes];
			};
			_elevation = 0 max (_iPos select 2); // prevent buried weaponholder if the building is buried at this loot position
			_iPos set [2, _elevation];
			diag_log format["[PLAYZ] [%1, %2, %3, %4] call spawn_loot;", _itemType select 0, _itemType select 1, _iPos, 0.0];
			if( count _itemType > 1 ) then {
				[_itemType select 0, _itemType select 1, _iPos, 0.0] call spawn_loot;
				dayz_currentWeaponHolders = dayz_currentWeaponHolders + 1;
				_qty = _qty + 1;
			} else {
				diag_log format["[PLAYZ] NOT CALLING spawn_loot !!  _type=%1 | _itemTypes=%2", _type, _itemTypes];
			};
		};
		{ deleteVehicle _x; } count _delLootPiles;
	};
};

/*

diag_log format [ "%1: add loot %2%8 at [%6]. chance:%3(unbiased:%4) del:%7 old:%9 new:%5", __FILE__, 
	_obj, _lootChance, (getNumber (_config >> "lootChance")),
	_qty, _iPos, _deleted_loopiles, 
	if (_local) then { "(local)" } else { "" },_existing_loopiles_count
];	

*/

_qty

