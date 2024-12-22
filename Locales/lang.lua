Lang = {} --have to set globally since dofile() require() and loadfile() are restricted
--必须全局设置，因为 dofile() require() 和 loadfile() 受到限制

Lang["enUS"] = {
    ["头像模块"] = "Avatar Module",
    ["头像百分比"] = "Percentage of avatars",
    ["目标标记按钮"] = "Target mark button",
    ["动作条模块"] = "Action bar module",
    ["旧版动作条动画"] = "Old version action bar animation",
    ["微型菜单模块"] = "Micro menu module",
    ["角色面板耐久"] = "Durability of character panel",
    ["小地图模块"] = "Mini-map module",
    ["小地图图标渐隐"] = "Mini-map icon fades away",
    ["聊天窗模块"] = "Chat window module",
    ["聊天频道按钮"] = "Chat channel button",
    ["施法条模块"] = "Cast bar module",
    ["|cff00BFFF自定义施法条材质|r"] = "|cff00BFFFCustom cast bar material|r",
    ["滚动战斗记录"] = "Scrolling battle log",
    ["滚动战斗记录位置"] = "Scrolling battle log position",
    ["法术警报倒数(|cFF00FF55SAT|r)"] = "Spell alarm countdown(|cFF00FF55SAT|r)",
    ["进入战斗提示"] = "Enter battle prompt",
    ["密语自动邀请"] = "Automatic invitation by whisper",
    ["自我打断通报"] = "Self-interruption notification",
    ["自动卖灰"] = "Automatically sell grey",
    ["Shift焦点"] = "Shift focus",
    ["|cff00BFFFLFG增强|r"] = "|cff00BFFFLFG Enhanced|r",
    ["目标头像所有buff"] = "All buffs of target avatar",
    ["快速拾取"] = "Increase pickup speed",
    ["团队框架BUFF时间"] = "Team Framework BUFF time",
    ["CVAR自动设置"] = "CVAR auto set",
    ["MRT"] = "MRT",
    ["TinyInspect自动设置"] = "TinyInspect auto setup",
    ["灌注/大餐语音提醒"] = "Infusion/feast voice reminder",
    ["获得标记语音提醒"] = "get marked voice reminder",
    ["喊话标记语音提醒"] = "shout mark voice reminder",
    ["|cff00BFFF右下角信息栏|r"] = "|cff00BFFFlower right corner information bar|r",
    ["数值单位: w,亿"] = "value unit: w, billion",
    ["数值单位: 万,亿"] = "value unit: ten thousands, billion",
    ["数值单位: K,M"] = "value unit: thousands, million",
    ["鼠标提示:跟随"] = "Mouse tip: follow",
    ["鼠标提示:不跟随"] = "mouse tip: do not follow",
    ["鼠标提示:非战斗跟随"] = "mouse tip: non-combat follow",
    ["鼠标提示:禁用"] = "mouse tip: disable",
    ["返回设置"] = "return to settings",
    ["重载"] = "reload",
    ["恢复默认并重载界面"] = "Restore Defaults",
    ["此界面只是一些功能的开关,大部分功能改动后需要重载界面\n/aa 重载界面  /ab 打开网格线  /chat 配置聊天框\n/sc 删除所有宏并恢复默认按键  \n/sd 配置esc-界面-里面的大部分东西"] = "This interface is just a switch for some functions.\nAfter changing most functions, you need to reload the interface\n/aa Reload the interface /ab Open the grid /chat Configure the chat box\n/sc Delete all macros and restore the default keys\n/sd configures esc-interface-most of the things in it",
    ["|cff00FF7F/ad|r快速打开此界面"] = "|cff00FF7F/ad|r Quickly open this interface",
    ["更新记录"] = "Update record",
    ["|cffFFFFFF其他功能: |r"] = "|cffFFFFFFOther functions: |r",
    ["以下是一些没有开关的功能\n"] = "The following are some functions without switches\n",
    ["施法序列延迟"] = "Casting sequence delay",
    ["让拍卖行和专业界面可以同时打开"] = "Allows auction house and profession interface to be opened at the same time",
    ["会"] = "G",
    ["官"] = "O",
    ["团"] = "R",
    ["通知"] = "RW",
    ["团长"] = "RL",
    ["队长"] = "PL",
    ["向导"] = "PG",
    ["领袖"] = "BL",
    ["[暂离] "] = "[AFK] ",
    ["[勿扰] "] = "[DND] ",
    ["[GM] "] = "[GM] ",
    ["说"] = "S",
    ["喊"] = "Y",
    ["队"] = "P",
    ["副"] = "I",
    ["综"] = "1",
    ["报"] = "ST",
    ["交"] = "2",
    ["世"] = "W",
    [" 力量:"] = " Strength:",
    [" 敏捷:"] = " Agility:",
    [" 智力:"] = " Intellect:",
    ["装等:"] = "ilvl:",
    ["职业:"] = "Class:",
    ["天赋:"] = "Spec:",
    ["爆击:"] = "Crit:",
    ["急速:"] = "Haste:",
    ["精通:"] = "Mastery:",
    ["全能:"] = "Vers:",
    ["Reset to Default"] = "Reset to Default",
    ["Reload"] = "Reload"
}

