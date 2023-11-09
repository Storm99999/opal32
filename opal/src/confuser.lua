local function setindex(arr : table) arr.__index = arr or {} end
local opal32 = { 
  emojiTable = {
    "o32😊", "o32🌟", "o32🍎", "o32🐶", "o32🐱", "o32🌈", "o32🎉", "o32🚀", "o32🌍", "o32⚡", "o32🌺", "o32🎁", "o32🎈", "o32🌻", "o32🌸", "o32🍀", "o32🌹", "o32🐢", "o32🦋", "o32🦄",
    "o32🐬", "o32🐳", "o32🍕", "o32🍔", "o32🍟", "o32🍦", "o32🍩", "o32🍰", "o32🍫", "o32🍭", "o32🍪", "o32🥤", "o32🍸", "o32🍺", "o32🍷", "o32🍹", "o32🍾", "o32🥂", "o32🥃", "o32🍶",
    "o32🍵", "o32🍼", "o32🥛", "o32☕", "o32🍻", "o32🍨", "o32🍧", "o32🍢", "o32🍣", "o32🍡", "o32🍘", "o32🍥", "o32🥠", "o32🥮", "o32🍯", "o32🍝", "o32🍜", "o32🍲", "o32🍛", "o32🍚",
    "o32🍙", "o32🥟", "o32🥡", "o32🥢", "o32🍣", "o32🍤", "o32🍥", "o32🥮", "o32🍢", "o32🍡", "o32🍠", "o32🥔", "o32🍆", "o32🥕", "o32🌽", "o32🌶️", "o32🍄", "o32🥦", "o32🍀", "o32🍁",
    "o32🍂", "o32🍃", "o32🍇", "o32🍈", "o32🍉", "o32🍊", "o32🍋", "o32🍌", "o32🍍", "o32🥭", "o32🍎", "o32🍏", "o32🍐", "o32🍑", "o32🍒", "o32🍓", "o32🥝", "o32🍅", "o32🥥", "o32🥑",
    "o32🍆", "o32🥔", "o32🥕", "o32🌽", "o32🌶️"
  } 
}
opal32.b64 = {}
setindex(opal32)
setindex(opal32.b64)
setindex(opal32.emojiTable)

function opal32.b64:convert(data : string) : __namecall
  local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  return ((data:gsub(
    ".",
      function(x)
          local r, b = "", x:byte()
          for i = 8, 1, -1 do
              r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
          end
          return r
      end
  ) .. "0000"):gsub(
    "%d%d%d?%d?%d?%d?",
      function(x)
          if (#x < 6) then
               return ""
          end
          local c = 0
          for i = 1, 6 do
            c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
          end
          return b:sub(c + 1, c + 1)
      end
  ) .. ({"", "==", "="})[#data % 3 + 1])
end

function opal32:replace(inputString : string) : __namecall
    local result = ""
    for i = 1, #inputString do
        local char = inputString:sub(i, i)
        local emoji = opal32.emojiTable[math.random(1, #opal32.emojiTable)]
        if emoji then
            result = result .. emoji
        else
            result = result .. char
        end
    end
    return result
end

function opal32:encrypt_str(input : string) : __namecall
  local result;
  local lastString;

  for _ = 0, 12 do
      local str_encrypt = opal32.b64:convert(lastString == nil and input or lastString)
      lastString = str_encrypt
  end

  result = lastString;

  return opal32:replace(result)
end

local startTime = os.clock()

print(opal32:encrypt_str("Hello, World!"))
local endTime = os.clock()
local elapsedTime = endTime - startTime
print("Elapsed time:", elapsedTime, "seconds")
