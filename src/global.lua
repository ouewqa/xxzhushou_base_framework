-- global.lua
-- Author: cndy1860
-- Date: 2018-11-19
-- function: 全局变量相关操作


------PAGE LIST------
PAGE_NONE = "PAGE_NONE"		--未定义界面
PAGE_NOTICE = "PAGE_NOTICE"
PAGE_INIT = "PAGE_INIT"
PAGE_MAIN = "PAGE_MAIN"
PAGE_MAIN_MATCH = "PAGE_MAIN_MATCH"
PAGE_MAIN_CLUB = "PAGE_MAIN_CLUB"
PAGE_MAIN_CONCTRACT = "PAGE_MAIN_CONCTRACT"
PAGE_MAIN_EXTRAS = "PAGE_MAIN_EXTRAS"
PAGE_ONLINE_MATCH = "PAGE_ONLINE_MATCH"
PAGE_COACH_RANK = "PAGE_COACH_RANK"
PAGE_MATCHED = "PAGE_MATCHED"
PAGE_ROSTER = "PAGE_ROSTER"
PAGE_PLAYING = "PAGE_PLAYING"
PAGE_END_READY = "PAGE_END_READY"
PAGE_INTERVAL = "PAGE_INTERVAL"
PAGE_INTERVAL_READY = "PAGE_INTERVAL_READY"
PAGE_RANK_UP = "PAGE_RANK_UP"

PAGE_SUBSTITUTED = "PAGE_SUBSTITUTED"
PAGE_PLAYER_STATUS = "PAGE_PLAYER_STATUS"

PAGE_OFFLINE_FAIL = "PAGE_OFFLINE_FAIL"
PAGE_LEAGUE = "PAGE_LEAGUE"
PAGE_LEAGUE_SIM = "PAGE_LEAGUE_SIM"
PAGE_LEAGUE_MATCHED = "PAGE_LEAGUE_MATCHED"
PAGE_LEAGUE_POINTS = "PAGE_LEAGUE_POINTS"
PAGE_LEAGUE_RESULT = "PAGE_LEAGUE_RESULT"
PAGE_LEAGUE_SCOUT = "PAGE_LEAGUE_SCOUT"
--PAGE_PLAYER_EXPIRED = "PAGE_PLAYER_EXPIRED"
PAGE_LEAGUE_BREAKING = "PAGE_LEAGUE_BREAKING"
PAGE_ACHIEVEMENT = "PAGE_ACHIEVEMENT"

------ERR CODE------
ERR_MAIN = "ERR_MAIN"  		--主函数错误
ERR_NORMAL = "ERR_NORMAL"
ERR_FILE = "ERR_FILE"
ERR_PARAM = "ERR_PARAM"
ERR_TIMEOUT = "ERR_TIMEOUT"
ERR_WARNING = "ERR_WARNING"
ERR_UNKOWN = "ERR_UNKOWN"
ERR_TASK_ABORT = "ERR_TASK_ABORT"


------TASK------
TASK_NONE = "TASK_NONE"
TASK_TEST = "TASK_TEST"
TASK_BREAK_POINT = "TASK_BREAK_POINT"
TASK_SIM = "TASK_SIM"
TASK_LEAGUE_SIM = "TASK_LEAGUE_SIM"

------PROCESS------
PROCESS_NONE = "PROCESS_NONE"


------STATUS------
CURRENT_TASK = TASK_NONE
CURRENT_PROCESS = PROCESS_NONE
IS_BREAKING_TASK = false


------API------
sleep = mSleep