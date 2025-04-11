#include <amxmodx>
#include <amxmisc>
#include <LelaStocks>

#define PLUGIN "Ultimate | Vips Online"
#define VERSION "1.0"
#define AUTHOR "4D0CtOR4  DT"

#define VIP_FLAGS ADMIN_LEVEL_H

new const szContact[] = { "Dt4Real" }

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_clcmd("say", "handle_say")
}

public handle_say(id){
	new said[192];
	read_args(said, 191)
	if( (containi(said, "/vips") != -1) )
		print_vipnames(id);
}

print_vipnames(id){
	new vipnames[33][32], message[256], len, conmessage[256], len2, x, count, pl[32], pnum;
	get_players(pl, pnum)
	for(new i=0; i<pnum; i++){
		if((get_user_flags(pl[i]) && ADMIN_LEVEL_H) && !(is_user_bot(pl[i])))
			get_user_name(pl[i], vipnames[count++], 31)
	}
	
	len = format(message, 255, "!gVips Online Now Are : ")
	len2 = format(conmessage, 255, "------------------Vips Online------------------^n")
	if(count > 0){
		for(x = 0; x<count; x++){
			len += format(message[len], 255-len, "%s%s", vipnames[x], x < (count-1) ? ", ":"")
			len2 += format(conmessage[len2], 255-len2, "%s%s", vipnames[x], x < (count-1) ? "^n":"^n------------------Vips Online------------------^n")
			if(len > 96){
				LelaFunc_Print(id, message)
				client_print(id, print_console, conmessage)
				len = format(message, 255, "")
				len2 = format(conmessage, 255, "")
			}
		}
		LelaFunc_Print(id, message)
		client_print(id, print_console, conmessage)
	} else{
		len += format(message[len], 255-len, "!gThere Is No One Vip In Server Now")
		LelaFunc_Print(id, message)
	}
	LelaFunc_Print(id, "!gTo Buy Vip Contact : %s", szContact)
}
