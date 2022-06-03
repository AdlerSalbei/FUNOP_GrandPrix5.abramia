["Initialize"] call BIS_fnc_dynamicGroups;

missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroups", [GRAD_grandPrix_team_Einstein, GRAD_grandPrix_team_Hawking, GRAD_grandPrix_team_Newton, GRAD_grandPrix_team_Curie, GRAD_grandPrix_team_Lovelace], true];
missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroupNames", ["Team Einstein", "Team Hawking", "Team Newton", "Team Curie", "Team Lovelace"], true];