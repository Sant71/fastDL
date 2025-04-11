#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <cstrike>

#define PLUGIN "Ultimate | Vip Skin"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"
#define VIP_FLAGS ADMIN_LEVEL_H

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_Spawn, "player", "OnSpawn", 1)
}

public plugin_precache(){
	precache_model("models/player/UltimateVipSkin_Te/UltimateVipSkin_Te.mdl")
	precache_model("models/player/UltimateVipSkin_Ct/UltimateVipSkin_Ct.mdl")
}

public OnSpawn(id){
	set_task(0.1, "VipSkin", id)
}

public VipSkin(id){
	if(!(get_user_flags(id) && VIP_FLAGS) || is_user_bot(id)){
		return PLUGIN_HANDLED;
	}
	switch(cs_get_user_team(id)){
	case CS_TEAM_CT: {
		cs_set_user_model(id, "UltimateVipSkin_Ct")
	}
	case CS_TEAM_T: {
		cs_set_user_model(id, "UltimateVipSkin_Te")
	}
	default: {
		cs_reset_user_model(id)
	}
	}
	return PLUGIN_CONTINUE;
}
