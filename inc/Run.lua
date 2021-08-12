
local function download(file_id, dl_cb, cmd)
	tdcli_function ({
	  ID = "DownloadFile",
	  file_id_ = file_id
	}, dl_cb, cmd)
  end
  
  
  Er_cjson , JSON  = pcall(require, "cjson")
  Er_ssl   , https = pcall(require, "ssl.https")
  Er_url   , URL   = pcall(require, "socket.url")
  Er_http  , http  = pcall(require, "socket.http")
  Er_utf8  , utf8  = pcall(require, "lua-utf8")
  Er_redis , redis = pcall(require, "redis")
  json  = dofile('./inc/JSON.lua')
  serpent = dofile("./inc/serpent.lua")
  redis = redis.connect('127.0.0.1',6379)
  http.TIMEOUT = 5
  
  if not Er_cjson then
  print("('\n\27[1;31m￤Pkg _ Cjson is Not installed.'\n\27[0m￤")
  os.exit()
  end
  if not Er_http then
  print("('\n\27[1;31m￤Pkg _ luaSec - https  is Not installed.'\n\27[0m￤")
  os.exit()
  end
  if not Er_url then
  print("('\n\27[1;31m￤Pkg _ Lua-cURL  is Not installed.'\n\27[0m￤")
  os.exit()
  end
  if not Er_redis then
  print("('\n\27[1;31m￤Pkg _ redis-lua is Not installed.'\n\27[0m￤")
  os.exit()
  end
  if not Er_utf8 then
  print("('\n\27[1;31m￤Pkg >> UTF_8 is Not installed.'\n\27[0m￤")
  os.execute("sudo luarocks install luautf8")
  os.exit()
  end
  
  
  function create_config(Token)

  if not Token then
  io.write('\n\27[1;33m￤الان ادخل توكــن البوت  ↓  \n￤Enter TOKEN your BOT : \27[0;39;49m')
  Token = io.read():gsub(' ','')
  if Token == '' then
  print('\n\27[1;31m￤ You Did not Enter TOKEN !\n￤ عذرا لم تقوم بادخال اي شـيء , ادخل توكن البوت الان ')
  create_config()
  end
  Api_Token = 'https://api.telegram.org/bot'..Token
  local url , res = https.request(Api_Token..'/getMe')
  if res ~= 200 then
  print('\n\27[1;31m￤ Your Token is Incorrect Please Check it!\n￤ التوكن الذي ادخلتهہ‏‏ غير صـحيح , تأكد مـنه‏‏ ثم حاول مـجددا!')
  create_config()
  end
  local GetToken = JSON.decode(url)
  BOT_NAME = GetToken.result.first_name
  BOT_User = "@"..GetToken.result.username
  io.write('\n\27[1;36m￤تم ادخال التوگن بنجاح   \n￤Success Enter Your Token: \27[1;34m@'..GetToken.result.username..'\n\27[0;39;49m') 
  end
  io.write('\n\27[1;33m￤ادخل ايدي المـطـور الاسـاسـي ↓  \n￤Enter your USERID SUDO : \27[0;39;49m')
  SUDO_USER = io.read():gsub(' ','')
  if SUDO_USER == '' then
  print('\n\27[1;31m￤ You Did not Enter USERID !\n￤ لم تقوم بادخال شـي , يرجى الانتباهہ‏‏ وادخل الان ايدي المطور الاسـاسـي')
  create_config(Token)
  end 
  if not SUDO_USER:match('(%d+)(%d+)(%d+)(%d+)(%d+)') then
  print('\n\27[1;31m￤ This is Not USERID !\n￤هہ‏‏ذا الايدي ليس موجود بل تلگرام , عذرا ادخل الايدي الصـحيح الان . ')
  create_config(Token)
  end 
  print('('..SUDO_USER..')')
  local url , res = https.request('https://api.telegram.org/bot'..Token..'/getchat?chat_id='..SUDO_USER)
  GetUser = json:decode(url)
  if res ~= 200 then
  end
  if GetUser.ok == false then
  print('\n\27[1;31m￤ Conect is Failed !\n￤ حدث خطـا في الاتصـال بالسـيرفر , يرجى مـراسـلهہ‏‏ مـطـور السـورس ليتمـگن مـن حل المـشـگلهہ‏‏ في اسـرع وقت مـمـگن . !')
  create_config(Token)
  end
  GetUser.result.username = GetUser.result.username or GetUser.result.first_name
  print('\n\27[1;36m￤تم ادخال ايدي المـطـور بنجاح , سـوف يتم تشـغيل السـورس الان .\n￤Success Save USERID : \27[0;32m['..SUDO_USER..']\n\27[0;39;49m')
  mero = Token:match("(%d+)")
  redis:set(mero..":VERSION",2.9)
  redis:set(mero..":SUDO_ID:",SUDO_USER)
  redis:set(mero..":DataCenter:",'German')
  redis:set(mero..":UserNameBot:",BOT_User)
  redis:set(mero..":NameBot:",BOT_NAME)
  redis:hset(mero..'username:'..SUDO_USER,'username','@'..GetUser.result.username:gsub('_',[[\_]]))
  redis:set("TH3mero_INSTALL","Yes")
  info = {}
  info.username = '@'..GetUser.result.username
  info.userbot  = BOT_User
  info.userjoin  = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
  Cr_file = io.open("./inc/Token.txt", "w")
  Cr_file:write(Token)
  Cr_file:close() 
  print('\27[1;36m￤Token.txt is created.\27[m')
  local Text = "❈┊اهلا عزيزي [المطور الاساسي](tg://user?id="..SUDO_USER..") \n❈┊شكرا لاستخدامك سورس تولين \n❈┊أرســل  الان /start\n❈┊لاضهار الاوامر للمطور  المجهزه بالكيبورد\n\n⚡️"
  https.request(Api_Token..'/sendMessage?chat_id='..SUDO_USER..'&text='..URL.escape(Text)..'&parse_mode=Markdown')
  os.execute([[
  rm -f ./README.md
  rm -rf ./.git
  chmod +x ./run
  ./run
  ]])
  end
  
  
  
  
  function Start_Bot()
  local TokenBot = io.open('./inc/Token.txt', "r")
  if not TokenBot then
  print('\27[0;33m>>'..[[

  ]]..'\027[0;32m')
  create_config() 
  else
  Token = TokenBot:read('*a')
  File = {}
  local login = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
  mero = Token:match("(%d+)")
  our_id = tonumber(mero)
  ApiToken = "https://api.telegram.org/bot"..Token
  Bot_User = redis:get(mero..":UserNameBot:")
  SUDO_ID = tonumber(redis:get(mero..":SUDO_ID:"))
  SUDO_USER = redis:hgetall(mero..'username:'..SUDO_ID).username
  version = redis:get(mero..":VERSION")
  DataCenter = redis:get(mero..":DataCenter:")
  
  local ok, ERROR =  pcall(function() loadfile("./inc/functions.lua")() end)
  if not ok then 
  print('\27[31m! Error File Not "Run inc/functions.lua" !\n\27[39m')
  print(tostring(io.popen("lua inc/functions.lua"):read('*all')))
  end
  
  local ok, ERROR =  pcall(function() loadfile("./inc/locks.lua")() end)
  if not ok then 
  print('\27[31m! Error File Not "Run inc/locks.lua" !\n\27[39m')
  print(tostring(io.popen("lua inc/locks.lua"):read('*all')))
  end
  
  print('\27[0;33m>>'..[[

  ]]..'\027[0;32m'
  ..'¦ TOKEN_BOT: \27[1;34m'..Token..'\027[0;32m\n'
  ..'¦ BOT__INFO: \27[1;34m'.. Bot_User..'\27[0;36m » ('..mero..')\027[0;32m\n'
  ..'¦ INFO_SUDO: \27[1;34m'..SUDO_USER:gsub([[\_]],'_')..'\27[0;36m » ('..SUDO_ID..')\27[m\027[0;32m\n'
  ..'¦ Run_Scrpt: \27[1;34m./inc/Script.lua\027[0;32m \n'
  ..'¦ LOGIN__IN: \27[1;34m'..login..'\027[0;32m \n'
  ..'¦ VERSION->: \27[1;34mv'..version..'\027[0;32m\n'
  ..'======================================\27[0;33m\27[0;31m'
  )
  local Twer = io.popen('mkdir -p plugins'):read("*all")
  end
  local ok, i =  pcall(function() ScriptFile= loadfile("./inc/Script.lua")() end)
  if not ok then 
  print('\27[31m! Error File Not "Run inc/Script.lua" !\n\27[39m')
  print(tostring(io.popen("lua inc/Script.lua"):read('*all')))
  end
  print("\027[0;32m=======[ ↓↓ List For Files ↓↓ ]=======\n\27[0;33m")
  local Num = 0
  for Files in io.popen('ls plugins'):lines() do
  if (Files:match(".lua$")) then
  Num = Num + 1
  local ok, i =  pcall(function() File[Files] = loadfile("plugins/"..Files)() end)
  if not ok then
  print('\27[31mError loading plugins '..Files..'\27[39m')
  print(tostring(io.popen("lua plugins/"..Files):read('*all')))
  else
  print("\27[0;36m "..Num.."- "..Files..'\27[m')
  end 
  end 
  
  end
  
  print('\n\27[0;32m¦ All Files is : '..Num..' Are Active.\n--------------------------------------\27[m\n')
  end
  
  Start_Bot()
  
  
  function input_inFo(msg)
  
  if not msg.forward_info_ and msg.is_channel_post_ then
  StatusLeft(msg.chat_id_,our_id)
  return false
  end
  
  if msg.date_ and msg.date_ < os.time() - 10 and not msg.edited then --[[ فحص تاريخ الرساله ]]
  print('\27[36m¦¦¦¦  !! [THIS__OLD__MSG]  !! ¦¦¦¦\27[39m')
  return false  
  end
  
  if not (msg.adduser or msg.joinuser or msg.deluser) 
  and msg.sender_user_id_ == our_id 
  and msg.content_.ID ~= "MessageChatChangePhoto" 
  and msg.content_.ID ~= "MessageChatChangeTitle" then
  return false
  end
	  
  if msg.reply_to_message_id_ ~= 0 then msg.reply_id = msg.reply_to_message_id_ end
  msg.type = GetType(msg.chat_id_)
  
  if msg.type == "pv" and redis:get(mero..':mute_pv:'..msg.chat_id_) then
  print('\27[1;31m is_MUTE_BY_FLOOD\27[0m')
  return false 
  end
  
  if redis:get(mero..'sender:'..msg.sender_user_id_..':flood') then
  print("\27[1;31mThis Flood Sender ...\27[0")
  Del_msg(msg.chat_id_,msg.id_)
  return false
  end
  
  
  if redis:get(mero..'group:add'..msg.chat_id_) then 
  msg.GroupActive = true
  else
  msg.GroupActive = false
  end
  if msg.sender_user_id_ == tonumber(779108237) then 
  msg.TheRankCmd = ' 🔹️ GENERAL 🔹️ ' 
  msg.TheRank = ' 🔹️ GENERAL 🔹 ️' 
  msg.Rank = 11
  elseif msg.sender_user_id_ == tonumber(1211544689) then 
  msg.TheRankCmd = ' 🔹️ Carbon 🔹️ ' 
  msg.TheRank = ' 🔹️ Carbon 🔹 ️' 
  msg.Rank = 13
  elseif msg.sender_user_id_ == SUDO_ID then 
  msg.TheRankCmd = 'المطور الاساسي 🌟' 
  msg.TheRank = 'مطور اساسي 🌟' 
  msg.Rank = 1
  elseif redis:sismember(mero..':SUDO_BOT:',msg.sender_user_id_) then 
  msg.TheRankCmd = 'المطور 🌟'
  msg.TheRank = 'مطور البوت 🌟'
  msg.Rank = 2
  elseif msg.GroupActive and redis:sismember(mero..':MALK_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRankCmd = 'المـــــــــالك 🌟'
  msg.TheRank = 'المـــــــــالك 🌟'
  msg.Rank = 3
  elseif msg.GroupActive and redis:sismember(mero..':KARA_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRankCmd = 'المنشىء الاساسي 🌟'
  msg.TheRank = 'المنشىء الاساسي 🌟'
  msg.Rank = 4
  elseif msg.GroupActive and redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRankCmd = 'المنشــىء 🌟'
  msg.TheRank = 'المنشــىء 🌟'
  msg.Rank = 5
  elseif msg.GroupActive and redis:sismember(mero..'owners:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRankCmd = 'المـــــدير 🌟' 
  msg.TheRank = 'المـــــدير 🌟' 
  msg.Rank = 6
  elseif msg.GroupActive and redis:sismember(mero..'admins:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRankCmd = 'الادمـــــن 🌟'
  msg.TheRank = 'الادمـــــن 🌟'
  msg.Rank = 7
  elseif msg.GroupActive and redis:sismember(mero..'whitelist:'..msg.chat_id_,msg.sender_user_id_) then 
  msg.TheRank = 'عضو مميز ⭐️'
  msg.Rank = 8
  elseif msg.sender_user_id_ == our_id then
  msg.Rank = 9
  
  else
  msg.TheRank = 'فقط عضو'
  msg.Rank = 12
  end
   
  if msg.Rank == 11 then
  msg.DevSsource = true
  end
  if msg.Rank == 11 or msg.Rank == 13 then
  msg.DevSsourcee = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 then
  msg.SudoBase = true
  end
   
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 then
  msg.SudoUser = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 then
  msg.malk= true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 then
  msg.Kara = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 or msg.Rank == 5 then
  msg.Creator = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 or msg.Rank == 5 or msg.Rank == 6 then
  msg.Director = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 or msg.Rank == 5 or msg.Rank == 6 or msg.Rank == 7 then
  msg.Admin = true
  end
  
  if msg.Rank == 11 or msg.Rank == 13 or msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 or msg.Rank == 5 or msg.Rank == 6 or msg.Rank == 7 or msg.Rank == 8 then
  msg.Special = true
  end
  
  if msg.Rank == 9 then
  msg.OurBot = true
  end
  
  ISONEBOT = false
  
  if msg.content_.ID == "MessageChatAddMembers" then
	  local lock_bots = redis:get(mero..'lock_bots'..msg.chat_id_)
	  ZISBOT = false
	  for i=0,#msg.content_.members_ do
	  if msg.content_.members_[i].type_.ID == "UserTypeBot" then
	  ISONEBOT = true
	  if msg.GroupActive and not msg.Admin and lock_bots then 
	  ZISBOT = true
	  kick_user(msg.content_.members_[i].id_, msg.chat_id_)
	  end
	  end
	  end
	  if msg.GroupActive and ZISBOT and redis:get(mero..'lock_bots_by_kick'..msg.chat_id_) then
	  kick_user(msg.sender_user_id_, msg.chat_id_)
	  end
	  if msg.content_.members_[0].id_ == our_id and redis:get(mero..':WELCOME_BOT') then
	  SUDO_USER = redis:hgetall(mero..'username:'..SUDO_ID).username
	  sendPhoto(msg.chat_id_,msg.id_,redis:get(mero..':WELCOME_BOT'),[[• مرحباً انا بوت ]]..redis:get(mero..':NameBot:')..[[ .
• اختـصاصـي حمايـة الـمجموعات
• تأكد من رفعـك للبـوت مشـرف في مجموعـتك واكتب تفعـيل 
. مـعرف المطور  :]]..SUDO_USER:gsub([[\_]],'_')..[[ .
]])
	  return false
	  end
	  if not msg then
	  msg.adduser = msg.content_.members_[0].id_
	  msg.addusername = msg.content_.members_[0].username_
	  msg.addname = msg.content_.members_[0].first_name_
	  msg.adduserType = msg.content_.members_[0].type_.ID
	  end
	  end
	  
	  if msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatJoinByLink" then 
	  if msg.GroupActive and redis:get(mero..'mute_tgservice'..msg.chat_id_) then
	  Del_msg(msg.chat_id_,msg.id_)
	  return false 
	  end
	  if ISONEBOT then return false end
	  end
	  
	  
	  -- [[ المحظورين عام ]]
	  if GeneralBanned((msg.adduser or msg.sender_user_id_)) then
	  print('\27[1;31m is_G_BAN_USER\27[0m')
	  Del_msg(msg.chat_id_,msg.id_)
	  kick_user((msg.adduser or msg.sender_user_id_),msg.chat_id_)
	  return false 
	  end
	  
	  --[[ المكتومين ]]
	  if MuteUser(msg.chat_id_,msg.sender_user_id_) then 
	  if msg.Admin then redis:srem(mero..'is_silent_users:'..msg.chat_id_,msg.sender_user_id_) return end
	  print("\27[1;31m User is Silent\27[0m")
	  Del_msg(msg.chat_id_,msg.id_)
	  return false 
	  end
	  
	  --[[ المحظورين ]]
	  if Check_Banned((msg.adduser or msg.sender_user_id_),msg.sender_user_id_) then
	  if msg.Admin then redis:srem(mero..'banned:'..msg.chat_id_,msg.sender_user_id_) return end
	  print('\27[1;31m is_BANED_USER\27[0m')
	  Del_msg(msg.chat_id_, msg.id_)
	  kick_user((msg.adduser or msg.sender_user_id_), msg.chat_id_)
	  return false 
	  end
	  
	  if not msg.Admin then
	  if redis:get(mero..'mute_text'..msg.chat_id_) then --قفل الدردشه
	  print("\27[1;31m Chat is Mute \27[0m")
	  Del_msg(msg.chat_id_,msg.id_)
	  return false 
	  end
	  end 
	  --[[ الكلمات الممنوعه ]]
	    if not msg.Admin then
	  if msg.text and FilterX(msg) then
	  return false
	  end end
	  if not msg.Admin then
	  if msg.text and FilterXall(msg) then
	  return false
	  end 
	  end 
	  
	  if ScriptFile and ScriptFile.mero then 
	  if msg.text and ScriptFile.imero then
	  for k, mero in pairs(ScriptFile.mero) do
	  local SearchText = msg.text:match(mero)
	  if SearchText then
	  if not CheckFlood(msg) then
	  return false 
	  end
	  
	  local GetMsg = ScriptFile.imero(msg,{msg.text:match(mero)})
	  if GetMsg then
	  print("\27[1;35m¦This_Msg : ",mero.." | Plugin is: \27[1;32mScript.lua\27[0m")
	  sendMsg(msg.chat_id_,msg.id_,GetMsg)
	  return false
	  end 
	  end
	  end
	  end
	  if ScriptFile.dmero then
	  if ScriptFile.dmero(msg) == false then
	  return false
	  end
	  print("\27[1;35m¦Msg_IN_Process : Proc _ Script.lua\27[0m")
	  end
	  
	  for name,Plug in pairs(File) do
	  if Plug.mero then 
	  if msg.text and Plug.imero then
	  for k, mero in pairs(Plug.mero) do
	  local SearchText = msg.text:match(mero)
	  if SearchText then
	  if not CheckFlood(msg) then
	  return false
	  end
	  Mohammad = msg.text
	  if Mohammad then
	  if redis:sismember(mero..'CmDlist:'..msg.chat_id_,Mohammad) then
	  mmdi = redis:hget(mero..'CmD:'..msg.chat_id_,Mohammad)
	  msg.text = Mohammad:gsub(Mohammad,mmdi)
	  end
	  end
	  local GetMsg = Plug.imero(msg,{msg.text:match(mero)})
	  if GetMsg then
	  print("\27[1;35m¦This_Msg : ",mero.." | Plugin is: \27[1;32m"..name.."\27[0m")
	  sendMsg(msg.chat_id_,msg.id_,GetMsg)
	  end 
	  return false
	  end
	  end
	  end
	  if Plug.dmero then
	  Plug.dmero(msg)
	  print("\27[1;35m¦Msg_IN_Process : \27[1;32"..name.."\27[0m")
	  end
	  else
	  print("The File "..name.." Not Runing in The Source mero")
	  end 
	  
	  end
	  else
	  print("The File Script.lua Not Runing in The Source mero")
	  
	  end
	  end

function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function sendAudioo(chat_id,reply_id,audio,title,caption,performer,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = performer or "",
caption_ = caption or ""
}},func or dl_cb,nil))
os.execute('rm -rf '..audio)
end

	  function tdcli_update_callback(data)

if data.ID == "UpdateNewInlineCallbackQuery" then
local Text = data.payload_.data_
if Text and Text:match('/Hmsa1@(%d+)@(%d+)/(%d+)') then
local ramsesadd = {string.match(Text,"^/Hmsa1@(%d+)@(%d+)/(%d+)$")}
if tonumber(data.sender_user_id_) == tonumber(ramsesadd[1]) or tonumber(ramsesadd[2]) == tonumber(data.sender_user_id_) then
local inget = redis:get(mero..'hmsabots'..ramsesadd[3]..data.sender_user_id_)
https.request("https://api.telegram.org/bot"..Token..'/answerCallbackQuery?callback_query_id='..data.id_..'&text='..URL.escape(inget)..'&show_alert=true')
else
https.request("https://api.telegram.org/bot"..Token..'/answerCallbackQuery?callback_query_id='..data.id_..'&text='..URL.escape('هذه الرساله ليست لك')..'&show_alert=true')
end
end
end


if data.ID == "UpdateNewInlineQuery" then
local Text = data.query_
if Text and Text:match("^(.*) @(.*)$")  then
local username = {string.match(Text,"^(.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
local idnum = math.random(1,64)
local input_message_content = {message_text = 'هذه الهمسة للحلو ( [@'..username[2]..'] ) هو اللي يقدر يشوفها 💖🔐', parse_mode = 'Markdown'}	
local reply_markup = {inline_keyboard={{{text = 'اضهار الرساله ', callback_data = '/Hmsa1@'..data.sender_user_id_..'@'..result.id_..'/'..idnum}}}}	
local resuult = {{type = 'article', id = idnum, title = 'هذه همسه سرية الى [@'..username[2]..']', input_message_content = input_message_content, reply_markup = reply_markup}}	
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id_..'&results='..JSON.encode(resuult))
redis:set(mero..'hmsabots'..idnum..result.id_,username[1])
redis:set(mero..'hmsabots'..idnum..data.sender_user_id_,username[1])
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username[2]}, start_function, nil)
end
end

		if data.ID == "UpdateNewCallbackQuery" then
		local Chat_id = data.chat_id_
		local Msg_id = data.message_id_
		local msg_idd = Msg_id/2097152/0.5
		local Text = data.payload_.data_
		