Lang["zhCN"] = {
    ["头像模块"] = "头像模块",
    ["头像百分比"] = "头像百分比",
    ["目标标记按钮"] = "目标标记按钮",
    ["动作条模块"] = "动作条模块",
    ["旧版动作条动画"] = "旧版动作条动画",
    ["微型菜单模块"] = "微型菜单模块",
    ["角色面板耐久"] = "角色面板耐久",
    ["小地图模块"] = "小地图模块",
    ["小地图图标渐隐"] = "小地图图标渐隐",
    ["聊天窗模块"] = "聊天窗模块",
    ["聊天频道按钮"] = "聊天频道按钮",
    ["施法条模块"] = "施法条模块",
    ["|cff00BFFF自定义施法条材质|r"] = "|cff00BFFF自定义施法条材质|r",
    ["滚动战斗记录"] = "滚动战斗记录",
    ["滚动战斗记录位置"] = "滚动战斗记录位置",
    ["法术警报倒数(|cFF00FF55SAT|r)"] = "法术警报倒数(|cFF00FF55SAT|r)",
    ["进入战斗提示"] = "进入战斗提示",
    ["密语自动邀请"] = "密语自动邀请",
    ["自我打断通报"] = "自我打断通报",
    ["自动卖灰"] = "自动卖灰",
    ["Shift焦点"] = "Shift焦点",
    ["|cff00BFFFLFG增强|r"] = "|cff00BFFFLFG增强|r",
    ["目标头像所有buff"] = "目标头像所有buff",
    ["快速拾取"] = "增加拾取速度",
    ["团队框架BUFF时间"] = "团队框架BUFF时间",
    ["CVAR自动设置"] = "CVAR自动设置",
    ["MRT"] = "MRT",
    ["TinyInspect自动设置"] = "TinyInspect自动设置",
    ["灌注/大餐语音提醒"] = "灌注/大餐语音提醒",
    ["获得标记语音提醒"] = "获得标记语音提醒",
    ["喊话标记语音提醒"] = "喊话标记语音提醒",
    ["|cff00BFFF右下角信息栏|r"] = "|cff00BFFF右下角信息栏|r",
    ["数值单位: w,亿"] = "数值单位: w,亿",
    ["数值单位: 万,亿"] = "数值单位: 万,亿",
    ["数值单位: K,M"] = "数值单位: K,M",
    ["鼠标提示:跟随"] = "鼠标提示:跟随",
    ["鼠标提示:不跟随"] = "鼠标提示:不跟随",
    ["鼠标提示:非战斗跟随"] = "鼠标提示:非战斗跟随",
    ["鼠标提示:禁用"] = "鼠标提示:禁用",
    ["返回设置"] = "返回设置",
    ["重载"] = "重载",
    ["恢复默认并重载界面"] = "恢复默认并重载界面",
    ["此界面只是一些功能的开关,大部分功能改动后需要重载界面\n/aa 重载界面  /ab 打开网格线  /chat 配置聊天框\n/sc 删除所有宏并恢复默认按键  \n/sd 配置esc-界面-里面的大部分东西"] = "此界面只是一些功能的开关,大部分功能改动后需要重载界面\n/aa 重载界面  /ab 打开网格线  /chat 配置聊天框\n/sc 删除所有宏并恢复默认按键  \n/sd 配置esc-界面-里面的大部分东西",
    ["|cff00FF7F/ad|r快速打开此界面"] = "|cff00FF7F/ad|r快速打开此界面",
    ["更新记录"] = "更新记录",
    ["|cffFFFFFF其他功能: |r"] = "|cffFFFFFF其他功能: |r",
    ["以下是一些没有开关的功能\n"] = "以下是一些没有开关的功能\n",
    ["施法序列延迟"] = "施法序列延迟",
    ["让拍卖行和专业界面可以同时打开"] = "让拍卖行和专业界面可以同时打开",
    ["会"] = "会",
    ["官"] = "官",
    ["团"] = "团",
    ["通知"] = "通知",
    ["团长"] = "团长",
    ["队"] = "队",
    ["队长"] = "队长",
    ["向导"] = "向导",
    ["领袖"] = "领袖",
    ["[暂离] "] = "[暂离] ",
    ["[勿扰] "] = "[勿扰] ",
    ["[GM] "] = "[GM] ",
    ["说"] = "说",
    ["喊"] = "喊",
    ["副"] = "副",
    ["综"] = "综",
    ["报"] = "报",
    ["交"] = "交",
    ["世"] = "世",
    [" 力量:"] = " 力量:",
    [" 敏捷:"] = " 敏捷:",
    [" 智力:"] = " 智力:",
    ["装等:"] = "装等:",
    ["职业:"] = "职业:",
    ["天赋:"] = "天赋:",
    ["爆击:"] = "爆击:",
    ["急速:"] = "急速:",
    ["精通:"] = "精通:",
    ["全能:"] = "全能:",
    ["Reset to Default"] = "恢复默认并重载界面",
    ["Reload"] = "重载"
}

Lang["zhTW"] = { 
    
}

CurrentLang = GetLocale()
function GetLocText(key)
    return Lang[CurrentLang] and Lang[CurrentLang][key] or Lang["zhCH"][key] or key
end
return {
    GetLocText = GetLocText
}
--English added by US-Mysteiige