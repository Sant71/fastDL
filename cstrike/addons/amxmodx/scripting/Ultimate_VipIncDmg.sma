#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <fakemeta>
#include <cstrike>

#define PLUGIN "Ultimate | Vip Increased Damage"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"
#define VIP_FLAGS ADMIN_LEVEL_H

new cvToggle, cvIncDmg
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_TakeDamage, "player", "Ham_TakeDamage_Player", false);
	cvToggle = register_cvar("vip_incdmgtoggle", "1")
	cvIncDmg = register_cvar("vip_dmgmultiplier", "20")
}

new Debug
public client_putinserver(id)
{
	if(Debug)return
	
	if(is_user_bot(id))
	{
		Debug = 1
		new classname[32]
		pev(id,pev_classname,classname,31)
		
		if(!equal(classname,"player"))set_task(4.0,"_Debug",id)
	}	
}

public _Debug(id)
{
	RegisterHamFromEntity(Ham_TakeDamage,id,"Ham_TakeDamage_Player")
	client_print(0,print_console,"bot debuged")
}

public Ham_TakeDamage_Player(iVictim, iInflictor, iAttacker, Float:fDamage, iBitDamage){
	if((cs_get_user_team(iVictim) == cs_get_user_team(iAttacker)) || !(get_user_flags(iAttacker) && VIP_FLAGS) || (get_pcvar_num(cvToggle) == 0) || (is_user_bot(iAttacker)))
		return HAM_HANDLED;
	SetHamParamFloat(4, fDamage+get_pcvar_num(cvIncDmg))
	return HAM_IGNORED;
}
