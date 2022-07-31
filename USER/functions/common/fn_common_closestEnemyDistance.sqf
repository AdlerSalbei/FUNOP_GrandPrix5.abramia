params ["_pos", "_enemies"];

if (count _enemies <= 0) exitWith { 1e39 };

selectMin (_enemies apply {_pos distance _x})