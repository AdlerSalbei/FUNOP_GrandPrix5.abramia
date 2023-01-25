[{
    params ["_pos"];

    {
        deleteVehicle _x;
    } forEach (nearestObjects [_pos,["WeaponHolder","WeaponHolder_Single_F","WeaponHolderSimulated","WeaponHolderSimulated_Scripted","GroundWeaponHolder","GroundWeaponHolder_Scripted"],20]);

},_this,5] call CBA_fnc_waitAndExecute;
