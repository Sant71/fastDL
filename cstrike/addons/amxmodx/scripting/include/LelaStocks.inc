#if defined _LelaStocks_included
	#endinput
#endif
#define _LelaStocks_included

#if !defined _amxmodx_included
	#include <amxmodx>
#endif

#if !defined _hamsandwich_included
	#include <hamsandwich>
#endif

#if !defined _fakemeta_included
	#include <fakemeta>
#endif

/* -> Some Offsets -> */
#define linux_diff_weapon 4
#define linux_diff_animating 4
#define linux_diff_player 5
#define ACT_RANGE_ATTACK1 28
#define m_flFrameRate 36
#define m_flGroundSpeed 37
#define m_flLastEventCheck 38
#define m_fSequenceFinished 39
#define m_fSequenceLoops 40
#define m_pPlayer 41
#define m_flNextSecondaryAttack 47
#define m_iClip 51
#define m_Activity 73
#define m_IdealActivity 74
#define m_LastHitGroup 75
#define m_flNextAttack 83
#define m_bloodColor 89
#define m_iPlayerTeam 114
#define m_fHasPrimary 116
#define m_bHasChangeTeamThisRound 125
#define m_flLastAttackTime 220
#define m_afButtonPressed 246
#define m_iHideHUD 361
#define m_iClientHideHUD 362
#define m_iSpawnCount 365
#define m_pActiveItem 373
#define m_flNextDecalTime 486
#define g_szModelIndexPlayer 491

/**
 * Sends a colored chat message.
 *
 * @param id        Client index (use 0 to send to all players)
 * @param message     The message to send
 * @param any:...       Variable number of formatting parameters
 *
 * @return          Length of the printed message
 */
stock LelaFunc_Print(const id, const message[], any:...){
	new pl[32], pnum = 1;
	static msg[191];
	vformat(msg, 190, message, 3)
	replace_all(msg, 190, "!n", "^x01")
	replace_all(msg, 190, "!t", "^x03")
	replace_all(msg, 190, "!g", "^x04")
	if(id) pl[0] = id; else get_players(pl, pnum, "ch");
	{
		for(new i = 0; i < pnum; i++){
			if(is_user_connected(pl[i])){
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, pl[i])
				write_byte(pl[i])
				write_string(msg)
				message_end();
			}
		}
	} 
	return strlen(msg);
}

/**
 * Drop User Weapon.
 *
 * @param id        Client index (use 0 for all players)
 * @param type      Drop Type See Types Above
 * @param weapon    Weapon Name You Have To Write 3 in type
 *
 * @return          Nothing
 */
 /*
 Types:
 Type 1 = Drop Pistols
 Type 2 = Drop Rifles 
 Type 3 = Drop weapon type weapon name in weapon[]
 Type 0 = Drop All Weapons
 */
stock LelaFunc_Drop(const id, type=0, const weapon[]=""){
	new pl[32], pnum = 1;
	if(id) pl[0] = id; else get_players(pl, pnum, "h");
	{
		for(new i = 0; i < pnum; i++){
			if(is_user_connected(pl[i])){
				switch(type){
					case 1: {
						engclient_cmd(pl[i], "drop", "weapon_usp")
						engclient_cmd(pl[i], "drop", "weapon_glock18")
						engclient_cmd(pl[i], "drop", "weapon_p228")
						engclient_cmd(pl[i], "drop", "weapon_fiveseven")
						engclient_cmd(pl[i], "drop", "weapon_deagle")
						engclient_cmd(pl[i], "drop", "weapon_elite")
					}
					case 2: {
						engclient_cmd(pl[i], "drop", "weapon_scout")
						engclient_cmd(pl[i], "drop", "weapon_xm1014")
						engclient_cmd(pl[i], "drop", "weapon_mac10")
						engclient_cmd(pl[i], "drop", "weapon_aug")
						engclient_cmd(pl[i], "drop", "weapon_ump45")
						engclient_cmd(pl[i], "drop", "weapon_sg550")
						engclient_cmd(pl[i], "drop", "weapon_galil")
						engclient_cmd(pl[i], "drop", "weapon_famas")
						engclient_cmd(pl[i], "drop", "weapon_awp")
						engclient_cmd(pl[i], "drop", "weapon_mp5navy")
						engclient_cmd(pl[i], "drop", "weapon_m249")
						engclient_cmd(pl[i], "drop", "weapon_m3")
						engclient_cmd(pl[i], "drop", "weapon_m4a1")
						engclient_cmd(pl[i], "drop", "weapon_tmp")
						engclient_cmd(pl[i], "drop", "weapon_g3sg1")
						engclient_cmd(pl[i], "drop", "weapon_sg552")
						engclient_cmd(pl[i], "drop", "weapon_ak47")
						engclient_cmd(pl[i], "drop", "weapon_p90")
					}
					case 3: {
						engclient_cmd(pl[i], "drop", weapon)
					}
					default: {
						engclient_cmd(pl[i], "drop", "weapon_usp")
						engclient_cmd(pl[i], "drop", "weapon_glock18")
						engclient_cmd(pl[i], "drop", "weapon_p228")
						engclient_cmd(pl[i], "drop", "weapon_fiveseven")
						engclient_cmd(pl[i], "drop", "weapon_deagle")
						engclient_cmd(pl[i], "drop", "weapon_elite")
						engclient_cmd(pl[i], "drop", "weapon_scout")
						engclient_cmd(pl[i], "drop", "weapon_xm1014")
						engclient_cmd(pl[i], "drop", "weapon_mac10")
						engclient_cmd(pl[i], "drop", "weapon_aug")
						engclient_cmd(pl[i], "drop", "weapon_ump45")
						engclient_cmd(pl[i], "drop", "weapon_sg550")
						engclient_cmd(pl[i], "drop", "weapon_galil")
						engclient_cmd(pl[i], "drop", "weapon_famas")
						engclient_cmd(pl[i], "drop", "weapon_awp")
						engclient_cmd(pl[i], "drop", "weapon_mp5navy")
						engclient_cmd(pl[i], "drop", "weapon_m249")
						engclient_cmd(pl[i], "drop", "weapon_m3")
						engclient_cmd(pl[i], "drop", "weapon_m4a1")
						engclient_cmd(pl[i], "drop", "weapon_tmp")
						engclient_cmd(pl[i], "drop", "weapon_g3sg1")
						engclient_cmd(pl[i], "drop", "weapon_sg552")
						engclient_cmd(pl[i], "drop", "weapon_ak47")
						engclient_cmd(pl[i], "drop", "weapon_p90")
					}
				}
			}
		}
	}
}

