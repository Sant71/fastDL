#include <amxmodx>
#include <amxmisc>
#include <cstrike>

#define PLUGIN "Ultimate | Vip Tag ScoreBoard"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"

enum {
    SCOREATTRIB_ARG_PLAYERID = 1,
    SCOREATTRIB_ARG_FLAGS
};

enum ( <<= 1 ) {
    SCOREATTRIB_FLAG_NONE = 0,
    SCOREATTRIB_FLAG_DEAD = 1,
    SCOREATTRIB_FLAG_BOMB,
    SCOREATTRIB_FLAG_VIP
};

new cvToggle;
new ScoreInfo
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	cvToggle = register_cvar("vip_scoreboardtoggle", "1")
	ScoreInfo = get_user_msgid("ScoreAttrib")
	register_message(ScoreInfo, "VipTagScoreBoard")
}

public VipTagScoreBoard(iMsgId, iDest, iReceiver){
	if(get_pcvar_num(cvToggle) == 0)
		return PLUGIN_HANDLED;
	new id = get_msg_arg_int(1)
	if(get_user_flags(id) && ADMIN_LEVEL_H){
	set_msg_arg_int(0, ARG_BYTE, 3)
	}
	return PLUGIN_CONTINUE;
}
