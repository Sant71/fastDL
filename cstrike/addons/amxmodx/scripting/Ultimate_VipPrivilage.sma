#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <fun>
#include <cstrike>
#include <LelaStocks>

#define PLUGIN "Ultimate | Vip Privilage"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"

new gp_iVipHealth, gp_iVipArmor, gp_ServerName, gp_iToggle;
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_Spawn, "player", "OnSpawn", 1)
	gp_iToggle = register_cvar("amx_toggleprivilage", "1")
	gp_iVipHealth = register_cvar("amx_viphealth", "150")
	gp_iVipArmor = register_cvar("amx_viparmor", "100")
	gp_ServerName = register_cvar("amx_prefix", "ServerName")
	register_dictionary("UltimateVipLang.txt")
}

public OnSpawn(id){
	if(!(get_user_flags(id) && ADMIN_LEVEL_H) || is_user_bot(id) || (get_pcvar_num(gp_iToggle) == 0))
		return PLUGIN_HANDLED;
	new iHealth = get_pcvar_num(gp_iVipHealth);
	new iArmor = get_pcvar_num(gp_iVipArmor);
	new szServerName[64];
	get_pcvar_string(gp_ServerName, szServerName, 63)
	set_user_health(id, iHealth)
	set_user_armor(id, iArmor)
	give_item(id, "weapon_hegrenade")
	give_item(id, "weapon_flashbang")
	give_item(id, "weapon_flashbang")
	give_item(id, "weapon_smokegrenade")
	LelaFunc_Print(id, "%L", id, "VIPPRIVILAGE_GOTWHAT", szServerName, iHealth, iArmor)
	return PLUGIN_CONTINUE;
}
