#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <engine>
#include <fun>
#include <hamsandwich>
#include <fakemeta>
#include <LelaStocks>

#define PLUGIN "Ultimate | Vip Menu"
#define VERSION "L.V"
#define AUTHOR "4D0CtOR4  DT"

new const MENU_TAG[] = { "!t[ !gVipMenu !t]" }
new iRoundElapsed, VmenuUsed[33], VmenuToggle;
public plugin_init(){
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_Spawn, "player", "OnSpawn", 1)
	register_event("HLTV", "new_round", "a", "1=0", "2=0")
	register_logevent("LogEvent_RestartGame", 2, "1=Game_Commencing", "1&Restart_Round_");
	register_clcmd("say ", "handle_say")
	
	register_dictionary("UltimateVipLang.txt")
	VmenuToggle = register_cvar("amx_togglevmenu", "1")
}

public handle_say(id){
	new arg[190]
	read_args(arg, charsmax(arg))
	if( (containi(arg, "/vipmenu") != -1)  || (containi(arg, "/vmenu") != -1) )
		set_task(0.1, "CheckVM", id)
	return PLUGIN_CONTINUE;
}

public new_round(id){
	iRoundElapsed += 1
}

public LogEvent_RestartGame(id){
	iRoundElapsed = 0

}

public OnSpawn(id){
	VmenuUsed[id] = false;
	set_task(0.1, "CheckVM", id)
}

public CheckVM(id){
	if( (iRoundElapsed < 1) || (iRoundElapsed == 1) || (get_pcvar_num(VmenuToggle) == 0) )
		return PLUGIN_HANDLED;
	else if( VmenuUsed[id] ){
		LelaFunc_Print(id, "%L", id, "VIPMENU_MAXUSES", MENU_TAG);
		return PLUGIN_HANDLED;
	}
	else if( !(get_user_flags(id) && ADMIN_LEVEL_H) ){
		LelaFunc_Print(id, "%L", id, "VIPMENU_NOACCESS", MENU_TAG);
		return PLUGIN_HANDLED;
	}
	if(cs_get_user_team(id) == CS_TEAM_CT){
	set_task(0.1, "VipMenu_CT", id)
	}
	else if(cs_get_user_team(id) == CS_TEAM_T){
	set_task(0.1, "VipMenu_TE", id)
	}
	return PLUGIN_CONTINUE;
}

public VipMenu_CT(id){
	new iLen[192];
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_TITLE")
	new menu = menu_create(iLen, "vmenute_handler")
	
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_AK47")
	menu_additem(menu, iLen, "0", ADMIN_LEVEL_H)
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_M4A1")
	menu_additem(menu, iLen, "1", ADMIN_LEVEL_H)
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_AWP")
	menu_additem(menu, iLen, "2", ADMIN_LEVEL_H)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	menu_display(id, menu, 0)
}

public vmenuct_handler(id, menu, item){
	if(item == MENU_EXIT){
	menu_destroy(menu)
	return PLUGIN_HANDLED;
	}
	new Data[6], Name[33];
	new paccess, callback;
	menu_item_getinfo(menu, item, paccess, Data, charsmax(Data), Name, charsmax(Name), callback)
	new iKey = str_to_num(Data)
	switch(iKey){
		case 0:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_ak47")
			cs_set_user_bpammo(id, CSW_AK47, 90)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			give_item(id, "item_thighpack")
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDAKCT", MENU_TAG);
			VmenuUsed[id] = true;
		}
		case 1:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_m4a1")
			cs_set_user_bpammo(id, CSW_M4A1, 90)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			give_item(id, "item_thighpack")
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDM4CT", MENU_TAG);
			VmenuUsed[id] = true;
		}
		case 2:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_awp")
			cs_set_user_bpammo(id, CSW_AWP, 30)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			give_item(id, "item_thighpack")
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDAWPCT", MENU_TAG);
			VmenuUsed[id] = true;
		}
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED;
}

public VipMenu_TE(id){
	new iLen[192];
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_TITLE")
	new menu = menu_create(iLen, "vmenute_handler")
	
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_AK47")
	menu_additem(menu, iLen, "0", ADMIN_LEVEL_H)
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_M4A1")
	menu_additem(menu, iLen, "1", ADMIN_LEVEL_H)
	format(iLen, charsmax(iLen), "%L", id, "VIPMENU_AWP")
	menu_additem(menu, iLen, "2", ADMIN_LEVEL_H)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	menu_display(id, menu, 0)
}

public vmenute_handler(id, menu, item){
	if(item == MENU_EXIT){
	menu_destroy(menu)
	return PLUGIN_HANDLED;
	}
	new Data[6], Name[33];
	new paccess, callback;
	menu_item_getinfo(menu, item, paccess, Data, charsmax(Data), Name, charsmax(Name), callback)
	new iKey = str_to_num(Data)
	switch(iKey){
		case 0:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_ak47")
			cs_set_user_bpammo(id, CSW_AK47, 90)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			give_item(id, "item_thighpack")
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDAKTE", MENU_TAG);
			VmenuUsed[id] = true;
		}
		case 1:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_m4a1")
			cs_set_user_bpammo(id, CSW_M4A1, 90)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDM4TE", MENU_TAG);
			VmenuUsed[id] = true;
		}
		case 2:{
			LelaFunc_Drop(id, 0)
			give_item(id, "weapon_awp")
			cs_set_user_bpammo(id, CSW_AWP, 30)
			give_item(id, "weapon_deagle")
			cs_set_user_bpammo(id, CSW_DEAGLE, 35)
			LelaFunc_Print(id, "%L", id, "VIPMENU_CHOOSEDAWPTE", MENU_TAG);
			VmenuUsed[id] = true;
		}
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED;
}
