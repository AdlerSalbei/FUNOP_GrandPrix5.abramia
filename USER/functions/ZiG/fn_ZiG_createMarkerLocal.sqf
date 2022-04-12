private _marker = createMarkerLocal ["GRAD_grandPrix_ZiG_moneyMarker", GRAD_grandPrix_ZiG_moneyArea];
private _triggerArea = triggerArea GRAD_grandPrix_ZiG_moneyArea;
_marker setMarkerSizeLocal [_triggerArea # 0, _triggerArea # 1];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerBrushLocal "DiagGrid";
_marker setMarkerAlphaLocal 1;
_marker setMarkerDirLocal (_triggerArea # 2);

player setVariable ["GRAD_grandPrix_ZiG_moneyMarker", _marker];