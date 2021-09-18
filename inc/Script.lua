--[[

]]
   function Get_Info(msg,chat,user) --// ارسال نتيجة الصلاحيه
   print('&&')
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
return sendMsg(msg.chat_id_,msg.id_,'✿│صلاحياته منشئ الكروب\n✿')   
end 
if Json_Info.result.status == "member" then
return sendMsg(msg.chat_id_,msg.id_,'✿│مجرد عضو هنا\n✿')   
end 
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end
if Json_Info.result.can_manage_voice_chats == true then
voice = 'ꪜ' 
else 
voice = '✘' 
end
if Json_Info.result.can_manage_chat == true then
manage = 'ꪜ' 
else 
manage = '✘' 
end
return sendMsg(chat,msg.id_,'✿╿الرتبة : مشرف ✿\n✿╽والصلاحيات هي ⇓ \nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n✿╿تغير معلومات المجموعه ↞ ❪ '..info..' ❫\n✿│حذف الرسائل ↞ ❪ '..delete..' ❫\n✿│حظر المستخدمين ↞ ❪ '..restrict..' ❫\n✿│دعوة المستخدمين ↞ ❪ '..invite..' ❫\n✿│تثبيت الرسائل ↞ ❪ '..pin..' ❫\n✿│اضافة مشرفين جدد ↞ ❪ '..promote..' ❫\n✿│المكالمات الصوتيه ↞ ❪ '..voice..' ❫\n✿│الوضع التخفي ↞ ❪ '..manage..' ❫\n\n✿╽ملاحضه » علامة ❪  ꪜ ❫ تعني لديه الصلاحية وعلامة ❪ ✘ ❫ تعني ليس لديه الصلاحيه')   
end
end
end

function download_to_file(url, file_name)
  -- print to server
  -- print("url to download: "..url)
  -- uncomment if needed
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }

  -- nil, code, headers, status
  local response = nil

  if url:starts('https') then
    options.redirect = false
    response = {https.request(options)}
  else
    response = {http.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_name = file_name or get_http_file_name(url, headers)

  local file_path = "data/"..file_name
  -- print("Saved to: "..file_path)
	-- uncomment if needed
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()

  return file_path
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
function run_command(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end
function string:isempty()
  return self == nil or self == ''
end

-- Returns true if the string is blank
function string:isblank()
  self = self:trim()
  return self:isempty()
end

-- DEPRECATED!!!!!
function string.starts(String, Start)
  -- print("string.starts(String, Start) is DEPRECATED use string:starts(text) instead")
  -- uncomment if needed
  return Start == string.sub(String,1,string.len(Start))
end

-- Returns true if String starts with Start
function string:starts(text)
  return text == string.sub(self,1,string.len(text))
end

local getUser = function(user_id,cb)
tdcli_function({ID = "GetUser",user_id_ = user_id},cb,nil)
end

Bot_Api = 'https://api.telegram.org/bot'.. Token
function send_inline(chat_id,text,keyboard,markdown)
local url = Bot_Api
if keyboard then
url = url .. '/sendMessage?chat_id=' ..chat_id.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard))
else
url = url .. '/sendMessage?chat_id=' ..chat_id.. '&text='..URL.escape(text)..'&parse_mode=HTML'
end
if markdown == 'md' or markdown == 'markdown' then
url = url..'&parse_mode=Markdown'
elseif markdown == 'html' then
url = url..'&parse_mode=HTML'
end
return https.request(url)
end








function lock_photos(msg)
if not msg.Director then 
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
redis:set(mero.."getidstatus"..msg.chat_id_, "Simple")
return  "✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تعطيل الايدي بالصوره  \n✓" 
end 
function unlock_photos(msg)
if not msg.Director then
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
redis:set(mero.."getidstatus"..msg.chat_id_, "Photo")
return  "✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تفعيل الايدي بالصوره \n✓" 
end
function cmds_on(msg)
if not msg.Creator then return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n🚶"
end
redis:set(mero..'lock:kara:'..msg.chat_id_,'on')
return "✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تعطيل الرفع في المجموعه \n✓"
end
function cmds_off(msg)
if not msg.Creator then return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n🚶"
end
redis:set(mero..'lock:kara:'..msg.chat_id_,'off')
return "✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تفعيل الرفع في المجموعه \n✓"
end

function lockjoin(msg)
if not msg.Admin then return "✿*│* هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n🚶"
end
redis:set(mero..'lock:join:'..msg.chat_id_,true)
return "*✿*╿* أهلا عزيزي *"..msg.TheRankCmd.."*\n✿*╽* تم قفل الدخول بالرابط \n✓*" 

end
function unlockjoin(msg)
if not msg.Admin then return "✿*│* هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n🚶"
end
redis:del(mero..'lock:join:'..msg.chat_id_)
return "*✿*╿* أهلا عزيزي *"..msg.TheRankCmd.."*\n✿*╽* تم فتح الدخول بالرابط \n✓*" 
end
function mute_usaet(msg) 
if not msg.Director then 
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
if redis:get(mero..'mute_usaet'..msg.chat_id_) then
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*الميديا بالتأكيد تم قفلها \n✓'
else
redis:set(mero..'mute_usaet'..msg.chat_id_,true)
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*تم قفل الميديا \n✓'
end
end

function unmute_usaet(msg)
if not msg.Director then 
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
if not redis:get(mero..'mute_usaet'..msg.chat_id_)then
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*الميديا بالتأكيد تم فتحها \n✓'
else 
redis:del(mero..'mute_usaet'..msg.chat_id_)
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*تم فتح الميديا \n✓'
end
end
function mute_usaet1(msg) 
if not msg.Director then 
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
if redis:get(mero..'mute_tflesh'..msg.chat_id_) then
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*التفليش بالتأكيد تم قفله \n✓'
else
redis:set(mero..'mute_tflesh'..msg.chat_id_,true)
redis:set(mero.."lock_edit_media"..msg.chat_id_,true)
redis:set(mero.."getidstatus"..msg.chat_id_, "Simple")
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*تم قفل التفليش \n✓'
end
end

function unmute_usaet1(msg)
if not msg.Director then 
return "✿*│* هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n🚶"
end
if not redis:get(mero..'mute_tflesh'..msg.chat_id_)then
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*التفليش بالتأكيد تم فتحه \n✓'
else 
redis:del(mero..'mute_tflesh'..msg.chat_id_)
redis:set(mero.."getidstatus"..msg.chat_id_, "Photo")
return '✿*╿*أهلا عزيزي '..msg.TheRankCmd..'\n✿*╽*تم فتح التفليش \n✓'
end
end
function is_JoinChannel(msg)
statusjoin = true
if not redis:sismember(mero..'BotFree:Group:',msg.chat_id_) then
Channel = redis:get(mero..":UserNameChaneel")
if Channel then
local url  = https.request('https://api.telegram.org/bot'..Token..'/getchatmember?chat_id=@'..Channel:gsub("@","")..'&user_id='..msg.sender_user_id_)
if res ~= 200 then
end
Joinchanel = json:decode(url)
if not GeneralBanned((msg.adduser or msg.sender_user_id_)) and (not Joinchanel.ok or Joinchanel.result.status == "left" or Joinchanel.result.status == "kicked") then
statusjoin = false
function name(arg,data)
bd = '✿╿اسمك  ('..(data.first_name_ or '')..')\n✿╽معرفك (@'..(data.username_ or '')..')\n\n✿╽اشتراك بالقناة اولا \n✿╽ثم ارجع استخدم الامر.'
local keyboard = {}
keyboard.inline_keyboard = {{
{text = 'اشتراك بالقناة ✿',url='https://telegram.me/'..Channel:gsub("@","")}}}   
send_inline(msg.chat_id_,bd,keyboard,'html')
end
getUser(msg.sender_user_id_,name)
else
end
else
end
end
return statusjoin
end

local function imero(msg,MsgText) 


--JoinChannel


if msg.type ~= 'pv' then

if MsgText[1] == "تفعيل" and not MsgText[2] then
if not msg.SudoUser and redis:sismember(mero..'Black:listBan:',msg.chat_id_) then
return 'المجموعه تم حظرها من قبل مطور البوت '
end 
redis:set(mero.."getidstatus"..msg.chat_id_, "Photo")
redis:set(mero..'lock:kara:'..msg.chat_id_,'off')
redis:set(mero.."brj_Bots"..msg.chat_id_,"close")
redis:del(mero..'mute_tflesh'..msg.chat_id_)
redis:set(mero..'replayallbot'..msg.chat_id_,true)
return modadd(msg)  
end
if is_JoinChannel(msg) == false then
      return false
      end
if MsgText[1] == "تعطيل" and not MsgText[2] then
return modrem(msg) 
end


if MsgText[1] == "تعطيل التحشيش" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero..'amrthshesh'..msg.chat_id_)  then
return '✿| تم تعطيل التحشيش مسبقا'
else
redis:set(mero.."amrthshesh"..msg.chat_id_,"true")
return '✿| تم تعطيل التحشيش'
end
end
if MsgText[1] == "تفعيل التحشيش" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not redis:get(mero..'amrthshesh'..msg.chat_id_)  then
return '✿| تم تفعيل التحشيش مسبقا'
else
redis:del(mero.."amrthshesh"..msg.chat_id_)
return '✿| تم تفعيل التحشيش'
end
end


if MsgText[1] == "تعطيل الطرد" or MsgText[1] == "تعطيل الحظر" then
if not msg.Kara then return "✿*│*هذا الامر يخص {المنشئ الاساسي,المالك,المطور,المطور الاساسي} فقط  \n✿" end
if redis:get(mero..'Ban:Cheking'..msg.chat_id_)  then
return '✿| تم تعطيل امر الحظر - الطرد مسبقا'
else
redis:set(mero.."Ban:Cheking"..msg.chat_id_,"true")
return '✿| تم تعطيل امر الحظر - الطرد'
end
end
if MsgText[1] == "تفعيل الطرد" or MsgText[1] == "تفعيل الحظر" then
if not msg.Kara then return "✿│هذا الامر يخص\n{المنشئ الاساسي,المالك,المطور} فقط  \n✿" end
if not redis:get(mero..'Ban:Cheking'..msg.chat_id_)  then
return '✿| تم تفعيل امر الحظر - الطرد مسبقا'
else
redis:del(mero.."Ban:Cheking"..msg.chat_id_)
return '✿| تم تفعيل امر الحظر - الطرد'
end
end

if MsgText[1] == 'مسح امر' then
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n✿" end
redis:set(mero..'del:sendamr:'..msg.chat_id_..msg.sender_user_id_,true)
return 'ارسل الامر الذي وضعته بدلا عن القديم'
end
if MsgText[1] == 'اضف امر' then
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n✿" end
redis:set(mero..'sendamr:'..msg.chat_id_..msg.sender_user_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'ارسل الامر القديم الان')
end

if MsgText[1] == "قفل الميديا" and not MsgText[2] then
return mute_usaet(msg)  
end
if MsgText[1] == "فتح الميديا" and not MsgText[2] then
return unmute_usaet(msg) 
end

if MsgText[1] == "قفل التفليش" and not MsgText[2] then
return mute_usaet1(msg)  
end
if MsgText[1] == "فتح التفليش" and not MsgText[2] then
return unmute_usaet1(msg) 
end



if MsgText[1] == "تفعيل الايدي بالصوره" and not MsgText[2] then
return unlock_photos(msg)  
end
if MsgText[1] == "تعطيل الايدي بالصوره" and not MsgText[2] then
return lock_photos(msg) 
end
if MsgText[1] == "تعطيل الرفع" and not MsgText[2] then
return cmds_on(msg)  
end
if MsgText[1] == "تفعيل الرفع" and not MsgText[2] then
return cmds_off(msg) 
end

if MsgText[1] == "قفل الدخول بالرابط" and not MsgText[2] then
return lockjoin(msg)  
end
if MsgText[1] == "فتح الدخول بالرابط" and not MsgText[2] then
return unlockjoin(msg) 
end

end


if msg.type ~= 'pv' and msg.GroupActive then 

if MsgText[1] == 'شحن' and MsgText[2] then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if tonumber(MsgText[2]) > 0 and tonumber(MsgText[2]) < 1001 then
local extime = (tonumber(MsgText[2]) * 86400)
redis:setex(mero..'ExpireDate:'..msg.chat_id_, extime, true)
if not redis:get(mero..'CheckExpire::'..msg.chat_id_) then 
redis:set(mero..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍│تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... ✿')
sendMsg(SUDO_ID,0,'💂🏻‍│تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... ✿\n🕵🏼️‍│في مجموعه  » »  '..redis:get(mero..'group:name'..msg.chat_id_))
else
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍│عزيزي المطور \n✿│شحن الاشتراك يكون ما بين يوم الى 1000 يوم فقط ✿')
end 
return false
end

if MsgText[1] == 'الاشتراك' and MsgText[2] then 
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if MsgText[2] == '1' then
redis:setex(mero..'ExpireDate:'..msg.chat_id_, 2592000, true)
if not redis:get(mero..'CheckExpire::'..msg.chat_id_) then 
redis:set(mero..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍│تم تفعيل الاشتراك   ✿\n📆│ الاشتراك » `30 يوم`  *(شهر)*')
sendMsg(SUDO_ID,0,'💂🏻‍│تم تفعيل الاشتراك  ✿\n📆│ الاشتراك » `30 يوم`  *(شهر)*')
end
if MsgText[2] == '2' then
redis:setex(mero..'ExpireDate:'..msg.chat_id_,7776000,true)
if not redis:get(mero..'CheckExpire::'..msg.chat_id_) then 
redis:set(mero..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍│تم تفعيل الاشتراك   ✿\n📆│ الاشتراك » `90 يوم`  *(3 اشهر)*')
sendMsg(SUDO_ID,0,'💂✿‍│تم تفعيل الاشتراك   ✿\n📆│ الاشتراك » `90 يوم`  *(3 اشهر)*')
end
if MsgText[2] == '3' then
redis:set(mero..'ExpireDate:'..msg.chat_id_,true)
if not redis:get(mero..'CheckExpire::'..msg.chat_id_) then 
redis:set(mero..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍│تم تفعيل الاشتراك   ✿\n📆│ الاشتراك » `مفتوح`  *(مدى الحياة)*')
sendMsg(SUDO_ID,0,'💂🏻‍│تم تفعيل الاشتراك   ✿\n📆│ الاشتراك » `مفتوح`  *(مدى الحياه)*')
end 
return false
end


if MsgText[1] == 'الاشتراك' and not MsgText[2] and msg.Admin then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local check_time = redis:ttl(mero..'ExpireDate:'..msg.chat_id_)
if check_time < 0 then return '*مـفـتـوح *✿\n✓' end
year = math.floor(check_time / 31536000)
byear = check_time % 31536000 
month = math.floor(byear / 2592000)
bmonth = byear % 2592000 
day = math.floor(bmonth / 86400)
bday = bmonth % 86400 
hours = math.floor( bday / 3600)
bhours = bday % 3600 
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if tonumber(check_time) > 1 and check_time < 60 then
remained_expire = '💳│`باقي من الاشتراك ` » » * \n 📆│ '..sec..'* ثانيه'
elseif tonumber(check_time) > 60 and check_time < 3600 then
remained_expire = '💳│`باقي من الاشتراك ` » » '..min..' *دقيقه و * *'..sec..'* ثانيه'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
remained_expire = '💳│`باقي من الاشتراك ` » » * \n 📆│ '..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
remained_expire = '💳│`باقي من الاشتراك ` » » * \n 📆│ '..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
remained_expire = '💳│`باقي من الاشتراك ` » » * \n 📆│ '..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 31536000 then
remained_expire = '💳│`باقي من الاشتراك ` » » * \n 📆│ '..year..'* سنه و *'..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه' end
return remained_expire
end
 
if MsgText[1] == 'مسح صوت' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
redis:set(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'startdel')
return '✿*│* ارسل اسم الصوتيه'
end
if MsgText[1]== 'اضف صوت' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
redis:set(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'start')
return '✿*│* ارسل اسم الصوت الان ...'
end
if MsgText[1]== ("الصوتيات") then
local list = redis:smembers(mero.."mero:text:Games:Bot"..msg.chat_id_)
if #list == 0 then
sendMsg(msg.chat_id_, msg.id_, "✿*│*لا يوجد صوتيات")
return false
end
message = '✿*│*قائمه الصوتيات :\n'
for k,v in pairs(list) do
message = message..""..k.."- ("..v..")\n"
end
sendMsg(msg.chat_id_, msg.id_,message)
end
if MsgText[1]== ("مسح الصوتيات") then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local list = redis:smembers(mero.."mero:text:Games:Bot"..msg.chat_id_)
if #list == 0 then
sendMsg(msg.chat_id_, msg.id_, "✿*│*لا يوجد صوتيات")
return false
end
for k,v in pairs(list) do
redis:srem(mero.."mero:text:Games:Bot"..msg.chat_id_,v)
redis:del(mero.."mero:audio:Games"..msg.chat_id_..v)
end
sendMsg(msg.chat_id_, msg.id_, "✿*│*تم مسح جميع الصوتيات")
end


if MsgText[1] == 'مسح صوت عام' then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'startdel')
return '✿*│* ارسل اسم الصوتيه'
end
if MsgText[1]== 'اضف صوت عام' then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'start')
return '✿*│* ارسل اسم الصوت الان ...'
end
if MsgText[1]== ("الصوتيات العامه") then
local list = redis:smembers(mero.."mero:All:text:Games:Bot")
if #list == 0 then
sendMsg(msg.chat_id_, msg.id_, "✿*│*لا يوجد صوتيات")
return false
end
message = '✿*│*قائمه الصوتيات العامه :\n'
for k,v in pairs(list) do
message = message..""..k.."- ("..v..")\n"
end
sendMsg(msg.chat_id_, msg.id_,message)
end
if MsgText[1]== ("مسح الصوتيات العامه") then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
local list = redis:smembers(mero.."mero:All:text:Games:Bot")
if #list == 0 then
sendMsg(msg.chat_id_, msg.id_, "✿*│*لا يوجد صوتيات")
return false
end
for k,v in pairs(list) do
redis:srem(mero.."mero:All:text:Games:Bot",v)
redis:del(mero.."mero:All:audio:Games"..v)
end
sendMsg(msg.chat_id_, msg.id_, "✿*│*تم مسح جميع الصوتيات")
end

if MsgText[1] == "المجموعه" or MsgText[1] == "عدد الكروب" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
GetFullChat(msg.chat_id_,function(arg,data)
local GroupName = (redis:get(mero..'group:name'..msg.chat_id_) or '')
redis:set(mero..'linkGroup'..msg.chat_id_,(data.invite_link_ or ""))
return sendMsg(msg.chat_id_,msg.id_,
"✿╿ ❪ مـعـلومـات الـمـجـموعـه ❫\n ـــــــــــــــــــــــــــــــــــــــــــــــــــــــ \n"
.."*✿│* عدد الاعـضـاء ⇜ ❪ *"..data.member_count_.."* ❫"
.."\n*✿│* عدد المحظـوريـن ⇜ ❪ *"..data.kicked_count_.."* ❫"
.."\n*✿│* عدد الادمـنـيـه ⇜ ❪ *"..data.administrator_count_.."* ❫"
.."\n*✿│* ايدي المجموعه ⇜ ❪`"..msg.chat_id_.."`❫"
.."\n\n✿│الاسم ⇜ ❪  ["..FlterName(GroupName).."]("..(data.invite_link_ or "")..")  ❫\n"
)
end,nil) 
return false
end

if MsgText[1] == "التفاعل" then
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="active"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="active"})
end  
return false
end
if MsgText[1] == "منع عام" then 
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return AddFilterall(msg, MsgText[2]) 
end

if MsgText[1] == "الغاء منع عام" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return RemFilterall(msg, MsgText[2]) 
end

if MsgText[1] == "قائمه المنع عام" then 
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return FilterXListall(msg) 
end
if MsgText[1] == "منع" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return AddFilter(msg, MsgText[2]) 
end

if MsgText[1] == "الغاء منع" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return RemFilter(msg, MsgText[2]) 
end

if MsgText[1] == "قائمه المنع" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return FilterXList(msg) 
end




if MsgText[1] == "الحمايه" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return settingsall(msg) 
end

if MsgText[1] == "الاعدادات" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return settings(msg) 
end

if MsgText[1] == "الوسائط" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return media(msg) 
end

if MsgText[1] == "الادمنيه" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return GetListAdmin(msg) 
end
if MsgText[1] == "تاك للكل" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end

local list = redis:smembers(mero..':MALK_BOT:'..msg.chat_id_)
if #list~=0 then
local message = 'المالكين : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
local list = redis:smembers(mero..':KARA_BOT:'..msg.chat_id_)
if #list~=0 then
local message = 'المنشئين الاساسيين : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
local list = redis:smembers(mero..':MONSHA_BOT:'..msg.chat_id_)
if #list~=0 then
local message = 'المنشئين : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
local list = redis:smembers(mero..'owners:'..msg.chat_id_)
if #list~=0 then
local message = 'المدراء : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
local list = redis:smembers(mero..'admins:'..msg.chat_id_)
if #list~=0 then
local message = 'الادمنيه : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
local list = redis:smembers(mero..'whitelist:'..msg.chat_id_)
if #list~=0 then
local message = 'المميزين : \n'
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
message = message..""..k.."- ([@"..data.username_.."])\n"
else
message = message..""..k.."- (`"..v.."`)\n"
end
if #list == k then
return sendMsg(msg.chat_id_,msg.id_,message)
end
end,nil)
end
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 400},function(ta,datat)
t = " الاعضاء :  \n"
x = 0
local list = datat.members_
for i=0 ,#list do
tdcli_function ({ID = "GetUser",user_id_ = datat.members_[i].user_id_},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = "["..datat.members_[i].user_id_.."](tg://user?id="..datat.members_[i].user_id_..')'
end
x = x + 1 
t = t..''..x..'- '..username..' \n '
if #list == i then
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(t).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end,nil)
end
end,nil)
return false
end

if MsgText[1] == 'تاك'  then
if not msg.Admin then return "✿*│* هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n🚶" end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 400},function(ta,datat)
t = "\n• قائمة الاعضاء \n━━━━━━━━━\n"
x = 0
local list = datat.members_
for i=0 ,#list do
tdcli_function ({ID = "GetUser",user_id_ = datat.members_[i].user_id_},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = "["..datat.members_[i].user_id_.."](tg://user?id="..datat.members_[i].user_id_..')'
end
x = x + 1
t = t..''..x..'- '..username..' \n '
if #list == i then
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(t).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end,nil)
end
end,nil)
end
if MsgText[1] == 'تفعيل تاك عام' then   
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if (redis:get(mero..'tagall@all'..msg.chat_id_) == 'open') then
return '✿| تم تفعيل امر @all مسبقا'
else
redis:set(mero..'tagall@all'..msg.chat_id_,'open') 
return '✿| تم تفعيل امر @all'
end
end
if MsgText[1] == 'تعطيل تاك عام' then   
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if (redis:get(mero..'tagall@all'..msg.chat_id_) == 'close') then
return '✿| تم تعطيل امر @all مسبقا'
else
redis:set(mero..'tagall@all'..msg.chat_id_,'close') 
return '✿| تم تعطيل امر @all'
end
end
if MsgText[1] == "تعطيل الصيغ" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'kadmeat'..msg.chat_id_)  then
return '✿| تم تعطيل اوامر الصيغ مسبقا'
else
redis:set(mero.."kadmeat"..msg.chat_id_,"true")
return '✿| تم تعطيل اوامر الصيغ'
end
end
if MsgText[1] == "تفعيل الصيغ" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not redis:get(mero..'kadmeat'..msg.chat_id_)  then
return '✿| تم تفعيل اوامر التحويلات مسبقا'
else
redis:del(mero.."kadmeat"..msg.chat_id_)
return '✿| تم تفعيل اوامر الصيغ'
end
end
if MsgText[1] == "تعطيل انطق" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'intg'..msg.chat_id_)  then
return '✿| تم تعطيل امر انطق مسبقا'
else
redis:set(mero.."intg"..msg.chat_id_,"true")
return '✿| تم تعطيل امر انطق'
end
end
if MsgText[1] == "تفعيل انطق" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not redis:get(mero..'intg'..msg.chat_id_)  then
return '✿| تم تفعيل امر انطق مسبقا'
else
redis:del(mero.."intg"..msg.chat_id_)
return '✿| تم تفعيل امر انطق'
end
end

if MsgText[1] == "تعطيل غنيلي" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'knele'..msg.chat_id_)  then
return '✿| تم تعطيل امر غنيلي مسبقا'
else
redis:set(mero.."knele"..msg.chat_id_,"true")
return '✿| تم تعطيل امر غنيلي'
end
end
if MsgText[1] == "تفعيل غنيلي" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not redis:get(mero..'knele'..msg.chat_id_)  then
return '✿| تم تفعيل امر غنيلي مسبقا'
else
redis:del(mero.."knele"..msg.chat_id_)
return '✿| تم تفعيل امر غنيلي'
end
end


if MsgText[1] == "تعطيل الرابط" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'status:link'..msg.chat_id_)  then
return '✿| تم تعطيل الرابط مسبقا'
else
redis:set(mero.."status:link"..msg.chat_id_,"true")
return '✿| تم تعطيل الرابط '
end
end
if MsgText[1] == "تفعيل الرابط" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not redis:get(mero..'status:link'..msg.chat_id_)  then
return '✿| تم تفعيل الرابط مسبقا'
else
redis:del(mero.."status:link"..msg.chat_id_)
return '✿| تم تفعيل الرابط '
end
end
if MsgText[1] == "تعطيل الابراج" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'brj_Bots'..msg.chat_id_) == 'close' then
return '✿| تم تعطيل الابراج مسبقا'
else
redis:set(mero.."brj_Bots"..msg.chat_id_,"close")
return '✿| تم تعطيل الابراج '
end
end
if MsgText[1] == "تفعيل الابراج" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'brj_Bots'..msg.chat_id_) == 'open' then
return '✿| تم تفعيل الابراج مسبقا'
else
redis:set(mero.."brj_Bots"..msg.chat_id_,"open")
return '✿| تم تفعيل الابراج '
end
end


if MsgText[1] ==("المالك") or MsgText[1] ==("مالك المجموعه") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
return sendMsg(msg.chat_id_, msg.id_, "🔘┇ حساب المالك محذوف")
end
local UserName = (b.username_ or "meroteam")
print(UserName)
return sendMsg(msg.chat_id_, msg.id_, "✿┇مالك المجموعه ~ ["..b.first_name_.."](T.me/"..UserName..")")
end,nil)   
end
end
end,nil)   
end
if MsgText[1] == 'تفعيل اليوتيوب' then   
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not redis:get(mero..'dw:bot:api'..msg.chat_id_)  then
return '✿| تم تفعيل امر تنزيل اليوتيوب مسبقا'
else
redis:del(mero..'dw:bot:api'..msg.chat_id_) 
return '✿| تم تفعيل امر تنزيل اليوتيوب'
end
end
if MsgText[1] == 'تعطيل اليوتيوب' then   
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if (redis:get(mero..'dw:bot:api'..msg.chat_id_) == 'true') then
return '✿| تم تعطيل امر تنزيل اليوتيوب مسبقا'
else
redis:set(mero..'dw:bot:api'..msg.chat_id_,true) 
return '✿| تم تعطيل امر تنزيل اليوتيوب'
end
end

if MsgText[1] == "@all" and (redis:get(mero..'tagall@all'..msg.chat_id_) == 'open')  or MsgText[1] == "تاك عام"  and (redis:get(mero..'tagall@all'..msg.chat_id_) == 'open') then
if not msg.Admin then return "✿*│* هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n🚶" end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200},function(ta,datate)
x = 0
y = 0
local list = datate.members_ 
for k, v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v.user_id_},function(arg,b) 
if x == 20 or x == y or k == 0 then
y = x + 20
t = ""
end
x = x + 1
tagname = b.first_name_ or 'Erorr'
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")\n"
if x == 20 or x == y or k == 0 then
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(t).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end,nil)
end
end,nil)
end
if MsgText[1] == "تفعيل قول" and not MsgText[2] then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
redis:set(mero..'kol:bot'..msg.chat_id_,true)  
return sendMsg(msg.chat_id_, msg.id_,'✿| تم تفعيل امر قول')
end
if MsgText[1] == "تعطيل قول" and not MsgText[2] then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
redis:del(mero..'kol:bot'..msg.chat_id_)  
return sendMsg(msg.chat_id_, msg.id_,'✿| تم تعطيل امر قول')
end


if MsgText[1] == "تاك للسرسريه" then
if not msg.Admin then return "✿*│* هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n🚶" end
return ownerlist(msg) .. GetListAdmin(msg) .. whitelist(msg)
end


if MsgText[1] == "المنشئ الاساسي" or MsgText[1] == "المنشئين الاساسيين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return KARA_BOT(msg) 
end

if MsgText[1] == "المالكين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return MALK_BOT(msg) 
end

if MsgText[1] == "المدراء" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return ownerlist(msg) 
end

if MsgText[1] == "المنشئين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return monshlist(msg) 
end

if MsgText[1] == "المميزين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return whitelist(msg) 
end


if MsgText[1] == "صلاحياته" then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
if MsgText[1] == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
if MsgText[1] == "صلاحياته" and MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if tonumber(msg.reply_to_message_id_) == 0 then 
local username = MsgText[2]
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
return sendMsg(msg.chat_id_,msg.id_,'✿│المعرف غير صحيح \n👨🏻‍✈️')   
end   
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return sendMsg(msg.chat_id_,msg.id_,'✿│هذا معرف قناة \n👨🏻‍✈️')   
end      
Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
if MsgText[1] == "فحص البوت" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end 
return sendMsg(msg.chat_id_,msg.id_,'\n✿╿اهلا عزيزي البوت هنا مشرف بالكروب \n✿╽وصلاحياته هي ⇓ \nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n✿╿تغير معلومات المجموعه ↞ ❪ '..info..' ❫\n✿│حذف الرسائل ↞ ❪ '..delete..' ❫\n✿│حظر المستخدمين ↞ ❪ '..restrict..' ❫\n✿│دعوة مستخدمين ↞ ❪❪ '..invite..' ❫\n✿│تثبيت الرسائل ↞ ❪ '..pin..' ❫\n✿│اضافة مشرفين جدد ↞ ❪ '..promote..' ❫\n\n✿╽ملاحضه » علامة ❪  ꪜ ❫ تعني لديه الصلاحية وعلامة ❪ ✘ ❫ تعني ليس لديه الصلاحيه')   
end
end
end

if MsgText[1] == "تثبيت" and msg.reply_id then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_pin_messages ~= true then
return  "ليست لدي صلاحيه التثبيت"
end
end

local GroupID = msg.chat_id_:gsub('-100','')
if not msg.Director and redis:get(mero..'lock_pin'..msg.chat_id_) then
return "لا يمكنك التثبيت الامر مقفول من قبل الاداره"
else
tdcli_function({
ID="PinChannelMessage",
channel_id_ = GroupID,
message_id_ = msg.reply_id,
disable_notification_ = 1},
function(arg,data)
if data.ID == "Ok" then
redis:set(mero..":MsgIDPin:"..msg.chat_id_,msg.reply_id)
return sendMsg(msg.chat_id_,msg.id_,"✿*╿*أهلا عزيزي "..msg.TheRankCmd.." \n✿*╽* تم تثبيت الرساله \n✓")
elseif data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* عذرا لا يمكنني التثبيت .\n✿*╽* لست مشرف او لا املك صلاحيه التثبيت \n ✿')    
end
end,nil)
end
return false
end

if MsgText[1] == "الغاء التثبيت" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_pin_messages ~= true then
return  "ليست لدي صلاحيه التثبيت"
end
end

if not msg.Director and redis:get(mero..'lock_pin'..msg.chat_id_) then
return "لا يمكنك الغاء التثبيت الامر مقفول من قبل الاداره"
else
local GroupID = msg.chat_id_:gsub('-100','')
tdcli_function({ID="UnpinChannelMessage",channel_id_ = GroupID},
function(arg,data) 
if data.ID == "Ok" then
return sendMsg(msg.chat_id_,msg.id_,"✿*╿*أهلا عزيزي "..msg.TheRankCmd.."  \n✿*╽* تم الغاء تثبيت الرساله \n✓")    
elseif data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* عذرا لا يمكنني الغاء التثبيت .\n✿*╽* لست مشرف او لا املك صلاحيه التثبيت \n ✿')    
elseif data.ID == "Error" and data.code_ == 400 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* عذرا عزيزي '..msg.TheRankCmd..' .\n✿*╽* لا توجد رساله مثبته لكي اقوم بازالتها \n ✿')    
end
end,nil)
end
return false
end


if MsgText[1] == "تقييد"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_restrict_members ~= true then
return  "ليست لدي صلاحيه الحظر"
end
end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="tqeed"}) 
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="tqeed"}) 
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="tqeed"}) 
end 
return false
end

if MsgText[1] == "فك التقييد" or MsgText[1] == "فك تقييد" or MsgText[1] == "الغاء التقييد"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_restrict_members ~= true then
return  "ليست لدي صلاحيه الحظر"
end
end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="fktqeed"}) 
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="fktqeed"}) 
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="fktqeed"}) 
end 
return false
end


if MsgText[1] == "رفع مميز"  then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="setwhitelist"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setwhitelist"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="setwhitelist"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'on' then
sendMsg(msg.chat_id_,msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الرفع معطل \n✓")
end
return false
end


if MsgText[1] == "تنزيل مميز"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="remwhitelist"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remwhitelist"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="remwhitelist"})
end 
return false
end


if (MsgText[1] == "رفع المدير"  or MsgText[1] == "رفع مدير" )  then
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="setowner"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setowner"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="setowner"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'on' then
sendMsg(msg.chat_id_,msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الرفع معطل \n✓")
end
return false
end


if (MsgText[1] == "تنزيل المدير" or MsgText[1] == "تنزيل مدير" )  then
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="remowner"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remowner"}) 
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="remowner"})
end 
return false
end


if (MsgText[1] == "رفع منشى اساسي" or MsgText[1] == "رفع منشئ اساسي") then
if not msg.malk then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="setkara"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setkara"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="setkara"}) 
return false
end 
end

if (MsgText[1] == "تنزيل منشى اساسي" or MsgText[1] == "تنزيل منشئ اساسي") then
if not msg.malk then return "✿*│*هذا الامر يخص {} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="remkara"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remkara"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="remkara"}) 
return false
end 
end
if (MsgText[1] == "رفع مالك" )  then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then 
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="SetMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="SetMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="SetMALK_BOT"})
end  
else
if not msg.SudoUser then
return "✿*│*هذا الامر يخص { المطور الاساسي ، المطور , منشئ الكروب } فقط  \n✿" 
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="SetMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="SetMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="SetMALK_BOT"})
end  
end
end,nil)   
return false
end
if (MsgText[1] == "تنزيل مالك" )  then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then 
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="RemMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="RemMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="RemMALK_BOT"})
end  
else
if not msg.SudoUser then
return "✿*│*هذا الامر يخص { المطور الاساسي ، المطور , منشئ الكروب } فقط  \n✿" 
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="RemMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="RemMALK_BOT"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="RemMALK_BOT"})
end  
end
end,nil)   
return false
end



if (MsgText[1] == "رفع منشى" or MsgText[1] == "رفع منشئ")  then
if not msg.Kara then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك ، المنشئ الاساسي} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="setmnsha"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setmnsha"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="setmnsha"})
end  
return false
end


if (MsgText[1] == "تنزيل منشى" or MsgText[1] == "تنزيل منشئ" )  then
if not msg.Kara then return "✿*│*هذا الامر يخص { المطور,المنشى الاساسي فقط } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="remmnsha"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remmnsha"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="remmnsha"})
end 
return false
end
if (MsgText[1] == "رفع مشرف" )  then
if not msg.Kara then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك ، المنشئ الاساسي} فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="SetMshrf"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="SetMshrf"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="SetMshrf"})
end  
return false
end
if (MsgText[1] == "تنزيل مشرف")  then
if not msg.Kara then return "✿*│*هذا الامر يخص { المطور,المنشى الاساسي فقط } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="RemMshrf"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="RemMshrf"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="RemMshrf"})
end 
return false
end
if (MsgText[1] == "رفع مشرف بكل الصلاحيات" )  then
if not msg.malk then return "✿*│*هذا الامر يخص {المالك} فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="SetMshrf1"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="SetMshrf1"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="SetMshrf1"})
end  
return false
end
if (MsgText[1] == "تنزيل مشرف بكل الصلاحيات")  then
if not msg.malk then return "✿*│*هذا الامر يخص {المالك} فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="RemMshrf"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="RemMshrf"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="RemMshrf"})
end 
return false
end

if MsgText[1] == "رفع ادمن"  then 
if not msg.Director then return "✿*│*هذا الامر يخص {المطور ، المالك ،المنشئ الاساسي ، المنشئ ، المدير} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="promote"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="promote"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'off' then
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="promote"})
end
end
if redis:get(mero..'lock:kara:'..msg.chat_id_) == 'on' then
sendMsg(msg.chat_id_,msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الرفع معطل \n✓")
end
return false
end



if MsgText[1] == "تنزيل ادمن"  then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="demote"})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="demote"})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="demote"})
end 
return false
end


if MsgText[1] == "تنزيل الكل" and not MsgText[2] and not msg.reply_id then
if not msg.malk then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك} فقط  \n✿" end
  
