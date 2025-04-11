#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <cstrike>
#include <hamsandwich>
#include <LelaStocks>
#include <fun>
#include <engine>

#define PLUGIN "Ultimate | Vip Medic"
#define VERSION "L.V"
#define AUTHOR "4D0CtOR4  DT"

#define SYRINGE_ID 3892102

new MEDIC_HEALTH, g_iPrice, Limit;
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_clcmd("say ", "handle_say")
	
	MEDIC_HEALTH = register_cvar("amx_medichealth", "35")
	g_iPrice = register_cvar("amx_medicprice", "3500")
	Limit = register_cvar("amx_mediclimit","150")
	register_dictionary("UltimateVipLang.txt")
}

public handle_say(id) {
    new said[192]
    read_args(said,192)
    if( ( containi(said, "medic") != -1 && containi(said, "/medic") != -1 ) || contain(said, "/heal") != -1 )
        set_task(0.1,"MEDIC",id)
    return PLUGIN_CONTINUE
}

public plugin_precache(){
	precache_model("models/MEDIC/v_syringe.mdl")
}

public MEDIC(id){
	new price = get_pcvar_num(g_iPrice)
	new inchealth = get_pcvar_num(MEDIC_HEALTH)
	new limit2 = get_pcvar_num(Limit)
	if(!(get_user_flags(id) & ADMIN_LEVEL_H) || !(is_user_alive(id))) 
	{
		LelaFunc_Print(id, "%L", id, "VIPMEDIC_NOACCESS");
		return PLUGIN_HANDLED; 
	} 
    
	else if(get_user_health(id) >= (limit2-inchealth))
	{
		LelaFunc_Print(id, "%L", id, "VIPMEDIC_MAXHEALTH", limit2);
		
		return PLUGIN_HANDLED;
	}
    
	else if(cs_get_user_money(id) < price)
	{
		LelaFunc_Print(id, "%L", id, "VIPMEDIC_LOWMONEY");
		
		return PLUGIN_HANDLED;
	}
	new money = cs_get_user_money(id)
	cs_set_user_money(id, money-price)
	
	set_pev(id, pev_viewmodel2, "models/MEDIC/v_syringe.mdl");
	LelaFunc_WeaponAnimation(id, 1);
	set_pdata_float(id, m_flNextAttack, 3.0);
	
	set_task(2.8, "Remove_Animation", id+ SYRINGE_ID);
	
	new health = get_user_health(id)
	set_user_health(id, health + inchealth)
	
	LelaFunc_Print(id, "%L", id, "VIPMEDIC_GOTHEALTH", inchealth);
	return PLUGIN_CONTINUE;
}

public Remove_Animation(id)
{
	id -= SYRINGE_ID;
	new iActiveItem = get_pdata_cbase(id, m_pActiveItem);
	if(iActiveItem > 0) ExecuteHamB(Ham_Item_Deploy, iActiveItem);
}
