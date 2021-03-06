-- page.lua
-- Author: cndy1860
-- Date: 2018-11-19
-- function: 界面相关处理
require("global")
require("config")

local type = type
local pairs = pairs
local tostring = tostring
local tonumber = tonumber
local strFormat = string.format
local getCurrentTime = os.time
local strSub = string.sub
local strFind = string.find
local tbInsert = table.insert

local modName = "page"
local M = {}

_G[modName] = M
package.loaded[modName] = M

--界面特制表
M.pageEigenvalueList = {
	{pageName = PAGE_INIT, points = "130|253|0xdc0014,241|240|0xdc0014,299|250|0xdc0014,400|249|0xdc0014,847|36|0xfabe00,256|369|0xffffff"},
	{pageName = PAGE_NOTICE, points = "65|23|0x12326a,73|22|0x080808,83|3|0xffffff,919|39|0x007aff,912|39|0xccdff2,927|39|0xccdff2,920|32|0xccdff2,920|47|0xccdff2"},
	{pageName = PAGE_MAIN, points = "136|21|0x000000,264|26|0x000000,712|18|0x007aff,122|513|0xe2e2e2,760|511|0xffffff,258|512|0xc6c6c6"},
	{pageName = PAGE_ONLINE_MATCH, points = "146|23|0x000000,265|18|0x000000,712|20|0x007aff,128|512|0x0079fd,196|439|0xffffff,745|270|0x007bfd"},
	{pageName = PAGE_COACH_RANK, points = "64|86|0x12a42b,62|315|0x0079fd,80|316|0x12a42b,276|82|0x1f1f1f,569|85|0xfc3979,74|409|0x0079fd"},
	{pageName = PAGE_MATCHED, points = "140|23|0x000000,713|18|0xc6c6c9,127|515|0x5c5c5c,824|504|0x0079fd"},
	{pageName = PAGE_ROSTER, points = "139|24|0x000000,713|21|0xc6c6c9,60|303|0x0079fd,852|120|0x005cbf,780|433|0x1f1f1f,812|513|0x0079fd"},
	{pageName = PAGE_PLAYING, points = "105|23|0x24353f,222|21|0x21323d,125|54|0x0ce0f1,205|50|0x08dca8", fuzzy = 80},
	{pageName = PAGE_INTERVAL, points = "378|106|0xe7fbfc,446|104|0x283944,625|271|0xebfef8,529|366|0x293943,479|455|0x1e3133"},
	{pageName = PAGE_INTERVAL_READY, points = "398|244|0xffffff,706|244|0x0079fd,804|391|0xffffff,829|510|0x0079fd"},
	{pageName = PAGE_END_READY, points = "398|244|0x0079fd,706|244|0xffffff,674|392|0x0079fd,689|391|0x12a42b,829|510|0x0079fd"},
	{pageName = PAGE_RANK_UP, points = "241|27|0x000000,817|22|0xc6c6c9,198|433|0x181c1c,611|31|0xc6c6c9,842|513|0x0079fd,790|403|0x101214", fuzzy = 90},
	{pageName = PAGE_SUBSTITUTED, points = "73|35|0xffffff,177|119|0xffffff,785|138|0x131313,827|125|0x003773,788|433|0x131313"},
	{pageName = PAGE_PLAYER_STATUS, points = "124|510|0x0079fd,68|407|0xfdfdfd,825|128|0x005cbf,800|275|0xff9500,797|421|0x1f1f1f"},
	{pageName = PAGE_OFFLINE_FAIL, points = "281|330|0xcaddf0,244|370|0xf5f5f5,197|365|0x767676,248|408|0x757575,761|394|0x7a7a7a,701|184|0xf5f5f5"},	--天梯掉线失败界面
	
	{pageName = PAGE_LEAGUE, points = "210|257|0x000000,209|244|0xf8f9fb,479|262|0x000000,477|244|0xf8f9fb,371|91|0xdf436f,566|439|0x007aff"},
	{pageName = PAGE_LEAGUE_SIM, points = "267|26|0x000000,69|122|0x0079fd,89|127|0x12a42b,82|387|0x0079fd,370|286|0x135e9b,878|95|0xfc3979"},
	{pageName = PAGE_LEAGUE_MATCHED, points = "231|414|0xff9500,123|98|0x205080,832|96|0x205080,612|415|0xff9500,795|525|0x0079fd,944|499|0x0079fd"},
	{pageName = PAGE_LEAGUE_POINTS, points = "138|355|0x135e9b,137|369|0x135e9b,138|411|0xa8cce0,135|421|0x135e9b,831|513|0x0079fd"},
	{pageName = PAGE_LEAGUE_RESULT, points = "416|162|0x9ec2ff,435|162|0x1e53b1,458|162|0x9ec2ff,472|162|0x1e53b1,492|164|0x9ec2ff,437|515|0xcaddf0,454|511|0x0078fd"},
	{pageName = PAGE_LEAGUE_SCOUT, points = "440|124|0xffcc00,435|145|0x638799,530|150|0x638799,479|149|0x98aab3,505|506|0xc2c2c2,832|510|0x0079fd"},
	{pageName = PAGE_LEAGUE_BREAKING, points = "321|89|0x797979,289|117|0x7d7d7d,480|460|0x7a7a7a,308|342|0xcaddf0,669|346|0xcaddf0,385|476|0x7f7f7f"},
}

