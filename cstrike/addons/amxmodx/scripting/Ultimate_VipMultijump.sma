#include <amxmodx>
#include <amxmisc>
#include <engine>

#define PLUGIN "Ultimate | Vip Multijump"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"
#define VIP_FLAGS ADMIN_LEVEL_H

new cvMaxJumps, cvToggle;
new bool:g_bCanJump[33], g_iJumps[33];
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	cvToggle = register_cvar("amx_togglemultijump", "1")
	cvMaxJumps = register_cvar("amx_maxjumps", "1")
}

public client_putinserver(id){
	g_iJumps[id] = 0;
	g_bCanJump[id] = false;
}

public client_disconnect(id){
	g_iJumps[id] = 0;
	g_bCanJump[id] = false;
}

public client_PreThink(id){
	if( !(get_user_flags(id) && VIP_FLAGS) || (get_pcvar_num(cvToggle) == 0) )
		return PLUGIN_HANDLED;
	new v_pNewButton = get_user_button(id), v_pOldButton = get_user_oldbutton(id)
	if( (v_pNewButton & IN_JUMP) && !(v_pOldButton & IN_JUMP) && !(get_entity_flags(id) & FL_ONGROUND) ){
		if(g_iJumps[id] < get_pcvar_num(cvMaxJumps)){
			g_iJumps[id]++
			g_bCanJump[id] = true;
		}
	}
	else if( (v_pNewButton & IN_JUMP) && (get_entity_flags(id) & FL_ONGROUND) ){
		g_iJumps[id] = 0;
	}
	return PLUGIN_CONTINUE;
}

public client_PostThink(id){
	if( !(get_user_flags(id) && VIP_FLAGS) || (get_pcvar_num(cvToggle) == 0) )
		return PLUGIN_HANDLED;
	if(g_bCanJump[id] == true){
		new Float:vector[3];
		entity_get_vector(id, EV_VEC_velocity, vector);
		vector[2] = random_float(265.0, 285.0);
		entity_set_vector(id, EV_VEC_velocity, vector);
		g_bCanJump[id] = false;
	}
	return PLUGIN_CONTINUE;
}
