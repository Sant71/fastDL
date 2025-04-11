#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <LelaStocks>
#include <csx>

#define PLUGIN "Ulitmate | Vip Rewards"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"

#define VIP_FLAGS ADMIN_LEVEL_H

new cvToggle, g_iReward;
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_event("DeathMsg", "OnDeath", "a")
	cvToggle = register_cvar("amx_viprewardstoggle", "1")
	register_dictionary("UltimateVipLang.txt")
}

public bomb_planted(id){
	g_iReward = 700;
	send_reward(id)
}

public bomb_defused(id){
	g_iReward = 700;
	send_reward(id)
	
}

public OnDeath(){
	new attacker = read_data(1), victim = read_data(2), headshot = read_data(3)
	if((get_pcvar_num(cvToggle) == 0) || !(get_user_flags(attacker) && VIP_FLAGS) || (attacker == victim))
		return PLUGIN_HANDLED;
	
	if(headshot || get_user_weapon(attacker) == CSW_KNIFE){
		g_iReward = 1500;
	}
	else{
		g_iReward = 700;
		
	}
	send_reward(attacker);
	return PLUGIN_CONTINUE;
}

send_reward(id){
	new iUserMoney;
	iUserMoney = cs_get_user_money(id);
	cs_set_user_money(id, iUserMoney + g_iReward)
	LelaFunc_Print(id, "%L", id, "VIPREWARDS_AMOUNTSENT", g_iReward)
}