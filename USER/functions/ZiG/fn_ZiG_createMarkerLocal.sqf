if !(hasInterface) exitWith {};

private _markerArea = createMarkerLocal ["GRAD_grandPrix_ZiG_moneyMarker", GRAD_grandPrix_ZiG_moneyArea];
private _triggerArea = triggerArea GRAD_grandPrix_ZiG_moneyArea;
_markerArea setMarkerSizeLocal [_triggerArea # 0, _triggerArea # 1];
_markerArea setMarkerShapeLocal "RECTANGLE";
_markerArea setMarkerColorLocal "ColorGreen";
_markerArea setMarkerBrushLocal "DiagGrid";
_markerArea setMarkerAlphaLocal 1;
_markerArea setMarkerDirLocal (_triggerArea # 2);

private _markerObjective = createMarkerLocal ["GRAD_grandPrix_ZiG_endMarke", [224.791,8544.16,0]];
_markerObjective setMarkerTypeLocal "hd_objective";
_markerObjective setMarkerColorLocal "ColorGreen";
_markerObjective setMarkerAlphaLocal 1;
_markerObjective setMarkerTextLocal "Abgabe";

player setVariable ["GRAD_grandPrix_ZiG_moneyMarkers", [_markerArea, _markerObjective], false];