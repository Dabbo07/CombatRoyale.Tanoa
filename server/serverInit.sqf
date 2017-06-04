// Global Server Variables
    zones = [];
	zoneStatus = [];
	killScores = [];
	killObjects = [];
	killNames = [];
	markedForDeath = [ "", "", "", "", "" ];
	plrs = [plr01, plr02, plr03, plr04, plr05, plr06, plr07, plr08, plr09, plr10, plr11, plr12, plr13, plr14, plr15, plr16, plr17, plr18, plr19, plr20, plr21, plr22, plr23, plr24, plr25, plr26, plr27, plr28, plr29, plr30, plr31, plr32, plr33, plr34, plr35, plr36, plr37, plr38, plr39, plr40];
	cars = [car01,car02,car03,car04,car05,car06,car07,car08,car09,car10,car11,car12,car13,car14,car15,car16,car17,car18,car19,car20];
	aiUnits = [ 
		ai00, ai01, ai02, ai03, ai04, ai05, ai06, ai07, ai08, ai09, 
		ai10, ai11, ai12, ai13, ai14, ai15, ai16, ai17, ai18, ai19,
		ai20, ai21, ai22, ai23, ai24, ai25, ai26, ai27, ai28, ai29,
		ai30, ai31, ai32, ai33, ai34, ai35, ai36, ai37, ai38, ai39,
		ai40, ai41, ai42, ai43, ai44, ai45, ai46, ai47, ai48, ai49
	];
	//aiMarks = [ "aim00", "aim01", "aim02", "aim03", "aim04", "aim05", "aim06", "aim07", "aim08", "aim09", "aim10", "aim11", "aim12", "aim13", "aim14", "aim15", "aim16", "aim17", "aim18", "aim19" ];
	//aiLife = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];

// Move Perimeter Zone
	"Perimeter" setMarkerPos (getMarkerPos format["game0%1", (GAMEMODEZ + 1)]);