--将{{x1, y1, c1},{x2, y2, c2},}转换成"x1|y1|c1,x2|y2|c2"格式
function M.toPointsString(pointsTable)
	local strr = ""
	for k, v in pairs(points) do
		strr = strr..tostring(v[1]).."|"..tostring(v[2]).."|"..strFormat("0x%06x",v[3])..","
	end
	strr = strSub(strr,1,-2)
	return strr
end

--将"x1|y1|c1,x2|y2|c2"转换成{{x1, y1, c1},{x2, y2, c2},}格式
function M.toPointsTable(pointString)
	local pointsTable = {}
	local lastI = 0
	local lastJ = 0
	local i = 0
	local j = 0
	local pointStr = ""
	local tmpStr = pointString..","
	
	while true do
		local tmpTable = {}
		i = strFind(tmpStr, ",", i + 1)
		if i == nil then
			break
		end
		pointStr = strSub(tmpStr, lastI + 1, i - 1)
		j = strFind(pointStr, "|")
		
		tbInsert(tmpTable,tonumber(strSub(pointStr, 1, j-1)))
		
		lastJ = j
		j = strFind(pointStr, "|", j + 1)
		
		tbInsert(tmpTable, tonumber(strSub(pointStr, lastJ + 1, j-1)))
		tbInsert(tmpTable,tonumber(strSub(pointStr, j + 1, -1)))
		tbInsert(pointsTable, tmpTable)
		lastI = i
	end
	
	return pointsTable
end

--x,y为坐标值，c为颜色值，s为相似度，范围0~100。
function M.isColor(x,y,c,s)
	local fl,abs = math.floor,math.abs
	s = fl(0xff*(100-s)*0.01)
	local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
	local rr,gg,bb = getColorRGB(x,y)
	if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
		return true
	end
	return false
end

--验证当前界面是否为points对应的界面，兼容string和{string,string,...}形式
function M.matchColors(points, fuzzy)
	if points == nil then
		catchError(ERR_PARAM, "points is nil in matchColors")
	end

	f = fuzzy or CFG.DEFAULT_FUZZY
	local tmpPoints = {}
	if type(points) == "string" then
		if points == "" then
			catchError(ERR_PARAM, "points is empty string in matchColors")
		end
		tmpPoints = M.toPointsTable(points)
	elseif type(points) == "table" then
		if #points == 0 then
			catchError(ERR_PARAM, "points is empty table in matchColors")
		end	
		tmpPoints = points
	else
		catchError(ERR_PARAM, "get a wrong type value in matchColors")
	end
	
	if #tmpPoints == 0 then
		catchError(ERR_PARAM, "get a empty table tmpPoints in matchColors")
	end
	
	local matchFlag = false
	for k, v in pairs(tmpPoints) do
		matchFlag = true
		if M.isColor(v[1], v[2], v[3], f) ~= true then
			matchFlag = false
			break
		end
	end
	
	return matchFlag
end

--获取当前界面
function M.getCurrentPage()
	for _, v in pairs(M.pageEigenvalueList) do
		local f = v.fuzzy or CFG.DEFAULT_FUZZY
		local isMatch = M.matchColors(v.points, f)
		if isMatch == true then
			Log("get current page : "..v.pageName)
			return v.pageName
		end
		--sleep(10)
	end
end

--验证当前界面是否为pageName界面
function M.isCurrentPage(pageName)		
	if pageName == nil then
		catchError(ERR_PARAM, "pageName is nil in isCurrentPage")
	end
	for k, v in pairs(M.pageEigenvalueList) do
		if v.pageName == pageName then
			local f = v.fuzzy or CFG.DEFAULT_FUZZY
			return page.matchColors(v.points, f)
		end
	end
	return false
end

