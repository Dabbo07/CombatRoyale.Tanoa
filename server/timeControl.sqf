timeBroadcast = 0;

if (isServer) then {

	publicVariable "timeBroadcast";
	sleep 15;
	while {true} do {
		sleep 120;
		timeBroadcast = 1;
		publicVariable "timeBroadcast";
	};

};