// Zone setup
	_lx = (getMarkerPos "Perimeter" select 0);
	_ly = (getMarkerPos "Perimeter" select 1);

	_zoneID = 0;
	_zx = 0;
	_zy = 0;
	while {_zoneID < 100} do {

		_pre = "";
		if (_zoneID < 10) then {
			_pre = "0";
		};
		_zoneLabel = format["zone%1%2", _pre, _zoneID];

		_lx = (getMarkerPos "Perimeter" select 0) + (_zx * 400) - 1800;
		_ly = (getMarkerPos "Perimeter" select 1) - (_zy * 400) + 1800;
		
		_safex1 = _lx - 125;
		_safey1 = _ly - 125;
		_safex2 = _lx + 125;
		_safey2 = _ly - 125;
		_safex3 = _lx - 125;
		_safey3 = _ly + 125;
		_safex4 = _lx + 125;
		_safey4 = _ly + 125;
		
		_landFound = 0;
		if (!surfaceIsWater [_safex1, _safey1]) then {
			_landFound = _landFound + 1;
		};
		if (!surfaceIsWater [_safex2, _safey2]) then {
			_landFound = _landFound + 1;
		};
		if (!surfaceIsWater [_safex3, _safey3]) then {
			_landFound = _landFound + 1;
		};
		if (!surfaceIsWater [_safex4, _safey4]) then {
			_landFound = _landFound + 1;
		};
		if (!surfaceIsWater [_lx, _ly]) then {
			_landFound = _landFound + 1;
		};
		if (_landFound < 2) then {
			_zoneLabel setMarkerColor "ColorRed";
			zoneStatus = zoneStatus + [ 100 ];	// was 15
		} else {
			_zoneLabel setMarkerColor "ColorGreen";
			zoneStatus = zoneStatus + [ ZONECREEP ];
		};
	
		zones = zones + [ _zoneLabel ];
		_zoneLabel setMarkerPos [_lx, _ly];
		format["%1txt", _zoneLabel] setMarkerPos [_lx - 25, _ly];
		_zx = _zx + 1;
		if (_zx > 9) then {
			_zx = 0;
			_zy = _zy + 1;
		};
		_zoneID = _zoneID + 1;
	};

	// Shrink zone according to ZONELIMIT host parameter
	if (ZONELIMIT < 2) then {
		_sel = 0;
		while {_sel < (count zones)} do {
			_killZone = 0;
			if (_sel <= 21) then {
				_killZone = 1;
			};
			if (_sel >= 78) then {
				_killZone = 1;
			};
			if (_sel >= 28 && _sel <= 31) then {
				_killZone = 1;
			};
			if (_sel >= 38 && _sel <= 41) then {
				_killZone = 1;
			};
			if (_sel >= 48 && _sel <= 51) then {
				_killZone = 1;
			};
			if (_sel >= 58 && _sel <= 61) then {
				_killZone = 1;
			};
			if (_sel >= 68 && _sel <= 71) then {
				_killZone = 1;
			};
			if (_killZone == 1) then {
				zoneStatus set [_sel, 100];
				(zones select _sel) setMarkerColor "ColorRed";
			};
			_sel = _sel + 1;
		};
	};
	
	if (ZONELIMIT < 1) then {
		_sel = 0;
		while {_sel < (count zones)} do {
			_killZone = 0;
			if (_sel <= 32) then {
				_killZone = 1;
			};
			if (_sel >= 67) then {
				_killZone = 1;
			};
			if (_sel >= 37 && _sel <= 42) then {
				_killZone = 1;
			};
			if (_sel >= 47 && _sel <= 52) then {
				_killZone = 1;
			};
			if (_sel >= 57 && _sel <= 62) then {
				_killZone = 1;
			};
			if (_killZone == 1) then {
				zoneStatus set [_sel, 100];
				(zones select _sel) setMarkerColor "ColorRed";
			};
			_sel = _sel + 1;
		};
	};

	// Random SAFEZONE
	_safeZoneSet = 0;
	while {_safeZoneSet == 0} do {
		SAFEZONE = floor(random (count zones));
		
		_pre = "";
		if (SAFEZONE < 10) then {
			_pre = "0";
		};
		_zoneLabel = format["zone%1%2", _pre, SAFEZONE];
		
		if ((zoneStatus select SAFEZONE) != 100) then {
			zoneStatus set [SAFEZONE, 0];
			_zoneLabel setMarkerColor "ColorBlue";
			_safeZoneSet = 1;
		};
	};

	// Set crate search area size
	"crate01m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate02m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate03m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate04m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate05m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate06m" setMarkerSize [CRATESIZE, CRATESIZE];

// Special Processes
	specialCrateSmoke = {
		while {true} do {
			if (floor(random 5) > 3) then {
				_smoke = "SmokeshellRed" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
			} else {
				if (floor(random 5) > 3) then {
					_smoke = "SmokeshellBlue" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
				} else {
					if (floor(random 5) > 3) then {
						_smoke = "SmokeshellGreen" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
					} else {
						_smoke = "SmokeshellYellow" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
					};
				};
			};
			sleep 110;
		};
	};

// Publish variables out to clients
	publicVariable "SAFEZONE";
	publicVariable "cars";
	publicVariable "zones";
	publicVariable "zoneStatus";