--通过循环等待来匹配到某个可点击的按钮(比如下一步按钮)的点集，然后执行点击操作
--这样实现了当从一个前界面跳转到当前界面时，不需要单独进行检测是否跳转完成，因
--为能够匹配到当前界面的(下一步)按钮，说明已经成功从上一个界面跳转到了当前界面
function M.goNextByCatchPoint(rect, points, delay, fuzzy)
	Log("in goNextByFindPoint")
	f = fuzzy or CFG.DEFAULT_FUZZY
	d = delay or CFG.DEFAULT_WAIT_AFTER_FIND
	local tmpPoints = {}
	if type(points) == "table" then
		tmpPoints = M.toPointsString(points)
	elseif type(points) == "string" then
		tmpPoints = points
	else
		catchError(ERR_PARAM, "get a wrong type value in matchColors")
	end
	
	local startTime = getCurrentTime()
	while true do
		x, y = findColor(rect, tmpPoints, f)
		if x ~= -1 and y ~= -1 then
			Log("get the next point x:"..x.."  y:"..y)
			sleep(d)
			tap(x, y)
			break
		end
		
		if getCurrentTime() - startTime > CFG.DEFAULT_TIMEOUT then
			catchError(ERR_TIMEOUT, "execute goNextByCatchPoint timeout")
		end
		
		sleep(50)
	end
	Log("end goNextByFindPoint")
end

--通过固定点点击进入下一步
function M.goNextByPoint(x, y)
	tap(x, y)
end

--跳过未定义的界面，等到一个已定义的界面(pageEigenvalueList)再释放
function M.waitSkipNilPage()
	local startTime = os.time()
	while true do
		if page.getCurrentPage() ~= nil then
			break
		end
		
		if os.time() - startTime > CFG.DEFAULT_TIMEOUT then
			catchError(ERR_TIMEOUT, "未检测到预定的脚本开始界面")
		end
		sleep(200)
	end
end

--检测低可能性出现的界面，通过检测可能界面和next page谁先到来，比起skip page机制，无需等待进入skip流程的时间CFG.WAIT_SKIP_NIL_PAGE
--originPage为一个pageEigenvalueList中的已定义界面，高概率出现界面，probabilityPageInfo可以为多个界面点集，为低概率出现的界面
function M.catchFewProbabilityPage(originPage, probabilityPageInfo)
	local startTime = os.time()
	while true do
		if type(probabilityPageInfo) == "string" then
			if page.matchColors(probabilityPageInfo) then	--先出现probabilityPage
				return 1
			end
		elseif type(probabilityPageInfo) == "table" then
			for k, v in pairs(probabilityPageInfo) do
				if page.matchColors(v) then	--先出现probabilityPage之一
					return k
				end
			end
		else
			catchError(ERR_PARAM, "get a worong type probabilityPageInfo in catchFewProbabilityPage")
		end
		
		local currentPage = page.getCurrentPage()
		if currentPage ~= nil and currentPage == originPage then	--先出现新的已定义界面
			return 0
		end
		
		if os.time() - startTime > CFG.DEFAULT_TIMEOUT then
			return -1	--直接释放
		end
		sleep(50)
	end

	return -1
end

--用于替代catchFewProbabilityPage()函数，推荐使用此函数
--捕获一个已定义(pageEigenvalueList中)的界面或者一个由点集pagePoints定义的界面后再释放
--返回值为界面序号，返回pagePoints中的序号为pageNames中界面总数+在pagePoints中的序号
--两参数均接受string或者{string, string, ...}
function M.catchPage(pageNames, pagePoints, waitTime)
	if pageNames == nil and pagePoints == nil then
		catchError(ERR_PARAM, "nil param in catchPage")
	end
	
	local wt = waitTime or DEFAULT_TIMEOUT
	
	tmpPageNamesList = {}
	tmpPagePointsList = {}
	if type(pageNames) == "string" then
		table.insert(tmpPageNamesList, pageNames)
	elseif type(pageNames) == "table" then
		for k, v in pairs(pageNames) do
			table.insert(tmpPageNamesList, v)
		end
	else
		catchError(ERR_PARAM, "wrong type in catchPage")
	end
	
	if type(pagePoints) == "string" then
		table.insert(tmpPagePointsList, pagePoints)
	elseif type(pagePoints) == "table" then
		for k, v in pairs(pagePoints) do
			table.insert(tmpPagePointsList, v)
		end
	else
		catchError(ERR_PARAM, "wrong type in catchPage")
	end
	
	local startTime = getCurrentTime()
	while true do
		for k, v in pairs(tmpPageNamesList) do
			if M.isCurrentPage(v) then
				return k
			end
		end
		
		for k, v in pairs(tmpPagePointsList) do
			if M.matchColors(v) then
				return #tmpPageNamesList + k
			end
		end
		
		if getCurrentTime() - startTime > wt then
			catchError(ERR_WARNING, "catchPage timeout")
			return 0
		end
		sleep(50)
	end
end

return M