/**
 * Strip User Weapon.
 *
 * @param id        Client index
 * @param szWeaponName[]      Weapon Name To Strip
 *
 * @return          Nothing
 */
stock LelaFunc_StripWeapon(const id, const szWeaponName[]){
	new pl[32], pnum = 1;
	if(id) pl[0] = id; else get_players(pl, pnum, "h");
	{
		for(new i = 0; i < pnum; i++){
			if(is_user_connected(pl[i])){
				new iEntity;
				while((iEntity = engfunc(EngFunc_FindEntityByString, iEntity, "classname", szWeaponName)) && pev(iEntity, pev_owner) != id) {}
				if(!iEntity) return 0;
				new iWeaponId = get_weaponid(szWeaponName);
				if(get_user_weapon(id) == iWeaponId) ExecuteHamB(Ham_Weapon_RetireWeapon, iEntity);
				if(!ExecuteHamB(Ham_RemovePlayerItem, id, iEntity)) return 0;
				ExecuteHamB(Ham_Item_Kill, iEntity);
				set_pev(id, pev_weapons, pev(id, pev_weapons) & ~(1<<iWeaponId));
			}
		}
	}
	return 1;
}

/**
 * Play Weapon Animation.
 *
 * @param id        Client index
 * @param iAnimation      Animation To Play
 *
 * @return          Nothing
 */
stock LelaFunc_WeaponAnimation(id, iAnimation)
{
	set_pev(id, pev_weaponanim, iAnimation);
	engfunc(EngFunc_MessageBegin, MSG_ONE_UNRELIABLE, SVC_WEAPONANIM, {0.0, 0.0, 0.0}, id);
	write_byte(iAnimation);
	write_byte(0);
	message_end();
}

/**
 * Play Player Animation.
 *
 * @param id        Client index
 * @param szAnimation      Animation Name To Play
 *
 * @return          Nothing
 */
stock LelaFunc_PlayerAnimation(id, const szAnimation[])
{
	new iAnimDesired, Float:flFrameRate, Float:flGroundSpeed, bool:bLoops;
	if((iAnimDesired = lookup_sequence(id, szAnimation, flFrameRate, bLoops, flGroundSpeed)) == -1) iAnimDesired = 0;
	new Float:flGametime = get_gametime();
	set_pev(id, pev_frame, 0.0);
	set_pev(id, pev_framerate, 1.0);
	set_pev(id, pev_animtime, flGametime);
	set_pev(id, pev_sequence, iAnimDesired);
	set_pdata_int(id, m_fSequenceLoops, bLoops, linux_diff_animating);
	set_pdata_int(id, m_fSequenceFinished, 0, linux_diff_animating);
	set_pdata_float(id, m_flFrameRate, flFrameRate, linux_diff_animating);
	set_pdata_float(id, m_flGroundSpeed, flGroundSpeed, linux_diff_animating);
	set_pdata_float(id, m_flLastEventCheck, flGametime, linux_diff_animating);
	set_pdata_int(id, m_Activity, ACT_RANGE_ATTACK1, linux_diff_player);
	set_pdata_int(id, m_IdealActivity, ACT_RANGE_ATTACK1, linux_diff_player);   
	set_pdata_float(id, m_flLastAttackTime, flGametime, linux_diff_player);
}

/**
 * Play Player Animation.
 *
 * @param id        Client index (use 0 to send to all players)
 * @param iPitch      Changes Pitch Of Sound
 * @param Sample        Sound Path To Play
 * @param any:...      Variable number of formatting parameters
 *
 * @return          Nothing
 */
stock LelaFunc_EmitSound(id, iPitch = 100, const Sample[], any:...)
{
	new szBuffer[128];
	if(numargs() > 3) vformat(szBuffer, charsmax(szBuffer), Sample, 4);
	else copy(szBuffer, charsmax(szBuffer), Sample);
	switch(id)
	{
		case 0:
		{
			message_begin(MSG_BROADCAST, get_user_msgid("SendAudio"));
			write_byte(id);
			write_string(szBuffer);
			write_short(iPitch);
			message_end();
		}
		default:
		{
			engfunc(EngFunc_MessageBegin, MSG_ONE_UNRELIABLE, get_user_msgid("SendAudio"), {0.0, 0.0, 0.0}, id);
			write_byte(id);
			write_string(szBuffer);
			write_short(iPitch);
			message_end();
		}
	}
}