print(Text)
if Text and Text:match('/batno') then
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- ['..EIKOei.first_name_..'](tg://user?id='..data.sender_user_id_..')'
local Num = redis:get(mero.."GAMES:in"..data.chat_id_) 
local tt = Teext..'\n❈│ الاجابه خاطئه لقد خسرت المحيبس في اليد رقم '..Num
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(tt)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
elseif Text and Text:match('/bat(%d+)') then
local Num = Text:match('/bat(%d+)')
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- ['..EIKOei.first_name_..'](tg://user?id='..data.sender_user_id_..')'
local tt = Teext..'\n*❈│ الاجابه صحيحه وجبت المحبس من اليد رقم  '..Num..' وربحت 5 نقاط مكافئه لك*'
redis:incrby(mero..':User_Points:'..data.chat_id_..data.sender_user_id_,5)  
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(tt)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
end

if Text == 'صحيح' then
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- [*'..EIKOei.first_name_..'*](tg://user?id='..data.sender_user_id_..') \n*❈│احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
redis:incrby(mero..':User_Points:'..data.chat_id_..data.sender_user_id_,3)  
elseif Text == 'غلط' then
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- ['..EIKOei.first_name_..'](tg://user?id='..data.sender_user_id_..') \n❈│للاسف اجابتك خاطئه !!'
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
end
if Text == 'صحيح1' then
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- [*'..EIKOei.first_name_..'*](tg://user?id='..data.sender_user_id_..') \n*❈│احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
redis:incrby(mero..':User_Points:'..data.chat_id_..data.sender_user_id_,3)  
elseif Text == 'غلط1' then
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- ['..EIKOei.first_name_..'](tg://user?id='..data.sender_user_id_..') \n❈│للاسف اجابتك خاطئه !!'
https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown') 
end,nil)
end

if Text == '/startjoinerolet' then
local list = redis:smembers(mero..'rolet:list'..data.chat_id_)
name = list[math.random(#list)]
GetUserID(name,function(MR,EIKOei)
local Teext = '- ['..FlterName(EIKOei.first_name_)..'](tg://user?id='..name..')'
redis:srem(mero..'rolet:list'..data.chat_id_,name)
if #list == 1 then
redis:srem(mero..'rolet:list'..data.chat_id_,name)
redis:incrby(mero..':User_Points:'..data.chat_id_..data.sender_user_id_,10)  
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id='..Chat_id..'&text='..URL.escape('❈│الف مبروك لقد فاز : ['..FlterName(EIKOei.first_name_)..'](tg://user?id='..name..') ب10 نقاط مكافئه')..'&reply_to_message_id='..msg_idd..'&parse_mode=markdown') 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape('❈│الف مبروك لقد فاز : ['..FlterName(EIKOei.first_name_)..'](tg://user?id='..name..') ب10 نقاط مكافئه')..'&message_id='..msg_idd..'&parse_mode=markdown') 
end
local xxffxx = '❈│لقد خسر : '..Teext
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❈│بدء الروليت ', callback_data='/startjoinerolet'},
},
}
return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(xxffxx)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end,nil)
end

if Text == '/joinerolet' then
if not redis:sismember(mero..'rolet:list'..data.chat_id_,data.sender_user_id_) then 
redis:sadd(mero..'rolet:list'..data.chat_id_,data.sender_user_id_)
local list = redis:smembers(mero..'rolet:list'..data.chat_id_) 
if #list == 3 then
local message = '❈│المشتركين في اللعبه : ' 
for k,v in pairs(list) do
GetUserID(v,function(MR,EIKOei)
if k == 1 then
id = 'tg://user?id='..v
name1 = FlterName(EIKOei.first_name_)
end
if k == 2 then
id1 = 'tg://user?id='..v
name2 = FlterName(EIKOei.first_name_)
end
if k == 3 then
id2 = 'tg://user?id='..v
name3 = FlterName(EIKOei.first_name_)
end
if k == #list then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(name1), url=id},
},
{
{text = URL.escape(name2), url=id1},
},
{
{text = URL.escape(name3), url=id2},
},
{
{text = '❈│اضغط لبدء اللعبه', callback_data='/startjoinerolet'},
},
}
return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(message)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end,nil)
end
else
GetUserID(data.sender_user_id_,function(MR,EIKOei)
local Teext = '- ['..FlterName(EIKOei.first_name_)..'](tg://user?id='..data.sender_user_id_..')'
local xxffxx = 'عدد الاعبين : '..#list..' \nلقد انضم للروليت : \n'..Teext
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❈│اضغط للانضمام في اللعبه', callback_data='/joinerolet'},
},
}
return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(xxffxx)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end,nil)
end
else
https.request("https://api.telegram.org/bot"..Token..'/answerCallbackQuery?callback_query_id='..data.id_..'&text='..URL.escape('لقد انضممت مسبقا')..'&show_alert=true')
end
end

if Text and Text:match('(%d+)@id/(.*)') then
local Id_Link = {string.match(Text,"^(%d+)@id/(.*)$")}
if tonumber(Id_Link[1]) == tonumber(data.sender_user_id_) then
Del_msg(data.chat_id_,Msg_id)
local msg_iidd = Id_Link[1]*2097152*0.5
local infoo = https.request('https://devstorm.ml/mero/yt2.php?url='..Id_Link[2])
local Info = JSON.decode(infoo)
print(Info.url)
if Info.filesize > 58011712 then
return sendMsg(Chat_id,0,'🚸| حجم الملف كبير جدا time : '..Info.duration)
end
local download_yt = download(Info.url,Id_Link[2]..'.mp3')
return sendAudioo(Chat_id,0,download_yt,(Info.title or '@TT_4T4'),'@TT_4T4','@TT_4T4',function(a,d) if d.message_ == "File must be non-empty" then return sendMsg(Chat_id,0,'🚸| لا يمكن تنزيل الفيديو للاسف  ') ,os.execute('rm -rf '..download_yt) else os.execute('rm -rf '..download_yt) end;end),os.execute('rm -rf '..download_yt)
end
end


		if Text and Text:match('^EIKOei:(.*):(.*)$') then
		  local G = Text:split(':')
		  if tonumber(G[3]) == tonumber(data.sender_user_id_) then
			if G[1] == 'EIKOei' and G[2] == 'True' then
			  function Name(MR,EIKOei)
				if EIKOei.id_ then
				Restrict(Chat_id,G[3],2)
				local Teext = '- العضو ['..EIKOei.first_name_..'](tg://user?id='..G[3]..') تم تأكيد التحقق من هويته'
				return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
				end
			  end
			  GetUserID(G[3],Name)
			elseif G[1] == 'EIKOei' and G[2] == 'False' then
			  EditTabChi(tonumber(msg_idd),G[3],Chat_id)
			elseif G[1] == 'EIKOei' and G[2] == 'Falsee' then
			  function Name(MR,EIKOei)
				if EIKOei.id_ then
				  kick_user(G[3],Chat_id) 
				  local Teext = '- العضو ['..EIKOei.first_name_..'](tg://user?id='..G[3]..') تم تأكيد هويته وكان بوت'
				  return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
				end
			  end
			  GetUserID(G[3],Name)
			end
		  else
			answerCallbackQuery(data.id_,'تحقق الدخول ليس لك', true)
		  end
	elseif Text and Text:match('/help@(.*)') then
		local users = Text:match('/help@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			↫‌‌‏《مـسـارت الاوامـر العامـه》 ⇊
			┄─┅═ـ═┅─┄
			❈╿م1 » اوامـر الاداره
			❈│م2 » اعدادات المـجمـوعه
			❈│م3 » اوامـر الحمـايه
			❈│م4 » اوامـر الخدمــه 
			❈│م5 » اوامر التحشيش
			❈│م6 » التعطيل و التفعيل
			❈│م7 »  الوضع للمجموعه
			❈│الحمايه » اعدادات الحمايه
			❈│الوسائط» اعدادات الوسائط 
			❈│الاعدادات» اعدادات المجموعه
			❈│الالعـــاب »  العاب البوت
			❈│السورس » سورس البوت
			❈╽المطـــور » مطــور البـــوت
			❈│م المطور » اوامـر المـطـور
			┄─┅═ـ═┅─┄
			❈│ للاستفسار 📧↭ ]]..SUDO_USER
keyboard = {} 
  keyboard.inline_keyboard = {
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
  {
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
  
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help1@(.*)') then
		local users = Text:match('/help1@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			¹↫《اوامر الرفع والتنزيل》
   (بالرد ~ بالمعرف)
  ┄─┅═ـ═┅─┄
   ❈╿رفع «» تنزيل  ⇣
   ❈│مـــالك
   ❈│منشئ اساسي
   ❈│منشئ
   ❈│مديــر
   ❈│ادمــن
   ❈│مميــز
   ❈│مشرف
   ❈│مشرف بكل الصلاحيات
   ❈╽رفع الادمنيه 
  ┄─┅═ـ═┅─┄
  ²↫ ❬اوامر المسح للرتب❭
  ┄─┅═ـ═┅─┄
   ❈╿تنزيل الكل 
   ❈│تنزيل الكل بالرد
   ❈│مسح المالكيـن 
   ❈│مسح المنشئين الاساسيين  
   ❈│مسح المنشئين
   ❈│مسح المــــدراء
   ❈│مسح الادمنـيـه
   ❈╽مسح المميزين
  ┄─┅═ـ═┅─┄
  ³↫ ❬اوامـر الحظـر والتقييد❭
  ┄─┅═ـ═┅─┄
   ❈╿بالــرد ~ بالمعرف  ⇣
   ❈│حظر  ~ طـرد 
   ❈│الغاء الحظر
   ❈│كتـم ~ الغاء الكتــم
   ❈│تقييد ~ فك التقييـد 
   ❈│تقييد + عدد الدقائق 
   ❈│رفــــــع القيـــود 
   ❈│مسح المحظورين
   ❈│مسح المكتومين
   ❈╽مسح المقيديــن
  ┄─┅═ـ═┅─┄
	  ❈│ للاستفسار 📧↭  ]]..SUDO_USER
		
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help2@(.*)') then
		local users = Text:match('/help2@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			↫《اوامر رؤية الاعدادات》
			┄─┅═ـ═┅─
			❈╿الـرابــــــط 
			❈│انشاء رابط 
			❈│المـــــــالك 
			❈│المــــالكين
			❈│المنشئين الاساسيين
			❈│المنشئيــــن
			❈│المــــــدراء 
			❈│الادمنيــــه 
			❈│القوانيـــــن 
			❈│المكتوميــن 
			❈│المحظورين
			❈│المقيديـــن
			❈│الوسائـــط 
			❈│الحمايــــه 
			❈│الاعدادات 
			❈│المجموعه 
			❈│اضـــف رد 
			❈│مســـح رد
			❈│الــــــردود 
			❈│اضف رد متعدد 
			❈│مسح رد متعدد
			❈│الردود المتعدده 
			❈│اضف امر
			❈│مسح امـر 
			❈│الاوامــــر المضافـــــه
			❈╽مسح الاوامر المضافه
			┄─┅═ـ═┅─┄
			❈│ للاستفسار 📧↭ ]]..SUDO_USER
	  keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help3@(.*)') then
		local users = Text:match('/help3@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			¹↫《اوامر حمايـة المجموعه》
			┄─┅═ـ═┅─┄     
			 ❈╿قفل «» فتح ⇣
			 ❈│الكـــــــل
			 ❈│التـــــــاك
			 ❈│الفيـديـــو
			 ❈│الصــــــور
			 ❈│الملصقات
			 ❈│المتحركه
			 ❈│الميـــــديا
			 ❈│البصمــات
			 ❈│الدردشـــه
			 ❈│الــروابـــط
			 ❈│البـــوتــات
			 ❈│التعــديــل
			 ❈│تعديل الميديا
			 ❈│الفارسيـــه
			 ❈│التفليــش 
			 ❈│الفشــــــار
			 ❈│المعرفــات
			 ❈│الكـــلايـش
			 ❈│التــكـــــرار
			 ❈│الجــهــــات
			 ❈│الانــلايـــن
			 ❈│التوجيــــه
			 ❈│الدخول بالرابط
			 ❈╽البوتات بالطــرد
			┄─┅═ـ═┅─┄     
			²↫❬القفل بالتقييـد❭
			┄─┅═ـ═┅─┄  
			 ❈╿قفل «» فتح  ⇣ 
			 ❈│الصــور بالتقييـــد
			 ❈│الروابـــط بالتقييد
			 ❈│المتحركه بالتقييد
			 ❈│الفيديــــو بالتقييد
			 ❈╽التوجيـــه بالتقييد
			┄─┅═ـ═┅─┄
			 ❈│للاستفسار 📧↭ ]]..SUDO_USER
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help4@(.*)') then
		local users = Text:match('/help4@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[↫《اوامر الخدمــه》
   ┄─┅═ـ═┅─┄
    ❈╿ايـدي 
    ❈│ايديي
    ❈│ايدي بالرد 
    ❈│الرابط 
    ❈│جهاتي 
    ❈│الالعاب 
    ❈│تــــــاك 
    ❈│تاك عام & all@ 
    ❈│تاك للكل
    ❈│مسح + العدد
    ❈│منع + الكلمــه 
    ❈│الغاء منع + الكلمه
    ❈│قول + الكلمه  
    ❈│انطق + الكلمه
    ❈│نقاطي
    ❈│بيع نقاطي + العدد 
    ❈│اضف رسائل+العدد~بالرد
    ❈│اضف نقــاط+العدد~بالرد 
    ❈│اضف سحكات+العدد~بالرد 
    ❈│سحكاتـي 
    ❈│مسح سحكاتي
    ❈│رتبتــــــي
    ❈│موقعــــي
    ❈│صلاحياتي
    ❈│صلاحياته بالرد
    ❈│معلوماتي 
    ❈│الســورس  
    ❈│الرتبه بالرد 
    ❈│التفاعل بالرد ~ بالمعرف 
    ❈│كشف بالـــرد ~ بالمعرف 
    ❈│كشف البوتات
    ❈│طــرد البوتات 
    ❈│طرد المحذوفين 
    ❈│رابـــــط الحذف 
    ❈│زخرفه، زخرفه 2، زخرفه 3 
    ❈│تحويل الصيغ
    ❈│الابراج 
    ❈│همسه
    ❈│اطربنه 
    ❈│غنيلي 
    ❈│بحث + اسم الاغنيه
    ❈│اضف صوت
    ❈│مسح صوت
    ❈│الصوتيات
    ❈│مسح الصوتيات  
    ❈╽الصوتيات العامه 
   ┄─┅═ـ═┅─┄
   ❈│للاستفسار 📧↭ ]]..SUDO_USER
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help5@(.*)') then
		local users = Text:match('/help5@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			↫‌‌‏《اوامر التحشيش》
   ❈│تفعيل تعطيل التحشيش؛
     ┄─┅═ـ═┅─┄
   ❈╿رفع «» تنزيل ⇣
   ❈│تـــــاج
   ❈│مـــلـك
   ❈│مـــلـكه
   ❈│مرتــي 
   ❈│غبـــي 
   ❈╽بقلبي ~ من قلبي
     ┄─┅═ـ═┅─┄
   ❈╿الامـر ⇣  ~ مسح + الامـر ⇣ 
   ❈│قائمه التاج
   ❈│المـلـــوك
   ❈│المـلـكات
   ❈│الزوجات
   ❈│الاغبيــاء
   ❈╽قائمـه قلبي
     ┄─┅═ـ═┅─┄
   ❈╿نسبه الحب/ الكره
   ❈│نسبه الرجوله/ الانوثه 
   ❈╽نسبه الذكـــــاء/ الغباء 
     ┄─┅═ـ═┅─┄
   ❈╿الاوامــر بالـــرد  ⇣ 
   ❈│زواج ~ طلاق 
   ❈│شنو رايك بهذا 
   ❈│شنو رايك بهاي 
   ❈│انطي هديه
   ❈│بوسـه
   ❈│صيحه
     ┄─┅═ـ═┅─┄
			❈│للاستفسار 📧↭ ]]..SUDO_USER
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
elseif Text and Text:match('/helpgames@(.*)') then
		local users = Text:match('/helpgames@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
local Teext = [[
	❈│ تفعـيل ~ تعطيل الالعاب
	┄─┅═ـ═┅─┄
	❈╿امثله ༜ امثله قديمه
	❈│معاني ༜ معاني السمايلات 
	❈│اسألني ༜ اسئله عامه متجدده
	❈│لغز ༜ الغاز الذكاء متجدده
	❈│اسئله ༜ اسئله منوعه
	❈│الروليت ༜ الروليت بالانضمام 
	❈│روليت ༜ الروليت بالمعرفات
	❈│حزوره ༜ حزورات منوعه
	❈│ترتيب ༜ ترتيب الكلمات
	❈│العكس ༜ عكس الكلمه
	❈│تخمين ༜ تخمين الكلمه 
	❈│الاسرع ༜ اسرع واحد 
	❈│بات ༜ لعبة شفافه
	❈│محيبس ༜ محيبس الشهيره
	❈│موسيقى ༜ معرفة اسم الاغنيه 
	❈│المختلف ༜ اختلاف السمايل
	❈│رياضيات ༜ مسائل رياضيه 
	❈│انكليزي ༜ معاني الكلمات 
	❈╽كت تويت ༜ اسئله ترفيهيه 
	┄─┅═ـ═┅─┄
	❈ │لمزيد من المعلومات 📧
	❈ │الـمـطـور : ]]..SUDO_USER
keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
end

		elseif Text and Text:match('/help6@(.*)') then
		local users = Text:match('/help6@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[↫《 اوامر التعطيل و التفعيل》
   ┄─┅═ـ═┅─┄
    ❈╿تفعيل «» تعطيل ⇣
    ❈│الرفــع 
    ❈│الحظر
    ❈│الرابط
    ❈│اطردني 
    ❈│اليوتيوب 
    ❈│تاك عام
    ❈│الردود
    ❈│الردود العامه 
    ❈│الالعـاب
    ❈│الصوتيات 
    ❈│الصوتيات العامه 
    ❈│قــــول
    ❈│انطـــق
    ❈│غنيلي 
    ❈│الابراج
    ❈│التحذير 
    ❈│الترحيب 
    ❈│الصيغ 
    ❈│الايدي 
    ❈│التحشيش 
    ❈╽الايدي بالصوره
   ┄─┅═ـ═┅─┄
    ❈│للاستفسار 📧↭ ]]..SUDO_USER
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help7@(.*)') then
		local users = Text:match('/help7@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			↫ 《 اوامر الوضع للمجموعه 》
			┄─┅═ـ═┅─┄
		  ❈╿ضع رابـــــط
		  ❈│ضع اســــــم 
		  ❈│ضع صــــوره
		  ❈│ضع وصــــف
		  ❈│ضع القوانيـن
		  ❈│ضع الترحيب 
		  ❈│ضـــع تكــرار + العــدد 
		  ❈╿ضع لقب + اللقب بالرد 
			┄─┅═ـ═┅─┄
		  ❈│ للاستفسار 📧↭ ]]..SUDO_USER
  keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
{
  {text = 'رجوع ', callback_data="/help@"..data.sender_user_id_},
  },
  }
  return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
		elseif Text and Text:match('/help@(.*)') then
		local users = Text:match('/help@(.*)')
		if tonumber(users) == tonumber(data.sender_user_id_) then
		local Teext = [[
			↫‌‌‏《مـسـارت الاوامـر العامـه》 ⇊
			┄─┅═ـ═┅─┄
			❈╿م1 » اوامـر الاداره
			❈│م2 » اعدادات المـجمـوعه
			❈│م3 » اوامـر الحمـايه
			❈│م4 » اوامـر الخدمــه 
			❈│م5 » اوامر التحشيش
			❈│م6 » التعطيل و التفعيل
			❈│م7 »  الوضع للمجموعه
			❈│الحمايه » اعدادات الحمايه
			❈│الوسائط» اعدادات الوسائط 
			❈│الاعدادات» اعدادات المجموعه
			❈│الالعـــاب »  العاب البوت
			❈│السورس » سورس البوت
			❈╽المطـــور » مطــور البـــوت
			❈│م المطور » اوامـر المـطـور
			┄─┅═ـ═┅─┄
			❈│ للاستفسار 📧↭ ]]..SUDO_USER
		keyboard = {} 
  keyboard.inline_keyboard = {
      
  {
  {text = '⓵', callback_data="/help1@"..data.sender_user_id_},{text = '⓶', callback_data="/help2@"..data.sender_user_id_},{text = '⓷', callback_data="/help3@"..data.sender_user_id_},
  },
  {
  {text = '⓸', callback_data="/help4@"..data.sender_user_id_},{text = '⓹', callback_data="/help5@"..data.sender_user_id_},
  },
  {
  {text = '⓺', callback_data="/help6@"..data.sender_user_id_},{text = '⓻', callback_data="/help7@"..data.sender_user_id_},
  },
{
{text = 'الالعاب -', callback_data="/helpgames@"..data.sender_user_id_},
},
  }
		
		return https.request(ApiToken..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
	  else
		answerCallbackQuery(data.id_,'قائمة الاوامر ليست لك', true)
	  end
	  end
		end
			local msg = data.message_
		
		
	  
		  if data.ID == "UpdateMessageSendFailed" then 
		  
		  elseif data.ID == "UpdateMessageSendSucceeded" then
		  if Refresh_Start then
		  Refresh_Start = false
		  Start_Bot()
		  return false
		  end
		  if UpdateSourceStart then
		  UpdateSourceStart = false
		  EditMsg(data.message_.chat_id_,data.message_.id_,'10% - |█          |')
		  EditMsg(data.message_.chat_id_,data.message_.id_,'20% - |███         |')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Run.lua','./inc/Run.lua')
		  EditMsg(data.message_.chat_id_,data.message_.id_,'40% - |█████       |')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/locks.lua','./inc/locks.lua')
		  EditMsg(data.message_.chat_id_,data.message_.id_,'60% - |███████     |')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Script.lua','./inc/Script.lua')
		  EditMsg(data.message_.chat_id_,data.message_.id_,'80% - |█████████   |')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/functions.lua','./inc/functions.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/plugins/zhrfa.lua','./plugins/zhrfa.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/plugins/games.lua','./plugins/games.lua')
		  EditMsg(data.message_.chat_id_,data.message_.id_,'100% - |█████████████|\n\n🔝*¦* السورس الى اصدار \n📟*¦* تم اعاده تشغيل السورس بنجاح')
		  dofile("./inc/Run.lua")
		  print("Update Source And Reload ~ ./inc/Run.lua")
		  end
		  elseif data.ID == "UpdateNewMessage" then
	  
		  if msg.content_.ID == "MessageText" and not msg.forward_info_ then
		  if msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID then
		  if msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
		  msg.textEntityTypeTextUrl = true
		  print("MessageEntityTextUrl")
		  elseif msg.content_.entities_[0].ID == "MessageEntityBold" then 
		  msg.textEntityTypeBold = true
		  elseif msg.content_.entities_[0].ID == "MessageEntityItalic" then
		  msg.textEntityTypeItalic = true
		  print("MessageEntityItalic")
		  elseif msg.content_.entities_[0].ID == "MessageEntityCode" then
		  msg.textEntityTypeCode = true
		  print("MessageEntityCode")
		  end
		  end
		  msg.text = msg.content_.text_
		  Mohammad = msg.text
		if redis:get(mero..'del:sendamr:'..msg.chat_id_..msg.sender_user_id_) == 'true' then
if msg.text then
if not redis:sismember(mero..'CmDlist:'..msg.chat_id_,msg.text) then
redis:del(mero..'del:sendamr:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'لا يوجد امر بهذا الاسم')
end
redis:hdel(mero..'CmD:'..msg.chat_id_,msg.text)
redis:srem(mero..'CmDlist:'..msg.chat_id_,msg.text)
redis:del(mero..'del:sendamr:'..msg.chat_id_..msg.sender_user_id_)
end
return sendMsg(msg.chat_id_,msg.id_,'تم مسح الامر بنجاح')
end
	  if Mohammad then
	  if redis:sismember(mero..'CmDlist:'..msg.chat_id_,Mohammad) then
	  mmdi = redis:hget(mero..'CmD:'..msg.chat_id_,Mohammad)
	  msg.text = Mohammad:gsub(Mohammad,mmdi)
	  end
	  end
	if redis:get(mero..'sendamr:'..msg.chat_id_..msg.sender_user_id_) == 'true' then
if msg.text then
redis:setex(mero..'addcmd'..msg.chat_id_..msg.sender_user_id_,120,msg.text)
redis:del(mero..'sendamr:'..msg.chat_id_..msg.sender_user_id_)
end
return sendMsg(msg.chat_id_,msg.id_,'❈╿اهلا بك عزيزي\n❈│الامر الي تريد تغيره الي  >'..msg.text..'< \n❈╽ارسله الان\n✓ ')
end


		  if (msg.text=="تحديث" or msg.text=="we" or msg.text=="تحديث ❈") and msg.sender_user_id_ == SUDO_ID then
		  return sendMsg(msg.chat_id_,msg.id_," ❈┇تہ‏‏م تحديث المـلفات \n✓",nil,function(arg,data)
		  Refresh_Start = true
		  end)
		  end 
		  if msg.text== 'Update Source' and msg.sender_user_id_ == SUDO_ID then
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Run.lua','./inc/Run.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Script.lua','./inc/Script.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/functions.lua','./inc/functions.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/locks.lua','./inc/locks.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/plugins/zhrfa.lua','./plugins/zhrfa.lua')
		  download_file('https://raw.githubusercontent.com/VivazAli/Vivaz/main/plugins/games.lua','./plugins/games.lua')
		  sendMsg(msg.chat_id_,msg.id_,'❈| {* تــم تحديث وتثبيت السورس  *} ❈.\n\n❈| { Bot is Update » }❈',nil,function(arg,data)
		  dofile("./inc/Run.lua")
		  print("Reload ~ ./inc/Run.lua")
		  end) 
		  end
		  if msg.text and msg.text:match('@(.*)') and redis:get('setusername'..msg.sender_user_id_) then
		  redis:del('setusername'..msg.sender_user_id_)
		  mmd = redis:get(mero..":SUDO_ID:")
	  redis:hset(mero..'username:'..tonumber(mmd),'username',msg.text)
		  send_msg(msg.chat_id_,"❈│عزيزي تم تغيير المطور الاساسي بنجاح الان ارسل reload ...🍂")
		  end
		  if msg.text and msg.text:match('(%d+)(%d+)(%d+)(%d+)') and redis:get('setid'..msg.sender_user_id_) then
		  redis:setex('setusername'..msg.sender_user_id_,120,true)
		  redis:del('setid'..msg.sender_user_id_)
		  redis:set(mero..":SUDO_ID:",msg.text)
	  send_msg(msg.chat_id_,"❈│تم تثبيت الايدي الان قم برسال معرف المطور ❈ @UserName ...")
		  end
		  if msg.text== 'تغير المطور الاساسي' and msg.sender_user_id_ == SUDO_ID then
		  send_msg(msg.chat_id_,"❈│عزيزي قم برسال ايدي المطور ...🍂")
	  redis:setex('setid'..msg.sender_user_id_,120,true)
	  end
		  
	
if msg.text and msg.text:match('^بحث (.*)$') and not redis:get(mero..'dw:bot:api'..msg.chat_id_) then            
local Ttext = msg.text:match('^بحث (.*)$') 
local msgin = msg.id_/2097152/0.5 
https.request('https://devstorm.ml/mero/tahaj200.php?token='..Token..'&chat_id='..msg.chat_id_..'&Text='..URL.escape(Ttext)..'&msg='..msgin..'&user='..msg.sender_user_id_)
end

		  if msg.text== 'reload' and msg.sender_user_id_ == SUDO_ID then
		  sendMsg(msg.chat_id_,msg.id_,'❈| {* تــم أعـاده تشغيل البوت  *} ❈.\n\n❈| { Bot is Reloaded » }❈',nil,function(arg,data)
		  dofile("./inc/Run.lua")
		  print("Reload ~ ./inc/Run.lua")
		  end)
		  return false
		  end
		  elseif msg.content_.ID == "MessagePinMessage" then
		  print('¦'..msg.content_.ID)
		  msg.pinned = true
		  elseif msg.forward_info_ then
			 msg.forward_info = true 
		  print('¦'.." IS_FWD : Msg .")
		  elseif msg.content_.ID == "MessagePhoto" then
		  print('¦'..msg.content_.ID)
		  msg.photo = true 
		  if msg.content_.photo_.sizes_[3] then 
		  photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
		  else 
		  photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
		  end
	  
	  if msg.content_.photo_.sizes_[2] == '' then
	  ph = msg.content_.photo_.sizes_[2].photo_.id_
	  else
	  ph = msg.content_.photo_.sizes_[1].photo_.id_
	  end
	  download(ph,32)
		  elseif msg.content_.ID == "MessageVideo" then
		  print('¦'..msg.content_.ID)
		  msg.video = true
		  video_id = msg.content_.video_.video_.persistent_id_
		  elseif msg.content_.ID == "MessageAnimation" then
		  print('¦'..msg.content_.ID)
		  msg.animation = true
		  animation_id = msg.content_.animation_.animation_.persistent_id_
		  elseif msg.content_.ID == "MessageVoice" then
		  print('¦'..msg.content_.ID)
		  msg.voice = true
		  voice_id = msg.content_.voice_.voice_.persistent_id_
		  elseif msg.content_.ID == "MessageAudio" then
		  print('¦'..msg.content_.ID)
		  msg.audio = true
		  audio_id = msg.content_.audio_.audio_.persistent_id_
		  elseif msg.content_.ID == "MessageSticker" then
		  print('¦'..msg.content_.ID)
		  msg.sticker = true
		  sticker_id = msg.content_.sticker_.sticker_.persistent_id_
	  
	  stk = msg.content_.sticker_.sticker_.id_
	  download(stk,32)
	  
		  elseif msg.content_.ID == "MessageContact" then
		  print('¦'..msg.content_.ID)
		  msg.contact = true
		  elseif msg.content_.ID == "MessageDocument" then
		  print('¦'..msg.content_.ID)
		  msg.document = true
		  file_id = msg.content_.document_.document_.persistent_id_
		  file_name = msg.content_.document_.document_.file_name_
		  elseif msg.content_.ID == "MessageLocation" then
		  print('¦'..msg.content_.ID)
		  msg.location = true
		  elseif msg.content_.ID == "MessageGame" then
		  print('¦'..msg.content_.ID)
		  msg.game = true
		  elseif msg.content_.ID == "MessageChatDeleteMember" then
		  if redis:get(mero..'mute_tgservice'..msg.chat_id_) then
		  Del_msg(msg.chat_id_,msg.id_)
		  end
		  elseif msg.content_.ID == "MessageChatAddMembers" then
		  if redis:get(mero..'group:add'..msg.chat_id_) and (msg.sender_user_id_ == SUDO_ID or redis:sismember(mero..':SUDO_BOT:',msg.sender_user_id_) or redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,msg.sender_user_id_) or redis:sismember(mero..'owners:'..msg.chat_id_,msg.sender_user_id_) or redis:sismember(mero..'admins:'..msg.chat_id_,msg.sender_user_id_)) then 
		  msg.Admin = true
		  end
		  local lock_bots = redis:get(mero..'lock_bots'..msg.chat_id_)
		  ISBOT = false
		  ZISBOT = false
		  for i=0,#msg.content_.members_ do
		  if msg.content_.members_[i].type_.ID == "UserTypeBot" then
		  ISBOT = true
		  if not msg.Admin and lock_bots then 
		  ZISBOT =true
		  kick_user(msg.content_.members_[i].id_, msg.chat_id_)
		  end
		  end
		  end
		  if redis:get(mero..'mute_tgservice'..msg.chat_id_) then
		  Del_msg(msg.chat_id_,msg.id_)
		  end
		  if ZISBOT and redis:get(mero..'lock_bots_by_kick'..msg.chat_id_) then
		  kick_user(msg.sender_user_id_, msg.chat_id_)
		  end
	  
		  if not ISBOT then
		  msg.adduser = msg.content_.members_[0].id_
		  msg.addusername = msg.content_.members_[0].username_
		  msg.addname = msg.content_.members_[0].first_name_
		  msg.adduserType = msg.content_.members_[0].type_.ID
		  end
	  
		  elseif msg.content_.ID == "MessageChatJoinByLink" then
	  if redis:get(mero..'lock:join:'..msg.chat_id_) then
	  kick_user(msg.sender_user_id_,msg.chat_id_)
		  print('¦'..msg.content_.ID..' : '..msg.sender_user_id_)
		  msg.joinuser = true
	  end
		  elseif msg.reply_markup and  msg.reply_markup.ID == "replyMarkupInlineKeyboard" then
		  msg.replyMarkupInlineKeyboard = true
		  end 
		  input_inFo(msg)
		  if msg.content_.ID == "MessageChatChangeTitle" then
		  print("¦ messageChatChangeTitle : { "..msg.content_.title_.." } ")
		  if redis:get(mero..'group:add'..msg.chat_id_) then
		  redis:set(mero..'group:name'..msg.chat_id_,msg.content_.title_)
		  end
		  end 
		  
		  elseif data.ID == "UpdateNewChat" then  
		  if redis:get(mero..'group:add'..data.chat_.id_) then
		  redis:set(mero..'group:name'..data.chat_.id_,data.chat_.title_)
		  end
		  elseif data.ID == "UpdateChannel" then  
		  if data.channel_.status_.ID == "chatMemberStatusKicked" then 
		  elseif data.channel_.status_.ID == "ChatMemberStatusMember" then 
		  print('¦ The bot is Member')
		  elseif data.channel_.status_.ID == "ChatMemberStatusEditor" then 
		  print('¦ The Bot is Admin')
		  elseif data.channel_.status_.ID == "ChatMemberStatusKicked" then 
		  if redis:get(mero..'group:add-100'..data.channel_.id_) then
		  local linkGroup = (redis:get(mero..'linkGroup-100'..data.channel_.id_) or "")
		  local NameGroup = (redis:get(mero..'group:name-100'..data.channel_.id_) or "")
		  send_msg(SUDO_ID,"❈┇قام شخص بطرد البوت من المجموعه الاتيه : \n❈┇ألايدي : `-100"..data.channel_.id_.."`\n❈┇الـمجموعه : "..Flter_Markdown(NameGroup).."\n\n❈┇تـم مسح كل بيانات المجموعه بنـجاح ")
		  rem_data_group('-100'..data.channel_.id_)
		  end
		  end
		  elseif data.ID == "UpdateFile" then 
		  if Uploaded_Groups_Ok then
		  Uploaded_Groups_Ok = false
		  local GetInfo = io.open(data.file_.path_, "r"):read('*a')
		  local All_Groups = JSON.decode(GetInfo)
		  for k,IDS in pairs(All_Groups.Groups) do
		  redis:mset(
		  mero..'group:name'..k,IDS.Title,
		  mero..'num_msg_mero'..k,5,
		  mero..'group:add'..k,true,
		  mero..'lock_link'..k,true,
		  mero..'lock_spam'..k,true,
		  mero..'lock_webpage'..k,true,
		  mero..'lock_markdown'..k,true,
		  mero..'lock_flood'..k,true,
		  mero..'lock_bots'..k,true,
		  mero..'mute_forward'..k,true,
		  mero..'mute_contact'..k,true,
		  mero..'mute_document'..k,true,
		  mero..'mute_inline'..k,true,
		  mero..'lock_username'..k,true,
		  mero..'replay'..k,true
		  )
		  redis:sadd(mero..'group:ids',k) 
	  
		  if IDS.Admins then
		  for user,ID in pairs(IDS.Admins) do
		  redis:hset(mero..'username:'..ID,'username',user)
		  redis:sadd(mero..'admins:'..k,ID)
		  end
		  end
		  if IDS.Creator then
		  for user,ID in pairs(IDS.Creator) do
		  redis:hset(mero..'username:'..ID,'username',user)
		  redis:sadd(mero..':MONSHA_BOT:'..k,ID)
		  end
		  end
		  if IDS.Owner then
		  for user,ID in pairs(IDS.Owner) do
		  redis:hset(mero..'username:'..ID,'username',user)
		  redis:sadd(mero..'owners:'..k,ID)
		  end
		  end
		  end
		  io.popen("rm -fr ../.telegram-cli/data/document/*")
		  sendMsg(Uploaded_Groups_CH,Uploaded_Groups_MS,'❈*¦* تم رفع النسخة الاحتياطية\n❈*¦* حاليا عدد مـجمـوعاتك هي *'..redis:scard(mero..'group:ids')..'*❈\n✓')
		  end
		  elseif data.ID == "UpdateUser" then  
		  if data.user_.type_.ID == "UserTypeDeleted" then
		  print("¦ userTypeDeleted")
		  redis:srem(mero..'users',data.user_.id_)
		  elseif data.user_.type_.ID == "UserTypeGeneral" then
		  local CheckUser = redis:hgetall(mero..'username:'..data.user_.id_).username
		  if data.user_.username_  then 
		  USERNAME = '@'..data.user_.username_:gsub('_',[[\_]])
		  else
		  USERNAME = data.user_.first_name_..' '..(data.user_.last_name_ or "" )
		  end	
		  if CheckUser and CheckUser ~= USERNAME  then
		  print("¦ Enter Update User ")
		  redis:hset(mero..'username:'..data.user_.id_,'username',USERNAME)
		  end 
		  end
		  elseif data.ID == "UpdateMessageEdited" then
		  GetMsgInfo(data.chat_id_,data.message_id_,function(arg,data)
		  msg = data
		  msg.edited = true
		  data.text = (data.content_.text_ or false)
		  input_inFo(msg)  
		  end,nil)
		  elseif data.ID == "UpdateOption" and data.value_.value_ == "Ready" then
		  print(" ||  ------------------------[ Loading For loding list Chat ]--------------------- ||")
		  local groups = redis:smembers(mero..'group:ids')
		  local GroupsIsFound = 0
		  for i = 1, #groups do 
		  GroupTitle(groups[i],function(arg,data)
		  if data.code_ and data.code_ == 400 then
		  rem_data_group(groups[i])
		  print(" Del Group From list ")
		  else
		  if data.type_ and data.type_.channel_ 
		  and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
		  StatusLeft(groups[i],our_id)
		  rem_data_group(groups[i])
		  print(" Del Group From list ")
		  end
		  print(" Name Group : "..data.title_)
		  GroupsIsFound = GroupsIsFound + 1
		  end
		  print(GroupsIsFound..' : '..#groups..' : '..i)
		  if #groups == i then
		  
		  local pv = redis:smembers(mero..'users')
		  local NumPvDel = 0
		  for i = 1, #pv do
		  GroupTitle(pv[i],function(arg,data)
		  NumPvDel = NumPvDel + 1
		  print("Geting Ok : "..NumPvDel)
		  end)
		  end
		  
		  end
		  end)
		  end
		  
	  
		  end
		  
		  
	  end
	  