redis:del(mero..'admins:'..msg.chat_id_)
redis:del(mero..'owners:'..msg.chat_id_)
redis:del(mero..':KARA_BOT:'..msg.chat_id_)
redis:del(mero..':MONSHA_BOT:'..msg.chat_id_)
return "✿| تم تنزيل المنشئين الاساسين و المنشئين والمدراء والادمنيه "
end
if MsgText[1] == "تنزيل الكل" then
if not msg.Admin then return "📪¦ هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n" end

if not MsgText[2] and msg.reply_id then 

GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = data.sender_user_id_},function(argg,deata) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(argg,deatar) 
if deata.status_.ID == "ChatMemberStatusCreator" then 
 sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته مالك المجموعه \n❕") 
return false
end
local UserID = data.sender_user_id_
msg = arg.msg
msg.UserID = UserID
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
msg = arg.msg
UserID = msg.UserID
if UserID == our_id then return sendMsg(msg.chat_id_,msg.id_,"✿*¦* لا يمكنك تنفيذ الامر مع البوت\n❕") end
if UserID == 779108237 or UserID == 1211544689 then return sendMsg(msg.chat_id_,msg.id_,"✿*¦* لا يمكنك تنفيذ الامر ضد مطور السورس \n❕") end


if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(mero..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(mero..':MALK_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(mero..':KARA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 4
elseif redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 5
elseif redis:sismember(mero..'owners:'..msg.chat_id_,UserID) then 
rinkuser = 6
elseif redis:sismember(mero..'admins:'..msg.chat_id_,UserID) then 
rinkuser = 7
elseif redis:sismember(mero..'whitelist:'..msg.chat_id_,UserID) then 
rinkuser = 8
else
rinkuser = 9
end
local DonisDown = "\n✿¦ تم تنزيله من الرتب الاتيه : \n\n "
if redis:sismember(mero..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المطور ✓️\n"
end 
if redis:sismember(mero..':MALK_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المالك ✓️\n"
end 
if redis:sismember(mero..':KARA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المنشىء الاساسي  ✓️\n"
end 
if redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المنشــىء  ✓️\n"
end 
if redis:sismember(mero..'owners:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المدير ✓️\n"
end 
if redis:sismember(mero..'admins:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من الادمـــــن  ✓️\n"
end 
if redis:sismember(mero..'whitelist:'..msg.chat_id_,UserID) then
DonisDown = DonisDown.."✿¦ تم تنزيله من العضو مميز ✓️\n"
end
if deatar.status_.ID == "ChatMemberStatusCreator" then 
redis:srem(mero..':MALK_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
return sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") 
end
if rinkuser == 9 then return sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」   \nانه بالتأكيد عضو \n✓️")  end
huk = false
if msg.SudoBase then 
redis:srem(mero..':SUDO_BOT:',UserID)
redis:srem(mero..':MALK_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end
if rinkuser < 2 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end
redis:srem(mero..':MALK_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.malk then
if tonumber(rinkuser) == 3 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end 
if rinkuser < 3 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Kara then 
if rinkuser == 4 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end
if rinkuser < 4 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end

redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Creator then 
if rinkuser == 5 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end
if rinkuser < 5 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end

redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Director then 
if rinkuser == 6 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end
if rinkuser < 6 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end

redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Admin then 
if rinkuser == 7 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end
if rinkuser < 7 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
else
huk = true
end

if not huk then 
sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") 
end

end,{msg=msg})
end,nil)   
end,nil)   
end,{msg=msg})
end
  
  
  if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
  GetUserName(MsgText[2],function(arg,data)
  if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"✿*¦* لا يوجد عضـو بهذا المـعرف \n❕") end 
  local UserID = data.id_
  tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = data.id_},function(argg,deata) 
  tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(argg,deatar) 
if deata.status_.ID == "ChatMemberStatusCreator" then 
 sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته مالك المجموعه \n❕") 
return false
end
  if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"✿*¦* لا يمكنك تنفيذ الامر مع البوت\n❕") end
  
  msg = arg.msg
  if UserID == 779108237 or UserID == 1211544689 then return sendMsg(msg.chat_id_,msg.id_,"✿*¦* لا يمكنك تنفيذ الامر ضد مطور السورس \n❕") end
  NameUser = Hyper_Link_Name(data)
  
  if UserID == SUDO_ID then 
  rinkuser = 1
  elseif redis:sismember(mero..':SUDO_BOT:',UserID) then 
  rinkuser = 2
  elseif redis:sismember(mero..':MALK_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 3
  elseif redis:sismember(mero..':KARA_BOT:'..msg.chat_id_,UserID) then 
  rinkuser = 4
  elseif redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
  rinkuser = 5
  elseif redis:sismember(mero..'owners:'..msg.chat_id_,UserID) then 
  rinkuser = 6
  elseif redis:sismember(mero..'admins:'..msg.chat_id_,UserID) then 
  rinkuser = 7
  elseif redis:sismember(mero..'whitelist:'..msg.chat_id_,UserID) then 
  rinkuser = 8
  else
  rinkuser = 9
  end
  local DonisDown = "\n✿¦ تم تنزيله من الرتب الاتيه : \n\n "
  if redis:sismember(mero..':SUDO_BOT:',UserID) then 
  DonisDown = DonisDown.."✿¦ تم تنزيله من المطور ✓️\n"
  end 
  if redis:sismember(mero..':MALK_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."✿¦ تم تنزيله من المالك ✓️\n"
end 
  if redis:sismember(mero..':KARA_BOT:'..msg.chat_id_,UserID) then 
  DonisDown = DonisDown.."✿¦ تم تنزيله من المنشىء الاساسي 🌟 ✓️\n"
  end 
  if redis:sismember(mero..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
  DonisDown = DonisDown.."✿¦ تم تنزيله من المنشــىء 🌟 ✓️\n"
  end 
  if redis:sismember(mero..'owners:'..msg.chat_id_,UserID) then 
  DonisDown = DonisDown.."✿¦ تم تنزيله من المدير ✓️\n"
  end 
  if redis:sismember(mero..'admins:'..msg.chat_id_,UserID) then 
  DonisDown = DonisDown.."✿¦ تم تنزيله من الادمـــــن 🌟 ✓️\n"
  end 
  if redis:sismember(mero..'whitelist:'..msg.chat_id_,UserID) then
  DonisDown = DonisDown.."✿¦ تم تنزيله من العضو مميز ✓️\n"
  end
  if deatar.status_.ID == "ChatMemberStatusCreator" then 
print('&')
redis:srem(mero..':MALK_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
return sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") 
end
  function senddwon() sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") end
  function sendpluse() sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") end
  
  if rinkuser == 9 then return sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」   \nانه بالتأكيد عضو \n✓️")  end
  huk = false
  if msg.SudoBase then 
  redis:srem(mero..':SUDO_BOT:',UserID)
  redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
  redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
  redis:srem(mero..'owners:'..msg.chat_id_,UserID)
  redis:srem(mero..'admins:'..msg.chat_id_,UserID)
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.SudoUser then 
  if rinkuser == 2 then return sendpluse() end
  if rinkuser < 2 then return senddwon() end
  redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
  redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
  redis:srem(mero..'owners:'..msg.chat_id_,UserID)
  redis:srem(mero..'admins:'..msg.chat_id_,UserID)
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.malk then
if tonumber(rinkuser) == 3 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") 
end 
if rinkuser < 3 then 
return sendMsg(msg.chat_id_,msg.id_,"✿*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") 
end
redis:srem(mero..':KARA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(mero..'owners:'..msg.chat_id_,UserID)
redis:srem(mero..'admins:'..msg.chat_id_,UserID)
redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.Kara then 
  if rinkuser == 4 then return sendpluse() end
  if rinkuser < 4 then return senddwon() end
  redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,UserID)
  redis:srem(mero..'owners:'..msg.chat_id_,UserID)
  redis:srem(mero..'admins:'..msg.chat_id_,UserID)
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.Creator then 
  if rinkuser == 5 then return sendpluse() end
  if rinkuser < 5 then return senddwon() end
  redis:srem(mero..'owners:'..msg.chat_id_,UserID)
  redis:srem(mero..'admins:'..msg.chat_id_,UserID)
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.Director then 
  if rinkuser == 6 then return sendpluse() end
  if rinkuser < 6 then return senddwon() end
  redis:srem(mero..'admins:'..msg.chat_id_,UserID)
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  elseif msg.Admin then 
  if rinkuser == 7 then return sendpluse() end
  if rinkuser < 7 then return senddwon() end
  redis:srem(mero..'whitelist:'..msg.chat_id_,UserID)
  else
  huk = true
  end
  
  if not huk then sendMsg(msg.chat_id_,msg.id_,"✿¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") end
  end,nil)   
  end,nil)   
  end,{msg=msg})
  end 
  
  if MsgText[2] and MsgText[2]:match('^%d+$') then 
  GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwnAll"}) 
  end
  
  return false
  end
  


--{ Commands For locks }

if MsgText[1] == "قفل" then

if MsgText[2] == "الكل"		 then return lock_All(msg) end
if MsgText[2] == "الوسائط" 	 then return lock_Media(msg) end
if MsgText[2] == "الصور بالتقييد" 	 then return tqeed_photo(msg) end
if MsgText[2] == "الفيديو بالتقييد"  then return tqeed_video(msg) end
if MsgText[2] == "المتحركه بالتقييد" then return tqeed_gif(msg) end
if MsgText[2] == "التوجيه بالتقييد"  then return tqeed_fwd(msg) end
if MsgText[2] == "الروابط بالتقييد"  then return tqeed_link(msg) end
if MsgText[2] == "الدردشه"    	     then return mute_text(msg) end
if MsgText[2] == "المتحركه" 		 then return mute_gif(msg) end
if MsgText[2] == "الصور" 			 then return mute_photo(msg) end
if MsgText[2] == "الفيديو"			 then return mute_video(msg) end
if MsgText[2] == "البصمات" 		then  return mute_audio(msg) end
if MsgText[2] == "الصوت" 		then return mute_voice(msg) end
if MsgText[2] == "الملصقات" 	then return mute_sticker(msg) end
if MsgText[2] == "الجهات" 		then return mute_contact(msg) end
if MsgText[2] == "التوجيه" 		then return mute_forward(msg) end
if MsgText[2] == "الموقع"	 	then return mute_location(msg) end
if MsgText[2] == "الملفات" 		then return mute_document(msg) end
if MsgText[2] == "الاشعارات" 	then return mute_tgservice(msg) end
if MsgText[2] == "الانلاين" 		then return mute_inline(msg) end
if MsgText[2] == "الكيبورد" 	then return mute_keyboard(msg) end
if MsgText[2] == "الروابط" 		then return lock_link(msg) end
if MsgText[2] == "التاك" 		then return lock_tag(msg) end
if MsgText[2] == "المعرفات" 	then return lock_username(msg) end
if MsgText[2] == "التعديل" 		then return lock_edit(msg) end
if MsgText[2] == "الكلايش" 		then return lock_spam(msg) end
if MsgText[2] == "التكرار" 		then return lock_flood(msg) end
if MsgText[2] == "البوتات" 		then return lock_bots(msg) end
if MsgText[2] == "البوتات بالطرد" 	then return lock_bots_by_kick(msg) end
if MsgText[2] == "الماركدوان" 	then return lock_markdown(msg) end
if MsgText[2] == "الويب" 		then return lock_webpage(msg) end 
if MsgText[2] == "التثبيت" 		then return lock_pin(msg) end 
end

--{ Commands For Unlocks }
if MsgText[1] == "فتح" 		then 
if MsgText[2] == "الكل" then return Unlock_All(msg) end
if MsgText[2] == "الوسائط" then return Unlock_Media(msg) end
if MsgText[2] == "الصور بالتقييد" 		then return fktqeed_photo(msg) 	end
if MsgText[2] == "الفيديو بالتقييد" 	then return fktqeed_video(msg) 	end
if MsgText[2] == "المتحركه بالتقييد" 	then return fktqeed_gif(msg) 	end
if MsgText[2] == "التوجيه بالتقييد" 	then return fktqeed_fwd(msg) 	end
if MsgText[2] == "الروابط بالتقييد" 	then return fktqeed_link(msg) 	end
if MsgText[2] == "المتحركه" 	then return unmute_gif(msg) 	end
if MsgText[2] == "الدردشه" 		then return unmute_text(msg) 	end
if MsgText[2] == "الصور" 		then return unmute_photo(msg) 	end
if MsgText[2] == "الفيديو" 		then return unmute_video(msg) 	end
if MsgText[2] == "البصمات" 		then return unmute_audio(msg) 	end
if MsgText[2] == "الصوت" 		then return unmute_voice(msg) 	end
if MsgText[2] == "الملصقات" 	then return unmute_sticker(msg) end
if MsgText[2] == "الجهات" 		then return unmute_contact(msg) end
if MsgText[2] == "التوجيه" 		then return unmute_forward(msg) end
if MsgText[2] == "الموقع" 		then return unmute_location(msg) end
if MsgText[2] == "الملفات" 		then return unmute_document(msg) end
if MsgText[2] == "الاشعارات" 	then return unmute_tgservice(msg) end
if MsgText[2] == "الانلاين" 		then return unmute_inline(msg) 	end
if MsgText[2] == "الكيبورد" 	then return unmute_keyboard(msg) end
if MsgText[2] == "الروابط" 		then return unlock_link(msg) 	end
if MsgText[2] == "التاك" 		then return unlock_tag(msg) 	end
if MsgText[2] == "المعرفات" 	then return unlock_username(msg) end
if MsgText[2] == "التعديل" 		then return unlock_edit(msg) 	end
if MsgText[2] == "الكلايش" 		then return unlock_spam(msg) 	end
if MsgText[2] == "التكرار" 		then return unlock_flood(msg) 	end
if MsgText[2] == "البوتات" 		then return unlock_bots(msg) 	end
if MsgText[2] == "البوتات بالطرد" 	then return unlock_bots_by_kick(msg) end
if MsgText[2] == "الماركدوان" 	then return unlock_markdown(msg) end
if MsgText[2] == "الويب" 		then return unlock_webpage(msg) 	end
if MsgText[2] == "التثبيت" 		then return unlock_pin(msg) end 
end
 
if MsgText[1] == "انشاء رابط" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
if redis:get(mero..'status:link'..msg.chat_id_) then
return "✿│الرابط معطل من قبل  الاداره\n✿" end
if not redis:get(mero..'ExCmdLink'..msg.chat_id_) then
local LinkGp = ExportLink(msg.chat_id_)
if LinkGp then
LinkGp = LinkGp.result
redis:set(mero..'linkGroup'..msg.chat_id_,LinkGp)
redis:setex(mero..'ExCmdLink'..msg.chat_id_,120,true)
return sendMsg(msg.chat_id_,msg.id_,"✿*╿*تم انشاء رابط جديد \n✿│["..LinkGp.."]\n✿╽لعرض الرابط ارسل { الرابط } \n")
else
return sendMsg(msg.chat_id_,msg.id_,"✿╿لا يمكنني انشاء رابط للمجموعه .\n✿╽لانني لست مشرف في المجموعه \n ✿")
end
else
return sendMsg(msg.chat_id_,msg.id_,"✿╿لقد قمت بانشاء الرابط سابقا .\n✿╽ارسل { الرابط } لرؤيه الرابط  \n ✿")
end
return false
end 

if MsgText[1] == "ضع رابط" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
redis:setex(mero..'linkGroup'..msg.sender_user_id_,300,true)
return '✿│عزيزي قم برسال الرابط الجديد ...🍂'
end

if MsgText[1] == "الرابط"  then
if redis:get(mero..'status:link'..msg.chat_id_) then
return "✿│الرابط معطل من قبل  الاداره\n✿" end
if not redis:get(mero..'linkGroup'..msg.chat_id_) then 
return "✿*╿* اوه 🙀 لا يوجد رابط ☹️\n✿*╽*لانشاء رابط ارسل { `انشاء رابط` }\n✿" 
end
local GroupName = redis:get(mero..'group:name'..msg.chat_id_)
local GroupLink = redis:get(mero..'linkGroup'..msg.chat_id_)
return "✿╿رابـط الـمـجـمـوعه ✿\n✿╽"..Flter_Markdown(GroupName).." :\n\n["..GroupLink.."]\n"
end
  

if MsgText[1] == "الرابط خاص" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local GroupLink = redis:get(mero..'linkGroup'..msg.chat_id_)
if not GroupLink then return "✿*╿* اوه 🙀 لا يوجد هنا رابط\n✿╽* اكتب [ضع رابط]*🔃" end
local Text = "✿╿رابـط الـمـجـمـوعه ✿\n✿╽"..Flter_Markdown(redis:get(mero..'group:name'..msg.chat_id_)).." :\n\n["..GroupLink.."]\n"
local info, res = https.request(ApiToken..'/sendMessage?chat_id='..msg.sender_user_id_..'&text='..URL.escape(Text)..'&disable_web_page_preview=true&parse_mode=Markdown')
if res == 403 then
return "✿*╿*عذرا عزيزي \n✿╽لم استطيع ارسالك الرابط لانك قمت بحظر البوت\n!"
elseif res == 400 then
return "✿*╿*عذرا عزيزي \n✿╽ لم استطيع ارسالك الرابط يجب عليك مراسله البوت اولا \n!"
end
if res == 200 then 
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."  \n✿╽تم ارسال الرابط خاص لك 🔃"
end
end


if MsgText[1] == "ضع القوانين" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
redis:setex(mero..'rulse:witting'..msg.sender_user_id_,300,true)
return '✿╿حسننا عزيزي  \n✿╽الان ارسل القوانين  للمجموعه ✿'
end

if MsgText[1] == "القوانين" then
if not redis:get(mero..'rulse:msg'..msg.chat_id_) then 
return "✿*╿*مرحبا عزيري القوانين كلاتي ⇣\n✿│ممنوع نشر الروابط \n✿│ممنوع التكلم او نشر صور اباحيه \n✿│ممنوع  اعاده توجيه\n✿│ممنوع التكلم بلطائفية \n✿│الرجاء احترام المدراء والادمنيه\n"
else 
return "*✿│القوانين :*\n"..redis:get(mero..'rulse:msg'..msg.chat_id_) 
end 
end


if MsgText[1] == "ضع تكرار" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local NumLoop = tonumber(MsgText[2])
if NumLoop < 1 or NumLoop > 50 then 
return "✿*│* حدود التكرار ,  يجب ان تكون ما بين  *[2-50]*" 
end
redis:set(mero..'flood'..msg.chat_id_,MsgText[2]) 
return "✿*│* تم وضع التكرار » { *"..MsgText[2].."* }"
end



if MsgText[1] == "مسح" then
if not MsgText[2] and msg.reply_id then 
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_delete_messages ~= true then
return  "ليست لدي صلاحيه المسح"
end
end
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
Del_msg(msg.chat_id_, msg.reply_id) 
Del_msg(msg.chat_id_, msg.id_) 
return false
end

if MsgText[2] and MsgText[2]:match('^%d+$') then
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_delete_messages ~= true then
return  "ليست لدي صلاحيه المسح"
end
end
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
if tonumber(MsgText[2]) > 1000 then 
sendMsg(msg.chat_id_, msg.id_,'✿┇لا تستطيع تنظيف اكثر من *~ 1000* رساله') 
return false  
end  
local Message = msg.id_
for i=1,tonumber(MsgText[2]) do
Del_msg(msg.chat_id_, Message) 
Message = Message - 1048576
end
sendMsg(msg.chat_id_, msg.id_,'✿┇تم تنظيف *~ '..MsgText[2]..'* رساله .')  
return false
end


if MsgText[2] == "الادمنيه" then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end

local Admins = redis:scard(mero..'admins:'..msg.chat_id_)
if Admins ==0 then  
return "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا يوجد ادمنيه ليتم مسحهم ✓" 
end
redis:del(mero..'admins:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..Admins.."} من الادمنيه في البوت \n✓"
end

if MsgText[2] == "قائمه المنع عام" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
local Mn3Word = redis:scard(mero..'Filter_Word:all')
if Mn3Word == 0 then 
return "✿*│* عذرا لا توجد كلمات ممنوعه ليتم حذفها ✓" 
end
redis:del(mero..'Filter_Word:all')
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {*"..Mn3Word.."*} كلمات من المنع ✓"
end

if MsgText[2] == "قائمه المنع" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local Mn3Word = redis:scard(mero..':Filter_Word:'..msg.chat_id_)
if Mn3Word == 0 then 
return "✿*│* عذرا لا توجد كلمات ممنوعه ليتم حذفها ✓" 
end
redis:del(mero..':Filter_Word:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {*"..Mn3Word.."*} كلمات من المنع ✓"
end


if MsgText[2] == "القوانين" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
if not redis:get(mero..'rulse:msg'..msg.chat_id_) then 
return "✿│عذرا لا يوجد قوانين ليتم مسحه \n!" 
end
redis:del(mero..'rulse:msg'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم حذف القوانين بنجاح ✓"
end


if MsgText[2] == "الترحيب"  then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
if not redis:get(mero..'welcome:msg'..msg.chat_id_) then 
return "\n*✿╽عذرا لا يوجد ترحيب ليتم مسحه ✓*" 
end
redis:del(mero..'welcome:msg'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم حذف الترحيب بنجاح \n✓"
end


if MsgText[2] == "المنشئين الاساسين" then
if not msg.malk then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك} فقط  \n✿" end
local NumMnsha = redis:scard(mero..':KARA_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
return "✿│عذرا لا يوجد المنشىء الاساسي 🌟 \n!" 
end
redis:del(mero..':KARA_BOT:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMnsha.." *} المنشىء الاساسي 🌟 \n✓"
end
if MsgText[2] == "المنشئين الاساسيين" then
if not msg.malk then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك} فقط  \n✿" end
local NumMnsha = redis:scard(mero..':KARA_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
return "✿│عذرا لا يوجد المنشىء الاساسي 🌟 \n!" 
end
redis:del(mero..':KARA_BOT:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMnsha.." *} المنشىء الاساسي 🌟 \n✓"
end
if MsgText[2] == "المالكين" then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then 
local NumMnsha = redis:scard(mero..':MALK_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
sendMsg(msg.chat_id_,msg.id_, "✿│عذرا لا يوجد مالكين 🌟 \n!" )
end
redis:del(mero..':MALK_BOT:'..msg.chat_id_)
redis:sadd(mero..':MALK_BOT:'..msg.chat_id_,msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMnsha.." *} مالكين 🌟 \n✓")
else
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور } فقط  \n✿" end
local NumMnsha = redis:scard(mero..':MALK_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
sendMsg(msg.chat_id_,msg.id_, "✿│عذرا لا يوجد مالكين 🌟 \n!" )
end
redis:del(mero..':MALK_BOT:'..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMnsha.." *} مالكين 🌟 \n✓")
end
end,nil)
end

if MsgText[2] == "المنشئين" then
if not msg.malk then return "✿*│*هذا الامر يخص {المطور الاساسي ، المطور ، المالك} فقط  \n✿" end
local NumMnsha = redis:scard(mero..':MONSHA_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
return "✿│عذرا لا يوجد منشئيين ليتم مسحهم \n!" 
end
redis:del(mero..':MONSHA_BOT:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMnsha.." *} من المنشئيين\n✓"
end


if MsgText[2] == "المدراء" then
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n🚶" end
local NumMDER = redis:scard(mero..'owners:'..msg.chat_id_)
if NumMDER ==0 then 
return "✿│عذرا لا يوجد مدراء ليتم مسحهم \n!" 
end
redis:del(mero..'owners:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..NumMDER.." *} من المدراء  \n✓"
end

if MsgText[2] == 'المحظورين' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end

local list = redis:smembers(mero..'banned:'..msg.chat_id_)
if #list == 0 then return "*✿│لا يوجد مستخدمين محظورين  *" end
message = '✿*│* قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
StatusLeft(msg.chat_id_,v)
end 
redis:del(mero..'banned:'..msg.chat_id_)
return "✿*│*أهلا عزيزي "..msg.TheRankCmd.."   \n✿│ تم مسح {* "..#list.." *} من المحظورين  \n✓"
end

if MsgText[2] == 'المكتومين' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local MKTOMEN = redis:scard(mero..'is_silent_users:'..msg.chat_id_)
if MKTOMEN ==0 then 
return "✿*│* لا يوجد مستخدمين مكتومين في المجموعه " 
end
redis:del(mero..'is_silent_users:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..MKTOMEN.." *} من المكتومين  \n✓"
end

if MsgText[2] == 'المميزين' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local MMEZEN = redis:scard(mero..'whitelist:'..msg.chat_id_)
if MMEZEN ==0 then 
return "*✿*│لا يوجد مستخدمين مميزين في المجموعه " 
end
redis:del(mero..'whitelist:'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽ تم مسح {* "..MMEZEN.." *} من المميزين  \n✓"
end


if MsgText[2] == 'الرابط' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
if not redis:get(mero..'linkGroup'..msg.chat_id_) then 
return "*✿*│لا يوجد رابط مضاف اصلا " 
end
redis:del(mero..'linkGroup'..msg.chat_id_)
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح رابط المجموعه \n✓"
end


end 
--End del 


if MsgText[1] == "ضع اسم" then
if not msg.Creator then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_change_info ~= true then
return  "ليست لدي صلاحيه تغيير المعلومات"
end
end
redis:setex(mero..'name:witting'..msg.sender_user_id_,300,true)
return "✿╿حسننا عزيزي  \n✿╽الان ارسل الاسم  للمجموعه \n✿"
end


if MsgText[1] == "مسح الصوره" then
if not msg.Creator then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
https.request(ApiToken.."/deleteChatPhoto?chat_id="..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿│تم مسح الصوره المـجمـوعهہ✿\n✓')
end


if MsgText[1] == "ضع صوره" then
if not msg.Creator then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_change_info ~= true then
return  "ليست لدي صلاحيه تغيير المعلومات"
end
end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then 
photo_id = data.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({ID="ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = GetInputFile(photo_id)},
function(arg,data)
if data.ID == "Ok" then
--return sendMsg(msg.chat_id_,msg.id_,'✿│تم تغيير صوره المـجمـوعهہ ⠀\n✓')
elseif  data.code_ == 3 then
return sendMsg(msg.chat_id_,msg.id_,'✿╿ليس لدي صلاحيه تغيير الصوره \n✿ ╽يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ⠀\n✓')
end
end, nil)
end

end ,nil)
return false
else 
redis:setex(mero..'photo:group'..msg.chat_id_..msg.sender_user_id_,300,true)
return '✿╿حسننا عزيزي 🍁\n✿╽الان قم بارسال الصوره\n✿' 
end 
end


if MsgText[1] == "ضع وصف" then 
if not msg.Creator then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
redis:setex(mero..'about:witting'..msg.sender_user_id_,300,true) 
return "✿╿حسننا عزيزي  \n✿╽الان ارسل الوصف  للمجموعه\n✿" 
end


if MsgText[1] == "طرد البوتات" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),
filter_ ={ID="ChannelMembersBots"},offset_ = 0,limit_ = 50},function(arg,data)
local Total = data.total_count_ or 0
if Total == 1 then
return sendMsg(msg.chat_id_,msg.id_,"✿| لا يـوجـد بـوتـات في الـمـجـمـوعـه .") 
else
local NumBot = 0
local NumBotAdmin = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then
kick_user(v.user_id_,msg.chat_id_,function(arg,data)
if data.ID == "Ok" then
NumBot = NumBot + 1
else
NumBotAdmin = NumBotAdmin + 1
end
local TotalBots = NumBot + NumBotAdmin  
if TotalBots  == Total - 1 then
local TextR  = "✿ | عـدد الـبـوتات •⊱ {* "..(Total - 1).." *} ⊰•\n\n"
if NumBot == 0 then 
TextR = TextR.."✿│لا يـمـكـن طردهم لانـهـم مشـرفـين .\n"
else
if NumBotAdmin >= 1 then
TextR = TextR.."✿ |  لم يتم طـرد {* "..NumBotAdmin.." *} بوت لانهم مـشـرفين."
else
TextR = TextR.."✿ |  تم طـرد كــل البوتات بنجاح .\n"
end
end
return sendMsg(msg.chat_id_,msg.id_,TextR) 
end
end)
end
end
end

end,nil)

return false
end


if MsgText[1] == "كشف البوتات" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),
filter_ ={ID= "ChannelMembersBots"},offset_ = 0,limit_ = 50},function(arg,data)
local total = data.total_count_ or 0
AllBots = '✿| قـائمه البوتات الـحالية\n\n'
local NumBot = 0
for k, v in pairs(data.members_) do
GetUserID(v.user_id_,function(arg,data)
if v.status_.ID == "ChatMemberStatusEditor" then
BotAdmin = "» *★*"
else
BotAdmin = ""
end

NumBot = NumBot + 1
AllBots = AllBots..NumBot..'- @['..data.username_..'] '..BotAdmin..'\n'
if NumBot == total then
AllBots = AllBots..[[

✿| لـديـک {]]..total..[[} بـوتـات
✿| ملاحظة : الـ ★ تعنـي ان البوت مشرف في المجموعـة.]]
sendMsg(msg.chat_id_,msg.id_,AllBots) 
end

end,nil)
end

end,nil)
return false
end


if MsgText[1] == 'طرد المحذوفين' then
if not msg.Creator then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ } فقط  \n✿" end
sendMsg(msg.chat_id_,msg.id_,'✿ | جاري البحث عـن الـحـسـابـات المـحذوفـة ...')
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100','')
,offset_ = 0,limit_ = 200},function(arg,data)
if data.total_count_ and data.total_count_ <= 200 then
Total = data.total_count_ or 0
else
Total = 200
end
local NumMem = 0
local NumMemDone = 0
for k, v in pairs(data.members_) do 
GetUserID(v.user_id_,function(arg,datax)
if datax.type_.ID == "UserTypeDeleted" then 
NumMemDone = NumMemDone + 1
kick_user(v.user_id_,msg.chat_id_,function(arg,data)  
redis:srem(mero..':MONSHA_BOT:'..msg.chat_id_,v.user_id_)
redis:srem(mero..'whitelist:'..msg.chat_id_,v.user_id_)
redis:srem(mero..'owners:'..msg.chat_id_,v.user_id_)
redis:srem(mero..'admins:'..msg.chat_id_,v.user_id_)
end)
end
NumMem = NumMem + 1
if NumMem == Total then
if NumMemDone >= 1 then
sendMsg(msg.chat_id_,msg.id_,"✿│تم طـرد {* "..NumMemDone.." *} من الحسـابات المـحذوفهہ‏‏✿")
else
sendMsg(msg.chat_id_,msg.id_,'✿│لا يوجد حسابات محذوفه في المجموعه✿')
end
end
end,nil)
end
end,nil)
return false
end  

if MsgText[1] == "id" or MsgText[1] == "ايدي"  then
if is_JoinChannel(msg) == false then
return false
end
if not MsgText[2] and not msg.reply_id then
if redis:get(mero..'lock_id'..msg.chat_id_) then 
local msgs = redis:get(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then UserNameID = "@"..data.username_.."" else UserNameID = "" end
local points = redis:get(mero..':User_Points:'..msg.chat_id_..msg.sender_user_id_)
if points and points ~= "0" then
nko = points
else
nko = '0'
end
local rfih = (redis:get(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local NumGha = (redis:get(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local Namei = FlterName(data.first_name_..' '..(data.last_name_ or ""),20)
GetPhotoUser(msg.sender_user_id_,function(arg, data)
if redis:get(mero.."getidstatus"..msg.chat_id_) == "Photo" then
	if data.photos_[0] then 
		ali = {'❤❤❤❤❤️','🧡🧡🧡🧡🧡','💛💛💛💛💛','💚💚💚💚💚','💙💙💙💙💙️','💜💜💜💜💜','🤎🤎🤎🤎🤎️','🖤🖤🖤🖤🖤','🤍🤍🤍🤍🤍',
		}
		ssssys = ali[math.random(#ali)]
		if not redis:get("KLISH:ID") then
		sendPhoto(msg.chat_id_,msg.id_,data.photos_[0].sizes_[1].photo_.persistent_id_,'✹                   '..ssssys..'\n✹ ʏᴏᴜʀ ɪᴅ ➥• ❪ '..msg.sender_user_id_..' ❫\n✹ ᴜѕᴇʀɴᴀᴍᴇ ➥• ❪ '..UserNameID..' ❫\n✹ ѕᴛᴀᴛѕ ➥• ❪ '..msg.TheRank..' ❫\n✹ᴅᴇᴛᴀɪʟs ➥• ❪ '..Get_Ttl(msgs)..' ❫\n✹ᴍѕɢѕ ➥• ❪ '..msgs..' ❫\n✹ᴇᴅɪᴛ ᴍsɢ ➥• ❪ '..rfih..' ❫\n✹ ɢᴀᴍᴇ ➥• ❪ '..nko..' ❫',dl_cb,nil)
		else
		Text = redis:get("KLISH:ID")
		Text = Text:gsub('IDGET',msg.sender_user_id_)
		Text = Text:gsub('USERGET',UserNameID)
		Text = Text:gsub('RTBGET',msg.TheRank)
		Text = Text:gsub('TFGET',Get_Ttl(msgs))
		Text = Text:gsub('MSGGET',msgs)
		Text = Text:gsub('edited',rfih)
		Text = Text:gsub('adduser',NumGha)
		Text = Text:gsub('User_Points',nko)
		sendPhoto(msg.chat_id_,msg.id_,data.photos_[0].sizes_[1].photo_.persistent_id_,"🎇│"..ssssys.."\n"..Text.."",dl_cb,nil)
		end
	else
		if not redis:get("KLISH:ID") then
		sendMsg(msg.chat_id_,msg.id_,'✿│لا يمكنني عرض صورتك لانك قمت بحظر البوت او انك لاتملك صوره في بروفيلك ...!\n✹ ɴᴀᴍᴇ ➥• ❪ '..Namei..' ❫\n✹ ᴜѕᴇʀɴᴀᴍᴇ ➥• ❪ ['..UserNameID..'] ❫\n✹ ʏᴏᴜʀ ɪᴅ ➥• ❪ '..msg.sender_user_id_..' ❫\n✹ ѕᴛᴀᴛѕ ➥• ❪ '..msg.TheRank..' ❫\n✹ᴅᴇᴛᴀɪʟs ➥• ❪ '..Get_Ttl(msgs)..' ❫\n✹ᴍѕɢѕ ➥• ❪ '..msgs..' ❫\n✹ᴇᴅɪᴛ ᴍsɢ ➥• ❪ '..rfih..' ❫\n✹AddUser ➥• ❪ '..NumGha..' ❫\n✹ ɢᴀᴍᴇ ➥• ❪ '..nko..' ❫\n')
		else
		Text = redis:get("KLISH:ID")
		Text = Text:gsub('IDGET',msg.sender_user_id_)
		Text = Text:gsub('USERGET',UserNameID)
		Text = Text:gsub('RTBGET',msg.TheRank)
		Text = Text:gsub('TFGET',Get_Ttl(msgs))
		Text = Text:gsub('MSGGET',msgs)
		Text = Text:gsub('edited',rfih)
		Text = Text:gsub('adduser',NumGha)
		Text = Text:gsub('User_Points',nko)
		sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Text))
		end
	end
else
	if redis:get("KLISH:ID") then
		Text = redis:get("KLISH:ID")
		Text = Text:gsub('IDGET',msg.sender_user_id_)
		Text = Text:gsub('USERGET',UserNameID)
		Text = Text:gsub('RTBGET',msg.TheRank)
		Text = Text:gsub('TFGET',Get_Ttl(msgs))
		Text = Text:gsub('MSGGET',msgs)
		Text = Text:gsub('edited',rfih)
		Text = Text:gsub('adduser',NumGha)
		Text = Text:gsub('User_Points',nko)
		sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Text))
		else
		sendMsg(msg.chat_id_,msg.id_,'✿│الايدي بالصوره معطل \n✹ ɴᴀᴍᴇ ➥• ❪ '..Namei..' ❫\n✹ ᴜѕᴇʀɴᴀᴍᴇ ➥• ❪ ['..UserNameID..'] ❫\n✹ ʏᴏᴜʀ ɪᴅ ➥• ❪ '..msg.sender_user_id_..' ❫\n✹ ѕᴛᴀᴛѕ ➥• ❪ '..msg.TheRank..' ❫\n✹ᴅᴇᴛᴀɪʟs ➥• ❪ '..Get_Ttl(msgs)..' ❫\n✹ᴍѕɢѕ ➥• ❪ '..msgs..' ❫\n✹ᴇᴅɪᴛ ᴍsɢ ➥• ❪ '..rfih..' ❫\n✹AddUser ➥• ❪ '..NumGha..' ❫\n✹ ɢᴀᴍᴇ ➥• ❪ '..nko..' ❫\n')
		end
end

end) 
end ,nil)
end
return false
end

if msg.reply_id and not MsgText[2] then
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="iduser"})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="iduser"})
return false
end 
return false
end

if MsgText[1] == "الرتبه" and not MsgText[2] and msg.reply_id then 
return GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="rtba"})
end


if MsgText[1]== 'رسائلي' or MsgText[1] == 'رسايلي' or MsgText[1] == 'احصائياتي'  then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:get(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(mero..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(mero..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(mero..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(mero..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(mero..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(mero..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info =  " \n✿│❪ احصائيات رسائلك ❫\n ـــــــــــــــــــــــــــــــــــــــــــــــــــــــ \n"
.."✿╿الـرسـائـل ❪ "..msgs.." ❫\n"
.."✿│الـجـهـات ❪ "..NumGha.." ❫\n"
.."✿│الـصـور ❪ "..photo.." ❫\n"
.."✿│الـمـتـحـركـه ❪ "..animation.." ❫\n"
.."✿│الـمـلـصـقات ❪ "..sticker.." ❫\n"
.."✿│الـبـصـمـات ❪ "..voice.." ❫\n"
.."✿│الـصـوت ❪ "..audio.." ❫\n"
.."✿│الـفـيـديـو ❪ "..video.." ❫\n"
.."✿│الـتـعـديـل ❪ "..edited.." ❫\n"
.."✿╽تـفـاعـلـك ❪ "..Get_Ttl(msgs).." ❫\n"
return sendMsg(msg.chat_id_,msg.id_,Get_info)    
end,nil)
return false
end

if MsgText[1] == 'مسح' and MsgText[2] == 'رسائلي'   then
local msgs = redis:get(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if rfih == 0 then  return "✿*│*عذرا لا يوجد رسائل لك في البوت  ✿" end
redis:del(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
return "✿*│*تم مسح {* "..msgs.." *} من رسائلك \n✓"
end

if MsgText[1]== 'جهاتي'  then
return '✿*│*  عدد جهاتك‏‏ ⇜ ❪ '..(redis:get(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)..' ❫'
end

if MsgText[1] == 'مسح' and MsgText[2] == 'جهاتي'   then
local adduser = redis:get(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0
if adduser == 0 then  return "✿*│*عذرا ليس لديك جهات لكي يتم مسحها" end
redis:del(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) 
return "✿*│*تم مسح {* "..adduser.." *} من جهاتك\n✓"
end

if MsgText[1]== 'اسمي' then
GetUserID(msg.sender_user_id_,function(arg,data)
local FlterName = FlterName(data.first_name_..'\n\n✿│اسمك الثاني ⇜ '..(data.last_name_ or ""),90)
local Get_info = "✿│اسمك الاول ⇜ \n "..FlterName.." \n"
return sendMsg(msg.chat_id_,msg.id_,Get_info)    
end,nil)
return false
end

if MsgText[1] == 'مسح' and MsgText[2] == 'نقاطي'   then
local points = redis:get(mero..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
if points == 0 then  return "✿*│*عذرا ليس لديك مجوهرات لكي يتم مسحها" end
redis:del(mero..':User_Points:'..msg.chat_id_..msg.sender_user_id_)
return "✿*│*تم مسح {* "..points.." *} من مجوهراتك\n✓"
end

if MsgText[1] == 'معلوماتي' then
GetUserID(msg.sender_user_id_,function(arg,data)

local msgs = (redis:get(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(mero..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(mero..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(mero..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(mero..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(mero..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(mero..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info ="✿│اهـلا بـك عزيزي في معلوماتك 🥀 \n"
.."𖤍━┅┄⟞⟦✿ 𝐓𝐎𝐋𝐄𝐍 ✿⟧⟝┄┉━𖤍\n"
.."✿╿الاســم ❪ "..FlterName(data.first_name_..' '..(data.last_name_ or ""),25).." ❫\n"
.."✿│المعرف ❪ "..ResolveUser(data).." ❫\n"
.."✿│الايـدي ❪ `"..msg.sender_user_id_.."` ❫\n"
.."✿│رتبتــك ❪ "..msg.TheRank.."❫\n"
.."✿╽ـ ❪ `"..msg.chat_id_.."` ❫\n"
.."𖤍━┅┄⟞⟦✿ 𝐓𝐎𝐋𝐄𝐍 ✿⟧⟝┄┉━𖤍\n"
.." ❪ احـصـائـيـات الـرسـائـل ❫\n ـــــــــــــــــــــــــــــــــــــــــــــــــــــــ \n"
.."✿╿الـرسـائـل ❪ `"..msgs.."` ❫\n"
.."✿│الـجـهـات ❪ `"..NumGha.."` ❫\n"
.."✿│الـصـور ❪ `"..photo.."` ❫\n"
.."✿│الـمـتـحـركـه ❪ `"..animation.."` ❫\n"
.."✿│الـمـلـصـقات ❪ `"..sticker.."` ❫\n"
.."✿│الـبـصـمـات ❪ `"..voice.."` ❫\n"
.."✿│الـصـوت ❪ `"..audio.."` ❫\n"
.."✿│الـفـيـديـو ❪ `"..video.."` ❫\n"
.."✿│الـتـعـديـل ❪`"..edited.."` ❫\n"
.."✿╽تـفـاعـلـك ❪ "..Get_Ttl(msgs).." ❫\n"
return sendMsg(msg.chat_id_,msg.id_,Get_info)    
end,nil)
return false
end
if MsgText[1] == "موقعي" then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,deata) 
if deata.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'مالك المجموعه'
elseif deata.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف المجموعه' 
elseif deata.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو في المجموعه'
end
return sendMsg(msg.chat_id_, msg.id_,'✿| موقعك : '..rtpa)
end,nil)
return false
end
if MsgText[1] == "مسح معلوماتي" then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:del(mero..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:del(mero..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:del(mero..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:del(mero..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:del(mero..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:del(mero..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:del(mero..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:del(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:del(mero..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info ="✿│اهلاً عزيزي تم حذف جميع معلوماتك "
return sendMsg(msg.chat_id_,msg.id_,Get_info)    
end,nil)
return false
end

if MsgText[1] == "فتح تعديل الميديا" 		then return unlock_edit_media(msg) end 
if MsgText[1] == "قفل تعديل الميديا" 		then return lock_edit_media(msg) end 

if MsgText[1] == "فتح الفشار" 		then return unlock_mmno3(msg) end 
if MsgText[1] == "قفل الفشار" 		then return lock_mmno3(msg) end 

if MsgText[1] == "تفعيل الردود العشوائيه" 	then return unlock_replayRn(msg) end
if MsgText[1] == "تعطيل الردود العشوائيه" 	then return lock_replayRn(msg) end

if MsgText[1] == "فتح الفارسيه" 		then  return unlock_pharsi(msg) end 
if MsgText[1] == "قفل الفارسيه" 		then return lock_pharsi(msg) end 

if MsgText[1] == "تفعيل" then

if MsgText[2] == "الردود" 	then return unlock_replay(msg) end
if MsgText[2] == "الردود العامه" 	then return unlock_replayall(msg) end
if MsgText[2] == "الاذاعه" 	then return unlock_brod(msg) end
if MsgText[2] == "الايدي" 	then return unlock_ID(msg) end
if MsgText[2] == "االترحيب" 	then return unlock_Welcome(msg) end
if MsgText[2] == "التحذير" 	then return unlock_waring(msg) end 
end




if MsgText[1] == "تعطيل" then

if MsgText[2] == "الردود" 	then return lock_replay(msg) end
if MsgText[2] == "الردود العامه" 	then return lock_replayall(msg) end
if MsgText[2] == "الاذاعه" 	then return lock_brod(msg) end
if MsgText[2] == "الايدي" 	then return lock_ID(msg) end
if MsgText[2] == "االترحيب" 	then return lock_Welcome(msg) end
if MsgText[2] == "التحذير" 	then return lock_waring(msg) end
end


if MsgText[1] == "ضع الترحيب" then 
if not msg.Admin then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير ، الادمن} فقط  \n✿" end
redis:set(mero..'welcom:witting'..msg.sender_user_id_,true) 
return "✿╿حسنا عزيزي  \n✿│ارسل كليشه الترحيب الان\n\n✿│ملاحظه تستطيع اضافه دوال للترحيب مثلا :\n✿│اضهار قوانين المجموعه  » *{القوانين}*  \n✿│ اضهار الاسم العضو » *{الاسم}*\n✿│اضهار المعرف العضو » *{المعرف}*\n✿╽اضهار اسم المجموعه » *{المجموعه}*" 
end

if MsgText[1] == 'تفعيل الترحيب' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero..'welcome:gett'..msg.chat_id_) then
sendMsg(msg.chat_id_,msg.id_,'تم تفعيل الترحيب سابقا')
else
sendMsg(msg.chat_id_,msg.id_,'تم تفعيل الترحيب')
redis:set(mero..'welcome:gett'..msg.chat_id_,'true')
end
end
if MsgText[1] == 'تعطيل الترحيب' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not redis:get(mero..'welcome:gett'..msg.chat_id_) then
sendMsg(msg.chat_id_,msg.id_,'تم تعطيل الترحيب سابقا')
else
redis:del(mero..'welcome:gett'..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'تم تعطيل الترحيب')
end
end

if MsgText[1] == "الترحيب" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero..'welcome:msg'..msg.chat_id_)  then
return Flter_Markdown(redis:get(mero..'welcome:msg'..msg.chat_id_))
else 
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."  \n✿╽لا يوجد ترحيب في المجموعه" 
end 
end


if MsgText[1] == "كشف"  then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="whois"})
return false
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="whois"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="whois"}) 
return false
end 
end


if MsgText[1] == "طرد"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero.."Ban:Cheking"..msg.chat_id_) then
return 'الحظر - الطرد تم تعطيله هنا'
end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_restrict_members ~= true then
return  "ليست لدي صلاحيه الحظر"
end
end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="kick"})  
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="kick"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="kick"}) 
return false
end 
end


if MsgText[1] == "حظر"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero.."Ban:Cheking"..msg.chat_id_) then
return 'الحظر - الطرد تم تعطيله هنا'
end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_restrict_members ~= true then
return  "ليست لدي صلاحيه الحظر"
end
end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="ban"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ban"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="ban"}) 
return false
end 
end


if (MsgText[1] == "الغاء الحظر" or MsgText[1] == "الغاء حظر") and msg.Admin then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="unban"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="uban"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="unban"})
return false
end 
end


if MsgText[1] == "كتم"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="silent"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ktm"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="silent"}) 
return false
end 
end


if MsgText[1] == "الغاء الكتم" or MsgText[1] == "الغاء كتم"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="unsilent"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unktm"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="unsilent"}) 
return false
end 
end

if MsgText[1] == "المكتومين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return MuteUser_list(msg) 
end

if MsgText[1] == "المحظورين" then 
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
return GetListBanned(msg) 
end

if MsgText[1] == "رفع الادمنيه" then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
return set_admins(msg) 
end

end -- end of insert group 


if MsgText[1] == 'مسح' and MsgText[2] == 'المطورين'  then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
local mtwren = redis:scard(mero..':SUDO_BOT:')
if mtwren == 0 then  return "✿*│* عذرا لا يوجد مطورين في البوت  ✿" end
redis:del(mero..':SUDO_BOT:') 
return "✿*│* تم مسح {* "..mtwren.." *} من المطورين \n✓"
end

if MsgText[1] == 'مسح' and MsgText[2] == "قائمه العام"  then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
local addbannds = redis:scard(mero..'gban_users')
if addbannds ==0 then 
return "*✿│قائمة الحظر فارغه .*" 
end
redis:del(mero..'gban_users') 
return "✿*│* تـم مـسـح { *"..addbannds.." *} من قائمه العام\n✓" 
end 

if msg.SudoBase then

if MsgText[1] == "رفع مطور" then
if not msg.SudoBase then return "✿*│*هذا الامر يخص {المطور الاساسي ✿} فقط  \n✿" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="up_sudo"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="up_sudo"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="up_sudo"}) 
return false
end 
end

if MsgText[1] == "تنزيل مطور" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="dn_sudo"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="dn_sudo"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="dn_sudo"}) 
return false
end 
end

if MsgText[1] == "تنظيف المجموعات" or MsgText[1] == "تنظيف المجموعات ✿" then
local groups = redis:smembers(mero..'group:ids')
local GroupsIsFound = 0
for i = 1, #groups do 
GroupTitle(groups[i],function(arg,data)
if data.code_ and data.code_ == 400 then
rem_data_group(groups[i])
print(" Del Group From list ")
else
print(" Name Group : "..data.title_)
GroupsIsFound = GroupsIsFound + 1
end
print(GroupsIsFound..' : '..#groups..' : '..i)
if #groups == i then
local GroupDel = #groups - GroupsIsFound 
if GroupDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'✿*│* جـيـد , لا توجد مجموعات وهميه \n✓')
else
sendMsg(msg.chat_id_,msg.id_,'✿*╿* عدد المجموعات •⊱ { *'..#groups..'*  } ⊰•\n✿*│* تـم تنظيف  •⊱ { *'..GroupDel..'*  } ⊰• مجموعه \n📉*╽* اصبح العدد الحقيقي الان •⊱ { *'..GroupsIsFound..'*  } ⊰• مجموعه')
end
end
end)
end
return false
end
if MsgText[1] == "تنظيف المشتركين ✿" or MsgText[1] == "تنظيف المشتركين ✿" then
local pv = redis:smembers(mero..'users')
local NumPvDel = 0
for i = 1, #pv do
GroupTitle(pv[i],function(arg,data)
sendChatAction(pv[i],"Typing",function(arg,data)
if data.ID and data.ID == "Ok"  then
print("Sender Ok")
else
print("Failed Sender Nsot Ok")
redis:srem(mero..'users',pv[i])
NumPvDel = NumPvDel + 1
end
if #pv == i then 
if NumPvDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'⚜| جـيـد , لا يوجد مشتركين وهميين')
else
local SenderOk = #pv - NumPvDel
sendMsg(msg.chat_id_,msg.id_,'✿*╿* عدد المشتركين •⊱ { *'..#pv..'*  } ⊰•\n✿*│* تـم تنظيف  •⊱ { *'..NumPvDel..'*  } ⊰• مشترك \n📉*╽* اصبح العدد الحقيقي الان •⊱ { *'..SenderOk..'*  } ⊰• من المشتركين') 
end
end
end)
end)
end
return false
end
if MsgText[1] == "ضع صوره للترحيب" or MsgText[1]=="ضع صوره للترحيب ✿" then
redis:setex(mero..'welcom_ph:witting'..msg.sender_user_id_,300,true) 
return'✿╿حسننا عزيزي 🍁\n✿ ╽الان قم بارسال الصوره للترحيب \n✿' 
end

if MsgText[1] == "تعطيل" and MsgText[2] == "البوت خدمي" then
return lock_service(msg) 
end

if MsgText[1] == "تفعيل" and MsgText[2] == "البوت خدمي" then 
return unlock_service(msg) 
end

if MsgText[1] == "صوره الترحيب" then
local Photo_Weloame = redis:get(mero..':WELCOME_BOT')
if Photo_Weloame then
sendPhoto(msg.chat_id_,msg.id_,Photo_Weloame,[[⚜╿اهلا انا بوت اسـمـي ]]..redis:get(mero..':NameBot:')..[[ ✓
👨🏻‍✈️│اختصـاصـي حمـايه المـجمـوعات
✿╽مـن السـبام والتوجيه‌‏ والتكرار والخ...

✿│مـعـرف الـمـطـور  » ]]..SUDO_USER:gsub([[\_]],'_')..[[✿
]])

return false
else
return "✿╿لا توجد صوره مضافه للترحيب في البوت \n✿╽ لاضافه صوره الترحيب ارسل `ضع صوره للترحيب`"
end
end

if MsgText[1] == "ضع كليشه المطور" then 
redis:setex(mero..'text_sudo:witting'..msg.sender_user_id_,1200,true) 
return '✿╿حسننا عزيزي 🍁\n✿╽الان قم بارسال الكليشه \n✿' 
end

if MsgText[1] == "ضع شرط التفعيل" and MsgText[2] and MsgText[2]:match('^%d+$') then 
redis:set(mero..':addnumberusers',MsgText[2]) 
return '✿*│* تم وضـع شـرط التفعيل البوت اذا كانت المـجمـوعه اكثر مـن *【'..MsgText[2]..'】* عضـو  🍁\n' 
end

if MsgText[1] == "شرط التفعيل" then 
return'✿*│* شـرط التفعيل البوت اذا كانت المـجمـوعه اكثر مـن *【'..redis:get(mero..':addnumberusers')..'】* عضـو  🍁\n' 
end 
end

if MsgText[1] == 'المجموعات' or MsgText[1] == "المجموعات ✿" then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
return '✿*│* عدد المجموعات المفعلة » `'..redis:scard(mero..'group:ids')..'`  ➼' 
end

if MsgText[1] == "المشتركين" or MsgText[1] == "المشتركين ✿" then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
return '✿*│*عدد المشتركين في البوت : `'..redis:scard(mero..'users')..'` \n✿'
end

if MsgText[1] == 'قائمه المجموعات' then 
if not msg.SudoBase then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
return chat_list(msg) 
end

if MsgText[1] == 'تعطيل' and MsgText[2] and MsgText[2]:match("-100(%d+)") then
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if redis:sismember(mero..'group:ids',MsgText[2]) then
local name_gp = redis:get(mero..'group:name'..MsgText[2])
sendMsg(MsgText[2],0,'✿*╿* تم تعطيل المجموعه بأمر من المطور  \n✿*╽* سوف اغادر 😢😭 ...\n✘')
rem_data_group(MsgText[2])
StatusLeft(MsgText[2],our_id)
return '✿*╿* تم تعطيل المجموعه ومغادرتها \n✿*│* المجموعةة » ['..name_gp..']\n✿*╽* الايدي » ( *'..MsgText[2]..'* )\n✓'
else 
return '✿*│* لا توجد مجموعه مفعله بهذا الايدي !\n ' 
end 
end 

if MsgText[1] == 'المطور' then
return redis:get(mero..":TEXT_SUDO") or '🗃╿لا توجد كليشه المطور .\n✿╽يمكنك اضافه كليشه من خلال الامر\n       " `ضع كليشه المطور` " \n✿'
end

if MsgText[1] == "اذاعه عام بالتوجيه" or MsgText[1] == "اذاعه عام بالتوجيه ✿" then
if not msg.SudoUser then return"✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if not msg.SudoBase and not redis:get(mero..'lock_brod') then 
return "✿*│* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(mero..'fwd:'..msg.sender_user_id_,300, true) 
return "✿│حسننا الان ارسل التوجيه للاذاعه \n✿" 
end

if MsgText[1] == "اذاعه عام" or MsgText[1] == "اذاعه عام ✿" then		
if not msg.SudoUser then return"✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if not msg.SudoBase and not redis:get(mero..'lock_brod') then 
return "✿*│* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(mero..'fwd:all'..msg.sender_user_id_,300, true) 
return "✿│حسننا الان ارسل الكليشه للاذاعه عام \n✿" 
end

if MsgText[1] == "اذاعه خاص" or MsgText[1] == "اذاعه خاص ✿" then		
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if not msg.SudoBase and not redis:get(mero..'lock_brod') then 
return "✿*│* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(mero..'fwd:pv'..msg.sender_user_id_,300, true) 
return "✿│حسننا الان ارسل الكليشه للاذاعه خاص \n✿"
end

if MsgText[1] == "اذاعه" or MsgText[1] == "اذاعه ✿" then		
if not msg.SudoUser then return"✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
if not msg.SudoBase and not redis:get(mero..'lock_brod') then 
return "✿*│* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(mero..'fwd:groups'..msg.sender_user_id_,300, true) 
return "✿│حسننا الان ارسل الكليشه للاذاعه للمجموعات \n✿" 
end

if MsgText[1] == "المطورين" or MsgText[1] == "المطورين ✿" then
if not msg.SudoUser then return"✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
return sudolist(msg) 
end
 
if MsgText[1] == "قائمه العام" or MsgText[1]=="قائمه العام ✿" then 
if not msg.SudoUser then return"✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
return GetListGeneralBanned(msg) 
end

if MsgText[1] == "تعطيل" and (MsgText[2] == "التواصل" or MsgText[2]=="التواصل ✿") then 
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return lock_twasel(msg) 
end

if MsgText[1] == "تفعيل" and (MsgText[2] == "التواصل" or MsgText[2]=="التواصل ✿") then 
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return unlock_twasel(msg) 
end

if MsgText[1] == "حظر عام" then
if not msg.SudoBase then 
return "✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" 
end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="banall"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="bandall"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="banall"}) 
return false
end 
end

if MsgText[1] == "الغاء العام" or MsgText[1] == "الغاء عام" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,action_by_reply,{msg=msg,cmd="unbanall"}) 
return false
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unbandall"}) 
return false
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],action_by_username,{msg=msg,cmd="unbanall"}) 
return false
end 
end 

if MsgText[1] == "رتبتي" then return '✿*│* رتبتك ⇜ ❪ '..msg.TheRank..' ❫\n✿' end

----------------- استقبال الرسائل ---------------
if MsgText[1] == "الغاء الامر ✿" or MsgText[1] == "الغاء" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
redis:del(mero..'welcom:witting'..msg.sender_user_id_,
mero..'rulse:witting'..msg.sender_user_id_,
mero..'rulse:witting'..msg.sender_user_id_,
mero..'name:witting'..msg.sender_user_id_,
mero..'about:witting'..msg.sender_user_id_,
mero..'fwd:all'..msg.sender_user_id_,
mero..'fwd:pv'..msg.sender_user_id_,
mero..'fwd:groups'..msg.sender_user_id_,
mero..'namebot:witting'..msg.sender_user_id_,
mero..'addrd_all:'..msg.sender_user_id_,
mero..'delrd:'..msg.sender_user_id_,
mero..'addrd:'..msg.sender_user_id_,
mero..'delrdall:'..msg.sender_user_id_,
mero..'text_sudo:witting'..msg.sender_user_id_,
mero..'addrd:'..msg.chat_id_..msg.sender_user_id_,
mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return '✿*│* تم الغاء الامـر بنجاح \n✿'
end  


if MsgText[1] == 'اصدار السورس' or MsgText[1] == 'الاصدار' then
return '‍🔧│ اصدار سورس تولين : *v'..version..'* '
end

if (MsgText[1] == 'تحديث السورس' or MsgText[1] == 'تحديث السورس ✿') then
if not msg.SudoBase then return "✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
github = [[ cd inc 
rm -rf Run.lua 
rm -rf Script.lua 
rm -rf functions.lua 
rm -rf locks.lua 
wget https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Run.lua
wget https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/Script.lua
wget https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/functions.lua
wget https://raw.githubusercontent.com/VivazAli/Vivaz/main/inc/locks.lua
]]
os.execute(github)
sendMsg(msg.chat_id_,msg.id_,'✿| {* تــم تحديث وتثبيت السورس  *} ✿.\n\n✿| { Bot is Update » }✿',nil,function(arg,data)
dofile("./inc/Run.lua")
print("Reload ~ ./inc/Run.lua")
end) 
return false
end


if MsgText[1] == 'نسخه احتياطيه للمجموعات' then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return buck_up_groups(msg)
end 
if MsgText[1] == ("مسح الردود المتعدده") then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local list = redis:smembers(mero.."botss:merox:List:Rd:Sudo"..msg.chat_id_)
for k,v in pairs(list) do  
redis:del(mero.."botss:merox:Add:Rd:Sudo:Text"..v..msg.chat_id_) 
redis:del(mero.."botss:merox:Add:Rd:Sudo:Text1"..v..msg.chat_id_) 
redis:del(mero.."botss:merox:Add:Rd:Sudo:Text2"..v..msg.chat_id_)   
redis:del(mero.."botss:merox:List:Rd:Sudo"..msg.chat_id_)
end
sendMsg(msg.chat_id_, msg.id_,"تم حذف ردود المتعدده")
end
if MsgText[1] == ("الردود المتعدده") then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local list = redis:smembers(mero.."botss:merox:List:Rd:Sudo"..msg.chat_id_)
text = "\nقائمة ردود المتعدده \n━━━━━━━━\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
sendMsg(msg.chat_id_, msg.id_,"["..text.."]")
end
if MsgText[1] == "اضف رد متعدد" then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
redis:set(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return "ارسل الكلمه الان "
end
if MsgText[1] == "مسح رد متعدد" then 
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
redis:set(mero.."botss:merox:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return "ارسل الكلمه الان "
end
if MsgText[1] == 'رفع نسخه الاحتياطيه' then
if not msg.SudoBase then return "✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessageDocument' then
local file_name = data.content_.document_.file_name_
if file_name:match('.json')then
if file_name:match('@[%a%d_]+.json') then
if file_name:lower():match('@[%a%d_]+') == Bot_User:lower() then 
io.popen("rm -f ../.telegram-cli/data/document/*")
local file_id = data.content_.document_.document_.id_ 
tdcli_function({ID = "DownloadFile",file_id_ = file_id},function(arg, data) 
if data.ID == "Ok" then
Uploaded_Groups_Ok = true
Uploaded_Groups_CH = msg.chat_id_
Uploaded_Groups_MS = msg.id_
print(Uploaded_Groups_CH)
print(Uploaded_Groups_MS)
sendMsg(msg.chat_id_,msg.id_,'⏳*│* جاري رفع النسخه انتظر قليلا ... \n⌛️')
end
end,nil)
else 
sendMsg(msg.chat_id_,msg.id_,"✿*│* عذرا النسخه الاحتياطيه هذا ليست للبوت » ["..Bot_User.."]  \n✿")
end
else 
sendMsg(msg.chat_id_,msg.id_,'✿*│* عذرا اسم الملف غير مدعوم للنظام او لا يتوافق مع سورس تولين يرجى جلب الملف الاصلي الذي قمت بسحبه وبدون تعديل ع الاسم\n✿')
end  
else
sendMsg(msg.chat_id_,msg.id_,'✿*│* عذرا الملف ليس بصيغه Json !?\n✿')
end 
else
sendMsg(msg.chat_id_,msg.id_,'✿*│* عذرا هذا ليس ملف النسحه الاحتياطيه للمجموعات\n✿')
end 
end,nil)
else 
return "✿*╿* ارسل ملف النسخه الاحتياطيه اولا\n✿*╽* ثم قم بالرد على الملف وارسل \" `رفع نسخه الاحتياطيه` \" "
end 
return false
end

if (MsgText[1]=="تيست" or MsgText[1]=="test") then 
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return "🟢 البوت شـغــال 🟢" 
end

if (MsgText[1]== "ايدي" or MsgText[1]=="ايديي✿") and msg.type == "pv" then return  "\n✿ | اهلاً عزيزي المطور ايديك هو ⏬\n\n✿│"..msg.sender_user_id_.."\n"  end

if MsgText[1]== "قناة السورس ✿" and msg.type == "pv" then
local inline = {{{text="⚜│قناہ‏‏ السـورس ضـغـط هـنـا ",url="t.me/Y_Q_8"}}}
send_key(msg.sender_user_id_,'  [⚜│قناة سورس : تولين](t.me/Y_Q_8)',nil,inline,msg.id_)
return false
end

if (MsgText[1]== "الاحصائيات ✿" or MsgText[1]=="الاحصائيات") then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
return '✿│الاحصائيات ✿ \n\n✿*╿*عدد المجموعات المفعله : '..redis:scard(mero..'group:ids')..'\n✿*╽*عدد المشتركين في البوت : '..redis:scard(mero..'users')..'\n✿'
end
---------------[End Function data] -----------------------
if MsgText[1]=="اضف رد عام" or MsgText[1]=="اضف رد عام ✿" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
redis:setex(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_,300,true)
redis:del(mero..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
return "✿│حسننا الان ارسل كلمة الرد العام ✿\n"
end
if MsgText[1]=="مسح رد عام" or MsgText[1]=="مسح رد عام ✿" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
redis:set(mero..'delrdall:'..msg.sender_user_id_,true) 
return "✿╿حسننا عزيزي  \n✿╽الان ارسل الرد لمسحها من  المجموعات ✿"
end

if MsgText[1]== 'مسح' and MsgText[2]== 'الردود' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
local names 	= redis:exists(mero..'replay:'..msg.chat_id_)
local photo 	= redis:exists(mero..'replay_photo:group:'..msg.chat_id_)
local voice 	= redis:exists(mero..'replay_voice:group:'..msg.chat_id_)
local imation   = redis:exists(mero..'replay_animation:group:'..msg.chat_id_)
local audio	 	= redis:exists(mero..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:exists(mero..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:exists(mero..'replay_video:group:'..msg.chat_id_)
if names or photo or voice or imation or audio or sticker or video then
redis:del(mero..'replay:'..msg.chat_id_,mero..'replay_photo:group:'..msg.chat_id_,mero..'replay_voice:group:'..msg.chat_id_,
mero..'replay_animation:group:'..msg.chat_id_,mero..'replay_audio:group:'..msg.chat_id_,mero..'replay_sticker:group:'..msg.chat_id_,mero..'replay_video:group:'..msg.chat_id_)
return "✓ تم مسح كل الردود 🚀"
else
return '✿*│* لا يوجد ردود ليتم مسحها \n✿'
end
end

if MsgText[1]== 'مسح' and MsgText[2]== 'الردود العامه' then
if not msg.SudoBase then return"♨️ للمطورين فقط ! ✿" end
local names 	= redis:exists(mero..'replay:all')
local photo 	= redis:exists(mero..'replay_photo:group:')
local voice 	= redis:exists(mero..'replay_voice:group:')
local imation 	= redis:exists(mero..'replay_animation:group:')
local audio 	= redis:exists(mero..'replay_audio:group:')
local sticker 	= redis:exists(mero..'replay_sticker:group:')
local video 	= redis:exists(mero..'replay_video:group:')
if names or photo or voice or imation or audio or sticker or video then
redis:del(mero..'replay:all',mero..'replay_photo:group:',mero..'replay_voice:group:',mero..'replay_animation:group:',mero..'replay_audio:group:',mero..'replay_sticker:group:',mero..'replay_video:group:')
return "✓ تم مسح كل الردود العامه🚀"
else
return "لا يوجد ردود عامه ليتم مسحها ! 🚀"
end
end



if MsgText[1]== 'مسح' and MsgText[2]== 'رد' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
redis:set(mero..'delrd:'..msg.sender_user_id_,true)
return "✿╿حسننا عزيزي  \n✿╽الان ارسل الرد لمسحها من  المجموعه"
end

if MsgText[1]== 'الردود' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
local names  	= redis:hkeys(mero..'replay:'..msg.chat_id_)
local photo 	= redis:hkeys(mero..'replay_photo:group:'..msg.chat_id_)
local voice  	= redis:hkeys(mero..'replay_voice:group:'..msg.chat_id_)
local imation 	= redis:hkeys(mero..'replay_animation:group:'..msg.chat_id_)
local audio 	= redis:hkeys(mero..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:hkeys(mero..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:hkeys(mero..'replay_video:group:'..msg.chat_id_)
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 then 
return '✿*│*لا يوجد ردود مضافه حاليا \n✿' 
end
local ii = 1
local message = '✿*│*ردود البوت في المجموعه  :\n\n'
for i=1, #photo 	do message = message ..ii..' - *{* '..	photo[i]..' *}_*( صوره ) \n' 	 ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' - *{* '..	names[i]..' *}_*( نص ) \n'  	 ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' - *{* '..  voice[i]..' *}_*( بصمه ) \n' 	 ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' - *{* '..imation[i]..' *}_*( متحركه ) \n' ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' - *{* '..	audio[i]..' *}_*( صوتيه ) \n'  ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' - *{* '..sticker[i]..' *}_*( ملصق ) \n' 	 ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' - *{* '..	video[i]..' *}_*( فيديو ) \n' ii = ii + 1 end
return message..'\n'
end

if MsgText[1]== 'الردود العامه' or MsgText[1]=='الردود العامه ✿' then
if not msg.SudoBase then return "♨️ للمطور فقط ! ✿" end
local names 	= redis:hkeys(mero..'replay:all')
local photo 	= redis:hkeys(mero..'replay_photo:group:')
local voice 	= redis:hkeys(mero..'replay_voice:group:')
local imation 	= redis:hkeys(mero..'replay_animation:group:')
local audio 	= redis:hkeys(mero..'replay_audio:group:')
local sticker 	= redis:hkeys(mero..'replay_sticker:group:')
local video 	= redis:hkeys(mero..'replay_video:group:')
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 then 
return '✿*│*لا يوجد ردود مضافه حاليا \n✿' 
end
local ii = 1
local message = '✿*│*الردود العامه في البوت :   :\n\n'
for i=1, #photo 	do message = message ..ii..' - *{* '..	photo[i]..' *}_*( صوره ) \n' 	ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' - *{* '..	names[i]..' *}_*( نص ) \n'  	ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' - *{* '..	voice[i]..' *}_*( بصمه ) \n' 	ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' - *{* '..imation[i]..' *}_*( متحركه ) \n'ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' - *{* '..	audio[i]..' *}_*( صوتيه ) \n' ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' - *{* '..sticker[i]..' *}_*( ملصق ) \n' 	ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' - *{* '..	video[i]..' *}_*( فيديو ) \n'ii = ii + 1 end
return message..'\n✿✿✿'
end


if MsgText[1]=="اضف رد" and msg.GroupActive then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" end
redis:setex(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_,300,true) 
redis:del(mero..'replay1'..msg.chat_id_..msg.sender_user_id_)
return "✿│حسننا , الان ارسل كلمه الرد \n-"
end

if MsgText[1] == "ضع اسم للبوت" or MsgText[1]== 'ضع اسم للبوت ✿' then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
redis:setex(mero..'namebot:witting'..msg.sender_user_id_,300,true)
return"✿╿حسننا عزيزي  \n✿╽الان ارسل الاسم  للبوت ✿"
end



if MsgText[1] == 'server' then
if not msg.SudoUser then return "⛔ For Sudo Only ⛔" end
return io.popen([[

linux_version=`lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '📟 ❪ System ❫\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*✿ ❪ Memory ❫\n*»» '"$memUsedPrc"'*'
echo '*------------------------------\n*💾 ❪ HardDisk ❫\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*✿ ❪ Processor ❫\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*👨🏾‍🔧 ❪ Server[_]Login ❫\n*»» '`whoami`'*'
echo '*------------------------------\n*🔌 ❪ Uptime ❫  \n*»» '"$uptime"'*'
]]):read('*all')
end


if MsgText[1] == 'السيرفر' then
if not msg.SudoUser then return "⛔ للمطور الاساسي فقط ⛔" end
return io.popen([[

linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '📟l ❪ نظام التشغيل ❫\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*✿l ❪ الذاكره العشوائيه ❫\n*»» '"$memUsedPrc"'*'
echo '*------------------------------\n*💾l ❪ وحـده الـتـخـزيـن ❫\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*✿l ❪ الـمــعــالــج ❫\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*👨🏾‍🔧l ❪ الــدخــول ❫\n*»» '`whoami`'*'
echo '*------------------------------\n*🔌l ❪ مـده تـشغيـل الـسـيـرفـر ❫  \n*»» '"$uptime"'*'
]]):read('*all')
end


if msg.type == 'channel' and msg.GroupActive then
	if MsgText[1] == "الاوامر" then
	if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
	local texs = [[
• اهلا بك عزيزي 
• الاوامر العامه
   ━━━━━
• م1 - اوامر الاداره 
• م2 - اعدادات المجموعه 
• م3 - اوامر الحمايه 
• م4 - اوامر الخدمه 
• م5 - اوامر التحشيش 
• م6 - التفعيل و التعطيل 
• م7 - الوضع للمجموعه 
• الحمايه - اعدادات الحمايه 
• الوسائط - اعدادات الوسائط 
• الاعدادات - اعدادات المجموعه 
• الالعاب - العاب البوت 
• السورس - سورس البوت 
• المطور - مطور البوت 
• م المطور - اوامر المطور 
   ━━━━━
Carbon - ]]..SUDO_USER
	 keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𝟭', callback_data="/help1@"..msg.sender_user_id_},{text = '𝟮', callback_data="/help2@"..msg.sender_user_id_},{text = '𝟯', callback_data="/help3@"..msg.sender_user_id_},
},
{
{text = '𝟰', callback_data="/help4@"..msg.sender_user_id_},{text = '𝟱', callback_data="/help5@"..msg.sender_user_id_},
},
{
{text = '𝟲', callback_data="/help6@"..msg.sender_user_id_},{text = '𝟳', callback_data="/help7@"..msg.sender_user_id_},
},
{
{text = 'الالعاب  ', callback_data="/helpgames@"..msg.sender_user_id_},
},
}
local msg_id = msg.id_/2097152/0.5
https.request(ApiToken..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(texs).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if MsgText[1]== 'م1' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text =[[
• اهلا بك عزيزي 
• اوامر الرفع - والتنزيل  
━━━━━
• رفع تنزيل - مالك 
• رفع تنزيل - منشئ اساسي 
• رفع تنزيل - منشئ 
• رفع تنزيل - مدير 
• رفع تنزيل - ادمن
• رفع تنزيل - مميز 
• رفع تنزيل - مشرف 
• رفع تنزيل - مشرف بكل الصلاحيات 
• رفع تنزيل - الادمنيه 

• اوامر مسح - الحذف 
━━━━━
• تنزيل - الكل 
• تنزيل - الكل بالرد 
• مسح - المالكين 
• مسح - المنشئين الاساسيين 
• مسح - المنشئين
• مسح - المدراء
• مسح - الادمنيه 
• مسح - المميزين 
• مسح - الردود 
• مسح -  قائمه المنع
• مسح - المحظورين 
• مسح - المكتومين 
• مسح - المقيدين 
━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م2' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر الاعدادات 
   ━━━━━
• الرابط 
• انشاء رابط 
• المالك  
• المنشئين 
• المدراء 
• الادمنيه 
• القوانين 
• المكتومين 
• المحظورين 
• المقيدين 
• الوسائط 
• الحمايه 
• الاعدادات 
• المجموعه 
━━━━━
• اوامر الردود 
• اضف - رد 
• مسح - رد 
• الردود 
• اضف - رد متعدد 
• مسح - رد متعدد 
• الردود المتعدده 
• اضف امر 
• مسح امر 
• الاوامر المضافه 
• مسح الاوامر المضافه 
━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م3' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر حماية المجموعه
━━━━━
• قفل - فتح الكل 
• قفل - فتح الاضافه 
• قفل - فتح  الدردشه
• قفل - فتح  الدخول
• قفل - فتح  البوتات
• قفل - فتح  الاشعارات
• قفل - فتح المديا
• قفل - فتح الروابط
• قفل - فتح المعرفات
• قفل - فتح التاك
• قفل - فتح المصقات
• قفل - فتح المتحركه
• قفل - فتح الفيديو
• قفل - فتح  الصور
• قفل - فتح الاغاني
• قفل - فتح الصوت
• قفل - فتح التوجيه
• قفل - فتح الملفات
• قفل - فتح  الجهات
• قفل - فتح  الكلايش
• قفل - فتح  التكرار
• قفل - فتح  السب
• قفل - فتح  الانلاين
━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م4' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر الخدمه 
   ━━━━━
• ايدي 
• ايديي 
• ايدي بالرد 
• الرابط 
• جهاتي 
• الالعاب 
• تاك 
• تاك عام - all@ 
• تاك للكل 
• مسح + العدد 
• منع + الكلمه 
• الغاء منع + الكلمه 
• قول + الكلمه 
• انطق + الكلمه 
• نقاطي 
• بيع نقاطي + العدد 
• اضف رسائل + العدد - بالرد 
• اضف نقاط + العدد - بالرد 
• اضف سحكات + العدد - بالرد 
• سحكاتي 
• مسح - سحكاتي 
• رتبتي 
• موقعي 
• صلاحياتي 
• صلاحياته بالرد 
• معلوماتي 
• السورس
• الرتبه بالرد 
• التفاعل بالرد - بالمعرف 
• كشف بالرد - بالمعرف 
• كشف البوتات 
• طرد البوتات 
• طرد المحذوفين 
• رابط الحذف 
• زخرفه - زخرفه 2 - زخرفه 3
• تحويل الصيغ 
• الابراج 
• همسه 
• اطربنه 
• غنيلي 
• بحث + اسم الاغنيه 
• اضف صوت 
• مسح صوت 
• الصوتيات 
• مسح الصوتيات 
• الصوتيات العامه 
   ━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م5' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text =[[
• اهلا بك عزيزي 
تفعيل - تعطيل التحشيش 
   ━━━━━
• رفع - تنزيل تاج 
• رفع - تنزيل ملك 
• رفع - تنزيل ملكه
• رفع - تنزيل مرتي 
• رفع - تنزيل غبي 
• رفع - تنزيل بقلبي - من قلبي 
   ━━━━━
• اوامر المسح 
• مسح قائمه التاج 
• مسح الملوك 
• مسح الملكات 
• مسح الزوجات 
• مسح الاغبياء 
• مسح قائمه قلبي 
   ━━━━━
• نسبه الحب - الكره 
• نسبه الرجوله - الانوثه 
• نسبه الذكاء - الغباء 
      ━━━━━
• الاوامر بالرد 
• زواج - طلاق 
• شنو رايك بهذا 
• شنو رايك بهاي 
• انطي هديه 
• بوسه 
• صيحه 
   ━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م6' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر تفعيل وتعطيل
━━━━━
• تفعيل - تعطيل اطردني
• تفعيل - تعطيل ضافني
• تفعيل - تعطيل الرفع
• تفعيل - تعطيل الحظر
• تفعيل - تعطيل الايدي
• تفعيل - تعطيل الايدي بالصوره 
• تفعيل - تعطيل الالعاب
• تفعيل - تعطيل الردود العامه
• تفعيل - تعطيل الردود
• تفعيل - تعطيل الرابط 
• تفعيل - تعطيل اليوتيوب 
• تفعيل - تعطيل التاك 
• تفعيل - تعطيل الردود العامه 
• تفعيل - تعطيل الصوتيات 
• تفعيل - تعطيل الصوتيات العامه 
• تفعيل - تعطيل قول 
• تفعيل - تعطيل انطق 
• تفعيل - تعطيل غنيلي 
• تفعيل - تعطيل الابراج 
• تفعيل - تعطيل غنيلي 
• تفعيل - تعطيل التحذير 
• تفعيل - تعطيل الترحيب 
• تفعيل - تعطيل التحشيش 
━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== 'م7' then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر الوضع للمجموعه
   ━━━━━
• ضع رابط 
• ضع اسم 
• ضع صوره 
• ضع وصف 
• ضع القوانين 
• ضع الترحيب 
• ضع تكرار + العدد 
• ضع لقب + اللقب بالرد 
   ━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end
if MsgText[1]== "م المطور" then
if not msg.SudoBase then return "✿│للمطور الاساسي فقط  ✿" end
local text = [[
• اهلا بك عزيزي 
• اوامر المطور
   ━━━━━
• تفعيل الوضع المدفوع + ايدي المجموعه 
• الغاء الوضع المدفوع + ايدي المجموعه
• حظر مجموعه + الايدي
• الغاء حظر مجموعه + الايدي 
• ضع شرط التفعيل + عدد 
• شرط التفعيل 
• اسم بوتك + غادر بالمجموعه 
• حظر عام بالرد او المعرف
• منع عام + الكلمه 
• الغاء منع عام +الكلمه
• قائمه المنع عام 
   ━━━━━
• الاحصائيات
• اذاعه «» مجموعات
• اذاعه خاص «» خاص
• اذاعه عام «» مجموعات ~ خاص
• اذاعه عام بالتوجيه «» من قناتك
• تنظيف «» المجموعات وهميه
• تنظيف المشتركين «» وهمي
• جلب المشتركين «» نسخة مشتركين
• رفع المشتركين بالرد عالملف «» للرفع
• اضف - مسح رد عام
• الردود العامه 
• مسح الردود العامه 
• اضف - مسح صوت عام
• الصوتيات العامه 
• مسح الصوتيات العامه
• اضف سؤال - حذف سؤال
• الاسئله المضافه
• اضف لغز - حذف لغز 
• الالغاز
• اضف - حذف سؤال كت تويت 
• اضف موسيقى 
• حذف موسيقى بالرد 
• قائمه الموسيقى 
• مسح قائمه الموسيقى
• متجر الملفات 
• اسم الملف + sp ~ تنزيل 
• اسم الملف + dp ~ حذف
   ━━━━━
• تحديث «» ملفات البوت
• تحديث السورس «» لاحدث اصدار 
   ━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end

if MsgText[1]== 'اوامر الرد' then
if not msg.Director then return "✿*│*هذا الامر يخص { المطور,المالك,المنشئ,المدير } فقط  \n✿" end
local text = [[
• اهلا بك عزيزي 
• جميع اوامر الردود
   ━━━━━
• الردود - لعرض الردود المثبته
• اضف رد - لأضافه رد جديد
• مسح رد - الرد المراد مسحه
• مسح الردود - لمسح كل الردود
• الردود العامه - لمعرف الردود المثبته عام 
• اضف رد عام - لاضافه رد لكل المجموعات
• مسح رد عام  - لمسح الرد العام 
• مسح الردود العامه - لمسح كل ردود العامه
   ━━━━━
Carbon - ]]..SUDO_USER
sendMsg(msg.chat_id_,msg.id_,text)
return false
end

if MsgText[1] == "تفعيل" and MsgText[2] == "اطردني"  then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if not redis:get(mero..'lave_me'..msg.chat_id_) then 
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* المغادره بالتاكيد تم تفعيلها\n✓" 
else 
redis:del(mero..'lave_me'..msg.chat_id_) 
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تفعيل المغادره \n✓" 
end 
end
if MsgText[1] == "تعطيل" and MsgText[2] == "اطردني" then
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
if redis:get(mero..'lave_me'..msg.chat_id_) then 
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* المغادره من قبل البوت بالتأكيد معطله\n✓" 
else
redis:set(mero..'lave_me'..msg.chat_id_,true)  
return "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تعطيل المغادره من قبل البوت\n✓" 
end   
end

if MsgText[1] == "اطردني" or MsgText[1] == "احظرني" then
if not redis:get(mero..'lave_me'..msg.chat_id_) then
if msg.Admin then return "✿*│*لا استطيع طرد المدراء والادمنيه والمنشئين  \n✿" end
kick_user(msg.sender_user_id_,msg.chat_id_,function(arg,data)
if data.ID == "Ok" then
StatusLeft(msg.chat_id_,msg.sender_user_id_)
send_msg(msg.sender_user_id_,"👨🏼‍⚕️╿اهلا عزيزي , لقد تم طردك من المجموعه بامر منك \n✿╽اذا كان هذا بالخطأ او اردت الرجوع للمجموعه \n\n✿│فهذا رابط المجموعه ✿\n✿│"..Flter_Markdown(redis:get(mero..'group:name'..msg.chat_id_)).." :\n\n["..redis:get(mero..'linkGroup'..msg.chat_id_).."]\n")
sendMsg(msg.chat_id_,msg.id_,"✿| لقد تم طردك بنجاح , ارسلت لك رابط المجموعه في الخاص اذا وصلت لك تستطيع الرجوع متى شئت ")
else
sendMsg(msg.chat_id_,msg.id_,"✿| لا استطيع طردك لانك مشرف في المجموعه  ")
end
end)
return false
end
end

end 

if MsgText[1] == "سورس"  or MsgText[1]=="السورس"  then
return [[
↫اهلا بكم في سورس 《 𝐓𝐎𝐋𝐄𝐍 》
ٴ♡♡♡♤♡♡♧♡♡☆♡~♡
✿╿[قناة السورس](https://t.me/Y_Q_8)
✿│[مبرمج السورس](t.me/VV_000_VV)
✿╽[مطور السـورس](t.me/X_0_1)
ٴ♡♡♡♤♡♡♧♡♡☆♡~♡
]]
end



if MsgText[1] == "متجر الملفات" or MsgText[1]:lower() == "/store"  then
if not msg.SudoBase then return "📪¦ هذا الامر يخص { المطور الاساسي } فقط  \n" end
local Get_Files, res = https.request("https://raw.githubusercontent.com/VivazAli/Vivaz/main/File.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
print(serpent.block(res.plugins_, {comment=false}))   
if Get_info then
local TextS = "\n📂┇اهلا بك في متجر ملفات تولين \n📮┇الملفات الموجوده حاليا \nꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ\n\n"
local TextE = "\nꔹ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ꔹ\n📌┇تدل علامة (✔) الملف مفعل\n".."📌┇تدل علامة (✖) الملف معطل\n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("plugins/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✔)"
else
CeckFile = "(✖)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."~⪼* {`"..name..'`} » '..CeckFile..'\n[- File Information]('..Info..')\n'
end
sendMsg(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
sendMsg(msg.chat_id_, msg.id_,"📮┇ لا يوجد اتصال من ال api \n") 
end
return false
end
if MsgText[1]:lower() == "sp" and MsgText[2] then
if not msg.SudoBase then return"📪¦ هذا الامر يخص { المطور الاساسي } فقط  \n" end
local FileName = MsgText[2]:lower()
local Check_File_is_Found = io.open("plugins/"..FileName,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
TText = "📑¦ الملف موجود بالفعل \n¦ تم تحديث الملف  \n✓"
else
TText = "🔖¦ تم تثبيت وتفعيل الملف بنجاح \n✓"
end
local Get_Files, res = https.request("https://raw.githubusercontent.com/VivazAli/Vivaz/main/libs/"..FileName)
if res == 200 then
print("DONLOADING_FROM_URL: "..FileName)
local FileD = io.open("plugins/"..FileName,'w+')
FileD:write(Get_Files)
FileD:close()
Start_Bot()

return TText
else
return "📛¦ لا يوجد ملف بهذا الاسم في المتجر \n✖️"
end
end

if MsgText[1]:lower() == "dp" and MsgText[2] then
if not msg.SudoBase then return"📪¦ هذا الامر يخص { المطور الاساسي } فقط  \n" end
local FileName = MsgText[2]:lower()
local Check_File_is_Found = io.open("plugins/"..FileName,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
os.execute("rm -fr plugins/"..FileName)
TText = "📑¦ الملف ~⪼ ["..FileName.."] \n🔖¦ تم حذفه بنجاح  \n✓"
else
TText = "📑¦ الملف ~⪼ ["..FileName.."] \n🔖¦ بالفعل محذوف  \n✓"
end
Start_Bot()
return TText
end


if MsgText[1] == "التاريخ" then
return "✿\n✿│الـتـاريـخ : "..os.date("%Y/%m/%d")
end

if MsgText[1]== "سحكاتي"  then
return '✿*│*عدد سحكاتك ⇜ ❪ '..(redis:get(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)..' ❫ \n🐾'
end

if MsgText[1] == 'مسح' and MsgText[2] == 'سحكاتي'   then
local rfih = (redis:get(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
if rfih == 0 then  return "✿*│*عذرا لا يوجد سحكات لك في البوت  " end
redis:del(mero..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
return "✿*│*تم مسح {* "..rfih.." *} من سحكاتك \n✓"
end

if MsgText[1] == "تفعيل الاشتراك الاجباري" or MsgText[1] == "تفعيل الاشتراك الاجباري ✿" then
if msg.sender_user_id_ ~= tonumber(779108237) then return"✿*│*هذا الامر يخص {المطور السورس} فقط  \n✿" end
if redis:get(mero..":UserNameChaneel") then
return "✿╿اهلا عزيزي المطور \n✿╽الاشتراك بالتأكيد مفعل"
else
redis:setex(mero..":ForceSub:"..msg.sender_user_id_,350,true)
return "✿╿مرحبا بـك في نظام الاشتراك الاجباري\n✿╽الان ارسل معرف قـنـاتـك"
end
end

if MsgText[1] == "تعطيل الاشتراك الاجباري" or MsgText[1] == "تعطيل الاشتراك الاجباري ✿" then
if msg.sender_user_id_ ~= tonumber(779108237) then return"✿*│*هذا الامر يخص {المطور السورس} فقط  \n✿" end
local SubDel = redis:del(mero..":UserNameChaneel")
if SubDel == 1 then
return "✿│تم تعطيل الاشتراك الاجباري . \n✓"
else
return "✿│الاشتراك الاجباري بالفعل معطل . \n✓"
end
end

if MsgText[1] == "الاشتراك الاجباري" or MsgText[1] == "الاشتراك الاجباري ✿" then
if not msg.SudoBase then return"✿*│*هذا الامر يخص { المطور الاساسي } فقط  \n✿" end
local UserChaneel = redis:get(mero..":UserNameChaneel")
if UserChaneel then
return "✿╿اهلا عزيزي المطور \n✿╽الاشتراك الاجباري للقناة : ["..UserChaneel.."]\n✓"
else
return "✿│لا يوجد قناة مفعله ع الاشتراك الاجباري. \n✓"
end
end

if MsgText[1] == "تغيير الاشتراك الاجباري" or MsgText[1] == "تغيير الاشتراك الاجباري ✿" then
if msg.sender_user_id_ ~= tonumber(779108237) then return"✿*│*هذا الامر يخص {المطور السورس} فقط  \n✿" end
redis:setex(mero..":ForceSub:"..msg.sender_user_id_,350,true)
return "✿╿مرحبا بـك في نظام الاشتراك الاجباري\n✿╽الان ارسل معرف قـنـاتـك"
end
 




end

local function dmero(msg)

if msg.text == "تفعيل الصوتيات العامه" then
if not msg.Director then return sendMsg(msg.chat_id_, msg.id_,"✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿") end
if not redis:get(mero..'lock_geamsAudio'..msg.chat_id_) then 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الصوتيات العامه بالتاكيد تم تفعيلها\n✓" )
else 
redis:del(mero..'lock_geamsAudio'..msg.chat_id_) 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تفعيل الصوتيات العامه \n✓" )
end 
end
if msg.text == "تعطيل الصوتيات العامه" then
if not msg.Director then return sendMsg(msg.chat_id_, msg.id_,"✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿") end
if redis:get(mero..'lock_geamsAudio'..msg.chat_id_) then 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الصوتيات العامه بالتأكيد معطله\n✓" )
else
redis:set(mero..'lock_geamsAudio'..msg.chat_id_,true)  
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تعطيل الصوتيات العامه\n✓" )
end   
end

if msg.text == "تفعيل الصوتيات" then
if not msg.Director then return sendMsg(msg.chat_id_, msg.id_,"✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿") end
if not redis:get(mero..'lock_geamsAudio1'..msg.chat_id_) then 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الصوتيات بالتاكيد تم تفعيلها\n✓" )
else 
redis:del(mero..'lock_geamsAudio1'..msg.chat_id_) 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تفعيل الصوتيات \n✓" )
end 
end
if msg.text == "تعطيل الصوتيات" then
if not msg.Director then return sendMsg(msg.chat_id_, msg.id_,"✿*│*هذا الامر يخص { المطور ، المالك ، المنشئ الاساسي ، المنشئ ، المدير } فقط  \n✿" ) end
if redis:get(mero..'lock_geamsAudio1'..msg.chat_id_) then 
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* الصوتيات بالتأكيد معطله\n✓" )
else
redis:set(mero..'lock_geamsAudio1'..msg.chat_id_,true)  
return sendMsg(msg.chat_id_, msg.id_,"✿*╿* أهلا عزيزي "..msg.TheRankCmd.."\n✿*╽* تم تعطيل الصوتيات\n✓" )
end   
end

if redis:get(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'startdel' then
if not redis:sismember(mero.."mero:All:text:Games:Bot",msg.text) then
sendMsg(msg.chat_id_, msg.id_,'✿*│* لا يوجد صوتيه بهذا الاسم في العامه')
redis:del(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
return false
end
redis:del(mero.."mero:All:audio:Games"..msg.text)
redis:srem(mero.."mero:All:text:Games:Bot",msg.text)  
redis:del(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
sendMsg(msg.chat_id_, msg.id_,'✿*│* تم مسح الصوتيه بنجاح')
return false
end

if redis:get(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'start' then
redis:set(mero..'mero:All:Text:Games:audio'..msg.chat_id_,msg.text)
redis:sadd(mero.."mero:All:text:Games:Bot",msg.text)  
redis:set(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'started')
sendMsg(msg.chat_id_, msg.id_,'✿*│*الان ارسل الصوتيه ليتم حفظها باسم  : '..msg.text)
return false
end
if redis:get(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'started' then
if msg.content_.audio_ then  
local nameaudio = redis:get(mero..'mero:All:Text:Games:audio'..msg.chat_id_)
redis:set(mero.."mero:All:audio:Games"..nameaudio,msg.content_.audio_.audio_.persistent_id_)  
redis:del(mero.."mero:All:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
sendMsg(msg.chat_id_, msg.id_,'✿*│* تم حفظ الصوتيه باسم : '..nameaudio)
return false
end   
end
if msg.text and not redis:get(mero..'lock_geamsAudio'..msg.chat_id_) then
local nameaudio = redis:get(mero.."mero:All:audio:Games"..msg.text)
if nameaudio then
sendAudio(msg.chat_id_,msg.id_,nameaudio,"")
end
end

if redis:get(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'startdel' then
if not redis:sismember(mero.."mero:text:Games:Bot"..msg.chat_id_,msg.text) then
sendMsg(msg.chat_id_, msg.id_,'✿*│* لا يوجد صوتيه بهذا الاسم في المجموعه')
redis:del(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
return false
end
redis:del(mero.."mero:audio:Games"..msg.chat_id_..msg.text)
redis:srem(mero.."mero:text:Games:Bot"..msg.chat_id_,msg.text)  
redis:del(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
sendMsg(msg.chat_id_, msg.id_,'✿*│* تم مسح الصوتيه بنجاح')
return false
end

if redis:get(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'start' then
redis:set(mero..'mero:Text:Games:audio'..msg.chat_id_,msg.text)
redis:sadd(mero.."mero:text:Games:Bot"..msg.chat_id_,msg.text)  
redis:set(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_,'started')
sendMsg(msg.chat_id_, msg.id_,'✿*│*الان ارسل الصوتيه ليتم حفضها باسم  : '..msg.text)
return false
end
if redis:get(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_) == 'started' then
if msg.content_.audio_ then  
local nameaudio = redis:get(mero..'mero:Text:Games:audio'..msg.chat_id_)
redis:set(mero.."mero:audio:Games"..msg.chat_id_..nameaudio,msg.content_.audio_.audio_.persistent_id_)  
redis:del(mero.."mero:Add:audio:Games"..msg.sender_user_id_..":"..msg.chat_id_)
sendMsg(msg.chat_id_, msg.id_,'✿*│* تم حفظ الصوتيه باسم : '..nameaudio)
return false
end   
end
if msg.text and not redis:get(mero..'lock_geamsAudio1'..msg.chat_id_) then
local nameaudio = redis:get(mero.."mero:audio:Games"..msg.chat_id_..msg.text)
if nameaudio then
sendAudio(msg.chat_id_,msg.id_,nameaudio,"")
end
end


local getChatId = function(id)
  local chat = {}
  local id = tostring(id)
  if id:match("^-100") then
    local channel_id = id:gsub("-100", "")
    chat = {ID = channel_id, type = "channel"}
  else
    local group_id = id:gsub("-", "")
    chat = {ID = group_id, type = "group"}
  end
  return chat
end
local getChannelFull = function(channel_id, cb)
  tdcli_function({
    ID = "GetChannelFull",
    channel_id_ = getChatId(channel_id).ID
  }, cb or dl_cb, nil)
end

local getUser = function(user_id, cb)
tdcli_function({ID = "GetUser", user_id_ = user_id}, cb, nil)
end
local getChat = function(chat_id, cb)
tdcli_function({ID = "GetChat", chat_id_ = chat_id}, cb or dl_cb, nil)
end


if redis:get(mero..'welcome:gett'..msg.chat_id_) == 'true' then
if msg.content_.ID == 'MessageChatJoinByLink' then
function WelcomeByAddUser(BlaCk,Diamond)
local function setlinkgp(td,mrr619)
function gps(arg,data)
if redis:get(mero..'welcome:msg'..msg.chat_id_) then
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(redis:get(mero..'welcome:msg'..msg.chat_id_)))
else
txt = '*✿╿َٰياهلا بالقمر نورت/ َٰ♡ ي\n ْ'..(Diamond.first_name_ or '---')..'\n ْ'..(data.title_ or '---')..' \n✿│يجب احترام الادمنية\n✿│الالتزام بالقوانين في الوصف\n✿│ الاعضاء '..mrr619.member_count_..'~ الادمنيه '..mrr619.administrator_count_..' \n✿│ وقت الانضمام :('..os.date("%H:%M:%S")..')\n✿╽ تاريخ الانضمام :('..os.date("%Y/%m/%d")..')*\n'
sendMsg(msg.chat_id_,msg.id_,txt)
end
end
getChat(msg.chat_id_,gps)
end
getChannelFull(msg.chat_id_,setlinkgp)
end
getUser(msg.sender_user_id_,WelcomeByAddUser)
end
end



local Text = msg.text
if Text then


if Text and (Text:match('(.*)')) and tonumber(msg.sender_user_id_) ~= 0 then
function dl_username(arg,data)
if data.username_ then
info = data.username_
else
info = data.first_name_
end
local hash = mero..'user_names:'..msg.sender_user_id_
redis:set(hash,info)
end
getUser(msg.sender_user_id_,dl_username)
end

------set cmd------
Black = msg.text 
text = msg.text 
if text and text:match('^ذيع (-100%d+)$') and tonumber(msg.reply_to_message_id_) ~= 0 then
local Chatid = text:match('^ذيع (-100%d+)$')
if not msg.SudoUser then return "❈*│*هذا الامر يخص {المطور} فقط  \n❈" end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(arg, result) 
tdcli_function({ID='GetChat',chat_id_ = Chatid},function(arg,data)
if not data.id_ then
sendMsg(msg.chat_id_, msg.id_,'- لا توجد مجموعه في البوت بهذا الايدي')
return false
end
sendMsg(Chatid, 0,result.content_.text_)
sendMsg(msg.chat_id_, msg.id_,'- تم الاذاعه الى  : ['..data.title_..']\n ')
end,nil)
end, nil)
end 
if text and text:match('^تفعيل الوضع المدفوع (-100%d+)$') then
local Chatid = text:match('^تفعيل الوضع المدفوع (-100%d+)$')
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
tdcli_function({ID='GetChat',chat_id_ = Chatid},function(arg,data)
if not data.id_ then
sendMsg(msg.chat_id_, msg.id_,'- لا توجد مجموعه في البوت بهذا الايدي')
return false
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
redis:sadd(mero.."BotFree:Group:",Chatid)
sendMsg(msg.chat_id_, msg.id_,'- تم تفعيل الوضع المدفوع بنجاح على : ['..data.title_..']')
else
sendMsg(msg.chat_id_, msg.id_,'- البوت عضو في المجموعه')
end
end,nil)
end 
if text and text:match('^الغاء الوضع المدفوع (-100%d+)$') then
local Chatid = text:match('^الغاء الوضع المدفوع (-100%d+)$')
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:srem(mero.."BotFree:Group:",Chatid)
sendMsg(msg.chat_id_, msg.id_,'- تم الغاء الوضع المدفوع عن المجموعه ')
end 

if text and text:match('^حظر مجموعه (-100%d+)$') then
local Chatid = text:match('^حظر مجموعه (-100%d+)$')
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
tdcli_function({ID='GetChat',chat_id_ = Chatid},function(arg,data)
if not data.id_ then
sendMsg(msg.chat_id_, msg.id_,'- لا توجد مجموعه في البوت بهذا الايدي')
return false
end
StatusLeft(Chatid,our_id)
redis:sadd(mero.."Black:listBan:",Chatid)
sendMsg(msg.chat_id_, msg.id_,'- تم حظر المجموعه  : ['..data.title_..']\n - وتم مغادره البوت من المجموعه')
end,nil)
end 
if text and text:match('^الغاء حظر مجموعه (-100%d+)$') then
local Chatid = text:match('^الغاء حظر مجموعه (-100%d+)$')
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:srem(mero.."Black:listBan:",Chatid)
sendMsg(msg.chat_id_, msg.id_,'- تم الغاء حظر المجموعه ')
end 

if text == 'الروليت' and not redis:get(mero..'lock_geams'..msg.chat_id_) then
local xxffxx = 'اهلا بك في لعبه الروليت يجب انضمام 3 لاعبين فقط'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '✿│اضغط للانضمام في اللعبه', callback_data='/joinerolet'},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(xxffxx).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
redis:del(mero..'rolet:list'..msg.chat_id_) 
end
if text and text:match('^تقييد (%d+) (.*) @(.*)$') and msg.Admin then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*) @(.*)$")}
if is_JoinChannel(msg) == false then
return false
end
if msg.can_be_deleted_ == false then 
sendMsg(msg.chat_id_, msg.id_,"⚠┇عذرا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
sendMsg(msg.chat_id_,msg.id_,"⚠┇عذرا هذا معرف قناة")   
return false 
end      

if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.id_, msg.chat_id_) then
sendMsg(msg.chat_id_, msg.id_, "\n✿│لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Getrtba(result.id_,msg.chat_id_).."")
else
if TextEnd[3] == "ايام" or TextEnd[3] == 'دقايق' or TextEnd[3] == 'ساعات' then
GetUserID(result.id_,function(MR,EIKOei)
local Teext = '✿│العضو » ❪ ['..EIKOei.first_name_..'](tg://user?id='..result.id_..')❫\n✿╽تم تقييده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
local msg_id = msg.id_/2097152/0.5
https.request(ApiToken..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Teext).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end,nil)
https.request("https://api.telegram.org/bot"..Token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, FunctionStatus, nil)
end
if text and text:match('^تقييد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and msg.Admin then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*)$")}
if is_JoinChannel(msg) == false then
return false
end
if msg.can_be_deleted_ == false then 
sendMsg(msg.chat_id_, msg.id_,"⚠┇عذرا البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
sendMsg(msg.chat_id_, msg.id_, "\n✿│لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Getrtba(result.sender_user_id_,msg.chat_id_).."")
else
if TextEnd[3] == "ايام" or TextEnd[3] == 'دقايق' or TextEnd[3] == 'ساعات' then
GetUserID(result.sender_user_id_,function(MR,EIKOei)
local Teext = '✿│العضو » ❪ ['..EIKOei.first_name_..'](tg://user?id='..result.sender_user_id_..')❫\n✿╽تم تقييده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
local msg_id = msg.id_/2097152/0.5
https.request(ApiToken..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Teext).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end,nil)
https.request("https://api.telegram.org/bot"..Token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
 
if text == "اضف سؤال" then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,true)
return sendMsg(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سؤال" then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,'truedel')
return sendMsg(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == 'الاسئله المضافه' then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
local list = redis:smembers(mero.."gamebot:new1")
t = "✿*│* الاسئله المضافه : \n"
for k,v in pairs(list) do
t = t..""..k.."- (["..v.."])\n"
end
if #list == 0 then
t = "• لا يوجد اسئله"
end
return sendMsg(msg.chat_id_, msg.id_,t)
end

if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "truedel" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حذف السؤال')
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"truefguigf1")
redis:del(mero.."gamebot:newqus"..msg.chat_id_,text)
redis:srem(mero.."gamebot:new1", text)
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح \n ارسل الجواب الاول')
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(mero.."gamebot:newqus"..msg.chat_id_,text)
redis:sadd(mero.."gamebot:new1", text)
return false 
end
end
if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
sendMsg(msg.chat_id_, msg.id_, ' \n ارسل الجواب الثاني')
local quschen = redis:get(mero.."gamebot:newqus"..msg.chat_id_)
redis:set(mero.."gamebot:newqus:as1"..quschen,text)
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
end
if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true2" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح \n ارسل الجواب الثالث')
local quschen = redis:get(mero.."gamebot:newqus"..msg.chat_id_)
redis:set(mero.."gamebot:newqus:as2"..quschen,text)
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true3")
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true3" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ الاجوبه \n ارسل الجواب الرابع')
local quschen = redis:get(mero.."gamebot:newqus"..msg.chat_id_)
redis:set(mero.."gamebot:newqus:as3"..quschen,text)
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true4")
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true4" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ الاجوبه \n ارسل الجواب الصحيح')
local quschen = redis:get(mero.."gamebot:newqus"..msg.chat_id_)
redis:set(mero.."gamebot:newqus:as0"..quschen,text)
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true44")
return false 
end
end


if text and text:match("^(.*)$") then
if redis:get(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true44" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفض الجواب الصحيح')
local quschen = redis:get(mero.."gamebot:newqus"..msg.chat_id_)
redis:set(mero.."gamebot:newqus:as4"..quschen,text)
redis:set(mero.."gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true186")
return false 
end
end
if text == 'اسألني' or text == 'اسالني' then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero..'lock_geams'..msg.chat_id_) then
local list = redis:smembers(mero.."gamebot:new1")
if #list ~= 0 then
local quschen = list[math.random(#list)]
local ansar1 = redis:get(mero.."gamebot:newqus:as1"..quschen)
local ansar2 = redis:get(mero.."gamebot:newqus:as2"..quschen)
local ansar3 = redis:get(mero.."gamebot:newqus:as3"..quschen)
local ansar0 = redis:get(mero.."gamebot:newqus:as0"..quschen)
local ansar4 = redis:get(mero.."gamebot:newqus:as4"..quschen)
if ansar1 == ansar4 then
tt = 'ansar1'
elseif ansar2 == ansar4 then
tt = 'ansar2'
elseif ansar3 == ansar4 then
tt = 'ansar3'
elseif ansar0 == ansar4 then
tt = 'ansar0'
end
print(tt)
if tt == 'ansar1' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='صحيح'},{text = URL.escape(ansar2), callback_data='خطا'},
},
{
{text = URL.escape(ansar3), callback_data='خطا'},{text = URL.escape(ansar0), callback_data='خطا'},
}, 
}
elseif tt == 'ansar2' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='خطا'},{text = URL.escape(ansar2), callback_data='صحيح'},
},
{
{text = URL.escape(ansar3), callback_data='خطا'},{text = URL.escape(ansar0), callback_data='خطا'},
}, 
}
elseif tt == 'ansar3' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='خطا'},{text = URL.escape(ansar2), callback_data='خطا'},
},
{
{text = URL.escape(ansar3), callback_data='صحيح'},{text = URL.escape(ansar0), callback_data='خطا'},
}, 
}
elseif tt == 'ansar0' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='خطا'},{text = URL.escape(ansar2), callback_data='خطا'},
},
{
{text = URL.escape(ansar3), callback_data='خطا'},{text = URL.escape(ansar0), callback_data='صحيح'},
}, 
}
end
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(quschen).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "اضف لغز" then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,true)
return sendMsg(msg.chat_id_, msg.id_,"ارسل اللغز الان ")
end
if text == "حذف لغز" then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,'truedel')
return sendMsg(msg.chat_id_, msg.id_,"ارسل اللغز الان ")
end
if text == 'الالغاز' then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
local list = redis:smembers(mero.."lkz:gamebot:new1")
t = "✿*│* الالغاز : \n"
for k,v in pairs(list) do
t = t..""..k.."- (["..v.."])\n"
end
if #list == 0 then
t = "• لا يوجد اللغاز"
end
return sendMsg(msg.chat_id_, msg.id_,t)
end
if text == 'مسح الالغاز' then
if is_JoinChannel(msg) == false then
return false
end
if not msg.SudoUser then return "✿*│*هذا الامر يخص {المطور} فقط  \n✿" end
 redis:del(mero.."lkz:gamebot:new1")
return sendMsg(msg.chat_id_, msg.id_,'تم مسح الالغاز جميعا ')
end

if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "truedel" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حذف اللغز')
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"truefguigf1")
redis:del(mero.."lkz:gamebot:newqus"..msg.chat_id_,text)
redis:srem(mero.."lkz:gamebot:new1", text)
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ اللغز بنجاح \n ارسل الجواب الاول')
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(mero.."lkz:gamebot:newqus"..msg.chat_id_,text)
redis:sadd(mero.."lkz:gamebot:new1", text)
return false 
end
end
if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
sendMsg(msg.chat_id_, msg.id_, ' \n ارسل الجواب الثاني')
local quschen = redis:get(mero.."lkz:gamebot:newqus"..msg.chat_id_)
redis:set(mero.."lkz:gamebot:newqus:as1"..quschen,text)
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
end
if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true2" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفظ اللغز بنجاح \n ارسل الجواب الثالث')
local quschen = redis:get(mero.."lkz:gamebot:newqus"..msg.chat_id_)
redis:set(mero.."lkz:gamebot:newqus:as2"..quschen,text)
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true3")
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true3" then
sendMsg(msg.chat_id_, msg.id_, ' \n ارسل الجواب الصحيح')
local quschen = redis:get(mero.."lkz:gamebot:newqus"..msg.chat_id_)
redis:set(mero.."lkz:gamebot:newqus:as3"..quschen,text)
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true44")
return false 
end
end

if text and text:match("^(.*)$") then
if redis:get(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_) == "true44" then
sendMsg(msg.chat_id_, msg.id_, '\nتم حفض الجواب الصحيح')
local quschen = redis:get(mero.."lkz:gamebot:newqus"..msg.chat_id_)
redis:set(mero.."lkz:gamebot:newqus:as4"..quschen,text)
redis:set(mero.."lkz:gamebot:new"..msg.sender_user_id_..":"..msg.chat_id_,"true186")
return false 
end
end
if text == 'اللغز' or text == 'لغز' then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero..'lock_geams'..msg.chat_id_) then
local list = redis:smembers(mero.."lkz:gamebot:new1")
if #list ~= 0 then
local quschen = list[math.random(#list)]
local ansar1 = redis:get(mero.."lkz:gamebot:newqus:as1"..quschen)
local ansar2 = redis:get(mero.."lkz:gamebot:newqus:as2"..quschen)
local ansar3 = redis:get(mero.."lkz:gamebot:newqus:as3"..quschen)
local ansar4 = redis:get(mero.."lkz:gamebot:newqus:as4"..quschen)
if ansar1 == ansar4 then
tt = 'ansar1'
elseif ansar2 == ansar4 then
tt = 'ansar2'
elseif ansar3 == ansar4 then
tt = 'ansar3'
end
print(tt)
if tt == 'ansar1' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='صحيح1'},
},
{
{text = URL.escape(ansar2), callback_data='خطا1'},
},
{
{text = URL.escape(ansar3), callback_data='خطا1'},
}, 
}
elseif tt == 'ansar2' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='خطا1'},
},
{
{text = URL.escape(ansar2), callback_data='صحيح1'},
},
{
{text = URL.escape(ansar3), callback_data='خطا1'},
}, 
}
elseif tt == 'ansar3' then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = URL.escape(ansar1), callback_data='خطا1'},
},
{
{text = URL.escape(ansar2), callback_data='خطا1'},
},
{
{text = URL.escape(ansar3), callback_data='صحيح1'},
}, 
}
end
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(quschen).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text and text:match("^رفع القيود @(.*)") and msg.Admin then 
local username = text:match("^رفع القيود @(.*)") 
tdcli_function ({ID = "SearchPublicChat",username_ = username},function(extra, result, success)
if result.id_ then
if msg.SudoUser then
redis:srem(mero.."gban_users",result.id_)
redis:srem(mero.."banned:"..msg.chat_id_,result.id_)
redis:srem(mero.."is_silent_users:"..msg.chat_id_,result.id_)
Restrict(msg.chat_id_,result.id_,2)
usertext = "\n✿╿ العضو » ["..result.title_.."](t.me/"..(username or "dd")..")"
status  = "\n✿╽ تم رفع القيود عنه"
texts = usertext..status
sendMsg(msg.chat_id_, msg.id_,texts)
else
redis:srem(mero.."banned:"..msg.chat_id_,result.id_)
redis:srem(mero.."is_silent_users:"..msg.chat_id_,result.id_)
Restrict(msg.chat_id_,result.id_,2)
usertext = "\n✿╿ العضو » ["..result.title_.."](t.me/"..(username or "dd")..")"
status  = "\n✿╽ تم رفع القيود عنه"
texts = usertext..status
sendMsg(msg.chat_id_, msg.id_,texts)
end
else
sendMsg(msg.chat_id_, msg.id_,"📫┇ المعرف خطا")
end
end, nil)
end
if text == "رفع القيود" and msg.Admin then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success)
if msg.SudoUser then
redis:srem(mero.."gban_users",result.sender_user_id_)
redis:srem(mero.."banned:"..msg.chat_id_,result.sender_user_id_)
redis:srem(mero.."is_silent_users:"..msg.chat_id_,result.sender_user_id_)
Restrict(msg.chat_id_,result.sender_user_id_,2)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = "\n✿╿ العضو » ["..data.first_name_.."](t.me/"..(data.username_ or "kenwa")..")"
status  = "\n✿╽ تم رفع القيود عنه"
sendMsg(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
redis:srem(mero.."banned:"..msg.chat_id_,result.sender_user_id_)
redis:srem(mero.."is_silent_users:"..msg.chat_id_,result.sender_user_id_)
Restrict(msg.chat_id_,result.sender_user_id_,2)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = "\n✿╿ العضو » ["..data.first_name_.."](t.me/"..(data.username_ or "kenwa")..")"
status  = "\n✿╽ تم رفع القيود عنه"
sendMsg(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
 end, nil)
end


if text and text:match("ضع لقب (.*)") and msg.reply_to_message_id_ ~= 0 and msg.Kara then
local namess = text:match("ضع لقب (.*)")
if is_JoinChannel(msg) == false then
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
sendMsg(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. result.sender_user_id_..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "member" then
return sendMsg(msg.chat_id_,msg.id_,'✿│انه ليس مشرف هنا\n✿')   
end 
end


Chek_Info1 = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&custom_title="..namess)
local Json_Info = JSON.decode(Chek_Info1)
if Json_Info.error_code == 400 then
return sendMsg(msg.chat_id_,msg.id_,'✿│لست انا من رفعته\n✿')   
end 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'meroteam')..') '
status  = '\n• \n تم تغيير لقب '..namess..''
sendMsg(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^(ضع لقب) @(.*) (.*)$") and msg.Kara then
local TextEnd = {string.match(text, "^(ضع لقب) @(.*) (.*)$")}
if is_JoinChannel(msg) == false then
return false
end
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. mero..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.can_promote_members ~= true then
return  "ليست لدي صلاحيه اضافه مشرفين"
end
end
if msg.can_be_deleted_ == false then 
sendMsg(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
local Chek_Info = https.request('https://api.telegram.org/bot'..Token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. result.id_..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "member" then
return sendMsg(msg.chat_id_,msg.id_,'✿│مجرد عضو هنا\n✿')   
end 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
sendMsg(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
local Chek_Info1 = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&custom_title="..TextEnd[3])
local Json_Info = JSON.decode(Chek_Info1)
if Json_Info.error_code == 400 then
return sendMsg(msg.chat_id_,msg.id_,'✿│لست انا من رفعته\n✿')   
end 
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'meroteam')..')'
status  = ' \n تم تغيير لقب '..TextEnd[3]..' '
texts = usertext..status
sendMsg(msg.chat_id_, msg.id_, texts)

else
sendMsg(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[2]}, start_function, nil)
return false
end


if msg.text == 'رفع المشتركين' and msg.SudoBase then
if is_JoinChannel(msg) == false then
return false
end
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
local info_file = io.open('./inc/users.json', "r"):read('*a')
local users = JSON.decode(info_file)
if users.users then
for k,v in pairs(users.users) do
redis:sadd(mero..'users',v)
end
sendMsg(msg.chat_id_,msg.id_,'تم رفع :'..#users.users..' مشترك ')
else
sendMsg(msg.chat_id_,msg.id_,'خطا هذا ليس ملف المشتركين ')
end
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
if msg.text == 'جلب المشتركين' and msg.SudoBase then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero..'users')  
local t = '{"users":['  
for k,v in pairs(list) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end
t = t..']}'
local File = io.open('./inc/users.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_,msg.id_,'./inc/users.json','عدد المشتركين :'..#list,dl_cb,nil)
end 

mmd = redis:get(mero..'addcmd'..msg.chat_id_..msg.sender_user_id_)
if mmd then
redis:sadd(mero..'CmDlist:'..msg.chat_id_,msg.text)
redis:hset(mero..'CmD:'..msg.chat_id_,msg.text,mmd)
sendMsg(msg.chat_id_,msg.id_,'✿╿اهلا عزيزي \n✿╽تم تثبيت الامر الجديد\n✓')
redis:del(mero..'addcmd'..msg.chat_id_..msg.sender_user_id_)
end




if Black and (Black:match('^delcmd (.*)') or Black:match('^مسح امر (.*)')) then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Kara then return "✿*│*هذا الامر يخص {المنشئ الاساسي,المالك,المطور,المطور الاساسي} فقط  \n✿" end
local cmd = Black:match('^delcmd (.*)') or Black:match('^مسح امر (.*)')
redis:hdel(mero..'CmD:'..msg.chat_id_,cmd)
redis:srem(mero..'CmDlist:'..msg.chat_id_,cmd)
sendMsg(msg.chat_id_,msg.id_,"✿╿اهلا عزيزي\nالامر >"..cmd.."\n✿╽ تم مسحه من قائمه الاوامر\n✓")
end
if Black == 'مسح الاوامر المضافه' or Black == 'مسح الاوامر المضافة' then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Creator then return "✿*│*هذا الامر يخص {المطور ، المالك ، المنشئ الاساسي ، المنشئ} فقط  \n✿" end
redis:del(mero..'CmD:'..msg.chat_id_)
redis:del(mero..'CmDlist:'..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,"✿| اهلا عزيزي تم مسح قائمه الاوامر")
end
if Black == "الاوامر المضافه" then 
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local CmDlist = redis:smembers(mero..'CmDlist:'..msg.chat_id_)
local t = '✿| الاوامر المضافه هي : \n'
for k,v in pairs(CmDlist) do
mmdi = redis:hget(mero..'CmD:'..msg.chat_id_,v)
t = t..k..") "..v.." > "..mmdi.."\n" 
end
if #CmDlist == 0 then
t = '⛔| عزيزي لم تقم بأضافة امر !'
end
sendMsg(msg.chat_id_,msg.id_,t)
end

if text == ("مسح الثولان") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:tahaath'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:tahaath'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من الثولان \n✓")
elseif text == ("مسح الجلاب") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:klp'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:klp'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من الجلاب \n✓")
elseif text == ("مسح المطايه") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:donke'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:donke'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من المطايه \n✓")
elseif text == ("مسح الزواحف") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:zahf'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:zahf'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من الزواحف \n✓")
elseif text == ("مسح الصخول") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:sakl'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:sakl'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من الصخول \n✓")
elseif text == ("مسح قائمه قلبي") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:klpe'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:klpe'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من قائمه قلبي \n✓")
elseif text == ("مسح قائمه التاج") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:tagge'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:tagge'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من قائمه التاج \n✓")
elseif text == ("مسح الزوجات") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:mrtee'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:mrtee'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من قائمه الزوجات \n✓")
elseif text == ("مسح الثولان") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:klp'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'admins:'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."}  \n✓")
elseif text == ("مسح اللوكيه") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:loke'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:loke'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من اللوكيه \n✓")
elseif text == ("مسح الاغبياء") then
if is_JoinChannel(msg) == false then
return false
end
if not msg.Admin then return "✿*│*هذا الامر يخص { الادمن,المدير,المنشئ,المالك,المطور } فقط  \n✿" end
local numtsh = redis:scard(mero..'mero:stope'..msg.chat_id_)
if numtsh ==0 then  
return sendMsg(msg.chat_id_,msg.id_, "✿*╿* اوه✿ هنالك خطأ ✿\n✿╽عذرا لا احد ليتم حذفه ✓" )
end
redis:del(mero..'mero:stope'..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_, "✿*╿*أهلا عزيزي "..msg.TheRankCmd.."   \n✿╽تم مسح {"..numtsh.."} من الاغبياء \n✓")
end


if Text == "الساعه" or Text == "الوقت" then
if is_JoinChannel(msg) == false then
return false
end
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
sendMsg(msg.chat_id_, msg.id_,ramsesj20)
end
if Text:match('^ببف$') or Text:match('^تحويل لببف$') and tonumber(msg.reply_to_message_id_) > 0 then
whoami()
BD = '/home/root/.telegram-cli/data/'
function tosticker(arg,data)
if data.content_.ID == 'MessagePhoto' then
if BD..'photo/'..data.content_.photo_.id_..'_(1).jpg' == '' then
pathf = BD..'photo/'..data.content_.photo_.id_..'.jpg'
else
pathf = BD..'photo/'..data.content_.photo_.id_..'_(1).jpg'
end
sendSticker(msg.chat_id_,msg.id_,pathf,'')
else
sendMsg(msg.chat_id_,msg.id_,'✿╿عزيزي المستخدم👨🏻‍✈️ \n✿╽الامر فقط للصوره\n✓')
end
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},tosticker, nil)
end

if Text == 'cgkhg' or Text == 'fdgjkk' and tonumber(msg.reply_to_message_id_) > 0 then
function tophoto(kara,mero)   
if mero.content_.ID == "MessageSticker" then        
local bd = mero.content_.sticker_.sticker_.path_          
sendPhoto(msg.chat_id_,msg.id_,bd,'')
else
sendMsg(msg.chat_id_,msg.id_,'✿╿عزيزي المستخدم👨🏻‍✈️ \n✿╽الامر فقط للملصق\n✓')
end
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},tophoto, nil)
end
end

if msg.type == "pv" then 
print(msg.SudoUser)
if not msg.SudoUser or msg.DevSsource then
local msg_pv = tonumber(redis:get(mero..'user:'..msg.sender_user_id_..':msgs') or 0)
if msg_pv > 5 then
redis:setex(mero..':mute_pv:'..msg.sender_user_id_,18000,true)   
return sendMsg(msg.chat_id_,0,'*✿│* تم حظرك من البوت بسبب التكرار \n✿') 
end
redis:setex(mero..'user:'..msg.sender_user_id_..':msgs',2,msg_pv+1)
end

if msg.text=="/start" then 
if is_JoinChannel(msg) == false then
return false
end
if msg.SudoBase then
local text = '✿╿منور حبي ♥\n🔻 |  انت المـطـور الاسـاسـي هنا ✿\n𖤍━┅┄⟞⟦✿ 𝐓𝐎𝐋𝐄𝐍 ✿⟧⟝┄┉━𖤍\n\n✿  |  تسـتطـيع‌‏ التحكم بكل الاوامـر المـوجودة‌‏ بالكيبورد الخاص بالبوت\n🔺╽فقط اضـغط ع الامـر الذي تريد تنفيذه‌‏'
local keyboard = {
{"ضع اسم للبوت ✿","ضع صوره للترحيب ✿"},
 {"تعطيل التواصل ✿","تفعيل التواصل ✿"},
{"تعطيل البوت خدمي","تفعيل البوت خدمي","المطورين ✿"},
 {"المشتركين ✿","المجموعات ✿","الاحصائيات ✿"},
 {"اضف رد عام ✿","الردود العامه ✿"},
 {"مسح رد عام ✿"},
 {"اذاعه ✿","اذاعه خاص ✿"},
{"اذاعه عام ✿","اذاعه عام بالتوجيه ✿"},
 {"تحديث ✿","قائمه العام ✿","ايديي✿"},
{"تعطيل الاشتراك الاجباري ✿","تفعيل الاشتراك الاجباري ✿"},
{"تغيير الاشتراك الاجباري ✿","الاشتراك الاجباري ✿"},
{"تنظيف المشتركين ✿","تنظيف المجموعات ✿"},
 {"نسخه احتياطيه للمجموعات"},
 {"قناة السورس ✿"},
 {"تحديث السورس ✿"},
 {"الغاء الامر ✿"}}
return send_key(msg.sender_user_id_,text,keyboard,nil,msg.id_)
else
redis:sadd(mero..'users',msg.sender_user_id_)
if redis:get(mero..'lock_service') then 
text = [[✿╿اهلا انا بــــوت اســمـي []]..redis:get(mero..':NameBot:')..[[] 🗽
⛓│ اختـصاصـي حمايـه المجـموعـات ..
🛡│ مـن السـبام والتوجيه والتكرار والخ
✿╽ لتفعيل البوت اتبــع الشـروط ❕
¹↫ ❬اضف البوت الى المجموعه❭ ✿
²↫ ❬ارفع البوت مشرف في المجموعه❭✿
³↫ ❬وارسل تفعيل داخل المجموعة وسيتم تفعيل البوت ورفع مشرفي الكروب تلقائيا ❭ 🔱

ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
 ✿│مـعـرف الـمـطـــور ↫ ]]..SUDO_USER..[[
]]
else
text = [[✿╿اهلا انا بــــوت اســمـي []]..redis:get(mero..':NameBot:')..[[] 🗽
⛓│ اختـصاصـي حمايـه المجـموعـات ..
🛡│ مـن السـبام والتوجيه والتكرار والخ
✿╽ لتفعيل البوت اتبــع الشـروط ❕
¹↫ ❬اضف البوت الى المجموعه❭ ✿
²↫ ❬ارفع البوت مشرف في المجموعه❭✿
³↫ ❬وارسل تفعيل داخل المجموعة وسيتم تفعيل البوت ورفع مشرفي الكروب تلقائيا ❭ 🔱

ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
 ✿│مـعـرف الـمـطـــور ↫ ]]..SUDO_USER..[[
]]
end
xsudouser = SUDO_USER:gsub('@','')
xsudouser = xsudouser:gsub([[\_]],'_')
local inline = {{{text="مـطـور الـبـوت ✓",url="t.me/"..xsudouser}}}
send_key(msg.sender_user_id_,text,nil,inline,msg.id_)
return false
end
end
 
if msg.SudoBase then

if msg.reply_id and msg.text ~= "رفع نسخه الاحتياطيه" then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,datainfo)
if datainfo.forward_info_ then
local FwdUser = datainfo.forward_info_.sender_user_id_
GetUserID(FwdUser,function(arg,data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)
if msg.text == 'حظر' then
redis:sadd(mero..'BaN:In:User',data.id_)  
return SendMention(msg.sender_user_id_,data.id_,msg.id_,"✿│المستخدم : "..USERNAME.." \n✿| تم حظره \n",13,USERCAR)   
end 
if msg.text =='الغاء الحظر' then
redis:srem(mero..'BaN:In:User',data.id_)  
return SendMention(msg.sender_user_id_,data.id_,msg.id_,"✿│المستخدم : "..USERNAME.." \n✿| تم الغاء حظره \n",13,USERCAR)   
end 
end,nil)
end
end,nil)
end

if msg.reply_id and msg.text ~= "رفع نسخه الاحتياطيه" and msg.text ~= "حظر" and msg.text ~= "الغاء الحظر" then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,datainfo)
if datainfo.forward_info_ then

local FwdUser = datainfo.forward_info_.sender_user_id_
local FwdDate = datainfo.forward_info_.date_
GetUserID(FwdUser,function(arg,data)

local MSG_ID = (redis:get(mero.."USER_MSG_TWASEL"..FwdDate) or 1)
if msg.text then
sendMsg(FwdUser,MSG_ID,Flter_Markdown(msg.text))
elseif msg.sticker then
sendSticker(FwdUser,MSG_ID,sticker_id,msg.content_.caption_ or '')
elseif msg.photo then
sendPhoto(FwdUser,MSG_ID,photo_id,msg.content_.caption_ or '')
elseif msg.voice then
sendVoice(FwdUser,MSG_ID,voice_id,msg.content_.caption_ or '')
elseif msg.animation then
sendAnimation(FwdUser,MSG_ID,animation_id,msg.content_.caption_ or '')
elseif msg.video then
sendVideo(FwdUser,MSG_ID,video_id,msg.content_.caption_ or '')
elseif msg.audio then
sendAudio(FwdUser,MSG_ID,audio_id,msg.content_.caption_ or '')
end 

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)

SendMention(msg.sender_user_id_,data.id_,msg.id_,"✿│تم ارسـال الرسـال‏‏هہ✿\n✿│الى : "..USERNAME.." ✿",39,USERCAR) 
return false 
end,nil)
end  
end,nil)
end 
else
if not redis:get(mero..'lock_twasel') and not redis:sismember(mero..'BaN:In:User',msg.sender_user_id_) then
if msg.forward_info_ or msg.sticker or msg.content_.ID == "MessageUnsupported" then
sendMsg(msg.chat_id_,msg.id_,"✿│عذرا لا يمـكنك ارسـال { توجيه‌‏ , مـلصـق , فديو كام.} ❗️")
return false
end
redis:setex(mero.."USER_MSG_TWASEL"..msg.date_,43200,msg.id_)
sendMsg(msg.chat_id_,msg.id_,"✿╿تم ارسـال رسـالتك الى المـطـور\n✿│سـارد عليك في اقرب وقت\n👨‍✈️╽معرف المطور "..SUDO_USER)
tdcli_function({ID='GetChat',chat_id_ = SUDO_ID},function(arg,data)
fwdMsg(SUDO_ID,msg.chat_id_,msg.id_)
end,nil)
return false
end
end
end

--====================== Reply Only Group ====================================
if redis:get(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_) and redis:get(mero..'replay1'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(mero..'replay1'..msg.chat_id_..msg.sender_user_id_)
if msg.text then 
redis:hset(mero..'replay:'..msg.chat_id_,klma,Flter_Markdown(msg.text))
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\n  ✓ تم اضافة الرد \n✓')
elseif msg.photo then 
redis:hset(mero..'replay_photo:group:'..msg.chat_id_,klma,photo_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه صوره للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوره الاتيه ')
elseif msg.voice then
redis:hset(mero..'replay_voice:group:'..msg.chat_id_,klma,voice_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه بصمه صوت للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لسماع البصمه الاتيه ')
elseif msg.animation then
redis:hset(mero..'replay_animation:group:'..msg.chat_id_,klma,animation_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه متحركه للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوره الاتيه ')
elseif msg.video then
redis:hset(mero..'replay_video:group:'..msg.chat_id_,klma,video_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه فيديو للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الفيديو الاتي ')
elseif msg.audio then
redis:hset(mero..'replay_audio:group:'..msg.chat_id_,klma,audio_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه للصوت للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوت الاتي ')
elseif msg.sticker then
redis:hset(mero..'replay_sticker:group:'..msg.chat_id_,klma,sticker_id)
redis:del(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه ملصق للرد بنجاح ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الملصق الاتي ')
end  

end

--====================== Reply All Groups =====================================
if redis:get(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) and redis:get(mero..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(mero..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
if msg.text then
redis:hset(mero..'replay:all',klma,Flter_Markdown(msg.text))
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\n  ✓ تم اضافة الرد لكل المجموعات 🚀 ')
elseif msg.photo then 
redis:hset(mero..'replay_photo:group:',klma,photo_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه صوره للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوره الاتيه ')
elseif msg.voice then
redis:hset(mero..'replay_voice:group:',klma,voice_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه بصمه صوت للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لسماع البصمه الاتيه ')
elseif msg.animation then
redis:hset(mero..'replay_animation:group:',klma,animation_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه متحركه للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوره الاتيه ')
elseif msg.video then
redis:hset(mero..'replay_video:group:',klma,video_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه فيديو للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵لاضهار الفيديو الاتي ')
elseif msg.audio then
redis:hset(mero..'replay_audio:group:',klma,audio_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه للصوت للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الصوت الاتي ')
elseif msg.sticker then
redis:hset(mero..'replay_sticker:group:',klma,sticker_id)
redis:del(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'✿╿تم اضافه ملصق للرد العام ✓\n✿╽يمكنك ارسال ❴ ['..klma..'] ❵ لاضهار الملصق الاتي ')
end  

end

if msg.text then
if msg.text == 'ملصق' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_ then
if data.content_.photo_.sizes_[0] then
photo_in_group = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
if data.content_.photo_.sizes_[1] then
photo_in_group = data.content_.photo_.sizes_[1].photo_.persistent_id_
end
if data.content_.photo_.sizes_[2] then
photo_in_group = data.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if data.content_.photo_.sizes_[3] then
photo_in_group = data.content_.photo_.sizes_[3].photo_.persistent_id_
end
end
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..photo_in_group) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.webp') 
sendSticker(msg.chat_id_,msg.id_,Name_File)
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذه ليست صوره')
end
end, nil)
end
if msg.text == 'صوره' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageSticker" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content_.sticker_.sticker_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.jpg') 
sendPhoto(msg.chat_id_,msg.id_,Name_File,'')
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذا ليس ملصق')
end
end, nil)
end
if msg.text == 'بصمه' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageAudio" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content_.audio_.audio_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.ogg') 
sendVoice(msg.chat_id_,msg.id_,Name_File,'')
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذا ليس ملف صوتي')
end
end, nil)
end
if msg.text == 'صوت' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageVoice" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content_.voice_.voice_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.mp3') 
sendAudio(msg.chat_id_,msg.id_,Name_File)  
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذا ليس بصمه')
end
end, nil)
end
if msg.text == 'mp3' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageVideo" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content_.video_.video_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.mp3') 
sendAudio(msg.chat_id_,msg.id_,Name_File)  
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذا ليس فيديو')
end
end, nil)
end
if msg.text == 'متحركه' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(mero..'kadmeat'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageVideo" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. Token .. '/getfile?file_id='..data.content_.video_.video_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path, './'..msg.id_..'.mp4') 
sendAnimation(msg.chat_id_,msg.id_,Name_File)   
os.execute('rm -rf '..Name_File) 
else
sendMsg(msg.chat_id_,msg.id_,'هذا ليس فيديو')
end
end, nil)
end

if text == "غنيلي"  or text == "غني" then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."knele"..msg.chat_id_) then
data,res = https.request('https://black-source.tk/BlackTeAM/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='✯︙تم اختيار المقطع الصوتي لك'
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end

if msg.text and msg.text:match("^انطق (.*)$") and not redis:get(mero..'intg'..msg.chat_id_)   then
if is_JoinChannel(msg) == false then
return false
end
local UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(msg.text:match("^انطق (.*)$")))
Antk = JSON.decode(UrlAntk)
if UrlAntk.ok ~= false then
uuu = download("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",'./'..Antk.result.translate..'.mp3') 

sendAudio(msg.chat_id_,msg.id_,uuu)  
os.execute('rm -rf ./'..Antk.result.translate..'.mp3') 
end
end

 
if msg.text == "نسبه الحب" or msg.text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
hggg = '✿│الان ارسل اسمك واسم الشخص الثاني :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if redis:get(mero..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '✫: اليك النتائج الخـاصة :\n\n✫: نسبة الحب بيـن : *'..msg.text..'* '..sendnum..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if msg.text == "نسبه الغباء" or msg.text == "نسبه غباء" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":lov_Bottts"..msg.chat_id_,"sendlove")
hggg = '✿│الان ارسل اسم الشخص :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if redis:get(mero..":"..msg.sender_user_id_..":lov_Bottts"..msg.chat_id_) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '✫: اليك النتائج الخـاصة :\n\n✫: نسبة الغباء  : *'..msg.text..'* '..sendnum..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":lov_Bottts"..msg.chat_id_)
end

if msg.text == "نسبه الذكاء" or msg.text == "نسبه ذكاء" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":lov_Botttuus"..msg.chat_id_,"sendlove")
hggg = '✿│الان ارسل اسم الشخص :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if redis:get(mero..":"..msg.sender_user_id_..":lov_Botttuus"..msg.chat_id_) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '✫: اليك النتائج الخـاصة :\n\n✫: نسبة الذكاء  : *'..msg.text..'* '..sendnum..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":lov_Botttuus"..msg.chat_id_)
end


if msg.text == "نسبه الكره" or msg.text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
hggg = '✿│الان ارسل اسمك واسم الشخص الثاني :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if msg.text and redis:get(mero..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '⌯ اليك النتائج الخـاصة :\n\n⌯ نسبه الكره : *'..msg.text..'* '..sendnum..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if msg.text == "نسبه الرجوله" or msg.text == "نسبه رجوله" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
hggg = '✿│الان ارسل اسم الشخص :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if msg.text and msg.text ~="نسبه الرجوله" and redis:get(mero..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","?? 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnuj = numj[math.random(#numj)]
local tttttt = '✫: اليك النتائج الخـاصة :\n\n✫:  نسبة الرجوله لـ : *'..msg.text..'* '..sendnuj..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if msg.text == "نسبه الانوثه" or msg.text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
redis:set(mero..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
hggg = '✿│الان ارسل اسم الشخص :'
sendMsg(msg.chat_id_, msg.id_,hggg) 
return false
end
end

if msg.text and msg.text ~="نسبه الانوثه" and redis:get(mero..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnuj = numj[math.random(#numj)]
local tttttt = '✫: اليك النتائج الخـاصة :\n\n✫:  نسبه الانوثة لـ : *'..msg.text..'* '..sendnuj..'%'
sendMsg(msg.chat_id_, msg.id_,tttttt) 
redis:del(mero..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end

if msg.text and msg.text:match("^برج (.*)$") and redis:get(mero.."brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = msg.text:match("^برج (.*)$")
if is_JoinChannel(msg) == false then
return false
end
gk = https.request('https://black-source.tk/BlackTeAM/Horoscopes.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
sendMsg(msg.chat_id_, msg.id_, br.ok.hso)
end

if msg.text == ("المقيدين") and msg.Director then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero..'Muted:User:kid'..msg.chat_id_)
t = "\n *⌔︙قائمة المقيديين* \n*•━━━━━━ 𝑷𝑨 ━━━━━━━•*\n"
for k,v in pairs(list) do
local info = redis:hgetall(mero..'username:'..v)
  if info and info.username and info.username:match("@[%a%d_]+") then
  t = t ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
  else
  t = t ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
  end
end
if #list == 0 then
t = " *⌔︙لا يوجد مقيدين*"
end
sendMsg(msg.chat_id_, msg.id_, t)
end
if msg.text == 'مسح المقيدين' and msg.Director then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero..'Muted:User:kid'..msg.chat_id_)
for k,v in pairs(list) do
Restrict(msg.chat_id_,v,2)
end
redis:del(mero..'Muted:User:kid'..msg.chat_id_)
sendMsg(msg.chat_id_, msg.id_, ' *⌔︙تم مسح المقيدين*')
end

--====================== Requst UserName Of Channel For ForceSub ==============
local Text = msg.text
local UserID =  msg.sender_user_id_
if msg.Creator then
if Text == "تعين الايدي" and msg.SudoUser then
if is_JoinChannel(msg) == false then
return false
end
redis:setex("CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
local hasnid= [[
*✿¦ اهلا بك عزيزي  
✿¦تستطيع الان تغير كليشه الايدي ✿
---------------------
 •  الايدي •* `IDGET`
*• رتبتي • * `RTBGET`
*• المعرف • * `USERGET`
*• رسائلك • * `MSGGET`
*•سحكاتك • * `edited`
*• تفاعلك • * `TFGET`
*• جهاتك • * `adduser`
*•مجوهراتك • * `User_Points`

]]
return sendMsg(msg.chat_id_,msg.id_,hasnid) 
end
if Text == "مسح الايدي" and msg.SudoUser then
if is_JoinChannel(msg) == false then
return false
end
redis:del("KLISH:ID")
sendMsg(msg.chat_id_,msg.id_,"✿*¦* أهلا عزيزي "..msg.TheRankCmd.."\n✿*¦* تم  حذف كليشه الايدي \n✓")
return false  
end
if redis:get("CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if Text == "الغاء" then 
sendMsg(msg.chat_id_,msg.id_,"*✿¦ تم الغاء الامر *\n✓")
redis:del("CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end 
redis:del("CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = Text:match("(.*)")  
redis:set("KLISH:ID",CHENGER_ID)
sendMsg(msg.chat_id_,msg.id_,'\n*🏌️‍¦ تم تغير كليشه الايدي بنجاح*\n')
end

end

if msg.content_.ID == "MessageChatAddMembers" then  
redis:set(mero.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(mero.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
BESSO = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(BESSO)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end



if text == 'مين ضافني' then
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'⚠¦ انت منشئ المجموعه ') 
return false
end
local Added_Me = redis:get(mero.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '✿¦ الشخص الذي قام باضافتك هو » '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'✿¦ انت دخلت عبر الرابط') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'⚠¦ امر مين ضافني تم تعطيله من قبل المدراء ') 
end
end

if text == "تفعيل مين ضافني" then   
if is_JoinChannel(msg) == false then
return false
end
if redis:get(mero..'Added:Me'..msg.chat_id_) then
sendMsg(msg.chat_id_,msg.id_,"✿*¦* أهلا عزيزي "..msg.TheRankCmd.."\n✿*¦* تم  تفعيل امر مين ضافني\n✓")
redis:del(mero..'Added:Me'..msg.chat_id_)  
else
sendMsg(msg.chat_id_,msg.id_,"✿*¦* أهلا عزيزي "..msg.TheRankCmd.."\n✿*¦* تم  تفعيل مين ضافني سابقا \n✓")
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل مين ضافني' then  
if is_JoinChannel(msg) == false then
return false
end
if not redis:get(mero..'Added:Me'..msg.chat_id_) then
redis:set(mero..'Added:Me'..msg.chat_id_,true)  
sendMsg(msg.chat_id_,msg.id_,"✿*¦* أهلا عزيزي "..msg.TheRankCmd.."\n✿*¦* تم  تعطيل مين ضافني\n✓")
else
sendMsg(msg.chat_id_,msg.id_,"✿*¦* أهلا عزيزي "..msg.TheRankCmd.."\n✿*¦* تم تعطيل مين ضافني سابقا\n✓")
end
send(msg.chat_id_, msg.id_,Text) 
end

if redis:get(mero..":ForceSub:"..msg.sender_user_id_) then
if msg.text:match("^@[%a%d_]+$") then
redis:del(mero..":ForceSub:"..msg.sender_user_id_)
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..msg.text..'&user_id='..msg.sender_user_id_)
if res == 400 then
local Req = JSON.decode(url)
if Req.description == "Bad Request: chat not found" then 
sendMsg(msg.chat_id_,msg.id_,"✿╿عذرا , هناك خطأ لديك \n✿╽المعرف الذي ارسلته ليس معرف قناة.")
return false
elseif Req.description == "Bad Request: CHAT_ADMIN_REQUIRED" then
sendMsg(msg.chat_id_,msg.id_,"✿╿عذرا , لقد نسيت شيئا \n✿╽يجب رفع البوت مشرف في قناتك لتتمكن من تفعيل الاشتراك الاجباري .")
return false
end
else
redis:set(mero..":UserNameChaneel",msg.text)
sendMsg(msg.chat_id_,msg.id_,"✿╿جـيـد , الان لقد تم تفعيل الاشتراك الاجباري\n✿╽على قناتك ⇜ ["..msg.text.."]")
return false
end
else
sendMsg(msg.chat_id_,msg.id_,"✿╿عذرا , عزيزي المطور \n✿╽هذا ليس معرف قناة , حاول مجددا .")
return false
end
end

if redis:get(mero..'namebot:witting'..msg.sender_user_id_) then --- استقبال اسم البوت 
redis:del(mero..'namebot:witting'..msg.sender_user_id_)
redis:set(mero..':NameBot:',msg.text)
Start_Bot() 
sendMsg(msg.chat_id_,msg.id_,"✿╿تم تغير اسم البوت  \n✿╽الان اسمه "..Flter_Markdown(msg.text).." \n✓")
return false
end

if redis:get(mero..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد لكل المجموعات
if not redis:get(mero..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال كلمه الرد لكل المجموعات
redis:hdel(mero..'replay_photo:group:',msg.text)
redis:hdel(mero..'replay_voice:group:',msg.text)
redis:hdel(mero..'replay_animation:group:',msg.text)
redis:hdel(mero..'replay_audio:group:',msg.text)
redis:hdel(mero..'replay_sticker:group:',msg.text)
redis:hdel(mero..'replay_video:group:',msg.text)
redis:setex(mero..'allreplay:'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"✿╿جيد , يمكنك الان ارسال جواب الرد العام \n✿╽[[ نص,صوره,فيديو,متحركه,بصمه,اغنيه ]]\n✓")
end
end

if redis:get(mero..'delrdall:'..msg.sender_user_id_) then
redis:del(mero..'delrdall:'..msg.sender_user_id_)
local names = redis:hget(mero..'replay:all',msg.text)
local photo =redis:hget(mero..'replay_photo:group:',msg.text)
local voice = redis:hget(mero..'replay_voice:group:',msg.text)
local animation = redis:hget(mero..'replay_animation:group:',msg.text)
local audio = redis:hget(mero..'replay_audio:group:',msg.text)
local sticker = redis:hget(mero..'replay_sticker:group:',msg.text)
local video = redis:hget(mero..'replay_video:group:',msg.text)
if not (names or photo or voice or animation or audio or sticker or video) then
return sendMsg(msg.chat_id_,msg.id_,'✿*│*هذا الرد ليس مضاف في قائمه الردود ✿')
else
redis:hdel(mero..'replay:all',msg.text)
redis:hdel(mero..'replay_photo:group:',msg.text)
redis:hdel(mero..'replay_voice:group:',msg.text)
redis:hdel(mero..'replay_audio:group:',msg.text)
redis:hdel(mero..'replay_animation:group:',msg.text)
redis:hdel(mero..'replay_sticker:group:',msg.text)
redis:hdel(mero..'replay_video:group:',msg.text)
return sendMsg(msg.chat_id_,msg.id_,'('..Flter_Markdown(msg.text)..')\n  ✓ تم مسح الرد ')
end 
end 


if redis:get(mero..'text_sudo:witting'..msg.sender_user_id_) then -- استقبال كليشه المطور
redis:del(mero..'text_sudo:witting'..msg.sender_user_id_) 
redis:set(mero..':TEXT_SUDO',Flter_Markdown(msg.text))
return sendMsg(msg.chat_id_,msg.id_, "✿*│* تم وضع الكليشه بنجاح كالاتي ✿🏻\n\n*{*  "..Flter_Markdown(msg.text).."  *}*\n✓")
end
if redis:get(mero..'welcom:witting'..msg.sender_user_id_) then -- استقبال كليشه الترحيب
redis:del(mero..'welcom:witting'..msg.sender_user_id_) 
redis:set(mero..'welcome:msg'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"✿*│* تم وضع الترحيب بنجاح كالاتي\n✓" )
end
if redis:get(mero..'rulse:witting'..msg.sender_user_id_) then --- استقبال القوانين
redis:del(mero..'rulse:witting'..msg.sender_user_id_) 
redis:set(mero..'rulse:msg'..msg.chat_id_,Flter_Markdown(msg.text)) 
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* مرحبا عزيزي\n✿│تم حفظ القوانين بنجاح ✓\n✿╽ارسل [[ القوانين ]] لعرضها \n✿✓')
end
if redis:get(mero..'name:witting'..msg.sender_user_id_) then --- استقبال الاسم
redis:del(mero..'name:witting'..msg.sender_user_id_) 
tdcli_function({ID= "ChangeChatTitle",chat_id_=msg.chat_id_,title_=msg.text},dl_cb,nil)
end
if redis:get(mero..'linkGroup'..msg.sender_user_id_,link) then --- استقبال الرابط
redis:del(mero..'linkGroup'..msg.sender_user_id_,link) 
redis:set(mero..'linkGroup'..msg.chat_id_,Flter_Markdown(msg.text)) 
return sendMsg(msg.chat_id_,msg.id_,'🖇│تم وضع الرابط الجديد بنجاح .. 🍂')
end
if redis:get(mero..'about:witting'..msg.sender_user_id_) then --- استقبال الوصف
redis:del(mero..'about:witting'..msg.sender_user_id_) 
tdcli_function({ID="ChangeChannelAbout",channel_id_=msg.chat_id_:gsub('-100',''),about_ = msg.text},function(arg,data) 
if data.ID == "Ok" then 
return sendMsg(msg.chat_id_,msg.id_,"✿*│* تم وضع الوصف بنجاح\n✓")
end 
end,nil)
end


if redis:get(mero..'fwd:all'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه عام
redis:del(mero..'fwd:all'..msg.sender_user_id_)
local pv = redis:smembers(mero..'users')  
local groups = redis:smembers(mero..'group:ids')
local allgp =  #pv + #groups
if allgp >= 300 then
sendMsg(msg.chat_id_,msg.id_,'✿╿اهلا عزيزي المطور \n✿╽جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
for i = 1, #pv do 
sendMsg(pv[i],0,Flter_Markdown(msg.text),nil,function(arg,data)
if data.send_state_ and data.send_state_.ID == "MessageIsBeingSent"  then
print("Sender Ok")
else
print("Rem user From list")
redis:srem(mero..'users',pv[i])
end
end)
end
for i = 1, #groups do 
if not redis:sismember(mero..'BotFree:Group:',groups[i]) then
sendMsg(groups[i],0,Flter_Markdown(msg.text),nil,function(arg,data)
if data.send_state_ and data.send_state_.ID == "MessageIsBeingSent"  then
print("Sender Ok")
else
print("Rem Group From list")
rem_data_group(groups[i])
end
end)
end
end
return sendMsg(msg.chat_id_,msg.id_,'✿*╿*تم اذاعه الكليشه بنجاح ✿\n✿*│*للمـجمـوعات » ❴ *'..#groups..'* ❵ كروب \n✿*╽* للمـشـتركين » ❴ '..#pv..' ❵ مـشـترك \n✓')
end

if redis:get(mero..'fwd:pv'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
redis:del(mero..'fwd:pv'..msg.sender_user_id_)
local pv = redis:smembers(mero..'users')
if #pv >= 300 then
sendMsg(msg.chat_id_,msg.id_,'✿╿اهلا عزيزي المطور \n✿╽جاري نشر الرساله للمشتركين ...')			
end
local NumPvDel = 0
for i = 1, #pv do
sendMsg(pv[i],0,Flter_Markdown(msg.text),nil,function(arg,data)
if data.send_state_ and data.send_state_.ID == "MessageIsBeingSent"  then
print("Sender Ok")
else
print("Rem Group From list")
redis:srem(mero..'users',pv[i])
NumPvDel = NumPvDel + 1
end
if #pv == i then 
local SenderOk = #pv - NumPvDel
sendMsg(msg.chat_id_,msg.id_,'🙍✿‍♂*╿*عدد المشتركين : ❴ '..#pv..' ❵\n✿*╽*تم الاذاعه الى ❴ '..SenderOk..'  ❵ مشترك \n ✓') 
end
end)
end
end

if redis:get(mero..'fwd:groups'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
local groups = redis:smembers(mero..'group:ids')
redis:del(mero..'fwd:groups'..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'✿*╿*عدد المجموعات ❴ *'..#redis:smembers(mero..'group:ids')..'* ❵\n✿*╽*تـم الاذاعه الى ❴ *'..#redis:smembers(mero..'group:ids')..'* ❵\n✓')
if #groups >= 300 then
sendMsg(msg.chat_id_,msg.id_,'✿╿اهلا عزيزي المطور \n✿╽جاري نشر الرساله للمجموعات ...')			
end
local NumGroupsDel = 0
for i = 1, #groups do 
if not redis:sismember(mero..'BotFree:Group:',groups[i]) then
sendMsg(groups[i],0,Flter_Markdown(msg.text),nil,function(arg,data)
if data.send_state_ and data.send_state_.ID == "MessageIsBeingSent"  then
print("Sender Ok") 
else
print("Rem Group From list")
rem_data_group(groups[i])
NumGroupsDel = NumGroupsDel + 1
end
if #groups == i then
local AllGroupSend = #groups - NumGroupsDel
if NumGroupsDel ~= 0 then
MsgTDel = '✿*│*تم حذف ❴ *'..NumGroupsDel..'* ❵ من قائمه الاذاعه لانهم قاموا بطرد البوت من المجموعه'
else
MsgTDel = ''
end
end
end)
end
end
end 
end 

if msg.adduser and msg.adduser == our_id and redis:get(mero..':WELCOME_BOT') then
sendPhoto(msg.chat_id_,msg.id_,redis:get(mero..':WELCOME_BOT'),[[⚜╿اهلا انا بوت اسـمـي ]]..redis:get(mero..':NameBot:')..[[ ✓
👨🏻‍✈️│اختصـاصـي حمـايه المـجمـوعات
✿╽مـن السـبام والتوجيه والتكرار والخ...

✿│مـعـرف الـمـطـور  : ]]..SUDO_USER:gsub([[\_]],'_')..[[✿
]])
return false
end 

if msg.forward_info and redis:get(mero..'fwd:'..msg.sender_user_id_) then
redis:del(mero..'fwd:'..msg.sender_user_id_)
local pv = redis:smembers(mero..'users')
local groups = redis:smembers(mero..'group:ids')
local allgp =  #pv + #groups
if allgp == 500 then
sendMsg(msg.chat_id_,msg.id_,'✿╿اهلا عزيزي المطور \n✿╽جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
local number = 0
for i = 1, #pv do 
fwdMsg(pv[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
for i = 1, #groups do 
if not redis:sismember(mero..'BotFree:Group:',groups[i]) then
fwdMsg(groups[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
end
return sendMsg(msg.chat_id_,msg.id_,'✿*╿*تم اذاعه التوجيه بنجاح ✿\n✿*│*للمـجمـوعات » ❴ *'..#groups..'* ❵\n✿*╽*للخاص » ❴ '..#pv..' ❵\n✓')			
end

 
if msg.text and msg.text:match("^(.*)$") then
if redis:get(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
sendMsg(msg.chat_id_, msg.id_, '\nارسل لي الكلمه الان ')
redis:set(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(mero.."botss:merox:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, msg.text)
redis:sadd(mero.."botss:merox:List:Rd:Sudo"..msg.chat_id_, msg.text)
return false end
end
if msg.text and msg.text:match("^(.*)$") then
if redis:get(mero.."botss:merox:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
sendMsg(msg.chat_id_, msg.id_,"تم حذف الرد من ردود المتعدده")
redis:del(mero..'botss:merox:Add:Rd:Sudo:Text'..msg.text..msg.chat_id_)
redis:del(mero..'botss:merox:Add:Rd:Sudo:Text1'..msg.text..msg.chat_id_)
redis:del(mero..'botss:merox:Add:Rd:Sudo:Text2'..msg.text..msg.chat_id_)
redis:del(mero.."botss:merox:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(mero.."botss:merox:List:Rd:Sudo"..msg.chat_id_, msg.text)
return false
end
end
if msg.text then
local test = redis:get(mero.."botss:merox:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:set(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if msg.text then   
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub("`","") 
msg.text = msg.text:gsub("*","") 
redis:set(mero.."botss:merox:Add:Rd:Sudo:Text"..test..msg.chat_id_, msg.text)  
end  
sendMsg(msg.chat_id_, msg.id_,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if msg.text then
local test = redis:get(mero.."botss:merox:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
redis:set(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if msg.text then   
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub("`","") 
msg.text = msg.text:gsub("*","") 
redis:set(mero.."botss:merox:Add:Rd:Sudo:Text1"..test..msg.chat_id_, msg.text)  
end  
sendMsg(msg.chat_id_, msg.id_,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if msg.text then
local test = redis:get(mero.."botss:merox:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
redis:set(mero.."botss:merox:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if msg.text then   
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub('"',"") 
msg.text = msg.text:gsub("`","") 
msg.text = msg.text:gsub("*","") 
redis:set(mero.."botss:merox:Add:Rd:Sudo:Text2"..test..msg.chat_id_, msg.text)  
end  
sendMsg(msg.chat_id_, msg.id_,"تم حفظ الرد")
return false  
end  
end
if msg.text then
local Text = redis:get(mero.."botss:merox:Add:Rd:Sudo:Text"..msg.text..msg.chat_id_)   
local Text1 = redis:get(mero.."botss:merox:Add:Rd:Sudo:Text1"..msg.text..msg.chat_id_)   
local Text2 = redis:get(mero.."botss:merox:Add:Rd:Sudo:Text2"..msg.text..msg.chat_id_)   
if Text or Text1 or Text2 then 
local texting = {Text,Text1,Text2}
sendMsg(msg.chat_id_, msg.id_,texting[math.random(#texting)])
end
end




if msg.text and msg.type == "channel" then
if msg.text:match("^"..Bot_Name.." غادر$") and (msg.SudoBase or msg.SudoBase) then
sendMsg(msg.chat_id_,msg.id_,'✿│بالناقص منكم - باي 💔🚶‍♂')
rem_data_group(msg.chat_id_)
StatusLeft(msg.chat_id_,our_id)
return false
end
end

if msg.content_.ID == "MessagePhoto" and redis:get(mero..'welcom_ph:witting'..msg.sender_user_id_) then
redis:del(mero..'welcom_ph:witting'..msg.sender_user_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:set(mero..':WELCOME_BOT',photo_id)
return sendMsg(msg.chat_id_,msg.id_,'✿│تم تغيير صـورهہ‏‏ الترحيب للبوت✿\n✓')
end 

if msg.content_.ID == "MessagePhoto" and msg.type == "channel" and msg.GroupActive then
if redis:get(mero..'photo:group'..msg.chat_id_..msg.sender_user_id_) then
redis:del(mero..'photo:group'..msg.chat_id_..msg.sender_user_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({ID="ChangeChatPhoto",chat_id_=msg.chat_id_,photo_=GetInputFile(photo_id)},function(arg,data)
if data.code_ == 3 then
sendMsg(arg.chat_id_,arg.id_,'✿╿ليس لدي صلاحيه تغيير الصوره \n✿╽يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ⠀\n✓')
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
return false
end
end

if not msg.GroupActive then return false end
if msg.text then

if redis:get(mero..'addrd:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد للمجموعه فقط

if not redis:get(mero..'replay1'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
redis:hdel(mero..'replay:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_video:group:'..msg.chat_id_,msg.text)
redis:setex(mero..'replay1'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"✿╿جيد , يمكنك الان ارسال جواب الرد \n✿╽[[ نص,صوره,فيديو,متحركه,بصمه,اغنيه ]]\n✓")
end
end

if redis:get(mero..'delrd:'..msg.sender_user_id_) then
redis:del(mero..'delrd:'..msg.sender_user_id_)
local names 	= redis:hget(mero..'replay:'..msg.chat_id_,msg.text)
local photo 	= redis:hget(mero..'replay_photo:group:'..msg.chat_id_,msg.text)
local voice 	= redis:hget(mero..'replay_voice:group:'..msg.chat_id_,msg.text)
local animation = redis:hget(mero..'replay_animation:group:'..msg.chat_id_,msg.text)
local audio 	= redis:hget(mero..'replay_audio:group:'..msg.chat_id_,msg.text)
local sticker 	= redis:hget(mero..'replay_sticker:group:'..msg.chat_id_,msg.text)
local video 	= redis:hget(mero..'replay_video:group:'..msg.chat_id_,msg.text)
if not (names or photo or voice or animation or audio or sticker or video) then
return sendMsg(msg.chat_id_,msg.id_,'✿*│*هذا الرد ليس مضاف في قائمه الردود ✿')
else
redis:hdel(mero..'replay:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(mero..'replay_video:group:'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..msg.text..'])\n  ✓ تم مسح الرد ')
end 
end

end

if msg.pinned then
print(" -- pinned -- ")
local msg_pin_id = redis:get(mero..":MsgIDPin:"..msg.chat_id_)
if not msg.Director and redis:get(mero..'lock_pin'..msg.chat_id_) then
if msg_pin_id then
print(" -- pinChannelMessage -- ")
tdcli_function({ID ="PinChannelMessage",
channel_id_ = msg.chat_id_:gsub('-100',''),
message_id_ = msg_pin_id,
disable_notification_ = 0},
function(arg,data)
if data.ID == "Ok" then
return sendMsg(msg.chat_id_,msg.id_,"✿*│* عذرا التثبيت مقفل من قبل الاداره تم ارجاع التثبيت القديم\n")
end
end,nil)
else
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},
function(arg,data) 
if data.ID == "Ok" then
return sendMsg(msg.chat_id_,msg.id_,"✿*│* عذرا التثبيت مقفل من قبل الاداره تم الغاء التثبيت\n✓")      
end
end,nil)
end
return false
end
redis:set(mero..":MsgIDPin:"..msg.chat_id_,msg.id_)
end

if msg.content_.ID == "MessageChatChangePhoto" then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end
return sendMsg(msg.chat_id_,msg.id_," قام ["..UserName.."] بتغير صوره المجموعه ✓\n")
end)
end

if msg.content_.ID == "MessageChatChangeTitle" then
GetUserID(msg.sender_user_id_,function(arg,data)
redis:set(mero..'group:name'..msg.chat_id_,msg.content_.title_)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end

return sendMsg(msg.chat_id_,msg.id_,"✿╿ قام  ["..UserName.."]\n✿│بتغير اسم المجموعه  ✋\n✿╽الى "..Flter_Markdown(msg.content_.title_).." \n✓") 
end)
end
if msg.adduser or msg.joinuser then
if redis:get(mero..'mute_tgservice'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_)
else
if redis:get(mero..'welcome:get'..msg.chat_id_) then 
if not msg.adduserType then
GetUserID(msg.sender_user_id_,function(arg,data)  
welcome = (redis:get(mero..'welcome:msg'..msg.chat_id_) or "✿│اهلن بك عزيزي {الاسم}\n✿│معرفك » {المعرف}\n{القوانين}\n\nالرجاء الالتزام بالقوانين ♥\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n⚜│اسم الكروب » {المجموعه}")
if welcome then
rules = (redis:get(mero..'rulse:msg'..msg.chat_id_) or "✿╿مرحبأ عزيري القوانين كلاتي 👇🏻\n✿│ممنوع نشر الروابط\n✿│ممنوع التكلم او نشر صور اباحيه\n⚔│ممنوع  اعاده توجيه\n✿│ممنوع التكلم بلطائفه\n♥️╽الرجاء احترام المدراء والادمنيه \n")
welcome = welcome:gsub("{القوانين}", rules)
if data.username_ then UserName = '@'..data.username_ else UserName = '< لا يوجد معرف >' end
welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(mero..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{المعرف}",UserName)
local welcome = welcome:gsub("{الاسم}",FlterName(data.first_name_..' '..(data.last_name_ or "" ),20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome))
end 
end)
else
welcome = (redis:get(mero..'welcome:msg'..msg.chat_id_) or "✿│اهلن بك عزيزي {الاسم}\n✿│معرفك » {المعرف}\n{القوانين}\n\nالرجاء الالتزام بالقوانين ♥\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n⚜│اسم الكروب » {المجموعه}")
if welcome then
rules = (redis:get(mero..'rulse:msg'..msg.chat_id_) or "✿╿مرحبأ عزيري القوانين كلاتي 👇🏻\n✿│ممنوع نشر الروابط\n✿│ممنوع التكلم او نشر صور اباحيه\n⚔│ممنوع  اعاده توجيه\n✿│ممنوع التكلم بلطائفه\n♥️╽الرجاء احترام المدراء والادمنيه ✿\n")
welcome = welcome:gsub("{القوانين}", rules)
if msg.addusername then UserName = '@'..msg.addusername else UserName = '< لا يوجد معرف >' end
welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(mero..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{المعرف}",UserName)
local welcome = welcome:gsub("{الاسم}",FlterName(msg.addname,20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome))
end 
end
end

end
end 

-------------------------------------------
if msg.adduser and redis:get(mero..'welcome:get'..msg.chat_id_) then
  local adduserx = tonumber(redis:get(mero..'user:'..msg.sender_user_id_..':msgs') or 0)
  if adduserx > 3 then 
  redis:del(mero..'welcome:get'..msg.chat_id_)
  end
  redis:setex(mero..'user:'..msg.sender_user_id_..':msgs',3,adduserx+1)
  end
  
  
    if not msg.Admin and not (msg.adduser or msg.joinuser or msg.deluser ) then -- Delete For User $ Vip


    if tonumber(msg.via_bot_user_id_) ~= 0 and redis:get(mero..'mute_inline'..msg.chat_id_) then -- قفل الانلاين
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send inline \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا الانلاين مقفول  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
end
    

if msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text and msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text and msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text and msg.text:match("[Ww][Ww][Ww].") or msg.text and msg.text:match(".[Cc][Oo][Mm]") or msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text and msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text and msg.text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.text and msg.text:match("[Tt].[Mm][Ee]/") then
print(msg.text)
if redis:get(mero..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال الروابط  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
end
end

if (msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text and msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text and msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text and msg.text:match(".[Pp][Ee]") 
or msg.text and msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text and msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text and msg.text:match("[Ww][Ww][Ww].") 
or msg.text and msg.text:match(".[Cc][Oo][Mm]")) 
and redis:get(mero..':tqeed_link:'..msg.chat_id_)  then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user i restricted becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false
end
end


    if not msg.Special and not (msg.adduser or msg.joinuser or msg.deluser ) then -- Delete For User $ Vip
 if msg.text then
 
    if msg.text and (msg.text:match("ه‍") or msg.text:match("ی") or msg.text:match("ک")) and redis:get(mero.."lock_pharsi"..msg.chat_id_) then
    Del_msg(msg.chat_id_,msg.id_,function(arg,data)
    print("\27[1;31m Msg Del becuse send lock_pharsi \27[0m")
    if data.ID == "Error" and data.code_ == 6 then
    return sendMsg(msg.chat_id_,msg.id_,'✿*¦* لا يمكنني مسح الرساله المخالفه .\n✿*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
    end
    if redis:get(mero..'lock_woring'..msg.chat_id_) then
    GetUserID(msg.sender_user_id_,function(arg,data)
    if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
    SendMention(msg.chat_id_,data.id_,msg.id_,"✿¦ العضو » "..USERNAME.."\n✿¦ ممنوع ارسال الفارسيه  \n✿",11,utf8.len(USERNAME))
    end,nil)
    end
    end)
    end
  
    if msg.text and (msg.text:match("كسمك") or msg.text:match("منيوج") or msg.text:match("عير") or msg.text:match("منيوك") or msg.text:match("طويز") or msg.text:match("العيوره") or msg.text:match("مناويج") or msg.text:match("عيوره") or msg.text:match("فروخ") or msg.text:match("sex") or msg.text:match("نيج")  or msg.text:match("كحاب")  or msg.text:match("طيازه")or msg.text:match("طيز")or msg.text:match("كس") or msg.text:match("زب") or msg.text:match("نيك") or msg.text:match("فرخ") or msg.text:match("كحبه") or msg.text:match("انيكك") or msg.text:match("امك") or msg.text:match("اختك")  or msg.text:match("شرموطه")  or msg.text:match("عاهرة")or msg.text:match("ديوزه")or msg.text:match("قحبه") or msg.text:match("عرص") or msg.text:match("معرص") or msg.text:match("خنيث") or msg.text:match("يالخنيث") or msg.text:match("خول") or msg.text:match("خولات") )and redis:get(mero.."lock_mmno3"..msg.chat_id_) then
    Del_msg(msg.chat_id_,msg.id_,function(arg,data)
    print("\27[1;31m Msg Del becuse send mseeea \27[0m")
    if data.ID == "Error" and data.code_ == 6 then
    return sendMsg(msg.chat_id_,msg.id_,'✿*¦* لا يمكنني مسح الرساله المخالفه .\n✿*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
    end
    if redis:get(mero..'lock_woring'..msg.chat_id_) then
    GetUserID(msg.sender_user_id_,function(arg,data)
    if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
    SendMention(msg.chat_id_,data.id_,msg.id_,"✿¦ العضو » "..USERNAME.."\n✿¦ ممنوع ارسال الكلمات المسيئه  \n✿",11,utf8.len(USERNAME))
    end,nil)
    end
    end)
    end
    end

    
  end
  
  

      if msg.edited and redis:get(mero.."lock_edit_media"..msg.chat_id_) and not (msg.content_.ID == "MessageText") then 
      print('&&&')
     if not msg.Director then  
        GetUserID(msg.sender_user_id_,function(arg,data)
        msg = arg.msg 
        local usersmnc = ""
        local NameUser = Hyper_Link_Name(data)
        if data.username_  then
        uuseri = "\n✿│ معرفه : @["..(data.username_ or "None").."]" 
        else
        uuseri = ""
        end
        if (msg.content_.ID == "MessagePhoto") then
        Rwers = "صوره"
        Del_msg(msg.chat_id_,msg.id_)
        elseif (msg.content_.ID == "MessageVoice") then
        Rwers = "بصمه"
        Del_msg(msg.chat_id_,msg.id_)
        elseif (msg.content_.ID == "MessageAudio") then
        Rwers = "صوت"
        Del_msg(msg.chat_id_,msg.id_)
        elseif (msg.content_.ID == "MessageVideo") then
        Rwers = "فيديو"
        Del_msg(msg.chat_id_,msg.id_)
        elseif (msg.content_.ID == "MessageAnimation") then
        Rwers = "متحركه"
        Del_msg(msg.chat_id_,msg.id_)
        end
        local monsha = redis:smembers(mero..':MALK_BOT:'..msg.chat_id_)
        if #monsha ~= 0 then 
        for k,v in pairs(monsha) do
        local info = redis:hgetall(mero..'username:'..v)
        if info and info.username and info.username:match("@[%a%d_]+") then
        usersmnc = usersmnc..info.username.." - "
        end
        sendMsg(v,0,"✿╿ هناك شخص قام بالتعديل \n✿╿ الاسم : ⋙「 "..NameUser.." 」 "..(uuseri or "None").."\n✿│ الايدي : `"..msg.sender_user_id_.."`\n✿│ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n✿│ نوع التعديل : "..(Rwers or "").."\n✿│ المجموعة : "..Flter_Markdown((redis:get(mero..'group:name'..msg.chat_id_) or '')).."\n✿╽ الرابط : "..redis:get(mero..'linkGroup'..msg.chat_id_).." \n✿" )
        tecxt = "✿¦ نداء للمنشئيين : 「[ > Click < ](tg://user?id="..v..")」 \n✿╿ هناك شخص قام بالتعديل"..(uuseri or "None").."\n✿│ الاسم : ⋙「 ["..NameUser.."] 」 \n✿│ الايدي : `"..msg.sender_user_id_.."`\n✿│ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n✿╽ نوع التعديل :  "..(Rwers or "").."\n✿"
    
  end
        
        return send_msg(msg.chat_id_,tecxt)
        end
        end,{msg=msg})
     end
     end
    
if msg.text and utf8.len(msg.text) > 500 or msg.content_.ID == "MessageUnsupported" or msg.photo or msg.video or msg.sticker or msg.animation or msg.audio or msg.voice or msg.forward_info_ or (msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text and msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text and msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text and msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text and msg.text:match(".[Pp][Ee]")) or (msg.text and msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text and msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text and msg.text:match("[Ww][Ww][Ww].") 
or msg.text and msg.text:match(".[Cc][Oo][Mm]")) then
if not msg.Admin then
if redis:get(mero..'mute_tflesh'..msg.chat_id_)  then -- قفل  التفليش
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
end)
end
end
end

  if msg.content_.ID == "MessageUnsupported" or msg.photo or msg.video or msg.sticker or msg.animation then
  if not msg.Admin then
  print('&&&')
if redis:get(mero..'mute_usaet'..msg.chat_id_)  then -- قفل الوسائط
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
end)
end
end
end

  if not msg.Admin and not msg.Special and not (msg.adduser or msg.joinuser or msg.deluser ) then -- للاعضاء فقط   
  
  if not msg.forward_info and redis:get(mero..'lock_flood'..msg.chat_id_)  then
  local msgs = (redis:get(mero..'user:'..msg.sender_user_id_..':msgs') or 0)
  local NUM_MSG_mero = (redis:get(mero..'num_msg_mero'..msg.chat_id_) or 5)
  if tonumber(msgs) > tonumber(NUM_MSG_mero) then 
  GetUserID(msg.sender_user_id_,function(arg,datau)
  Restrict(msg.chat_id_,msg.sender_user_id_,1)
  redis:setex(mero..'sender:'..msg.sender_user_id_..':flood',30,true)
  if datau.username_ then USERNAME = '@'..datau.username_ else USERNAME = FlterName(datau.first_name_..' '..(datau.last_name_ or "")) end
  local USERCAR = utf8.len(USERNAME)
  SendMention(msg.chat_id_,datau.id_,msg.id_,"✿┃العضو » "..USERNAME.."\n✿┃قمـت بتكرار اكثر مـن "..NUM_MSG_mero.." رسـاله‌‏ , لذا تم تقييدك مـن المـجمـوعه‌‏ ✓\n",10,USERCAR)  
  return false
  end)
  end 
  redis:setex(mero..'user:'..msg.sender_user_id_..':msgs',2,msgs+1)
  end
   

if msg.forward_info_ then
if redis:get(mero..'mute_forward'..msg.chat_id_) then -- قفل التوجيه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd \27[0m")

if data.ID == "Error" and data.code_ == 6 then 
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) and not redis:get(mero..':User_Fwd_Msg:'..msg.sender_user_id_..':flood') then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع اعادة التوجيه  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  
return redis:setex(mero..':User_Fwd_Msg:'..msg.sender_user_id_..':flood',15,true)
end,nil)
end
end)
return false
elseif redis:get(mero..':tqeed_fwd:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd tqeed \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false 
end
elseif tonumber(msg.via_bot_user_id_) ~= 0 and redis:get(mero..'mute_inline'..msg.chat_id_) then -- قفل الانلاين
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send inline \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا الانلاين مقفول  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.text then -- رسايل فقط
if utf8.len(msg.text) > 500 and redis:get(mero..'lock_spam'..msg.chat_id_) then -- قفل الكليشه 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send long msg \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال الكليشه والا سوف تجبرني على طردك  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false

elseif (msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Tt][Kk]") or msg.text:match(".[Mm][Ll]") or msg.text:match(".[Oo][Rr][Gg]")) and redis:get(mero..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال روابط الويب   \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.text:match("#[%a%d_]+") and redis:get(mero..'lock_tag'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send tag \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال التاك  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.text:match("@[%a%d_]+")  and redis:get(mero..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال المعرف   \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  
end,nil)
end
end)
return false
elseif not msg.textEntityTypeBold and (msg.textEntityTypeBold or msg.textEntityTypeItalic) and redis:get(mero..'lock_markdown'..msg.chat_id_) then 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send markdown \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال الماركدوان  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.textEntityTypeTextUrl and redis:get(mero..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web page \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿ممنوع ارسال روابط الويب   \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
 
elseif msg.edited and redis:get(mero..'lock_edit'..msg.chat_id_) then -- قفل التعديل
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send Edit \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذراً ممنوع التعديل تم المسح \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
end 
elseif msg.content_.ID == "MessageUnsupported" and redis:get(mero..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الفيديو كام \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
--SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  
end,nil)
end
end)
return false
elseif msg.photo then
if redis:get(mero..'mute_photo'..msg.chat_id_)  then -- قفل الصور
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الصور  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif redis:get(mero..':tqeed_photo:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user resctricted becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.video then
if redis:get(mero..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send vedio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الفيديو  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)   
end
end)
return false
elseif redis:get(mero..':tqeed_video:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.document and redis:get(mero..'mute_document'..msg.chat_id_) then -- قفل الملفات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send file \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
 if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الملفات  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.sticker and redis:get(mero..'mute_sticker'..msg.chat_id_) then --قفل الملصقات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send sticker \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الملصقات  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)   
end
end)
return false
elseif msg.animation then
if redis:get(mero..'mute_gif'..msg.chat_id_) then -- قفل المتحركه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال الصور المتحركه  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)   
end
end)
return false
elseif redis:get(mero..':tqeed_gif:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.contact and redis:get(mero..'mute_contact'..msg.chat_id_) then -- قفل الجهات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send Contact \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
 if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿│عذرا ممنوع ارسال جهات الاتصال  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.location and redis:get(mero..'mute_location'..msg.chat_id_) then -- قفل الموقع
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send location \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
 if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا ممنوع ارسال الموقع  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.voice and redis:get(mero..'mute_voice'..msg.chat_id_) then -- قفل البصمات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send voice \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
 if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا ممنوع ارسال البصمات  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)   
end
end)
return false
elseif msg.game and redis:get(mero..'mute_game'..msg.chat_id_) then -- قفل الالعاب
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send game \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "│╿عذرا ممنوع لعب الالعاب  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.audio and redis:get(mero..'mute_audio'..msg.chat_id_) then -- قفل الصوت
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send audio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا ممنوع ارسال الصوت  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.replyMarkupInlineKeyboard and redis:get(mero..'mute_keyboard'..msg.chat_id_) then -- كيبورد
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send keyboard \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا الكيبورد مقفول  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
end

if msg.content_ and msg.content_.caption_ then -- الرسايل الي بالكابشن
print("sdfsd     f- ---------- ")
if (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.content_.caption_:match("[Tt].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match(".[Pp][Ee]")) 
and redis:get(mero..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا ممنوع ارسال الروابط  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif (msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") 
or msg.content_.caption_:match("[Ww][Ww][Ww].") 
or msg.content_.caption_:match(".[Cc][Oo][Mm]")) 
and redis:get(mero..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send webpage caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgx = "✿╿عذرا ممنوع ارسال روابط الويب  \n✿"
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end
end)
return false
elseif msg.content_.caption_:match("@[%a%d_]+") and redis:get(mero..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'✿*╿* لا يمكنني مسح الرساله المخالفه .\n✿*╽* لست مشرف او ليس لدي صلاحيه  الحذف \n ✿')    
end
if redis:get(mero..'lock_woring'..msg.chat_id_) then
local msgx = "✿╿عذرا ممنوع ارسال التاك او المعرف  \n✿"
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿╽العضو » "..USERNAME..'\n'..msgx,10,USERCAR)  end,nil)
end 
end)
return false
end 

end --========{ End if } ======

end 
SaveNumMsg(msg)
------------------------------{ Start Replay Send }------------------------

if msg.text and redis:get(mero..'replayallbot'..msg.chat_id_) then

local Replay = false

 Replay = redis:hget(mero..'replay:all',msg.text)
if Replay then
sendMsg(msg.chat_id_,msg.id_,Replay)
return false
end

 Replay = redis:hget(mero..'replay_photo:group:',msg.text)
if Replay then 
 sendPhoto(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_voice:group:',msg.text)
if Replay then 
 sendVoice(msg.chat_id_,msg.id_,Replay)
return false
end

Replay = redis:hget(mero..'replay_animation:group:',msg.text)
if Replay then 
 sendAnimation(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_audio:group:',msg.text)
if Replay then 
 sendAudio(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_sticker:group:',msg.text)
if Replay then 
 sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_video:group:',msg.text)
if Replay then 
print("0000000000000") 
 sendVideo(msg.chat_id_,msg.id_,Replay)
return false
end

end
if msg.text and redis:get(mero..'replay'..msg.chat_id_) then
Replay = redis:hget(mero..'replay:'..msg.chat_id_,msg.text)
if Replay then 
 sendMsg(msg.chat_id_,msg.id_,Replay) 
return false
end

Replay = redis:hget(mero..'replay_photo:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendPhoto(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_voice:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendVoice(msg.chat_id_,msg.id_,Replay)
return false
end

Replay = redis:hget(mero..'replay_animation:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendAnimation(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_audio:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendAudio(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_sticker:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(mero..'replay_video:group:'..msg.chat_id_,msg.text)
if Replay then 
 sendVideo(msg.chat_id_,msg.id_,Replay)
return false
end

end

--================================{{  Reply Bot  }} ===================================
local hhh = {
"* جماد بحرف ⏎ ر  *", 
"* مدينة بحرف ⏎ ع  *",
"* حيوان ونبات بحرف ⏎ خ  *", 
"* اسم بحرف ⏎ ح  *", 
"* اسم ونبات بحرف ⏎ م  *", 
"* دولة عربية بحرف ⏎ ق  *", 
"* جماد بحرف ⏎ ي  *", 
"* نبات بحرف ⏎ ج  *", 
"* اسم بنت بحرف ⏎ ع  *", 
"* اسم ولد بحرف ⏎ ع  *", 
"* اسم بنت وولد بحرف ⏎ ث  *", 
"* جماد بحرف ⏎ ج  *",
"* حيوان بحرف ⏎ ص  *",
"* دولة بحرف ⏎ س  *",
"* نبات بحرف ⏎ ج  *",
"* مدينة بحرف ⏎ ب  *",
"* نبات بحرف ⏎ ر  *",
"* اسم بحرف ⏎ ك  *",
"* حيوان بحرف ⏎ ظ  *",
"* جماد بحرف ⏎ ذ  *",
"* مدينة بحرف ⏎ و  *",
"* اسم بحرف ⏎ م  *",
"* اسم بنت بحرف ⏎ خ  *",
"* اسم و نبات بحرف ⏎ ر  *",
"* نبات بحرف ⏎ و  *",
"* حيوان بحرف ⏎ س  *",
"* مدينة بحرف ⏎ ك  *",
"* اسم بنت بحرف ⏎ ص  *",
"* اسم ولد بحرف ⏎ ق  *",
"* نبات بحرف ⏎ ز  *",
"*  جماد بحرف ⏎ ز  *",
"*  مدينة بحرف ⏎ ط  *",
"*  جماد بحرف ⏎ ن  *",
"*  مدينة بحرف ⏎ ف  *",
"*  حيوان بحرف ⏎ ض  *",
"*  اسم بحرف ⏎ ك  *",
"*  نبات و حيوان و مدينة بحرف ⏎ س  *", 
"*  اسم بنت بحرف ⏎ ج  *", 
"*  مدينة بحرف ⏎ ت  *", 
"*  جماد بحرف ⏎ ه  *", 
"*  اسم بنت بحرف ⏎ ر  *", 
"* اسم ولد بحرف ⏎ خ  *", 
"* جماد بحرف ⏎ ع  *",
"* حيوان بحرف ⏎ ح  *",
"* نبات بحرف ⏎ ف  *",
"* اسم بنت بحرف ⏎ غ  *",
"* اسم ولد بحرف ⏎ و  *",
"* نبات بحرف ⏎ ل  *",
"*مدينة بحرف ⏎ ع  *",
"*دولة واسم بحرف ⏎ ب  *",
}
local drok = {
  "*أكثر جملة أثرت بك في حياتك؟ *",
  "*إيموجي يوصف مزاجك حاليًا؟ *",
  "*أجمل اسم بنت بحرف الباء؟ *",
  "*كيف هي أحوال قلبك؟ *",
  "*أجمل مدينة؟ *",
  "*كيف كان أسبوعك؟ *",
  "*شيء تشوفه اكثر من اهلك ؟ *",
  "*اخر مره فضفضت؟ *",
  "*قد كرهت احد بسبب اسلوبه؟ *",
  "*قد حبيت شخص وخذلك؟ *",
  "*كم مره حبيت؟ *",
  "*اكبر غلطة بعمرك؟ *",
  "*نسبة النعاس عندك حاليًا؟ *",
  "*شرايكم بمشاهير التيك توك؟ *",
  "*ما الحاسة التي تريد إضافتها للحواس الخمسة؟ *",
  "*اسم قريب لقلبك؟ *",
  "*مشتاق لمطعم كنت تزوره قبل الحظر؟ *",
  "*أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ *",
  "*ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ *",
  "*أغنية عالقة في ذهنك هاليومين؟ *",
  "*متى اخر مره قريت قرآن؟ *",
  "*كم صلاة فاتتك اليوم؟ *",
  "*تفضل التيكن او السنقل؟ *",
  "*وش أفضل بوت برأيك؟ *",
"*كم لك بالتلي؟ *",
"*وش الي تفكر فيه الحين؟ *",
"*كيف تشوف الجيل ذا؟ *",
"*منشن شخص وقوله، تحبني؟ *",
"*لو جاء شخص وعترف لك كيف ترده؟ *",
"*مر عليك موقف محرج؟ *",
"*وين تشوف نفسك بعد سنتين؟ *",
"*لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ *",
"*وش اجمل لهجة تشوفها؟ *",
"*قد سافرت؟ *",
"*افضل مسلسل عندك؟ *",
"*افضل فلم عندك؟ *",
"*مين اكثر يخون البنات/العيال؟ *",
"*متى حبيت؟ *",
  "*بالعادة متى تنام؟ *",
  "*شيء من صغرك ماتغير فيك؟ *",
  "*شيء بسيط قادر يعدل مزاجك بشكل سريع؟ *",
  "*تشوف الغيره انانيه او حب؟ *",
"*حاجة تشوف نفسك مبدع فيها؟ *",
  "*مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ *",
  "*عمرك بكيت على شخص مات في مسلسل ؟ *",
  "*‏- هل تعتقد أن هنالك من يراقبك بشغف؟ *",
  "*تدوس على قلبك او كرامتك؟ *",
  "*اكثر لونين تحبهم مع بعض؟ *",
  "*مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ *",
  "*سؤال دايم تتهرب من الاجابة عليه؟ *",
  "*تحبني ولاتحب الفلوس؟ *",
  "*العلاقه السريه دايماً تكون حلوه؟ *",
  "*لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ *",
"*كيف ينطق الطفل اسمك؟ *",
  "*ما هي نقاط الضعف في شخصيتك؟ *",
  "*اكثر كذبة تقولها؟ *",
  "*تيكن ولا اضبطك؟ *",
  "*اطول علاقة كنت فيها مع شخص؟ *",
  "*قد ندمت على شخص؟ *",
  "*وقت فراغك وش تسوي؟ *",
  "*عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ *",
  "*حاط نغمة خاصة لأي شخص؟ *",
  "*وش اسم شهرتك؟ *",
  "*أفضل أكلة تحبه لك؟ *",
"*عندك شخص تسميه ثالث والدينك؟ *",
  "*عندك شخص تسميه ثالث والدينك؟ *",
  "*اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ *",
  "*أطول مكالمة كم ساعة؟ *",
  "*تحب الحياة الإلكترونية ولا الواقعية؟ *",
  "*كيف حال قلبك ؟ بخير ولا مكسور؟ *",
  "*أطول مدة نمت فيها كم ساعة؟ *",
  "*تقدر تسيطر على ضحكتك؟ *",
  "*أول حرف من اسم الحب؟ *",
  "*تحب تحافظ على الذكريات ولا تمسحه؟ *",
  "*اسم اخر شخص زعلك؟ *",
"*وش نوع الأفلام اللي تحب تتابعه؟ *",
  "*أنت انسان غامض ولا الكل يعرف عنك؟ *",
  "*لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ *",
  "*عندك أخوان او خوات من الرضاعة؟ *",
  "*إختصار تحبه؟ *",
  "*إسم شخص وتحس أنه كيف؟ *",
  "*وش الإسم اللي دايم تحطه بالبرامج؟ *",
  "*وش برجك؟ *",
  "*لو يجي عيد ميلادك تتوقع يجيك هدية؟ *",
  "*اجمل هدية جاتك وش هو؟ *",
  "*الصداقة ولا الحب؟ *",
"*الصداقة ولا الحب؟ *",
  "*الغيرة الزائدة شك؟ ولا فرط الحب؟ *",
  "*قد حبيت شخصين مع بعض؟ وانقفطت؟ *",
  "*وش أخر شي ضيعته؟ *",
  "*قد ضيعت شي ودورته ولقيته بيدك؟ *",
  "*تؤمن بمقولة اللي يبيك مايحتار فيك؟ *",
  "*سبب وجوك بالتليجرام؟ *",
  "*تراقب شخص حاليا؟ *",
  "*عندك معجبين ولا محد درا عنك؟ *",
  "*لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ *",
  "*أنت محبوب بين الناس؟ ولاكريه؟ *",
"*كم عمرك؟ *",
  "*لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ *",
  "*تؤمن بمقولة الصحبة تغنيك الحب؟ *",
  "*وش مشروبك المفضل؟ *",
  "*قد جربت الدخان بحياتك؟ وانقفطت ولا؟ *",
  "*أفضل وقت للسفر؟ الليل ولا النهار؟ *",
  "*انت من النوع اللي تنام بخط السفر؟ *",
  "*عندك حس فكاهي ولا نفسية؟ *",
  "*تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ *",
  "*أفضل ممارسة بالنسبة لك؟ *",
  "*لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ *",
"*لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ *",
  "*برأيك كم العمر المناسب للزواج؟ *",
  "*اذا تزوجت بعد كم بتخلف عيال؟ *",
  "*فكرت وش تسمي أول اطفالك؟ *",
  "*من الناس اللي تحب الهدوء ولا الإزعاج؟ *",
  "*الشيلات ولا الأغاني؟ *",
  "*عندكم شخص مطوع بالعايلة؟ *",
  "*تتقبل النصيحة من اي شخص؟ *",
  "*اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ *",
  "*جربت شعور احد يحبك بس انت مو قادر تحبه؟ *",
  "*دايم قوة الصداقة تكون بإيش؟ *",
"*أفضل البدايات بالعلاقة بـ وش؟ *",
  "*وش مشروبك المفضل؟ او قهوتك المفضلة؟ *",
  "*تحب تتسوق عبر الانترنت ولا الواقع؟ *",
  "*انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ *",
  "*أخر مرة بكيت متى؟ وليش؟ *",
  "*عندك الشخص اللي يقلب الدنيا عشان زعلك؟ *",
  "*أفضل صفة تحبه بنفسك؟ *",
  "*كلمة تقولها للوالدين؟ *",
  "*أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ *",
  "*كم عدد سنينك بالتليجرام؟ *",
  "*تحب تعترف ولا تخبي؟ *",
"*انت من الناس الكتومة ولا تفضفض؟ *",
  "*أنت بعلاقة حب الحين؟ *",
  "*عندك اصدقاء غير جنسك؟ *",
  "*أغلب وقتك تكون وين؟ *",
  "*لو المقصود يقرأ وش بتكتب له؟ *",
  "*تحب تعبر بالكتابة ولا بالصوت؟ *",
  "*عمرك كلمت فويس احد غير جنسك؟ *",
  "*لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ *",
  "*لو عندك فلوس وش السيارة اللي بتشتريها؟ *",
  "*كم أعلى مبلغ جمعته؟ *",
  "*اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ *",
"*قد جربت تبكي فرح؟ وليش؟ *",
  "*تتوقع إنك بتتزوج اللي تحبه؟ *",
  "*ما هو أمنيتك؟ *",
  "*وين تشوف نفسك بعد خمس سنوات؟ *",
  "*لو خيروك تقدم الزمن ولا ترجعه ورا؟ *",
  "*لعبة قضيت وقتك فيه بالحجر المنزلي؟ *",
  "*تحب تطق الميانة ولا ثقيل؟ *",
  "*باقي معاك للي وعدك ما بيتركك؟ *",
  "*اول ماتصحى من النوم مين تكلمه؟ *",
  "*عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ *",
  "*قد قابلت شخص تحبه؟ وولد ولا بنت؟ *",
"*اذا قفطت احد تحب تفضحه ولا تستره؟ *",
  "*كلمة للشخص اللي يسب ويسطر؟ *",
  "*آية من القران تؤمن فيه؟ *",
  "*تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ *",
"*حاجة ودك تغيرها هالفترة؟ *",
  "*كم فلوسك حاليا وهل يكفيك ام لا؟ *",
  "*وش لون عيونك الجميلة؟ *",
  "*من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ *",
  "*اذكر موقف ماتنساه بعمرك؟ *",
  "*وش حاب تقول للاشخاص اللي بيدخل حياتك؟ *",
  "*ألطف شخص مر عليك بحياتك؟ *",
"*انت من الناس المؤدبة ولا نص نص؟ *",
  "*كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ *",
  "*لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ *",
  "*أكثر شي تخاف منه بالحياه وش؟ *",
  "*اكثر المتابعين عندك باي برنامج؟ *",
  "*متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ *",
  "*قد تمنيت شي وتحقق؟ *",
  "*قلبي على قلبك مهما صار لمين تقولها؟ *",
  "*وش نوع جوالك؟ واذا بتغيره وش بتأخذ؟ *",
  "*كم حساب عندك بالتليجرام؟ *",
  "*متى اخر مرة كذبت؟ *",
"*كذبت في الاسئلة اللي مرت عليك قبل شوي؟ *",
  "*تجامل الناس ولا اللي بقلبك على لسانك؟ *",
  "*قد تمصلحت مع أحد وليش؟ *",
  "*وين تعرفت على الشخص اللي حبيته؟ *",
  "*قد رقمت او احد رقمك؟ *",
  "*وش أفضل لعبته بحياتك؟ *",
  "*أخر شي اكلته وش هو؟ *",
  "*حزنك يبان بملامحك ولا صوتك؟ *",
  "*لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ *",
  "*فيه شيء م تقدر تسيطر عليه ؟ *",
  "*منشن شخص متحلطم م يعجبه شيء؟ *",
"*اكتب تاريخ مستحيل تنساه *",
  "*شيء مستحيل انك تاكله ؟ *",
  "*تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ *",
  "*انسان م تحب تتعامل معاه ابداً ؟ *",
  "*شيء بسيط تحتفظ فيه؟ *",
  "*فُرصه تتمنى لو أُتيحت لك ؟ *",
  "*شيء مستحيل ترفضه ؟. *",
  "*لو زعلت بقوة وش بيرضيك ؟ *",
  "*تنام بـ اي مكان ، ولا بس غرفتك ؟ *",
  "*ردك المعتاد اذا أحد ناداك ؟ *",
  "*مين الي تحب يكون مبتسم دائما ؟ *",
"* إحساسك في هاللحظة؟ *",
  "*وش اسم اول شخص تعرفت عليه فالتلقرام ؟ *",
  "*اشياء صعب تتقبلها بسرعه ؟ *",
  "*شيء جميل صار لك اليوم ؟ *",
  "*اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ *",
  "*يهمك ملابسك تكون ماركة ؟ *",
  "*ردّك على شخص قال (أنا بطلع من حياتك)؟. *",
  "*مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ *",
  "*تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ *",
  "*كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ *",
  "*عمرك ضحيت باشياء لاجل شخص م يسوى ؟ *",
"*اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ *",
  "*شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ *",
  "*مشاكلك بسبب ؟ *",
  "*نسبه الندم عندك للي وثقت فيهم ؟ *",
  "*اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ *",
  "*اكثر شيء تحس انه مات ف مجتمعنا؟ *",
  "*لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ *",
  "*كم عددكم بالبيت؟ *",
  "*عادي تتزوج من برا القبيلة؟ *",
  "*أجمل شي بحياتك وش هو؟ *",
}

local srah = {
  "*صراحه  |  صوتك حلو؟ *",
  "*صراحه  |  التقيت الناس مع ابو وجهين؟ *",
  "*صراحه  |  شيء كنت تبي تحققه؟ *",
  "*صراحه  |  أنا شخص ضعيف عندما؟ *",
  "*صراحه  |  هل ترغب في إظهار حبك ومرفق لشخص أو رؤية هذا الضعف؟ *",
  "*صراحه  |  يدل على أن الكذب مرات تكون ضرورية شي؟ *",
  "*صراحه  |  أشعر بالوحدة على الرغم من أنني تحيط بك كثيرا؟ *",
  "*صراحه  |  كيفية الكشف عن من يكمن عليك؟ *",
  "*صراحه  |  إذا حاول شخص ما أن يكرهه أن يقترب منك ويهتم بك تعطيه فرصة؟ *",
  "*صراحه  |  أشجع شيء حلو في حياتك؟ *",
  'صراحه  |  طريقة جيدة يقنع حتى لو كانت الفكرة خاطئة"* توافق؟',
  "*صراحه  |  كيف تتصرف مع من يسيئون فهمك ويأخذ على ذهنه ثم ينتظر أن يرفض؟ *",
  "*صراحه  |  التغيير العادي عندما يكون الشخص الذي يحبه؟ *",
  "*صراحه  |  المواقف الصعبة تضعف لك ولا ترفع؟ *",
  "*صراحه  |  نظرة تفسد الصداقة؟ *",
  "*صراحه  |  ‏‏إذا أحد قالك كلام سيء بالغالب وش تكون ردة فعلك؟ *",
  "*صراحه  |  شخص معك بالحلوه والمُره؟ *",
  "*صراحه  |  ‏هل تحب إظهار حبك وتعلقك بالشخص أم ترى ذلك ضعف؟ *",
  "*صراحه  |  تأخذ بكلام اللي ينصحك ولا تسوي اللي تبي؟ *",
  "*صراحه  |  وش تتمنى الناس تعرف عليك؟ *",
  "*صراحه  |  ابيع المجرة عشان؟ *",
  "*صراحه  |  أحيانا احس ان الناس ، كمل؟ *",
  "*صراحه  |  مع مين ودك تنام اليوم؟ *",
  "*صراحه  |  صدفة العمر الحلوة هي اني؟ *",
  'صراحه  |  الكُره العظيم دايم يجي بعد حُب قوي "* تتفق؟',
  "*صراحه  |  صفة تحبها في نفسك؟ *",
  'صراحه  |  ‏الفقر فقر العقول ليس الجيوب "* ، تتفق؟',
  "*صراحه  |  تصلي صلواتك الخمس كلها؟ *",
  "*صراحه  |  ‏تجامل أحد على راحتك؟ *",
  "*صراحه  |  اشجع شيء سويتة بحياتك؟ *",
  "*صراحه  |  وش ناوي تسوي اليوم؟ *",
  "*صراحه  |  وش شعورك لما تشوف المطر؟ *",
  "*صراحه  |  غيرتك هاديه ولا تسوي مشاكل؟ *",
  "*صراحه  |  ما اكثر شي ندمان عليه؟ *",
  "*صراحه  |  اي الدول تتمنى ان تزورها؟ *",
  "*صراحه  |  متى اخر مره بكيت؟ *",
  "*صراحه  |  تقيم حظك ؟ من عشره؟ *",
  "*صراحه  |  هل تعتقد ان حظك سيئ؟ *",
  "*صراحه  |  شـخــص تتمنــي الإنتقــام منـــه؟ *",
  "*صراحه  |  كلمة تود سماعها كل يوم؟ *",
  "*صراحه  |  **هل تُتقن عملك أم تشعر بالممل؟ *",
  "*صراحه  |  هل قمت بانتحال أحد الشخصيات لتكذب على من حولك؟ *",
  "*صراحه  |  متى آخر مرة قمت بعمل مُشكلة كبيرة وتسببت في خسائر؟ *",
  "*صراحه  |  ما هو اسوأ خبر سمعته بحياتك؟ *",
  "*‏صراحه | هل جرحت شخص تحبه من قبل ؟ *",
  "*صراحه  |  ما هي العادة التي تُحب أن تبتعد عنها؟ *",
  "*‏صراحه | هل تحب عائلتك ام تكرههم؟ *",
  "*‏صراحه  |  من هو الشخص الذي يأتي في قلبك بعد الله – سبحانه وتعالى- ورسوله الكريم – صلى الله عليه وسلم؟ *",
  "*‏صراحه  |  هل خجلت من نفسك من قبل؟ *",
  "*‏صراحه  |  ما هو ا الحلم  الذي لم تستطيع ان تحققه؟ *",
  "*‏صراحه  |  ما هو الشخص الذي تحلم به كل ليلة؟ *",
  "*‏صراحه  |  هل تعرضت إلى موقف مُحرج جعلك تكره صاحبهُ؟ *",
  "*‏صراحه  |  هل قمت بالبكاء أمام من تُحب؟ *",
  "*‏صراحه  |  ماذا تختار حبيبك أم صديقك؟ *",
  "*‏صراحه  | هل حياتك سعيدة أم حزينة؟ *",
  "*صراحه  |  ما هي أجمل سنة عشتها بحياتك؟ *",
  "*‏صراحه  |  ما هو عمرك الحقيقي؟ *",
  "*‏صراحه  |  ما اكثر شي ندمن عليه؟ *",
  "*صراحه  |  ما هي أمنياتك المُستقبلية؟‏ *",
  "*صراحه | نفسك فـ ايه ؟ *",
  "*صراحه | هل تحب فتاه او احببت من قبل ؟ *",
  "*صراحه | هل شكلك حلو او جيد او متوسط او سئ ؟ *",
  "*صراحه | ما هي الماده الدراسيه التي تحبها اكثر وتفضلها؟ *",
  "*صراحه | هل تحب مدرستك ؟ *",
  "*صراحه | ما الشئ الذي تتمني ان يحصل ؟ *",
  "*صراحه | هل تحب عائلتك ؟ *",
}

local ker = {
"*لو خيروك |  بين الإبحار لمدة أسبوع كامل أو السفر على متن طائرة لـ 3 أيام متواصلة؟ *",
"*لو خيروك |  بين شراء منزل صغير أو استئجار فيلا كبيرة بمبلغ معقول؟ *",
"*لو خيروك |  أن تعيش قصة فيلم هل تختار الأكشن أو الكوميديا؟ *",
"*لو خيروك |  بين تناول البيتزا وبين الآيس كريم وذلك بشكل دائم؟ *",
"*لو خيروك |  بين إمكانية تواجدك في الفضاء وبين إمكانية تواجدك في البحر؟ *",
"*لو خيروك |  بين تغيير وظيفتك كل سنة أو البقاء بوظيفة واحدة طوال حياتك؟ *",
"*لو خيروك |  أسئلة محرجة أسئلة صراحة ماذا ستختار؟ *",
"*لو خيروك |  بين الذهاب إلى الماضي والعيش مع جدك أو بين الذهاب إلى المستقبل والعيش مع أحفادك؟ *",
"*لو كنت شخص آخر هل تفضل البقاء معك أم أنك ستبتعد عن نفسك؟ *",
"*لو خيروك |  بين الحصول على الأموال في عيد ميلادك أو على الهدايا؟ *",
"*لو خيروك |  بين القفز بمظلة من طائرة أو الغوص في أعماق البحر؟ *",
"*لو خيروك |  بين الاستماع إلى الأخبار الجيدة أولًا أو الاستماع إلى الأخبار السيئة أولًا؟ *",
"*لو خيروك |  بين أن تكون رئيس لشركة فاشلة أو أن تكون موظف في شركة ناجحة؟ *",
"*لو خيروك |  بين أن يكون لديك جيران صاخبون أو أن يكون لديك جيران فضوليون؟ *",
"*لو خيروك |  بين أن تكون شخص مشغول دائمًا أو أن تكون شخص يشعر بالملل دائمًا؟ *",
"*لو خيروك |  بين قضاء يوم كامل مع الرياضي الذي تشجعه أو نجم السينما الذي تحبه؟ *",
"*لو خيروك |  بين استمرار فصل الشتاء دائمًا أو بقاء فصل الصيف؟ *",
"*لو خيروك |  بين العيش في القارة القطبية أو العيش في الصحراء؟ *",
"*لو خيروك |  بين أن تكون لديك القدرة على حفظ كل ما تسمع أو تقوله وبين القدرة على حفظ كل ما تراه أمامك؟ *",
"*لو خيروك |  بين أن يكون طولك 150 سنتي متر أو أن يكون 190 سنتي متر؟ *",
"*لو خيروك |  بين إلغاء رحلتك تمامًا أو بقائها ولكن فقدان الأمتعة والأشياء الخاص بك خلالها؟ *",
"*لو خيروك |  بين أن تكون اللاعب الأفضل في فريق كرة فاشل أو أن تكون لاعب عادي في فريق كرة ناجح؟ *",
"*لو خيروك |  بين ارتداء ملابس البيت لمدة أسبوع كامل أو ارتداء البدلة الرسمية لنفس المدة؟ *",
"*لو خيروك |  بين امتلاك أفضل وأجمل منزل ولكن في حي سيء أو امتلاك أسوأ منزل ولكن في حي جيد وجميل؟ *",
"*لو خيروك |  بين أن تكون غني وتعيش قبل 500 سنة، أو أن تكون فقير وتعيش في عصرنا الحالي؟ *",
"*لو خيروك |  بين ارتداء ملابس الغوص ليوم كامل والذهاب إلى العمل أو ارتداء ملابس جدك/جدتك؟ *",
"*لو خيروك |  بين قص شعرك بشكل قصير جدًا أو صبغه باللون الوردي؟ *",
"*لو خيروك |  بين أن تضع الكثير من الملح على كل الطعام بدون علم أحد، أو أن تقوم بتناول شطيرة معجون أسنان؟ *",
"*لو خيروك |  بين قول الحقيقة والصراحة الكاملة مدة 24 ساعة أو الكذب بشكل كامل مدة 3 أيام؟ *",
"*لو خيروك |  بين تناول الشوكولا التي تفضلها لكن مع إضافة رشة من الملح والقليل من عصير الليمون إليها أو تناول ليمونة كاملة كبيرة الحجم؟ *",
"*لو خيروك |  بين وضع أحمر الشفاه على وجهك ما عدا شفتين أو وضع ماسكارا على شفتين فقط؟ *",
"*لو خيروك |  بين الرقص على سطح منزلك أو الغناء على نافذتك؟ *",
"*لو خيروك |  بين تلوين شعرك كل خصلة بلون وبين ارتداء ملابس غير متناسقة لمدة أسبوع؟ *",
"*لو خيروك |  بين تناول مياه غازية مجمدة وبين تناولها ساخنة؟ *",
"*لو خيروك |  بين تنظيف شعرك بسائل غسيل الأطباق وبين استخدام كريم الأساس لغسيل الأطباق؟ *",
"*لو خيروك |  بين تزيين طبق السلطة بالبرتقال وبين إضافة البطاطا لطبق الفاكهة؟ *",
"*لو خيروك |  بين اللعب مع الأطفال لمدة 7 ساعات أو الجلوس دون فعل أي شيء لمدة 24 ساعة؟ *",
"*لو خيروك |  بين شرب كوب من الحليب أو شرب كوب من شراب عرق السوس؟ *",
"*لو خيروك |  بين الشخص الذي تحبه وصديق الطفولة؟ *",
"*لو خيروك |  بين أمك وأبيك؟ *",
"*لو خيروك |  بين أختك وأخيك؟ *",
"*لو خيروك |  بين نفسك وأمك؟ *",
"*لو خيروك |  بين صديق قام بغدرك وعدوك؟ *",
"*لو خيروك |  بين خسارة حبيبك/حبيبتك أو خسارة أخيك/أختك؟ *",
"*لو خيروك |  بإنقاذ شخص واحد مع نفسك بين أمك أو ابنك؟ *",
"*لو خيروك |  بين ابنك وابنتك؟ *",
"*لو خيروك |  بين زوجتك وابنك/ابنتك؟ *",
"*لو خيروك |  بين جدك أو جدتك؟ *",
"*لو خيروك |  بين زميل ناجح وحده أو زميل يعمل كفريق؟ *",
"*لو خيروك |  بين لاعب كرة قدم مشهور أو موسيقي مفضل بالنسبة لك؟ *",
"*لو خيروك |  بين مصور فوتوغرافي جيد وبين مصور سيء ولكنه عبقري فوتوشوب؟ *",
"*لو خيروك |  بين سائق سيارة يقودها ببطء وبين سائق يقودها بسرعة كبيرة؟ *",
"*لو خيروك |  بين أستاذ اللغة العربية أو أستاذ الرياضيات؟ *",
"*لو خيروك |  بين أخيك البعيد أو جارك القريب؟ *",
"*لو خيروك |  يبن صديقك البعيد وبين زميلك القريب؟ *",
"*لو خيروك |  بين رجل أعمال أو أمير؟ *",
"*لو خيروك |  بين نجار أو حداد؟ *",
"*لو خيروك |  بين طباخ أو خياط؟ *",
"*لو خيروك |  بين أن تكون كل ملابس بمقاس واحد كبير الحجم أو أن تكون جميعها باللون الأصفر؟ *",
"*لو خيروك |  بين أن تتكلم بالهمس فقط طوال الوقت أو أن تصرخ فقط طوال الوقت؟ *",
"*لو خيروك |  بين أن تمتلك زر إيقاف موقت للوقت أو أن تمتلك أزرار للعودة والذهاب عبر الوقت؟ *",
"*لو خيروك |  بين أن تعيش بدون موسيقى أبدًا أو أن تعيش بدون تلفاز أبدًا؟ *",
"*لو خيروك |  بين أن تعرف متى سوف تموت أو أن تعرف كيف سوف تموت؟ *",
"*لو خيروك |  بين العمل الذي تحلم به أو بين إيجاد شريك حياتك وحبك الحقيقي؟ *",
"*لو خيروك |  بين معاركة دب أو بين مصارعة تمساح؟ *",
"*لو خيروك |  بين إما الحصول على المال أو على المزيد من الوقت؟ *",
"*لو خيروك |  بين امتلاك قدرة التحدث بكل لغات العالم أو التحدث إلى الحيوانات؟ *",
"*لو خيروك |  بين أن تفوز في اليانصيب وبين أن تعيش مرة ثانية؟ *",
"*لو خيروك |  بأن لا يحضر أحد إما لحفل زفافك أو إلى جنازتك؟ *",
"*لو خيروك |  بين البقاء بدون هاتف لمدة شهر أو بدون إنترنت لمدة أسبوع؟ *",
"*لو خيروك |  بين العمل لأيام أقل في الأسبوع مع زيادة ساعات العمل أو العمل لساعات أقل في اليوم مع أيام أكثر؟ *",
"*لو خيروك |  بين مشاهدة الدراما في أيام السبعينيات أو مشاهدة الأعمال الدرامية للوقت الحالي؟ *",
"*لو خيروك |  بين التحدث عن كل شيء يدور في عقلك وبين عدم التحدث إطلاقًا؟ *",
"*لو خيروك |  بين مشاهدة فيلم بمفردك أو الذهاب إلى مطعم وتناول العشاء بمفردك؟ *",
"*لو خيروك |  بين قراءة رواية مميزة فقط أو مشاهدتها بشكل فيلم بدون القدرة على قراءتها؟ *",
"*لو خيروك |  بين أن تكون الشخص الأكثر شعبية في العمل أو المدرسة وبين أن تكون الشخص الأكثر ذكاءً؟ *",
"*لو خيروك |  بين إجراء المكالمات الهاتفية فقط أو إرسال الرسائل النصية فقط؟ *",
"*لو خيروك |  بين إنهاء الحروب في العالم أو إنهاء الجوع في العالم؟ *",
"*لو خيروك |  بين تغيير لون عينيك أو لون شعرك؟ *",
"*لو خيروك |  بين امتلاك كل عين لون وبين امتلاك نمش على خديك؟ *",
"*لو خيروك |  بين الخروج بالمكياج بشكل مستمر وبين الحصول على بشرة صحية ولكن لا يمكن لك تطبيق أي نوع من المكياج؟ *",
"*لو خيروك |  بين أن تصبحي عارضة أزياء وبين ميك آب أرتيست؟ *",
"*لو خيروك |  بين مشاهدة كرة القدم أو متابعة الأخبار؟ *",
"*لو خيروك |  بين موت شخصية بطل الدراما التي تتابعينها أو أن يبقى ولكن يكون العمل الدرامي سيء جدًا؟ *",
"*لو خيروك |  بين العيش في دراما قد سبق وشاهدتها ماذا تختارين بين الكوميديا والتاريخي؟ *",
"*لو خيروك |  بين امتلاك القدرة على تغيير لون شعرك متى تريدين وبين الحصول على مكياج من قبل خبير تجميل وذلك بشكل يومي؟ *",
"*لو خيروك |  بين نشر تفاصيل حياتك المالية وبين نشر تفاصيل حياتك العاطفية؟ *",
"*لو خيروك |  بين البكاء والحزن وبين اكتساب الوزن؟ *",
"*لو خيروك |  بين تنظيف الأطباق كل يوم وبين تحضير الطعام؟ *",
"*لو خيروك |  بين أن تتعطل سيارتك في نصف الطريق أو ألا تتمكنين من ركنها بطريقة صحيحة؟ *",
"*لو خيروك |  بين إعادة كل الحقائب التي تملكينها أو إعادة الأحذية الجميلة الخاصة بك؟ *",
"*لو خيروك |  بين قتل حشرة أو متابعة فيلم رعب؟ *",
"*لو خيروك |  بين امتلاك قطة أو كلب؟ *",
"*لو خيروك |  بين الصداقة والحب *",
"*لو خيروك |  بين تناول الشوكولا التي تحبين طوال حياتك ولكن لا يمكنك الاستماع إلى الموسيقى وبين الاستماع إلى الموسيقى ولكن لا يمكن لك تناول الشوكولا أبدًا؟ *",
"*لو خيروك |  بين مشاركة المنزل مع عائلة من الفئران أو عائلة من الأشخاص المزعجين الفضوليين الذين يتدخلون في كل كبيرة وصغيرة؟ *",
}
local su = {
"نعم حبيبي المطور 🌝❤",
"هايروحي قول 😊😍",
"ها يابــعد دقات قلبي 🤩️",
"يابعد روح ["..Bot_Name.."] 😘❤️",
"هلا بمطوري العشق أمرني"}
local ss97 = {
"ها حياتي 😍❤️","عيونه 👀",
"ها حبي 😍","ها عمري 🌹",
"هياتني اجيت 🌚❤️","نعم حبي 😎",
"احكي بسرعه شو بدك 😤","ها يا قلبي ❤️",
"لك فداك ["..Bot_Name.."] حبيبي انت اموووح 💋","قول حبيبي أمرني 😍",
"ياعيون ["..Bot_Name.."] أمرني 😍",
}
local ns = {
"هلووات 😊🌹",
"هلا تاج راسي 🤷🏼‍",
"كافي قبل شويه سلمت😌",
"هلوات اذا عندك كروبات ضيفني🤷🏼‍❤️",
"هلوات عمري ☺",
}
local sh = {
"اهلا عزيزي المطور 😽❤️",
"هلوات نورت مطوري 😍",
"هلا سيدي المطور 😍 ",
"هلا تاج راسي المطور 😎",
"هلا بتاج راس ["..Bot_Name.."] 😘❤️",
}
local sss = {
"تمام وانت يكيوت ؟ 💕",
"تمام انت شلونك 😁❤️",
"لوني مثل لونك كافي تسأل🤨",
}
local dr = {
"بعد وقت وين 🙄",
"منو زعلك حتى تروح 😥",
"تعال وين رايح عندي شغله وياك 🐣",
"• وين رايح خلينه متونسين 🙁",
"وين خلينه متونسين بيك 😂",
}
local nnn = {
"اسمي ["..Bot_Name.."] 😌",
"شتريد كل شويه كاتب بوت😏",
"انتا البوت😂",
}
local lovm = {
"اكرهك 👊😑",
"منو لقالك احبك؟ 😼👌🏻",
"اعشقك 😍",
"اي احبك 😍❤️",
"ماحبك 😌🖖",
"امـــوت فيك ☹️",
"ولي ماحبك 🙊💔",
}
local bos = {
"امممووااهحح شهلعسل🥺🍯💘",
"مابوس واحد خايس مثلك 😁",
"يععع تلعب نفسي 😷",
"مابوس 🌚💔",
"امممووااهحح شهلعسل🥺🍯💘",
"ولي مابوس واحد مثلك☹️",
"ممممح😘ححح😍😍💋"
}
local seha = {
"يمعوود تعاال يريدوكك🤕♥️",
"تتعال ححب محتاجيك🙂🍭",
"تعال يول استاذك ايريدككك😒🔪"
}

if Text and redis:get(mero..'replayallbot'..msg.chat_id_) then
if msg.SudoUser and Text=="هلو" then 
return sendMsg(msg.chat_id_,msg.id_,sh[math.random(#sh)])
elseif not msg.SudoUser and Text=="هلو" then 
return sendMsg(msg.chat_id_,msg.id_,ns[math.random(#ns)])
elseif not msg.SudoUser and (Text== "شلونكم" or Text== "شلونك" or Text== "شونك" or Text== "شونكم" or Text== "شلونكم") then
return sendMsg(msg.chat_id_,msg.id_,sss[math.random(#sss)])
elseif not msg.SudoUser and (Text==" باي" or Text == "باي") then
return sendMsg(msg.chat_id_,msg.id_,dr[math.random(#dr)])
elseif msg.SudoUser and Text== "احبك" then 
return sendMsg(msg.chat_id_,msg.id_,"اموت عليك حياتي  ❤️")
elseif msg.SudoUser and (Text== "تحبني" or Text=="حبك") then 
return sendMsg(msg.chat_id_,msg.id_,"اموت عليك حياتي  😍❤️")
elseif not msg.SudoUser and (Text== "احبك" or Text=="حبك") then 
return sendMsg(msg.chat_id_,msg.id_,lovm[math.random(#lovm)])
elseif not msg.SudoUser and Text== "تحبني" then
return sendMsg(msg.chat_id_,msg.id_,lovm[math.random(#lovm)])
elseif Text=="اطربنه" then 
return sendMsg(msg.chat_id_,msg.id_,song[math.random(#song)])
elseif Text== "بوب" then return sendMsg(msg.chat_id_,msg.id_,"[مالـك السورس 😍](t.me/VV_000_VV")
elseif Text== "ايرور" then return sendMsg(msg.chat_id_,msg.id_,"[ مطور سورس تولين 😍](t.me/X_0_1")
elseif Text== "وينك"  then return sendMsg(msg.chat_id_,msg.id_,"دور بقلبك وتلقاني 😍😍❤️")
elseif Text== "منورين"  then return sendMsg(msg.chat_id_,msg.id_,"من نورك عمري ❤️🌺")
elseif Text== "هاي"  then return sendMsg(msg.chat_id_,msg.id_,"هايات عمري 😍🍷")
elseif Text== "🙊"  then return sendMsg(msg.chat_id_,msg.id_,"فديت الخجول 😍")
elseif Text== "😢"  then return sendMsg(msg.chat_id_,msg.id_,"لا تبكي حياتي 😢")
elseif Text== "😭"  then return sendMsg(msg.chat_id_,msg.id_,"لا تبكي حياتي 😭😭")
elseif Text== "منور"  then return sendMsg(msg.chat_id_,msg.id_,"هذا نورك 🤗")
elseif Text== "😒" and not is_sudo then return sendMsg(msg.chat_id_,msg.id_,"شبيك عمو 🌚")
elseif Text== "مح"  then return sendMsg(msg.chat_id_,msg.id_,"محات حياتي🙈❤")
elseif Text== "شكرا" or Text== "ثكرا" then return  sendMsg(msg.chat_id_,msg.id_,"عفوا 💗")
elseif Text== "انتا وين"  then return sendMsg(msg.chat_id_,msg.id_,"بالــبــ🏠ــيــت")
elseif Text== "😍"  then return sendMsg(msg.chat_id_,msg.id_," يَمـه̷̐ إالُحــ❤ــب يَمـه̷̐ ❤️😍")
elseif Text== "اكرهك"  then return sendMsg(msg.chat_id_,msg.id_,"شلون اطيق خلقتك اني😾😏")
elseif Text== "اجيت" or Text=="اني اجيت" then return  sendMsg(msg.chat_id_,msg.id_,"كْـٌﮩٌﮧٌ﴿😍﴾ـﮩٌول الـ୭ـهـٌ୭ـْلا❤️")
elseif Text== "حفلش"  then return sendMsg(msg.chat_id_,msg.id_,"افلش راسك 🤓")
elseif Text== "نايمين" then return sendMsg(msg.chat_id_,msg.id_,"انا سهرانة احرسكـم😐'")
elseif Text== "اكو احد" then return sendMsg(msg.chat_id_,msg.id_,"يي عيني انـي موجـود🌝✿")
elseif Text== "انت منو" or Text=="منو انتا" then return sendMsg(msg.chat_id_,msg.id_,"⚜╿انا بوت بوت أسمي ["..Bot_Name.."] ✓ ⚜\n👨🏻‍✈️│اختصـاصـي حمـاية‌‏ المـجمـوعات\n\n✿│مـن السـبام والتوجيه‌‏ والتكرار والخ...\n\n✿╽ضيفني لكروبك ورفعني مشرف بلكروب وارسل تفعيل داخل الكروب")
elseif Text== "كلخرا" or Text== "اكل خره" then return sendMsg(msg.chat_id_,msg.id_,"خرا عليك ابلع😸🙊💋")
elseif Text== "😔"  then return sendMsg(msg.chat_id_,msg.id_,"ليش الحلو ضايج ❤️😐")
elseif Text== "☹️"  then return sendMsg(msg.chat_id_,msg.id_,"لضوج حبيبي 😢❤️")
elseif Text== "جوعان"  then return sendMsg(msg.chat_id_,msg.id_,"تعال كلني 😐😂")
elseif Text== "خاصك"  then return sendMsg(msg.chat_id_,msg.id_,"سهلـة الـﻐـرك بالمٲي ﺑﯿـدك تطلعـة بس الـغـﺭك بالـخاﺹ ڪلي شـيطلعـه 😹😔💜")
elseif Text== "لتحجي"  then return sendMsg(msg.chat_id_,msg.id_,"وانت شعليك حاجي من حلقك")
elseif Text== "معليك" or Text== "شعليك" then return sendMsg(msg.chat_id_,msg.id_,"عليه ونص 😡")
elseif Text== "شدسون" or Text== "شداتسوون" or Text== "شدتسون" then return  sendMsg(msg.chat_id_,msg.id_,"نطبخ 😐")
elseif Text:match(Bot_Name.." شلونك$") then 
return sendMsg(msg.chat_id_,msg.id_,"تِٰـِۢمِٰـِۢامِٰ بِٰـِۢشِٰـِۢﯛ̲فت الِٰـِۢطِٰـِۢبِٰـِۢيِٰـِۢنِٰ😊❤️-")
elseif Text== "يومه فدوه"  then return sendMsg(msg.chat_id_,msg.id_,"فدؤه الج حياتي 😍😙")
elseif Text== "افلش"  then return sendMsg(msg.chat_id_,msg.id_,"باند عام من 30 بوت 😉")
elseif Text== "احبج"  then return sendMsg(msg.chat_id_,msg.id_,"يخي احترم شعوري 😢")
elseif Text== "شكو ماكو"  then return sendMsg(msg.chat_id_,msg.id_,"غيرك/ج بل كلب ماكو يبعد كلبي😍❤️️")
elseif Text== "😋"  then return sendMsg(msg.chat_id_,msg.id_,"طبب لسانك جوه عيب 😌")
elseif Text== "😡"  then  return sendMsg(msg.chat_id_,msg.id_,"ابرد  🚒"  )
elseif Text== "مرحبا"  then return sendMsg(msg.chat_id_,msg.id_,"مراحب 😍❤️ نورت-ي 🌹")
elseif Text== "سلام" or Text== "السلام عليكم" or Text== "سلام عليكم" or Text=="سلامن عليكم" or Text=="السلامن عليكم" then 
return sendMsg(msg.chat_id_,msg.id_,"وعليكم السلام 💙" )
elseif Text== "عضه"  then return sendMsg(msg.chat_id_,msg.id_,"شكلولك علي جلب؟ انت روح عضه 😕😹" )
elseif Text== "🚶🏻‍♂"  then return sendMsg(msg.chat_id_,msg.id_,"لُـﮩـضڵ تتـمشـﮥ اڪعـد ﺳـﯠڵـف 😕😹")
elseif Text== "البوت واقف" then return sendMsg(msg.chat_id_,msg.id_,"هياتني 🤪")
elseif Text== "ضايج"  then return sendMsg(msg.chat_id_,msg.id_,"ليش ضايج حياتي")
elseif Text== "ضايجه"  then return sendMsg(msg.chat_id_,msg.id_,"منو مضوجج كبدايتي")
elseif Text== "😳" or Text== "😳😳" or Text== "😳😳😳" then return sendMsg(msg.chat_id_,msg.id_," 😳😹🕷")
elseif Text== "صدك"  then return sendMsg(msg.chat_id_,msg.id_,"قابل اجذب عليك!؟ 🌚")
elseif Text== "تخليني"  then return sendMsg(msg.chat_id_,msg.id_,"بس تكبر 🤣🐸")
elseif Text== "مساعدة"  then return sendMsg(msg.chat_id_,msg.id_,"لعرض قائمة المساعدة اكتب الاوامر 🌚❤️")
elseif Text== "حلو"  then return sendMsg(msg.chat_id_,msg.id_,"انت الاحلى 🌚❤️")
elseif Text== "تبادل"  then return sendMsg(msg.chat_id_,msg.id_,"كافي ملينه تبادل ??💔")
elseif Text== "عاش"  then return sendMsg(msg.chat_id_,msg.id_,"الحلو 🌝🌷")
elseif Text== "ورده" or Text== "وردة" then return sendMsg(msg.chat_id_,msg.id_,"أنت عطرها 🌸")
elseif Text== "شسمك"  then return sendMsg(msg.chat_id_,msg.id_,"✿╿أسمي ["..Bot_Name.."]\n✿│اختصـاصـي حمـاية المـجمـوعات\n✿│مـن السـبام والتوجيه‌‏ والتكرار والخ...\n✿╽ضيفني لكروبك ورفعني مشرف بلكروب وارسل تفعيل داخل الكروب")
elseif Text== "فديت" or Text=="فطيت" then return sendMsg(msg.chat_id_,msg.id_,"فداك قلبي ودقاته 🙈💗")
elseif Text== "حبيبي" or Text=="حبي" then return  sendMsg(msg.chat_id_,msg.id_,"بعد روحي 😍❤️ تفضل")
elseif Text== "حبيبتي" then return sendMsg(msg.chat_id_,msg.id_,"تحبك وتحب عليك 🌝🌷")
elseif Text== "حياتي" then return sendMsg(msg.chat_id_,msg.id_,"ها حياتي 😍")
elseif Text== "اسكت" then return sendMsg(msg.chat_id_,msg.id_,"اوك معلم 🌚💞")
elseif Text== "بتحبني" then return sendMsg(msg.chat_id_,msg.id_,"بحبك اد الكون 😍🌷")
elseif Text== "موجود" then return sendMsg(msg.chat_id_,msg.id_,"تفضل عزيزي 🌝🌸")
elseif Text== "اقلك" then return sendMsg(msg.chat_id_,msg.id_,".قول حياتي 😚")
elseif Text== "فدوه" or Text=="فدوة" or Text=="فطوه" or Text=="فطوة" then  
return sendMsg(msg.chat_id_,msg.id_,"لقلبك 😍❤️")
elseif Text== "اشكرك" then return sendMsg(msg.chat_id_,msg.id_,"بخدمتك حبي ❤")
elseif Text== "😉"  then return sendMsg(msg.chat_id_,msg.id_,"😻🙈")
elseif Text== "نورتي"  then 
return sendMsg(msg.chat_id_,msg.id_,"منورة بأهلها ")
end
end
if msg.SudoUser and Text == Bot_Name and not Text2 then
return sendMsg(msg.chat_id_,msg.id_,su[math.random(#su)])
elseif not msg.SudoUser and Text== Bot_Name and not Text2 then  
return sendMsg(msg.chat_id_,msg.id_,ss97[math.random(#ss97)])
elseif Text and  Text:match("^قول (.*)$") and redis:get(mero..'kol:bot'..msg.chat_id_)  then
if utf8.len(Text:match("^قول (.*)$")) > 500 then 
if is_JoinChannel(msg) == false then
return false
end
return sendMsg(msg.chat_id_,msg.id_,"✿| ما اكدر اقول اكثر من 500 حرف 🙌🏾")
end
local callback_Text = FlterName(Text:match("^قول (.*)$"),50)
if callback_Text and callback_Text == 'الاسم سبام ✿' then
return sendMsg(msg.chat_id_,msg.id_,"✿| للاسف النص هذا مخالف ")
else
return sendMsg(msg.chat_id_,0,callback_Text) 
end
elseif Text and  Text:match("^"..Bot_Name.." اتفل(.*)$") and msg.Director then
if is_JoinChannel(msg) == false then
return false
end
if msg.reply_id then
sendMsg(msg.chat_id_,msg.id_,'اوك سيدي 🌝✿')
sendMsg(msg.chat_id_,msg.reply_id,'لك شنو هذا ويهك 😹') 
else
end

elseif Text and  Text:match("^صيحه$") and not redis:get(mero.."amrthshesh"..msg.chat_id_) then
if is_JoinChannel(msg) == false then
return false
end
if msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
GetUserID(result.sender_user_id_,function(arg,data)
local FlterName = FlterName(data.first_name_..(data.last_name_ or ""),90)
sendMsg(msg.chat_id_,msg.id_,'صارر ستاذيي 🏃🏻‍♂️♥️') 
local msg_id = msg.reply_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..result.sender_user_id_..')'..'\n'..seha[math.random(#seha)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
return false
end,nil)
end, nil)
end

elseif not msg.SudoUser and Text==" خيروك" then
sendMsg(msg.chat_id_,msg.id_,ker[math.random(#ker)])
elseif not msg.SudoUser and Text==" حروف" or Text == "حروف" or Text == " حر" or Text == "حر" then
sendMsg(msg.chat_id_,msg.id_,hhh[math.random(#hhh)])

elseif not msg.SudoUser and Text=="كت" or Text == "كت تويت" or Text == "كت" or Text == "تويت" then
sendMsg(msg.chat_id_,msg.id_,drok[math.random(#drok)])
elseif not msg.SudoUser and Text==" مقالات" or Text == "مقالات" or Text == " 0" or Text == "0" then

sendMsg(msg.chat_id_,msg.id_,mkl[math.random(#mkl)])
elseif not msg.SudoUser and Text==" صراحه" or Text == "صراحه" then
sendMsg(msg.chat_id_,msg.id_,srah[math.random(#srah)])

elseif Text and  Text:match("^رزله$")  then
if is_JoinChannel(msg) == false then
return false
end
if msg.reply_id then
sendMsg(msg.chat_id_,msg.id_,'صارر ستاذيي 🏃🏻‍♂️♥️')
return sendMsg(msg.chat_id_,msg.reply_id,tzl[math.random(#tzl)]) 
end 
elseif Text and  Text:match("^بوسه$") and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then
if msg.reply_id then
if is_JoinChannel(msg) == false then
return false
end
sendMsg(msg.chat_id_,msg.id_,'صارر ستاذيي 🏃🏻‍♂️♥️')
return sendMsg(msg.chat_id_,msg.reply_id,bos[math.random(#bos)]) 
end
elseif Text and  Text:match("^بوسه$") and not redis:get(mero.."amrthshesh"..msg.chat_id_) or Text and  Text:match("^بوسني$")  and not redis:get(mero.."amrthshesh"..msg.chat_id_) then
return sendMsg(msg.chat_id_,msg.id_,bos[math.random(#bos)]) 
elseif Text== "شنو رئيك بهذا" or Text== "شنو رئيك بي" or Text== "شنو رئيك بهاذه" or Text== "شنو رئيك بهذا" or Text== "شنو رأيك بهذا" or Text== "شنو رايك بهذا" then 
if msg.reply_id then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
GetUserID(result.sender_user_id_,function(arg,data)
local FlterName = FlterName(data.first_name_..(data.last_name_ or ""),90)
local msg_id = msg.reply_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..result.sender_user_id_..')'..'\n'..he[math.random(#he)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end,nil)
end, nil)
end
elseif Text== "شغال"  then return sendMsg(msg.chat_id_,msg.id_,"نعم عزيزي 😎")
elseif Text == "بوت" then
return sendMsg(msg.chat_id_,msg.id_,nnn[math.random(#nnn)])
elseif Text== "انطي هديه" and not redis:get(mero.."amrthshesh"..msg.chat_id_) then     
if msg.reply_id then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
GetUserID(result.sender_user_id_,function(arg,data)
local FlterName = FlterName(data.first_name_..(data.last_name_ or ""),90)
local geft = {
"الف مبروك 👏 هديتك بيذنجان🍆سوي تبسي واندعيلي 🤲😹",
"الف مبروك 👏 هديتك نوتيلا 🍫 \nيا كيكه انت 🥰😹",
"الف مبروك ?? هديتك شفقه 🧢 البسهه الشمس تسمط راسك 😁😹",
"الف مبروك 👏 هديتك راس بصل 🧅 اكله وابجي الدموع تريح القلب 😁😹",
"الف مبروك 👏 هديتك حذاء 👞 تلبسهه لو اكطعهه على راسك ??😹",
"الف مبروك 👏 هديتك شده 💸\n بس مو تتكبر على اصدقائك 😁😹",
"الف مبروك 👏 هديتك تاج ذهب 👑\n يا تاج وباج انت 😉🥰",
"الف مبروك ?? هديتك ساعه 🕰  بيها\nمنبه تكعدك الصبح 😁😹",
"الف مبروك 👏 هديتك خاتم 💍 \nواعزمنه بعرسك 💃😹",
"الف مبروك 👏 هديتك صابونه 🧼 والمي بلاش وروح اسبح 😁😹"
}
sendMsg(msg.chat_id_,msg.id_,'صارر ستاذيي 🏃🏻‍♂️♥️')
local msg_id = msg.reply_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..result.sender_user_id_..')'..'\n'..geft[math.random(#geft)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
return false
end,nil)
end, nil)
end
elseif Text== "شنو رئيك بهاي" or Text=="شنو رئيك بيه" or Text== "شنو رئيك بهاذش" or Text== "شنو رأيك بهاي" or Text== "شنو رايك بهاي" then 
if msg.reply_id then
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
GetUserID(result.sender_user_id_,function(arg,data)
local FlterName = FlterName(data.first_name_..(data.last_name_ or ""),90)
 local msg_id = msg.reply_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape('- ['..FlterName..'](tg://user?id='..result.sender_user_id_..')'..'\n'..she[math.random(#she)]).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end,nil)
end, nil)
end
elseif Text=="اتفل" or Text=="تفل" then
if is_JoinChannel(msg) == false then
return false
end
if msg.Admin then 
return sendMsg(msg.chat_id_,msg.id_,'💦💦💦')
else 
return sendMsg(msg.chat_id_,msg.id_,"✿ انجب ما اتفل عيب 😼🙌🏿") 
end
elseif Text == 'مطور السورس' or Text == 'مالك السورس' then
tdcli_function ({ID = "SearchPublicChat",username_ = 'VV_000_VV'}, function(arg, result)
if result.id_ then
GetUserID(result.id_,function(MR,EIKOei)
local Teext = '✿│مطور ومالك السورس » ❪ ['..EIKOei.first_name_..'](tg://user?id='..result.id_..')❫\n'
local msg_id = msg.id_/2097152/0.5
https.request(ApiToken..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Teext).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end,nil)
end
end, nil)
elseif Text== "رفع اثول"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:tahaath"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع العضو اثول الگروب🤪بنجاح\n✿╽تمت إضافته إلى قائمه الثولان😹\n✓️")
elseif Text== "تنزيل اثول"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:tahaath"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل العضو من ثولان الكروب\n✿╽تمت الزاله من قامة الثولان😹\n✓️")
elseif Text== "رفع جلب"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:klp"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع المتهم إلى مطي 🦓بنجاح\n✿╽تمت إضافته إلى قائمه المطايه??\n✓️")
elseif Text== "رفع مطي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:donke"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع المتهم إلى مطي 🦓بنجاح✿\n✿╽تمت إضافته إلى قائمه المطايه😹\n✓️")
elseif Text== "تنزيل مطي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:donke"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل المتهم مطي بنجاح\n✿╽تمت ازالته من قائمه المطايه 🦓😹\n✓️")
elseif Text== "رفع ملك"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:kink"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم رفع صديقك ملـ👑ـك بنجاح\n✿╽اصبح ملك الكروب 👨‍🎨😍❗️ \n✓️")
elseif Text== "تنزيل ملك"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:kink"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم تنزيل العضو المهتلف\n✿╽من قائمة ألملـ👑ـوك بنجاح 😹\n✓️")
elseif Text== "رفع ملكه"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:Quean"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم رفع صديقتك ملكـ👑ــه بنجاح\n✿╽اصبحت ملكة الكروب 💆‍♀😍❗️ \n✓️")
elseif Text== "تنزيل ملكه"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:Quean"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم تنزيل الجكمه🤵‍♀\n✿╽من قائمة ألملكـ👑ـات بنجاح 😹💔\n✓️")
elseif Text== "تنزيل جلب"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:klp"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي \n✿│تم تنزيل المتهم جلب 🐶بنجاح\n✿╽تمت إزالته من قائمه الجلاب🐕😹\n✓️")
elseif Text== "تنزيل زاحف"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:zahf"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل المتهم زاحف بنجاح\n✿│تم ازالته من قائمه الزواحف🐊😹\n✓️")
elseif Text== "رفع زاحف"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:zahf"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفعه زاحف🦎 بنجاح\n✿│تم اضافته الى قائمه الزواحف🐊😹\n✓️")
elseif Text== "رفع صخل"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:sakl"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع المتهم صخل بنجاح\n✿╽الان اصبح صخل الكروب 🐐😹\n✓️")
elseif Text== "تنزيل صخل"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:sakl"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل المتهم صخل بنجاح\n✿╽تمت ٳزالته من قائمة الصخوله🐐😺\n✓️")
elseif Text== "رفع بقلبي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:klpe"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع العضو داخل قلبك ❤\n✿╽تمت ترقيته بنجاح 😻\n✓️")
elseif Text== "تنزيل من قلبي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then  
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:klpe"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل من داخل قلبك❤️\n✿╽تمت ازالته من قائمه القلوب😹💔\n✓️")
elseif Text== "رفع تاج"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:tagge"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم رفع صديقك تـ👑ـاج بنجاح  \n✿╽اصبح خط احمر ❗️ \n✓️")
elseif Text== "تنزيل تاج"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:tagge"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهـلا عزيزي\n✿│تم تنزيل العضو المهتلف\n✿╽من قائمة ألتـ👑ـاج بنجاح 😹💔\n✓️")
elseif Text== "رفع مرتي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:mrtee"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفع العضو مرتك👫 بنجاح\nالان يمكنكم أخذ راحتكم🤤😉\n✓️")
elseif Text== "تنزيل مرتي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:mrtee"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيل الجكمه👩‍⚕️مرتك بنجاح\nالان انتم مفترقان☹️💔\n✓️")
elseif Text== "زواج"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:taha1"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم زواجكم الاثنين💃👭 بنجاح\n✿╽الان يمكنكم أخذ راحتكم🤤😉\n✓️")
elseif Text== "طلاق"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:taha1"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم طلاقكم 💔 بنجاح\n✿╽الان يمكنكم الانفصال 👌🤤\n✓️")
elseif Text== "رفع لوكي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:loke"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفعه ضمن اللوكيه👨‍🦯😹\n✓️")
elseif Text== "تنزيل لوكي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:loke"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيله من اللوكيه😹\n✓️")
elseif Text== "رفع غبي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:stope"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم رفعه اصبح غبي الان🧛‍♀️😺\n✓️")
elseif Text== "تنزيل غبي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then  
if is_JoinChannel(msg) == false then
return false
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success)
redis:srem(mero.."mero:stope"..msg.chat_id_, result.sender_user_id_)
 end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيله من الاغبياء👏😹\n✓️")
elseif Text== "رفع طلي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:sadd(mero.."mero:tele"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿│اهلا عزيزي\n✿│تم رفع المتهم طلي الكروب\n✿│اطلع برا ابو البعرور الوصخ 🤢😂")
elseif Text== "تنزيل طلي"  and msg.reply_id and not redis:get(mero.."amrthshesh"..msg.chat_id_) then    
if is_JoinChannel(msg) == false then
return false
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(extra, result, success) 
redis:srem(mero.."mero:tele"..msg.chat_id_, result.sender_user_id_)
end, nil)
return sendMsg(msg.chat_id_,msg.id_,"✿╿اهــلا عزيزي\n✿│تم تنزيله من الطليان👏😹\n✓️")
elseif Text == ("الملوك") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:kink"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد ملوك") end
t = "\n• قائمة الملوك\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil) 
end
elseif Text == ("الملكات") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:Quean"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد ملكات") end
t = "\n• قائمة الملكات\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil) 
end
elseif Text == ("مسح الملوك") and msg.Admin then
redis:del(mero.."mero:kink"..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'تم مسح الملوك ')
elseif Text == ("مسح الملكات") and msg.Admin then
redis:del(mero.."mero:Quean"..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'تم مسح الملكات ')
elseif Text == ("الثولان") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:tahaath"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد ثولان") end
t = "\n• قائمة الثولان\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil) 
end
elseif Text == ("مسح الطليان") and msg.Admin then
redis:del(mero.."mero:tele"..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'تم مسح الطليان ')
elseif Text == ("الطليان") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:tele"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد طليان") end
t = "\n• قائمة الطليان\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil) 
end
elseif Text == ("الطلاك") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:taha1"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد مطلقين") end
t = "\n• قائمة الطلاك\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil) 
end
elseif Text == ("الكلاب") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:klp"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد كلاب") end
t = "\n• قائمة الكلاب\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("المطايه") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:donke"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد مطايه") end
t = "\n• قائمة المطايه\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("الزواحف") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:zahf"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد زواحف") end
t = "\n• قائمة الزواحف\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("الصخول") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:sakl"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد صخول") end
t = "\n• قائمة الصخول\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("قائمه قلبي") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:klpe"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد اعضاء بقلبي") end
t = "\n• قائمة قلبي\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("قائمه التاج") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:tagge"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد قائمه تاج") end
t = "\n• قائمة التاج\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("الزوجات") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:mrtee"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد زوجات") end
t = "\n• قائمة الزوجات\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("اللوكيه") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:loke"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد لوكيه") end
t = "\n• قائمة اللوكيه\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end
elseif Text == ("الاغبياء") then
if is_JoinChannel(msg) == false then
return false
end
local list = redis:smembers(mero.."mero:stope"..msg.chat_id_)
if #list == 0 then return sendMsg(msg.chat_id_, msg.id_, "• لا يوجد اغبياء") end
t = "\n• قائمة الاغبياء\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
t = t..""..k.."~ : "..username.."\n"
if #list == k then
return sendMsg(msg.chat_id_,msg.id_, t)
end
end,nil)
end

elseif Text== "دعاء" then 
return sendMsg(msg.chat_id_,msg.id_,"﴿يَا أَيُّهَا الَّذِينَ امَنُوا اذْكُرُوا اللهَ ذِكْرًا كَثِيرًا﴾✨\n\n- «سُبْحَانَ اللهِ»\n- «الحَمْدُ للهِ»\n- «لَا إلَهَ إلَّا اللهُ»\n- «اللهُ أكْبَرُ»\n- «سُبْحَانَ اللهِ وَبِحَمْدِهِ»\n- «سُبْحَانَ اللهِ العَظِيمِ»\n- «لَا حَوْلَ وَلَا قُوَّةَ إلَّا بِاللهِ»\n- «أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ»\n- «لَا إلَهَ إلَّا أَنْتَ سُبْحَانَكَ إنِّي كُنْتُ مِنَ الظَّالِمِينَ»🌻")
elseif Text== "ايديي" or Text=="ايدي ✿" then 
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or "")) end
local USERCAR = utf8.len(USERNAME)
SendMention(msg.chat_id_,data.id_,msg.id_,"✿│اضـغط على الايدي ليتم النسـخ\n\n "..USERNAME.." ~⪼ ( "..data.id_.." )",37,USERCAR)  
return false
end)
elseif Text=="اريد رابط الحذف" or Text=="اريد رابط حذف" or Text=="رابط حذف" or Text=="رابط الحذف" then
if is_JoinChannel(msg) == false then
return false
end
return sendMsg(msg.chat_id_,msg.id_,[[
✿*╿* رابط حذف حـساب التيليكرام ↯
✿│لتتندم فڪر قبل ڪل شي  
✿│[اضغط هنا لـحـذف الـحـسـاب](https://telegram.org/deactivate)
‍✿│بالتـوفيـق عزيزي ...
✿╽[اضغط هنا لديك مفاجئه](https://t.me/Y_Q_8)
]] )
--=====================================
elseif Text== "انجب" or Text== "نجب" or Text=="جب" then
if msg.SudoUser then  
return sendMsg(msg.chat_id_,msg.id_,"حاضر مو تدلل حضره المطور  😇 ")
elseif msg.Creator then 
return sendMsg(msg.chat_id_,msg.id_,"ع راسي تدلل انت المنشئ تاج راسي 😌")
elseif msg.Director then 
return sendMsg(msg.chat_id_,msg.id_,"لخاطرك راح اسكت لان مدير وعلى راسي  😌")
elseif msg.Admin then 
return sendMsg(msg.chat_id_,msg.id_,"فوق مامصعدك ادمن ؟؟ انت انجب ??")
else 
return sendMsg(msg.chat_id_,msg.id_,"انجب انت لاتندفر 😏")
end 
end 




------------------------------{ End Replay Send }------------------------

------------------------------{ Start Checking CheckExpire }------------------------
if not redis:get('kar') then
redis:setex('kar',86400,true) 
json_data = '{"BotID": '..mero..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(mero..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(mero..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end
local admins = redis:smembers(mero..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(mero..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creators = redis:smembers(mero..':MONSHA_BOT:'..GroupS)
if #creators ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creators) do
local info = redis:hgetall(mero..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end
local creator = redis:smembers(mero..':KARA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Kara" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(mero..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(mero..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(mero..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end
json_data =  json_data.."}"
end
local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(SUDO_ID,0,"./inc/"..Bot_User..".json","✿| ملف نسخه تلقائيه\n✿|  اليك مجموعاتك » { "..#All_Groups_ID.." }\n✿| للبوت » "..Bot_User.."\n📆| التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end
if redis:get(mero..'CheckExpire::'..msg.chat_id_) then
local ExpireDate = redis:ttl(mero..'ExpireDate:'..msg.chat_id_)
if not ExpireDate and not msg.SudoUser then
rem_data_group(msg.chat_id_)
sendMsg(SUDO_ID,0,'🕵🏼️‍╿انتهى الاشتراك في احد المجموعات \n👨🏾‍🔧│المجموعه : '..FlterName(redis:get(mero..'group:name'..msg.chat_id_))..'✿\n💂🏻‍╽ايدي : '..msg.chat_id_)
sendMsg(msg.chat_id_,0,'🕵🏼️‍╿انتهى الاشتراك البوت\n💂🏻‍│سوف اغادر المجموعه فرصه سعيده ✿🏿\n👨🏾‍🔧╽او راسل المطور للتجديد '..SUDO_USER..' ✿')
return StatusLeft(msg.chat_id_,our_id)
else
local DaysEx = (redis:ttl(mero..'ExpireDate:'..msg.chat_id_) / 86400)
if tonumber(DaysEx) > 0.208 and ExpireDate ~= -1 and msg.Admin then
if tonumber(DaysEx + 1) == 1 and not msg.SudoUser then
sendMsg(msg.chat_id_,'✿🏼️‍╿باقي يوم واحد وينتهي الاشتراك \n👨🏾‍🔧╽راسل المطور للتجديد '..SUDO_USER..'\n✿')
end 
end 
end
end

------------------------------{ End Checking CheckExpire }------------------------


end 


return {
mero = {
"^(تقييد)$",
"^(تقييد) (%d+)$",
"^(تقييد) (@[%a%d_]+)$",
"^(فك التقييد)$",
"^(فك التقييد) (%d+)$",
"^(فك التقييد) (@[%a%d_]+)$",
"^(فك تقييد)$",
"^(فك تقييد) (%d+)$",
"^(فك تقييد) (@[%a%d_]+)$",
"^(الغاء التقييد)$",
"^(الغاء التقييد) (%d+)$",
"^(الغاء التقييد) (@[%a%d_]+)$",
"^(ضع شرط التفعيل) (%d+)$",
"^(التفاعل)$",
"^(التفاعل) (@[%a%d_]+)$",
"^([iI][dD])$",
"^(تفعيل الايدي بالصوره)$",
"^(تعطيل الايدي بالصوره)$",
"^(تعطيل الرفع)$",
"^(تفعيل الرفع)$",
"^(تعطيل قول)$",
"^(تفعيل قول)$",
"^(قفل الدخول بالرابط)$",
"^(فتح الدخول بالرابط)$", 
"^(قفل الميديا)$",
"^(فتح الميديا)$", 
"^(قفل التفليش)$",
"^(فتح التفليش)$", 
"^(ايدي)$",
"^(ايدي) (@[%a%d_]+)$",
"^(كشف)$",
"^(كشف) (%d+)$",
"^(كشف) (@[%a%d_]+)$",
'^(رفع مميز)$',
'^(رفع مميز) (@[%a%d_]+)$',
'^(رفع مميز) (%d+)$',
'^(تنزيل مميز)$',
'^(تنزيل مميز) (@[%a%d_]+)$',
'^(تنزيل مميز) (%d+)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (@[%a%d_]+)$',
'^(رفع ادمن) (%d+)$',
'^(تنزيل ادمن)$',
'^(تنزيل ادمن) (@[%a%d_]+)$',
'^(تنزيل ادمن) (%d+)$', 
'^(رفع مطي)$',
'^(تنزيل مطي)$', 
'^(رفع زاحف)$',
'^(تنزيل زاحف)$', 
'^(رفع المدير)$',
'^(رفع مدير)$', 
'^(رفع مدير) (@[%a%d_]+)$',
'^(رفع المدير) (@[%a%d_]+)$',
'^(رفع المدير) (%d+)$',
'^(رفع مدير) (%d+)$',
'^(رفع منشى اساسي)$',
'^(رفع منشئ اساسي)$',
'^(رفع منشئ اساسي) (@[%a%d_]+)$',
'^(رفع منشى اساسي) (@[%a%d_]+)$',
'^(رفع منشى اساسي) (%d+)$',
'^(رفع منشئ اساسي) (%d+)$',
'^(تنزيل منشئ اساسي)$',
'^(تنزيل منشى اساسي)$',
'^(تنزيل منشئ اساسي) (%d+)$',
'^(تنزيل منشئ اساسي) (@[%a%d_]+)$',
'^(تنزيل منشى اساسي) (%d+)$',
'^(تنزيل منشى اساسي) (@[%a%d_]+)$',
'^(رفع منشى)$',
'^(رفع منشئ)$',
'^(رفع منشئ) (@[%a%d_]+)$',
'^(رفع منشى) (@[%a%d_]+)$',
'^(تنزيل منشئ)$',
'^(تنزيل منشى)$',
'^(تنزيل منشئ) (%d+)$',
'^(تنزيل منشى) (%d+)$',
'^(تنزيل منشى) (@[%a%d_]+)$',
'^(تنزيل منشئ) (@[%a%d_]+)$',
'^(تنزيل المدير)$',
'^(تنزيل مدير)$',
'^(تنزيل مدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (%d+)$',
'^(تنزيل مدير) (%d+)$',
 '^(صلاحياته)$',
 '^(صلاحياتي)$',
'^(صلاحياته) (@[%a%d_]+)$',
'^(قفل) (.+)$',
'^(فتح) (.+)$',
'^(تفعيل)$',
'^(تفعيل) (.+)$',
'^(تعطيل)$',
'^(تعطيل) (.+)$',
'^(ضع تكرار) (%d+)$',
"^(مسح)$",
"^(مسح) (.+)$",
'^(منع عام) (.+)$',
'^(الغاء منع عام) (.+)$',
'^(منع) (.+)$',
'^(الغاء منع) (.+)$',
"^(حظر عام)$",
"^(حظر عام) (@[%a%d_]+)$",
"^(حظر عام) (%d+)$",
"^(الغاء العام)$",
"^(الغاء العام) (@[%a%d_]+)$",
"^(الغاء العام) (%d+)$",
"^(الغاء عام)$",
"^(الغاء عام) (@[%a%d_]+)$",
"^(الغاء عام) (%d+)$",
"^(حظر)$",
"^(حظر) (@[%a%d_]+)$",
"^(حظر) (%d+)$",
"^(الغاء الحظر)$", 
"^(الغاء الحظر) (@[%a%d_]+)$",
"^(الغاء الحظر) (%d+)$",
"^(الغاء حظر)$", 
"^(الغاء حظر) (@[%a%d_]+)$",
"^(الغاء حظر) (%d+)$",
"^(طرد)$",
"^(طرد) (@[%a%d_]+)$",
"^(طرد) (%d+)$",
"^(كتم)$",
"^(كتم) (@[%a%d_]+)$",
"^(كتم) (%d+)$",
"^(الغاء الكتم)$",
"^(الغاء الكتم) (@[%a%d_]+)$",
"^(الغاء الكتم) (%d+)$",
"^(الغاء كتم)$",
"^(الغاء كتم) (@[%a%d_]+)$",
"^(الغاء كتم) (%d+)$",
"^(رفع مطور)$",
"^(رفع مطور) (@[%a%d_]+)$",
"^(رفع مطور) (%d+)$",
"^(تنزيل مطور)$",
"^(تنزيل مطور) (%d+)$",
"^(تنزيل مطور) (@[%a%d_]+)$",
"^(تعطيل) (-%d+)$",
"^(الاشتراك) ([123])$",
"^(الاشتراك)$",
'^(تنزيل الكل) (@[%a%d_]+)$',
'^(تنزيل الكل) (%d+)$',
"^(تنزيل الكل)$",
"^(تنزيل)$", 
"^(شحن) (%d+)$",
"^(المجموعه)$",
"^(عدد الكروب)$",
"^(كشف البوت)$",
"^(انشاء رابط)$",
"^(ضع الرابط)$",
"^(تثبيت)$",
"^(الغاء التثبيت)$",
"^(الغاء تثبيت)$",
"^(رابط)$",
"^(الرابط)$",
"^(ضع رابط)$",
"^(رابط خاص)$",
"^(الرابط خاص)$",
"^(القوانين)$",
"^(ضع القوانين)$",
"^(ضع قوانين)$",
"^(ضع تكرار)$",
"^(ضع التكرار)$",
"^(الادمنيه)$",
"^(تاك للكل)$",
"^(تاك للسرسريه)$",
"^(تاك)$",
"^(@all)$",
"^(قائمه المنع عام)$",
"^(قائمه المنع)$",
"^(المدراء)$",
"^(المميزين)$",
"^(المكتومين)$",
"^(ضع الترحيب)$",
"^(الترحيب)$",
"^(المنشى الاساسي)$",
"^(المنشىء الاساسي 🌟)$",
"^(المنشئين الاساسيين)$",
"^(المحظورين)$",
"^(ضع اسم)$",
"^(ضع صوره)$",
"^(ضع وصف)$",
"^(طرد البوتات)$",
"^(كشف البوتات)$",
"^(طرد المحذوفين)$",
"^(رسائلي)$",
"^(رسايلي)$",
"^(احصائياتي)$",
"^(معلوماتي)$",
"^(مسح معلوماتي)$",
"^(موقعي)$",
"^(رفع الادمنيه)$",
"^(صوره الترحيب)$",
"^(ضع كليشه المطور)$",
"^(المطور)$",
"^(شرط التفعيل)$",
"^(قائمه المجموعات)$",
"^(المجموعات)$",
"^(المجموعات ✿)$",
"^(المشتركين)$",
"^(المشتركين ✿)$",
"^(اذاعه)$",
"^(اذاعه عام)$",
"^(اذاعه خاص)$",
"^(اذاعه عام بالتوجيه)$",
"^(اذاعه عام بالتوجيه ✿)$", 
"^(اذاعه خاص ✿)$", 
"^(اذاعه عام ✿)$", 
"^(اذاعه ✿)$", 
"^(قائمه العام)$",
"^(قائمه العام ✿)$",
"^(المطورين)$",
"^(المطورين ✿)$",
"^(تيست)$",
"^(test)$",
"^(فتح الفشار)$",
"^(قفل الفشار)$",
"^(قفل الفارسيه)$",
"^(فتح الفارسيه)$",
"^(فتح تعديل الميديا)$",
"^(قفل تعديل الميديا)$",
"^(ايديي✿)$",
"^(قناة السورس ✿)$",
"^(الاحصائيات)$",
"^(الاحصائيات ✿)$",
"^(اضف رد عام)$",
"^(اضف رد عام ✿)$",
"^(مسح رد عام)$",
"^(مسح رد عام ✿)$",
"^(مسح الردود)$",
"^(مسح الردود العامه)$",
"^(ضع اسم للبوت)$",
"^(مسح الصوره)$",
"^(مسح رد)$",
"^(الردود)$",
"^(الردود العامه)$",
"^(الردود العامه ✿)$",
"^(اضف رد)$",
"^(/UpdateSource)$",
"^(تحديث السورس ✿)$",
"^(تحديث السورس)$",
"^(تنظيف المجموعات)$",
"^(تنظيف المشتركين)$",
"^(تنظيف المجموعات ✿)$",
"^(تنظيف المشتركين ✿)$",
"^(رتبتي)$",
"^(ضع اسم للبوت ✿)$",
"^(ضع صوره للترحيب ✿)$",
"^(ضع صوره للترحيب)$",
"^(الحمايه)$",
"^(الاعدادات)$",
"^(الوسائط)$",
"^(الغاء الامر ✿)$",
"^(الرتبه)$",
"^(الغاء)$",
"^(سحكاتي)$",
"^(اسمي)$",
"^(التاريخ)$",
"^(/[Ss]tore)$",
"^(اصدار السورس)$",
"^(الاصدار)$",
"^(server)$",
"^(السيرفر)$",
"^(فحص البوت)$", 
"^(نسخه احتياطيه للمجموعات)$",
"^(رفع نسخه الاحتياطيه)$", 
"^(تفعيل الاشتراك الاجباري)$", 
"^(تعطيل الاشتراك الاجباري)$", 
"^(تغيير الاشتراك الاجباري)$", 
"^(الاشتراك الاجباري)$", 
"^(تفعيل الاشتراك الاجباري ✿)$", 
"^(تعطيل الاشتراك الاجباري ✿)$", 
"^(تغيير الاشتراك الاجباري ✿)$", 
"^(الاشتراك الاجباري ✿)$", 
"^(احظرني)$", 
"^(اطردني)$", 
"^(جهاتي)$", 
"^(المنشئين)$", 
"^(اضف امر)$", 
"^(مسح امر)$", 
"^(تعطيل الحظر)$", 
"^(تعطيل الطرد)$", 
"^(تفعيل الحظر)$", 
"^(تفعيل الطرد)$", 
"^(تفعيل الترحيب)$", 
"^(تعطيل الترحيب)$", 
"^(مسح الردود المتعدده)$", 
"^(الردود المتعدده)$", 
"^(اضف رد متعدد)$", 
"^(مسح رد متعدد)$", 
"^(تاك عام)$",
"^(تفعيل اليوتيوب)$",
"^(تعطيل اليوتيوب)$",
"^(تفعيل التحشيش)$",
"^(تعطيل التحشيش)$",
"^(تفعيل تاك عام)$",
"^(تعطيل تاك عام)$",
"^(تفعيل الصيغ)$",
"^(تعطيل الصيغ)$",
"^(تفعيل الرابط)$",
"^(تعطيل الرابط)$",
"^(تفعيل الابراج)$",
"^(تعطيل الابراج)$",
"^(تفعيل انطق)$",
"^(تعطيل انطق)$",
"^(تفعيل غنيلي)$",
"^(تعطيل غنيلي)$",
"^(المالك)$",
"^(مالك المجموعه)$",
"^(متجر الملفات)$",
"^([Ss][pP]) ([%a%d_]+.lua)$", 
"^([dD][pP]) ([%a%d_]+.lua)$", 
'^(رفع مشرف)$',
'^(رفع مشرف) (@[%a%d_]+)$',
'^(رفع مشرف) (%d+)$',
'^(تنزيل مشرف)$',
'^(تنزيل مشرف) (@[%a%d_]+)$',
'^(تنزيل مشرف) (%d+)$',
'^(رفع مالك)$',
'^(رفع مالك) (@[%a%d_]+)$',
'^(رفع مالك) (%d+)$',
'^(تنزيل مالك)$',
'^(تنزيل مالك) (@[%a%d_]+)$',
'^(تنزيل مالك) (%d+)$',
'^(المالكين)$',
'^(رفع مشرف بكل الصلاحيات)$',
'^(رفع مشرف بكل الصلاحيات) (@[%a%d_]+)$',
'^(رفع مشرف بكل الصلاحيات) (%d+)$',
'^(تنزيل مشرف بكل الصلاحيات)$',
'^(تنزيل مشرف بكل الصلاحيات) (@[%a%d_]+)$',
'^(تنزيل مشرف بكل الصلاحيات) (%d+)$',
"^(مسح الصوتيات العامه)$",
"^(الصوتيات العامه)$",
"^(اضف صوت عام)$",
"^(مسح صوت عام)$",
"^(مسح الصوتيات)$",
"^(الصوتيات)$",
"^(اضف صوت)$",
"^(مسح صوت)$",
"^(السورس)$",
"^(سورس)$",
"^(م المطور)$", 
"^(اوامر الرد)$",
"^(الاوامر)$",
"^(م1)$",
"^(م2)$",
"^(م3)$",
"^(م4)$",
"^(م5)$",
"^(م6)$",
"^(م7)$",
 
 
 },
 imero = imero,
 dmero = dmero,
 }