// Main processing
	if (ALLOWCARS > 0) then {
		// Move cars to marker positions
		{
			_cx = 0;
			_cy = 0;
			_randSel = 10;
			while {_randSel > 0} do {
				_randZoneSel = 5;
				_zr = SAFEZONE;
				while {_randZoneSel > 0} do {
					_zr = floor(random(count zones));
					if ((zoneStatus select _zr) == 100) then {
						_zr = SAFEZONE;
						_randZoneSel = _randZoneSel - 1;
					} else {
						_randZoneSel = 0;
					};
				};

				_zone = zones select _zr;
				_px = getMarkerPos _zone select 0;
				_py = getMarkerPos _zone select 1;

				_rx = -200 + floor(random 401);
				_ry = -200 + floor(random 401);
				_cx = _px + _rx;
				_cy = _py + _ry;
				
				if (surfaceIsWater [_cx, _cy]) then {
					_randSel = _randSel - 1;
				} else {
					_randSel = 0;
				};
			};
			_x setMarkerPos [_cx, _cy, 0];
		} foreach carMarks;
		_co = 0;
		{
			if (_co > ALLOWCARS) then {
				 _x setMarkerPos getPos (cars select _co);
			} else {
				_mx = getMarkerPos _x select 0;
				_my = getMarkerPos _x select 1;
				(cars select _co) setPos [_mx, _my, 0];
			};
			_co =_co + 1;
		} foreach carMarks;
		execVM "server\carTracker.sqf"; 
	};
	
	"playerScoreFetch" addPublicVariableEventHandler {
		_pcid = owner (_this select 1 select 0);
        _unit = _this select 1 select 0;
		_score = _this select 1 select 1;
		_co = 0;
		_killer = name _unit;
		{
			if (_x == _killer) then {
				_score = (killScores select _co);
			};
		} foreach killNames;
		playerScoreReturn = _score;
		_pcid publicVariableClient "playerScoreReturn";
	};
	
	"killerScored" addPublicVariableEventHandler {
		_killerObj = (_this select 1);
		_killer = name _killerObj;
		if (!(isPlayer _killerObj)) then {
			_killer = format["{AI} %1", _killer];
		};
		_co = 0;
		_found = false;
		{
			if (_x == _killer) then {
				_found = true;
				_score = (killScores select _co) + 1;
				killScores set [_co, _score];
				killObjects set [_co, name _killerObj];
			};
			_co = _co + 1;
		} foreach killNames;
		if (!_found) then {
			killObjects set [count killNames, name _killerObj];
			killNames set [count killNames, _killer];
			killScores set [count killScores, 1];
		};
		
		Score1 = "1st : ---------- 0 Kills";
		Score2 = "2nd : ---------- 0 Kills";
		Score3 = "3rd : ---------- 0 Kills";
		Score4 = "4th : ---------- 0 Kills";
		Score5 = "5th : ---------- 0 Kills";
		
		_co = 0;
		_max = -1;
		_tmpScores = [] + killScores;
		while {_co < 5} do {
			_sel = -1;
			_lp = 0;
			_top = 0;
			{
				if (_x > _top) then {
					if (_co == 0 || _max == -1 || _x <= _max) then {
						_sel = _lp;
					};
					_top = _x;
				};
				_lp = _lp + 1;
			} foreach _tmpScores;
			_info = "---------- 0 Kills";
			if (_sel > -1) then {
				_info = format["%1 - %2 Kills", killNames select _sel, killScores select _sel];
				_max = _tmpScores select _sel;
				_tmpScores set [_sel, -1];
				markedForDeath set [ _co, killObjects select _sel];
			};
			if (_co == 0) then {
				Score1 = format["1st : %1", _info];
			};
			if (_co == 1) then {
				Score2 = format["2nd : %1", _info];
			};
			if (_co == 2) then {
				Score3 = format["3rd : %1", _info];
			};
			if (_co == 3) then {
				Score4 = format["4th : %1", _info];
			};
			if (_co == 4) then {
				Score5 = format["5th : %1", _info];
			};
			_co = _co + 1;
		};
		publicVariable "Score1";
		publicVariable "Score2";
		publicVariable "Score3";
		publicVariable "Score4";
		publicVariable "Score5";
	};
	
	specCrate spawn specialCrateSmoke;
	execVM "server\crateControl.sqf"; 
	execVM "server\playerTracker.sqf"; 
	execVM "server\zoneControl.sqf"; 
	execVM "server\zoneBomber.sqf"; 
	if (AIENABLE > 0) then {
		execVM "server\aiPlayer.sqf";
	};
	if (ZONEBOMB == 1) then {
		execVM "server\bombDropper.sqf";
	};
	ServerReady = 1;
	publicVariable "ServerReady";

