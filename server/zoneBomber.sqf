playerBombID = DebugPlr;

if (isDedicated || isServer) then {
	sleep 30;
	publicVariable "playerBombID";
	
	_allUnits = [] + aiUnits + playableUnits;
	
	_selPlr = 0;
	while {true} do {
		_co = 0;
		{
			_obj = _x;
			if (alive _obj) then {
				_sel = 0;
				{
					if ((zoneStatus select _sel) == 100 && _sel != SAFEZONE) then {

						_zx = getMarkerPos (zones select _sel) select 0;
						_zy = getMarkerPos (zones select _sel) select 1;
						_px = getPos _obj select 0;
						_py = getPos _obj select 1;

						_dx = _px - _zx;
						_dy = _py - _zy;
						
						if ((_dx > -200) && (_dx < 200)) then {
							if ((_dy > -200) && (_dy < 200)) then {
								_nades = 3;
								while {_nades > 0} do {
									_rx = -15 + floor(random 30);
									_ry = -15 + floor(random 30);
									_ax = _px + _rx;
									_ay = _py + _ry;
									_bomb = "Grenade" createVehicle [_ax, _ay, 60];
									_nades = _nades - 1;
									sleep .05;
								};
							};
						};
					};
					_sel =_sel + 1;
				} forEach zones;
				// Perimeter check
				_lx = getMarkerPos "Perimeter" select 0;
				_ly = getMarkerPos "Perimeter" select 1;
				_px = getPos _obj select 0;
				_py = getPos _obj select 1;
				_bombMode = 0;
				if (_px < (_lx - 2000)) then {
					_bombMode = 1;
				};
				if (_px > (_lx + 2000)) then {
					_bombMode = 1;
				};
				if (_py < (_ly - 2000)) then {
					_bombMode = 1;
				};
				if (_py > (_ly + 2000)) then {
					_bombMode = 1;
				};
				if (_px > 27500) then {
					_bombMode = 0;
				};
				if (_bombMode == 1) then {
					_nades = 3;
					_obj setDamage 1;
					while {_nades > 0} do {
						_rx = -15 + floor(random 30);
						_ry = -15 + floor(random 30);
						_ax = _px + _rx;
						_ay = _py + _ry;
						_bomb = "Grenade" createVehicle [_ax, _ay, 60];
						_nades = _nades - 1;
						sleep .05;
					};
				};
			};
			_co = _co + 1;
		} forEach _allUnits;
		sleep 0.5;
	};
};
