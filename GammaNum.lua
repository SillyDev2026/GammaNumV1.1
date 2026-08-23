--!optimize 2
--!native
--[[
		INFORMATION
				
	Creator: @Valkzius
	Name: GammaNum
	Version: 1.1.1 - 8_22_2026 (SillyDev0050 Fixed Edition)
	Patch: SillyDev0050 Fixed Edition - 8_22_2026
	Description: large number library for numbers up to 10↑↑2^1024 optimized for speed
	Patch Credit: @sillydev0050 - correctness fixes, safer codecs, and QoL helpers
	please give credit if used
	
		Function List and Custom Function Area below
		Constants are at the very bottom (use scroll bar)
	
	Remember to scroll down
		
CONVERSION:
	.new(s,l,e)             => creates gammanum equal to s * (10^^l)^e
	^^ s must equal 0, 1, or -1, l must be non-negative
	.fromNumber(number)     => converts number to gammanum
	.fromScientific(m,e)    => creates gammanum equal to m*10^e
	.fromString(string)     => converts string to gammanum 
	^^ please be aware this function is much slower than other conversions
	.totuple(n)             => converts n to the sign,layer,exponent
	.tobuffer(n)            => converts n to a buffer (gammanum)
	.createCheckless(s,l,e) => converts s,l,e to a gammanum without correcting the values
	^^ giving incorrect values and then passing them to other functions could cause incorrect results
	
COMPARISON:
	.eq(n1, n2)      => a == b
	.lt(n1, n2)      => a < b
	.gt(n1, n2)      => a > b
	.lte(n1, n2)     => a <= b
	.gte(n1, n2)     => a >= b
	.max(..)         => returns the greatest number
	.min(..)         => returns the least number
	.maxabs(..)      => returns the number with greatest absolute value
	.minabs(..)      => returns the number with least absolute value
	
ARITHMETIC:
	.add(n1,n2)      => n1 + n2
	.sub(n1,n2)      => n1 - n2
	.mul(n1,n2)      => n1 * n2
	.div(n1,n2)      => n1 / n2
	.recip(n)        => 1 / n
	.intdiv(n1,n2)   => n1 // n2 -- division then floor ex. 33 // 4 = 8
	.mod(n1,n2)      => n1 % n2
	.pow(n1,n2)      => n1 ^ n2
	.root(n1,n2)     => n1 ^ (1 / n2)
	.sqrt(n)         => n ^ 0.5
	.pow2(n)         => 2 ^ n
	.pow10(n)        => 10 ^ n
	.exp(n)          => e ^ n (e = ~2.71828)
	.log(n1,n2)      => logarithm of n1 in base n2
	.log10(n)        => logarithm of n in base 10
	.abslog10(n)     => logarithm of |n| in base 10
	.log2(n)         => logarithm of n in base 2
	.ln(n)           => natural logarithm of n (base ~2.71828)
	.neg(n)          => -n
	.abs(n)          => |n| -- absolute value of n
	.tetr(n1,n2)     => n1↑↑n2 -- tetration of n1 to n2 (n2 must be an integer) ex. n1^n1^..^n1 with n2 n1's
	
EQUALS: 
	.addeq(n1,n2)    => n1 += n2
	.subeq(n1,n2)    => n1 -= n2
	.muleq(n1,n2)    => n1 *= n2
	.diveq(n1,n2)    => n1 /= n2
	.recipeq(n)      => n = 1 / n
	.intdiveq(n1,n2) => n1 //= n2 -- division then floor ex. 33 // 4 = 8
	.modeq(n1,n2)    => n1 %= n2
	.poweq(n1,n2)    => n1 ^= n2
	.rooteq(n1,n2)   => n1 ^= (1 / n2)
	.sqrteq(n)       => n ^= 0.5
	.pow2eq(n)       => n = 2 ^ n
	.pow10eq(n)      => n = 10 ^ n
	.expeq(n)        => n = e ^ n (e = ~2.71828)
	.logeq(n1,n2)    => n1 = logarithm of n1 in base n2
	.log10eq(n)      => n = logarithm of n in base 10
	.abslog10eq(n)   => n = logarithm of |n| in base 10
	.log2eq(n)       => n = logarithm of n in base 2
	.lneq(n)         => n = natural logarithm of n (base ~2.71828)
	.negeq(n)        => n = -n
	.abseq(n)        => n = |n| -- absolute value of n
	
	.set(n,s,l,e)    => sets n to a new gammanum using s,l,e
	.setFromNumber(n,number)    => sets n to a new gammanum from a number
	.copy(n1,n2)     => sets n1 to n2 (both must be gammanums)
	
ROUNDING:
	.floor(n)        => greatest integer less than n
	.round(n)        => closest integer to n
	.ceil(n)         => least integer greater than n
	.roundto(n1,n2)  => Round n1 to a multiple of n2
	
	.flooreq(n)      => n = greatest integer less than n
	.roundeq(n)      => n = closest integer to n
	.ceileq(n)       => n = least integer greater than n
	.roundtoeq(n1,n2)=> n = Round n1 to a multiple of n2

MISC:
	.sign(n)       => returns 1 if n is positive, -1 if negative, and 0 if n equals 0
	.isPositive(n) => returns true if n is positive, else false
	.isNegative(n) => returns true if n is negative, else false
	.isZero(n)     => returns true if n is zero, else false
	.isNumber(n)   => returns true if n is able to be represented by a number, else false
	
	.lbencode(n) => encodes n into something that could be stored in an OrderedDataStore
	.lbdecode(n) => decodes n from .lbencode()
	.b64encode(n) => encodes n into base64 without data loss
	.b64decode(n) => decodes n from .b64encode()
	.hexencode(n) => encodes n into hexadecimal without data loss (faster than b64 but is less compressed)
	.hexdecode(n) => decodes n from .hexencode()

	-- sillydev0050 fixed: QoL / safety helpers
	.clone(n) => returns an independent gammanum buffer
	.compare(n1,n2) => returns -1, 0, 1 (nil when either value is NaN)
	.clamp(n,min,max) => clamps n and returns a new gammanum
	.toNumber(n) => converts to a native number (saturates to +/-inf when needed)
	.isGammaNum(n) => true when n is a valid 17-byte gammanum buffer
	.isFinite(n) => true when n is not NaN or infinity
	.isNaN(n) => true when n uses GammaNum's NaN representation
	.isInf(n) => true when n is +/- infinity

	.random(n1,n2) => random number between n1 and n2
	.geosum(base,mul,start,last)    => sum of geometric series from start -> last	
	.geosumR(base,mul,start,amount) => end index of geometric series that starts from 'start' and sums to amount
	.gamma(n) => the gamma function | (n-1)!
	.fact(n)  => the factorial function | n!

STRING:
	.tostring(n,suffixtype) => converts using the suffix type given (defaults to .DefaultSuffixType below)
	.toScientific(n)        => converts n to scientific notation
	.toEngineer(n)          => converts n to engineer notation
	.toSuffix(n)            => converts n to suffix notation (ex. 3.5k)
	.toLayered(n)           => converts n to layered notation
	.std(s,l,e)             => converts s,l,e to a number then to a string
	.sci(s,l,e)             => converts s,l,e to scientific notation
	.eng(s,l,e)             => converts s,l,e to engineer notation
	.suf(s,l,e)             => converts s,l,e to suffix notation (ex. 3.5k)
	.lay(s,l,e)             => converts s,l,e to layered notation
	.suffix(i)              => suffix for given index ex. 3 would be b for billion
	.print(..)              => prints a list of gammanums without rounding (other types just get default tostring)
]]
local gn = {}
-- sillydev0050 fixed v1.1.1: lightweight release metadata for debugging/version checks
gn.Version = "1.1.1"
gn.FixedBy = "sillydev0050"
gn.SuffixTypes = {
	Scientific =     0 , -- scientific notation is always on
	Scientific3 =    1 , -- scientific notation starts at 1e3
	Scientific36 =   2 , -- scientific notation starts at 1e36
	Scientific306 =  3 , -- scientific notation starts at 1e306
	Scientific3006 = 4 , -- scientific notation starts at 1e3006
	Engineer = 	     5 , -- engineer notation is always on
	Engineer3 =      6 , -- engineer notation starts at 1e3
	Engineer36 =     7 , -- engineer notation starts at 1e36
	Engineer306 =    8 , -- engineer notation starts at 1e306
	Engineer3006 =   9 , -- engineer notation starts at 1e3006
	Layered =        10, -- layered notation is always on
}
--EDIT IF YOU WANT
gn.DefaultSuffixType = gn.SuffixTypes.Scientific306
gn.DefaultDigits = 3 -- default digits after the decimal with one digit before 
--ex. 2: 4.53, 3 : 4.536, 4 : 4.5361
gn.DefaultTotalDigits = 3 -- default digits after the decimal with some digits before
-- ex. 2: 4.53 or 45.3, 3 : 4.536 or 45.36 or 4.536, 4 : 4.5361 or 45.361 or 453.61 or 4536.1
gn.MaxEs = 3 -- maximum trailing Es for scientific() function (up to 20)
-- ex. 4 trailing Es is "eeee"
--DONT EDIT BELOW
local log10_2 = math.log10(2)
local log10_2x2 = math.log10(log10_2)
local euler = math.exp(1)
local ln_10 = 1 / math.log(10)
local ln_10x2 = math.log10(ln_10)
local inf_limit = math.log10(1.7976931348623157e+308)
local l1_THRESHOLD = 15.653559774527022
local digitcuts = {}
local capthres = {}
local capvalue = {}
local capthresl10 = {}
local capvaluel10 = {}
for i=0,20 do
	digitcuts[i] = "%."..i.."f"
	capthres[i] = 10-0.5*math.pow(10,-i)
	capvalue[i] = 10-math.pow(10,-i)
	capthresl10[i] = math.log10(10-0.5*math.pow(10,-i))
	capvaluel10[i] = math.log10(10-math.pow(10,-i))
end
local pow10 = {}
for i=-20,20 do
	pow10[i] = math.pow(10,i)
end
local Etrail = {"e"}
for i=2,20 do
	Etrail[i] = Etrail[i-1].."e"
end
--CUSTOM FUNCTION AREA
--EXAMPLES:
--[[
	This is a description, read the source then make your own.
]]
function gn.ExampleOperation(input1)
	--convert the input into something we can easily use
	local s1,l1,e1 = gn.totuple(input1)
	--do what you want
	s1 = math.abs(s1)
	l1 += 1
	e1 = -e1
	--then convert it back and return it
	return gn.new(s1,l1,e1)
end
--[[
	This is a description, read the source then make your own.
]]
function gn.ExampleToString(input1)
	--convert the input into something we can easily use
	local s1,l1,e1 = gn.totuple(input1)
	--do what you want
	s1 = math.abs(s1)
	l1 += 1
	e1 = -e1
	--then convert it to a string and return it
	return s1.."_"..l1.."_"..e1
end





--START OF DEFAULT FUNCTIONS
--[[
	Converts input to sign,layer,exponent in a tuple
]]
function gn.totuple(input)
	if type(input) == "buffer" then
		return buffer.readi8(input,0),buffer.readf64(input,1),buffer.readf64(input,9)
	elseif type(input) == "number" then
		-- sillydev0050 fixed: canonicalize native NaN/infinity before tuple math
		if input ~= input then
			return 1,-1,1
		elseif input == 0 then
			return 0,0,0
		elseif math.abs(input) == math.huge then
			return math.sign(input),math.huge,1
		else
			local s = math.sign(input)
			input = math.abs(input)
			if input >= 1e10 or input <= 1e-10 then
				return s,1,math.log10(input)
			else
				return s,0,input
			end
		end
	else
		error("Wrong Type: totuple(), Input 1")
	end
end

--[[
	Converts input to sign,layer,exponent in a buffer
]]
function gn.tobuffer(input)
	if type(input) == "buffer" then
		return input
	elseif type(input) == "number" then
		-- sillydev0050 fixed: reuse the corrected conversion path for native special values
		return gn.fromNumber(input)
	else
		error("Wrong Type: tobuffer(), Input 1")
	end
end

--[[
	Converts sign,layer,exponent to a buffer without checking
]]
function gn.createCheckless(s,l,e)
	local output = buffer.create(17)
	buffer.writei8(output,0,s)
	buffer.writef64(output,1,l)
	buffer.writef64(output,9,e)
	return output
end
--[[
	Prints gammanum and any type with tostring capabilities
]]
function gn.print(...)
	local args = {...}
	local str = ""
	for _, arg in args do
		if type(arg) == "buffer" then
			str ..= "{"..buffer.readi8(arg,0)..","..buffer.readf64(arg,1)..","..buffer.readf64(arg,9).."} "
		else
			str ..= tostring(arg).." "
		end
	end
	print(str:sub(1,-2))
end
--[[
	Returns Sign, Layer, Exponent of gammanum in a tuple
]]
function gn.show(n)
	return buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
end
--[[
	Returns Sign, Layer, Exponent of gammanum in a string
]]
function gn.showS(n)
	return "{"..buffer.readi8(n,0)..","..buffer.readf64(n,1)..","..buffer.readf64(n,9).."}"
end
--[[
	Creates gammanum from given Sign(s), Layer(l), Exponent(e)
	s: The Sign, must be 1 if positive, -1 if negative, and 0 if zero
	l: The Layer, number of e's before number (non-negative)
	e: The Exponent, number after the e
	number: s*1ee..(Layer times)..ee(Exponent)
	ex. 1,0,53 -> 53
	ex. -1,1,53 -> -1e53
	ex. 0,0,0 -> 0
	ex. 1,10,-17 -> 1e-eeeeeeeee17
]]
function gn.new(s,l,e)
	local buf = buffer.create(17)
	-- sillydev0050 fixed: validate tuple inputs and canonicalize NaN instead of storing NaN fields
	if type(s) ~= "number" then error("Wrong Type: new(), Input 1") end
	if s ~= s then
		buffer.writei8(buf,0,1); buffer.writef64(buf,1,-1); buffer.writef64(buf,9,1)
		return buf
	end
	if s == 0 then
		return buf
	end
	if type(l) ~= "number" then error("Wrong Type: new(), Input 2") end
	if type(e) ~= "number" then error("Wrong Type: new(), Input 3") end
	if l ~= l or e ~= e then
		buffer.writei8(buf,0,1); buffer.writef64(buf,1,-1); buffer.writef64(buf,9,1)
		return buf
	end
	s = math.sign(s)
	l = math.floor(l)
	if l < 0 then 
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == math.huge or e == math.huge then 
		-- sillydev0050 fixed: positive infinite exponent/layer is GammaNum infinity and preserves outer sign
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,math.huge)
		buffer.writef64(buf,9,1)
		return buf
	elseif e == -math.huge then
		-- sillydev0050 fixed: -Inf exponent collapses layers instead of incorrectly becoming +Inf
		if l == 0 then
			buffer.writei8(buf,0,-s); buffer.writef64(buf,1,math.huge); buffer.writef64(buf,9,1)
			return buf
		elseif l == 1 then
			return buf
		else
			return gn.new(s,l-2,1)
		end
	elseif l == 0 and e == 0 then 
		return buf
	elseif l == 0 then
		if e < 0  then
			e = -e
			s = -s
		end
		buffer.writei8(buf,0,s)
		if e <= 1e-10 or e >= 1e10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(e))
			return buf
		else
			buffer.writef64(buf,9,e)
			return buf
		end
	elseif math.abs(e) >= 1e10 then
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,math.sign(e)*math.log10(math.abs(e)))
		return buf
	elseif l == 1 and math.abs(e) < 10 then
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,9,math.pow(10,e))
		return buf
	elseif math.abs(e) < 1 then
		if l >= 3 then
			buffer.writei8(buf,0,s)
			buffer.writef64(buf,1,l-2)
			e = math.sign(e) * math.pow(10, math.abs(e))
			buffer.writef64(buf,9,math.sign(e)*math.pow(10,math.abs(e)))
			return buf
		else
			buffer.writei8(buf,0,s)
			buffer.writef64(buf,9,math.pow(10,math.sign(e) * math.pow(10, math.abs(e))))
			return buf
		end
	elseif math.abs(e) < 10 then
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l-1)
		buffer.writef64(buf,9,math.sign(e)*math.pow(10,math.abs(e)))
		return buf
	else
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,e)
		return buf
	end
end
--[[
	Creates gammanum equal to m * 10 ^ e
]]
function gn.fromScientific(m,e)
	-- sillydev0050 fixed: validate inputs, canonicalize zero, NaN, and infinities
	if type(m) ~= "number" then
		error("Wrong Type: fromScientific(), Input 1")
	end
	if type(e) ~= "number" then
		error("Wrong Type: fromScientific(), Input 2")
	end
	if m ~= m or e ~= e then
		return gn.new(1,-1,1)
	end
	if m == 0 then
		return buffer.create(17)
	end
	local s = math.sign(m)
	if math.abs(m) == math.huge then
		if e == -math.huge then
			return gn.new(1,-1,1)
		end
		return gn.new(s,math.huge,1)
	elseif e == math.huge then
		return gn.new(s,math.huge,1)
	elseif e == -math.huge then
		return buffer.create(17)
	end
	local scale = e + math.log10(math.abs(m))
	if scale == math.huge then
		return gn.new(s,math.huge,1)
	elseif scale == -math.huge then
		return buffer.create(17)
	end
	return gn.new(s,1,scale)
end

--[[
	Converts number to gammanum
]]
function gn.fromNumber(n)
	local buf = buffer.create(17)
	if type(n) ~= "number" then
		-- sillydev0050 fixed: preserve the library's NaN convention for invalid conversion input
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif n ~= n then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif n == 0 then
		return buf
	elseif math.abs(n) == math.huge then
		-- sillydev0050 fixed: native +/-inf now maps to GammaNum +/-inf
		buffer.writei8(buf,0,math.sign(n))
		buffer.writef64(buf,1,math.huge)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			-- sillydev0050 fixed: sign belongs in byte 0 only; exponent is magnitude
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	end
end

--[[
	Converts string to gammanum
	'A;B': layer = A, exponent = B
	'AeB': layer = 1, exponent = B+log10(A)
	'A': layer = 0, exponent = A
	Make value negative by putting '-' in front
	*Please use .new() instead for efficiency
]]
function gn.fromString(str)
	-- sillydev0050 fixed v1.1.1: parse finite native scientific strings through tonumber first
	-- so values such as "2e3" canonicalize to the exact same layer-0 value as fromNumber(2000).
	if type(str) ~= "string" then
		return gn.new(1,-1,1)
	end
	str = str:match("^%s*(.-)%s*$") or ""
	if str == "" then
		return buffer.create(17)
	end
	local lower = str:lower()
	if lower == "inf" or lower == "+inf" then
		return gn.new(1,math.huge,1)
	elseif lower == "-inf" then
		return gn.new(-1,math.huge,1)
	elseif lower == "nan" then
		return gn.new(1,-1,1)
	end

	local native = tonumber(str)
	if native ~= nil and native == native and math.abs(native) < math.huge then
		return gn.fromNumber(native)
	end

	local semicolon = string.find(str,";",1,true)
	if semicolon then
		local left = str:sub(1,semicolon-1)
		local right = str:sub(semicolon+1)
		if string.find(right,";",1,true) then
			return gn.new(1,-1,1)
		end
		local layerRaw = tonumber(left)
		local exponent = tonumber(right)
		if layerRaw == nil or exponent == nil or layerRaw ~= layerRaw or exponent ~= exponent then
			return gn.new(1,-1,1)
		end
		local s = math.sign(layerRaw)
		if s == 0 then s = 1 end
		return gn.new(s,math.abs(layerRaw),exponent)
	end

	-- Finite scientific notation was handled above. This path intentionally remains
	-- for values too large/small for a native double, where GammaNum can still represent them.
	local mantissaText, exponentText = str:match("^([%+%-]?[%d%.]+)[eE]([%+%-]?[%d%.]+)$")
	if mantissaText and exponentText then
		local mantissa = tonumber(mantissaText)
		local exponent = tonumber(exponentText)
		if mantissa == nil or exponent == nil or mantissa ~= mantissa or exponent ~= exponent then
			return gn.new(1,-1,1)
		end
		return gn.fromScientific(mantissa,exponent)
	end
	return gn.new(1,-1,1)
end
--[[
	Greatest integer less than n
]]
function gn.floor(n)
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: floor(), Input 1")
	end
	local buf = buffer.create(17)
	if s == 0 then
		return buf
	elseif s == 1 then
		if l == 0 then
			local rou = math.floor(e)
			if rou == 0 then
				return buf
			else
				buffer.writei8(buf,0,1)
				buffer.writef64(buf,9,rou)
				return buf
			end
		elseif e < 0 then
			-- sillydev0050 fixed: layer-1 values between 0.5 and 1 must round to 1
			if l == 1 and e >= -0.3010299956639812 then
				buffer.writei8(buf,0,1)
				buffer.writef64(buf,9,1)
			end
			return buf
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.floor(10^e)))
			return buf
		else
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,l)
			buffer.writef64(buf,9,e)
			return buf
		end
	elseif l == 0 then
		buffer.writei8(buf,0,-1)
		local rou = math.ceil(e)
		if rou == 1e10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,10)
			return buf
		else
			buffer.writef64(buf,9,rou)
			return buf
		end
	elseif e < 0 then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,1)
		buffer.writef64(buf,9,math.log10(math.ceil(10^e)))
		return buf
	else
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,e)
		return buf
	end
end
--[[
	Least integer greater than n
]]
function gn.ceil(n)
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: ceil(), Input 1")
	end
	local buf = buffer.create(17)
	if s == 0 then
		return buf
	elseif s == 1 then
		if l == 0 then
			buffer.writei8(buf,0,1)
			local rou = math.ceil(e)
			if rou == 1e10 then
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,10)
				return buf
			else
				buffer.writef64(buf,9,rou)
				return buf
			end
		elseif e < 0 then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,9,1)
			return buf
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.ceil(10^e)))
			return buf
		else
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,l)
			buffer.writef64(buf,9,e)
			return buf
		end
	elseif l == 0 then
		local rou = math.floor(e)
		if rou == 0 then
			return buf
		else
			buffer.writei8(buf,0,-1)
			buffer.writef64(buf,9,rou)
			return buf
		end
	elseif e < 0 then
		return buf
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,1)
		buffer.writef64(buf,9,math.log10(math.floor(10^e)))
		return buf
	else
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,e)
		return buf
	end
end
--[[
	Closest integer to n
]]
function gn.round(n)
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: round(), Input 1")
	end
	local buf = buffer.create(17)
	if s == 0 then
		return buf
	elseif s == 1 then
		if l == 0 then
			local rou = math.round(e)
			if rou == 0 then
				return buf
			elseif rou == 1e10 then
				buffer.writei8(buf,0,1)
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,10)
				return buf
			else
				buffer.writei8(buf,0,1)
				buffer.writef64(buf,9,rou)
				return buf
			end
		elseif e < 0 then
			return buf
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.round(10^e)))
			return buf
		else
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,l)
			buffer.writef64(buf,9,e)
			return buf
		end
	elseif l == 0 then
		local rou = math.round(e)
		if rou == 0 then
			return buf
		elseif rou == 1e10 then
			buffer.writei8(buf,0,-1)
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,10)
			return buf
		else
			buffer.writei8(buf,0,-1)
			buffer.writef64(buf,9,rou)
			return buf
		end
	elseif e < 0 then
		-- sillydev0050 fixed: symmetric negative rounding for magnitudes >= 0.5
		if l == 1 and e >= -0.3010299956639812 then
			buffer.writei8(buf,0,-1)
			buffer.writef64(buf,9,1)
		end
		return buf
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,1)
		buffer.writef64(buf,9,math.log10(math.round(10^e)))
		return buf
	else
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,e)
		return buf
	end
end
--[[
	Rounds n1 to nearest multiple of n2
]]
function gn.roundto(n1,n2)
	-- sillydev0050 fixed: correct formula is round(n1 / n2) * n2, not round(n1 * n2) / n2
	if gn.isZero(n2) then
		return gn.new(1,-1,1)
	end
	return gn.mul(gn.round(gn.div(n1,n2)),n2)
end

--[[
	n1 < n2
]]
-- sillydev0050 fixed: one canonical comparator prevents negative-ordering drift across lt/lte/gt/gte
local function compareMagnitude(l1,e1,l2,e2)
	local l1s = if e1 > 0 then l1 else -l1
	local l2s = if e2 > 0 then l2 else -l2
	if l1s < l2s then return -1 end
	if l1s > l2s then return 1 end
	if e1 < e2 then return -1 end
	if e1 > e2 then return 1 end
	return 0
end
local function compareValues(n1,n2)
	local s1,l1,e1 = gn.totuple(n1)
	local s2,l2,e2 = gn.totuple(n2)
	if l1 < 0 or l2 < 0 then
		return nil
	end
	if s1 < s2 then return -1 end
	if s1 > s2 then return 1 end
	if s1 == 0 then return 0 end
	local magnitude = compareMagnitude(l1,e1,l2,e2)
	return if s1 > 0 then magnitude else -magnitude
end

function gn.lt(n1,n2)
	local cmp = compareValues(n1,n2)
	return cmp ~= nil and cmp < 0
end

--[[
	n1 <= n2
]]
function gn.lte(n1,n2)
	local cmp = compareValues(n1,n2)
	return cmp ~= nil and cmp <= 0
end

--[[
	n1 > n2
]]
function gn.gt(n1,n2)
	local cmp = compareValues(n1,n2)
	return cmp ~= nil and cmp > 0
end

--[[
	n1 >= n2
]]
function gn.gte(n1,n2)
	local cmp = compareValues(n1,n2)
	return cmp ~= nil and cmp >= 0
end

--[[
	n1 == n2
]]
function gn.eq(n1,n2)
	local cmp = compareValues(n1,n2)
	return cmp ~= nil and cmp == 0
end

--[[
	Returns the greatest number in your list
]]
function gn.max(...)
	local args = {...}
	if #args == 0 then
		error("No Inputs: max()")
	end
	-- sillydev0050 fixed: use the canonical comparator so negative values are ordered correctly
	local best = args[1]
	for i=2,#args do
		if gn.gt(args[i],best) then
			best = args[i]
		end
	end
	return if type(best) == "buffer" then best else gn.fromNumber(best)
end

--[[
	Returns the least number in your list
]]
function gn.min(...)
	local args = {...}
	if #args == 0 then
		error("No Inputs: min()")
	end
	-- sillydev0050 fixed: old numeric-sign branch selected positive values as minima
	local best = args[1]
	for i=2,#args do
		if gn.lt(args[i],best) then
			best = args[i]
		end
	end
	return if type(best) == "buffer" then best else gn.fromNumber(best)
end

--[[
	Returns the number with the greatest absolute value in your list
]]
function gn.maxabs(...)
	local args = {...}
	if #args == 0 then
		error("No Inputs: maxabs()")
	end
	-- sillydev0050 fixed: consistent absolute-magnitude ordering and return type
	local best = args[1]
	for i=2,#args do
		local _,lBest,eBest = gn.totuple(best)
		local _,lNext,eNext = gn.totuple(args[i])
		if lBest < 0 or lNext < 0 then
			-- Keep the first NaN-like value stable, matching max/min's conservative behavior.
		elseif compareMagnitude(lNext,eNext,lBest,eBest) > 0 then
			best = args[i]
		end
	end
	return if type(best) == "buffer" then best else gn.fromNumber(best)
end

--[[
	Returns the number with the least absolute value in your list
]]
function gn.minabs(...)
	local args = {...}
	if #args == 0 then
		error("No Inputs: minabs()")
	end
	-- sillydev0050 fixed: numeric winners no longer leak out as raw Lua numbers
	local best = args[1]
	for i=2,#args do
		local _,lBest,eBest = gn.totuple(best)
		local _,lNext,eNext = gn.totuple(args[i])
		if lBest < 0 or lNext < 0 then
		elseif compareMagnitude(lNext,eNext,lBest,eBest) < 0 then
			best = args[i]
		end
	end
	return if type(best) == "buffer" then best else gn.fromNumber(best)
end

--[[
	n1 + n2
	Sum of n1 and n2
]]
function gn.add(n1,n2)
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: add(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: add(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: propagate NaN and make +inf + -inf undefined instead of zero
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	elseif l1 == math.huge and l2 == math.huge and s1 == -s2 then
		return gn.new(1,-1,1)
	end
	if s1 == 0 then
		buffer.writei8(buf,0,s2)
		buffer.writef64(buf,1,l2)
		buffer.writef64(buf,9,e2)
		return buf
	elseif s2 == 0 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	elseif s1 == -s2 and l1 == l2 and e1 == e2 then
		return buf
	elseif l1 >= 2 or l2 >= 2 then
		local l1s = if e1 > 0 then l1 else -l1
		local l2s = if e2 > 0 then l2 else -l2
		if l1s > l2s then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		elseif l1s < l2s then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		elseif e1 > e2 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		end
	elseif l1 == 0 and l2 == 0 then
		local n = s1 * e1 + s2 * e2
		if n == 0 then
			return buf
		elseif n == nil or type(n) ~= "number" then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,-1)
			buffer.writef64(buf,9,1)
			return buf
		else
			buffer.writei8(buf,0,math.sign(n))
			n = math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,math.log10(n))
				return buf
			else
				buffer.writef64(buf,9,n)
				return buf
			end
		end
	elseif l1 == 1 and l2 == 0 then
		local oomdif = e1 - math.log10(e2)
		if math.abs(oomdif) >= 16 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		end
		local n = s2 + s1 * math.pow(10,oomdif)
		buffer.writei8(buf,0,math.sign(n))
		local a = math.log10(e2 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 0 and l2 == 1 then
		local oomdif = e2 - math.log10(e1)
		if math.abs(oomdif) >= 16 then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		end
		local n = s1 + s2 * math.pow(10,oomdif)
		buffer.writei8(buf,0,math.sign(n))
		local a = math.log10(e1 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif e1 >= e2 then
		local oomdif = e1 - e2
		if oomdif >= 16 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			local n = s2 + s1 * 10 ^ oomdif
			buffer.writei8(buf,0,math.sign(n))
			local a = e2 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(buf,1,2)
				buffer.writef64(buf,9,math.log10(a))
				return buf
			elseif a < 10 then
				buffer.writef64(buf,9,10 ^ a)
				return buf
			else
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,a)
				return buf
			end
		end
	else
		local oomdif = e2 - e1
		if oomdif >= 16 then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		else
			local n = s1 + s2 * 10 ^ oomdif
			buffer.writei8(buf,0,math.sign(n))
			local a = e1 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(buf,1,2)
				buffer.writef64(buf,9,math.log10(a))
				return buf
			elseif a < 10 then
				buffer.writef64(buf,9,10 ^ a)
				return buf
			else
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,a)
				return buf
			end
		end
	end
end
--[[
	n1 - n2
	Difference of n1 and n2
]]
function gn.sub(n1,n2)
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: sub(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: sub(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: propagate NaN and make inf - inf undefined instead of zero
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	elseif l1 == math.huge and l2 == math.huge and s1 == s2 then
		return gn.new(1,-1,1)
	end
	if s1 == 0 then
		buffer.writei8(buf,0,-s2)
		buffer.writef64(buf,1,l2)
		buffer.writef64(buf,9,e2)
		return buf
	elseif s2 == 0 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	elseif s1 == -s2 and l1 == l2 and e1 == e2 then
		return buf
	elseif l1 >= 2 or l2 >= 2 then
		local l1s = if e1 > 0 then l1 else -l1
		local l2s = if e2 > 0 then l2 else -l2
		if l1s > l2s then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		elseif l1s < l2s then
			buffer.writei8(buf,0,-s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		elseif e1 > e2 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			buffer.writei8(buf,0,-s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		end
	elseif l1 == 0 and l2 == 0 then
		local n = s1 * e1 - s2 * e2
		if n == 0 then
			return buf
		elseif n == nil or type(n) ~= "number" then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,-1)
			buffer.writef64(buf,9,1)
			return buf
		else
			buffer.writei8(buf,0,math.sign(n))
			n = math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,math.log10(n))
				return buf
			else
				buffer.writef64(buf,9,n)
				return buf
			end
		end
	elseif l1 == 1 and l2 == 0 then
		local oomdif = e1 - math.log10(e2)
		if math.abs(oomdif) >= 16 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		end
		local n = s1 * math.pow(10,oomdif) - s2
		buffer.writei8(buf,0,math.sign(n))
		local a = math.log10(e2 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 0 and l2 == 1 then
		local oomdif = e2 - math.log10(e1)
		if math.abs(oomdif) >= 16 then
			buffer.writei8(buf,0,-s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		end
		local n = s1 - s2 * math.pow(10,oomdif)
		buffer.writei8(buf,0,math.sign(n))
		local a = math.log10(e1 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif e1 >= e2 then
		local oomdif = e1 - e2
		if oomdif >= 16 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			local n = s1 * 10 ^ oomdif - s2
			buffer.writei8(buf,0,math.sign(n))
			local a = e2 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(buf,1,2)
				buffer.writef64(buf,9,math.log10(a))
				return buf
			elseif a < 10 then
				buffer.writef64(buf,9,10 ^ a)
				return buf
			else
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,a)
				return buf
			end
		end
	else
		local oomdif = e2 - e1
		if oomdif >= 16 then
			buffer.writei8(buf,0,-s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		else
			local n = s1 - s2 * 10 ^ oomdif
			buffer.writei8(buf,0,math.sign(n))
			local a = e1 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(buf,1,2)
				buffer.writef64(buf,9,math.log10(a))
				return buf
			elseif a < 10 then
				buffer.writef64(buf,9,10 ^ a)
				return buf
			else
				buffer.writef64(buf,1,1)
				buffer.writef64(buf,9,a)
				return buf
			end
		end
	end
end
--[[
	n1 * n2
	Product of n1 and n2
]]
function gn.mul(n1,n2)
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: mul(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: mul(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: IEEE-like NaN/infinity handling for multiplication
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	elseif (s1 == 0 and l2 == math.huge) or (s2 == 0 and l1 == math.huge) then
		return gn.new(1,-1,1)
	elseif l1 == math.huge or l2 == math.huge then
		return gn.new(s1*s2,math.huge,1)
	end
	if s1 == 0 or s2 == 0 then
		return buf
	elseif l1 == 0 and l2 == 0 then
		local n = e1 * e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(n))
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	elseif l1 == l2 and e1 == -e2 then
		buffer.writei8(buf,0,s1*s2)
		buffer.writef64(buf,9,1)
		return buf
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		elseif l1 < l2 then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		elseif math.abs(e1) > math.abs(e2) then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,e2)
			return buf
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 + e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 + math.log10(e2)
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) + e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(buf,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l1)
				buffer.writef64(buf,9,e1)
				return buf
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s + e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e1s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e1s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e1s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e1s * a)
					return buf
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l2)
				buffer.writef64(buf,9,e2)
				return buf
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s + e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e2s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e2s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e2s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e2s * a)
					return buf
				end
			end
		end
	end
end
--[[
	n1 / n2
	Quotient of n1 and n2
]]
function gn.div(n1,n2)
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: div(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: div(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: NaN/infinity/zero-divisor handling before the optimized finite path
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	elseif s2 == 0 then
		if s1 == 0 then return gn.new(1,-1,1) end
		return gn.new(s1,math.huge,1)
	elseif l1 == math.huge and l2 == math.huge then
		return gn.new(1,-1,1)
	elseif l1 == math.huge then
		return gn.new(s1*s2,math.huge,1)
	elseif l2 == math.huge then
		return buffer.create(17)
	end
	if s1 == 0 or s2 == 0 then
		return buf
	elseif l1 == 0 and l2 == 0 then
		local n = e1 / e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	elseif l1 == l2 and e1 == e2 then
		buffer.writei8(buf,0,s1*s2)
		buffer.writef64(buf,9,1)
		return buf
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		elseif l1 < l2 then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,-e2)
			return buf
		elseif math.abs(e1) > math.abs(e2) then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,-e2)
			return buf
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(buf,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l1)
				buffer.writef64(buf,9,e1)
				return buf
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e1s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e1s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e1s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e1s * a)
					return buf
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l2)
				buffer.writef64(buf,9,-e2)
				return buf
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e2s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e2s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e2s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e2s * a)
					return buf
				end
			end
		end
	end
end
--[[
	n1 // n2 (similar to floor(n1 / n2))
	Integer Quotient of n1 and n2
]]
function gn.intdiv(n1,n2)
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: intdiv(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: intdiv(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: these were accidental globals in the original implementation
	local s,l,e
	-- sillydev0050 fixed: NaN/infinity/zero-divisor handling before the optimized finite path
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	elseif s2 == 0 then
		if s1 == 0 then return gn.new(1,-1,1) end
		return gn.new(s1,math.huge,1)
	elseif l1 == math.huge and l2 == math.huge then
		return gn.new(1,-1,1)
	elseif l1 == math.huge then
		return gn.new(s1*s2,math.huge,1)
	elseif l2 == math.huge then
		return buffer.create(17)
	end
	if s1 == 0 or s2 == 0 then
		s, l, e = 0, 0, 0
	elseif l1 == 0 and l2 == 0 then
		local n = e1 / e2
		s = s1 * s2 * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l1 == l2 and e1 == e2 then
		s = s1*s2
		l = 0
		e = 1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		s = s1*s2
		if l1 > l2 then
			l = l1
			e = e1
		elseif l1 < l2 then
			l = l2
			e = -e2
		elseif math.abs(e1) > math.abs(e2) then
			l = l1
			e = e1
		else
			l = l2
			e = -e2
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		s = s1 * s2
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				l = l1
				e = e1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e1s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e1s * 10 ^ a
					else
						l = 1
						e = e1s * a
					end
				else
					l = 2
					e = e1s * a
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				l = l2
				e = e2
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e2s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e2s * 10 ^ a
					else
						l = 1
						e = e2s * a
					end
				else
					l = 2
					e = e2s * a
				end
			end
		end
	end
	if s == 0 then
		return buf
	elseif s == 1 then
		if l == 0 then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,9,math.floor(e))
			return buf
		elseif e < 0 then
			return buf
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.floor(10^e)))
			return buf
		else
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,1,l)
			buffer.writef64(buf,9,e)
			return buf
		end
	elseif l == 0 then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,9,math.ceil(e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,1)
		buffer.writef64(buf,9,math.log10(math.ceil(10^e)))
		return buf
	else
		buffer.writei8(buf,0,-1)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,e)
		return buf
	end
end
--[[
	n1 % n2
	Modulus of n1 and n2
]]
function gn.mod(n1,n2)
	-- sillydev0050 fixed v1.1.1: the old implementation accidentally calculated and
	-- transformed the quotient instead of returning n1 - floor(n1 / n2) * n2.
	local s1,l1,e1 = gn.totuple(n1)
	local s2,l2,e2 = gn.totuple(n2)

	if l1 < 0 or l2 < 0 or s2 == 0 or l1 == math.huge then
		return gn.new(1,-1,1)
	end
	if s1 == 0 then
		return buffer.create(17)
	end
	if l2 == math.huge then
		return gn.createCheckless(s1,l1,e1)
	end

	-- sillydev0050 fixed v1.1.1: exact native fast path preserves Luau floor-modulo
	-- semantics, including negative dividends and divisors.
	if l1 == 0 and l2 == 0 then
		return gn.fromNumber((s1 * e1) % (s2 * e2))
	end

	local a = gn.createCheckless(s1,l1,e1)
	local b = gn.createCheckless(s2,l2,e2)
	local quotient = gn.floor(gn.div(a,b))
	return gn.sub(a,gn.mul(quotient,b))
end
--[[
	1 / n
	Reciprocal of n
]]
function gn.recip(n)
	local s,l,e = gn.totuple(n)
	local buf = buffer.create(17)
	if l < 0 then
		return gn.new(1,-1,1)
	elseif s == 0 then
		-- sillydev0050 fixed: reciprocal of zero is infinity instead of a sign-zero invalid buffer
		return gn.new(1,math.huge,1)
	elseif l == math.huge then
		-- sillydev0050 fixed: reciprocal of +/- infinity is zero
		return buffer.create(17)
	end
	buffer.writei8(buf,0,s)
	buffer.writef64(buf,1,l)
	buffer.writef64(buf,9, if l > 0 then -e else 1 / e)
	return buf
end

--[[
	|n|
	Absolute Value of n
]]
function gn.abs(n)
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: abs(), Input 1")
	end
	local buf = buffer.create(17)
	buffer.writei8(buf,0,math.abs(s))
	buffer.writef64(buf,1,l)
	buffer.writef64(buf,9,e)
	return buf
end
--[[
	-n
	Negated n
]]
function gn.neg(n)
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: neg(), Input 1")
	end
	local buf = buffer.create(17)
	buffer.writei8(buf,0,-s)
	buffer.writef64(buf,1,l)
	buffer.writef64(buf,9,e)
	return buf
end
--[[
	10^n
	Exponentiation of 10 and n
]]
function gn.pow10(n)
	-- sillydev0050 fixed: canonical special values for 10^NaN and 10^±Inf
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: pow10(), Input 1")
	end
	local buf = buffer.create(17)
	if l < 0 then
		return gn.new(1,-1,1)
	elseif l == math.huge then
		if s < 0 then return buf end
		return gn.new(1,math.huge,1)
	elseif l == 0 and e < 10 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,10^(s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end

--[[
	log10(n)
	Logarithm of n in base 10
]]
function gn.log10(n)
	-- sillydev0050 fixed: canonical native special values and log(1)=0
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: log10(), Input 1")
	end
	local buf = buffer.create(17)
	if l < 0 or s <= 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	elseif l == 0 and e == 1 then
		return buf
	elseif l == 0 then
		buffer.writef64(buf,9,math.log10(e))
		buffer.writei8(buf,0,math.sign(buffer.readf64(buf,9)))
		buffer.writef64(buf,9,math.abs(buffer.readf64(buf,9)))
		return buf
	else
		buffer.writei8(buf,0,math.sign(e))
		buffer.writef64(buf,1,l-1)
		buffer.writef64(buf,9,math.abs(e))
		return buf
	end
end

--[[
	log10(|n|)
	Logarithm of the Absolute Value of n in base 10
]]
function gn.abslog10(n)
	-- sillydev0050 fixed: canonical native special values and log(1)=0
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: abslog10(), Input 1")
	end
	local buf = buffer.create(17)
	if l < 0 or s == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	elseif l == 0 and e == 1 then
		return buf
	elseif l == 0 then
		buffer.writef64(buf,9,math.log10(e))
		buffer.writei8(buf,0,math.sign(buffer.readf64(buf,9)))
		buffer.writef64(buf,9,math.abs(buffer.readf64(buf,9)))
		return buf
	else
		buffer.writei8(buf,0,math.sign(e))
		buffer.writef64(buf,1,l-1)
		buffer.writef64(buf,9,math.abs(e))
		return buf
	end
end

--[[
	n1 ^ n2
	Exponentiation of n1 and n2
]]
function gn.pow(n1,n2)
	-- sillydev0050 fixed: canonicalize native NaN/Inf before the optimized finite path
	if type(n1) == "number" and (n1 ~= n1 or math.abs(n1) == math.huge) then n1 = gn.fromNumber(n1) end
	if type(n2) == "number" and (n2 ~= n2 or math.abs(n2) == math.huge) then n2 = gn.fromNumber(n2) end
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: pow(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: pow(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: NaN propagation, 0^0/0^negative, infinity, and negative-base parity
	if l1 < 0 or l2 < 0 then
		return gn.new(1,-1,1)
	end
	if s2 == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	end
	if s1 == 0 then
		if s2 < 0 then
			return gn.new(1,math.huge,1)
		end
		return buf
	end

	local resultSign = 1
	if s1 < 0 then
		-- Real-valued GammaNum cannot represent complex results.  For a negative base,
		-- require an exact layer-0 integer exponent so odd/even parity is knowable.
		if l2 ~= 0 or e2 ~= math.floor(e2) then
			return gn.new(1,-1,1)
		end
		local integerExponent = s2 * e2
		if math.abs(integerExponent) % 2 == 1 then
			resultSign = -1
		end
	end

	-- sillydev0050 fixed v1.1.1: preserve exact native results when both operands
	-- are ordinary layer-0 values. The logarithmic path can turn -8 into
	-- -7.999999999999999, which formats the same but breaks exact eq().
	if l1 == 0 and l2 == 0 then
		local nativeBase = s1 * e1
		local nativeExponent = s2 * e2
		local nativeResult = nativeBase ^ nativeExponent
		if nativeResult == nativeResult and math.abs(nativeResult) < math.huge and nativeResult ~= 0 then
			return gn.fromNumber(nativeResult)
		end
	end

	if l1 == math.huge then
		if s2 < 0 then
			return buf
		end
		return gn.new(resultSign,math.huge,1)
	end
	if l2 == math.huge then
		local magnitudeVsOne = compareMagnitude(l1,e1,0,1)
		if magnitudeVsOne == 0 then
			buffer.writei8(buf,0,1)
			buffer.writef64(buf,9,1)
			return buf
		elseif (magnitudeVsOne > 0 and s2 > 0) or (magnitudeVsOne < 0 and s2 < 0) then
			return gn.new(1,math.huge,1)
		else
			return buf
		end
	end
	if s1 == 1 and l1 == 0 and e1 == 1 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif s2 == 1 and l2 == 0 and e2 == 1 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	end
	--abslog10
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	--mul
	local s,l,e
	if l1 == 0 and l2 == 0 then
		local n = e1 * e2
		s = s1 * s2 * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l1 == l2 and e1 == -e2 then
		s = s1*s2
		l = 0
		e = 1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		s = s1*s2
		if l1 > l2 then
			l = l1
			e = e1
		elseif l1 < l2 then
			l = l2
			e = e2
		elseif math.abs(e1) > math.abs(e2) then
			l = l1
			e = e1
		else
			l = l2
			e = e2
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 + e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 + math.log10(e2)
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) + e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		s = s1 * s2
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				l = l1
				e = e1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s + e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e1s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e1s * 10 ^ a
					else
						l = 1
						e = e1s * a
					end
				else
					l = 2
					e = e1s * a
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				l = l2
				e = e2
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s + e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e2s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e2s * 10 ^ a
					else
						l = 1
						e = e2s * a
					end
				else
					l = 2
					e = e2s * a
				end
			end
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(buf,0,resultSign)
		buffer.writef64(buf,9,math.pow(10,s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,resultSign)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,resultSign)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end
--[[
	n1 ^ (1 / n2)
	n2'th Root of n1
]]
function gn.root(n1,n2)
	-- sillydev0050 fixed: canonicalize native NaN/Inf before the optimized finite path
	if type(n1) == "number" and (n1 ~= n1 or math.abs(n1) == math.huge) then n1 = gn.fromNumber(n1) end
	if type(n2) == "number" and (n2 ~= n2 or math.abs(n2) == math.huge) then n2 = gn.fromNumber(n2) end
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: root(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: root(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: root degree 0, NaN, zero/negative degree, and negative radicands
	if l1 < 0 or l2 < 0 or s2 == 0 then
		return gn.new(1,-1,1)
	end
	if s1 == 0 then
		if s2 < 0 then
			return gn.new(1,math.huge,1)
		end
		return buf
	end
	if s1 < 0 then
		if l2 ~= 0 or e2 ~= math.floor(e2) or math.abs(s2 * e2) % 2 ~= 1 then
			return gn.new(1,-1,1)
		end
		local positive = gn.root(gn.abs(n1), n2)
		return gn.neg(positive)
	end
	if l1 == math.huge then
		if s2 < 0 then return buf end
		return gn.new(1,math.huge,1)
	end
	if l2 == math.huge then
		-- Any positive finite x^(1/±Inf) tends to 1.
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	end
	if s1 == 1 and l1 == 0 and e1 == 1 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif s2 == 1 and l2 == 0 and e2 == 1 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	end
	--abslog10
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	--div
	local s,l,e
	if l1 == 0 and l2 == 0 then
		local n = e1 / e2
		s = s1 * s2 * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l1 == l2 and e1 == e2 then
		s = s1*s2
		l = 0
		e = 1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		s = s1*s2
		if l1 > l2 then
			l = l1
			e = e1
		elseif l1 < l2 then
			l = l2
			e = -e2
		elseif math.abs(e1) > math.abs(e2) then
			l = l1
			e = e1
		else
			l = l2
			e = -e2
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		s = s1 * s2
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				l = l1
				e = e1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e1s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e1s * 10 ^ a
					else
						l = 1
						e = e1s * a
					end
				else
					l = 2
					e = e1s * a
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				l = l2
				e = e2
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e2s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e2s * 10 ^ a
					else
						l = 1
						e = e2s * a
					end
				else
					l = 2
					e = e2s * a
				end
			end
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,math.pow(10,s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end
--[[
	n ^ 0.5
	Square Root of n
]]
function gn.sqrt(n)
	-- sillydev0050 fixed: canonicalize native NaN/Inf and reject negative real square roots
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: sqrt(), Input 1")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: this library is real-valued, so sqrt(negative) is NaN
	if l < 0 or s < 0 then
		return gn.new(1,-1,1)
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	end
	--checks
	if s == 0 then
		return buf
	elseif s == 1 and l == 0 and e == 1 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	end
	--abslog10
	if l == 0 then
		e = math.log10(e)
		s = math.sign(e)
		e = math.abs(e)
	else
		s = math.sign(e)
		l -= 1
		e = math.abs(e)
	end
	--div
	if l == 0 then
		local n = e / 2
		s = s * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l == 1 then
		local a = e - log10_2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,math.pow(10,s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end
--[[
	2 ^ n
	Exponentiation of 2 and n
]]
function gn.pow2(n)
	-- sillydev0050 fixed: propagate NaN and map ±Inf exponents correctly
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: pow2(), Input 1")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: exp-like functions are positive; -Inf -> 0, +Inf -> Inf
	if l < 0 then
		return gn.new(1,-1,1)
	elseif l == math.huge then
		if s < 0 then return buf end
		return gn.new(1,math.huge,1)
	end
	--checks
	if s == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif s == 1 and l == 0 and e == 1 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,2)
		return buf
	end
	--mul
	if l == 0 then
		local n = log10_2 * e
		s = s * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l == 1 then
		local a = e + log10_2x2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,math.pow(10,s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end

--[[
	e ^ n
	Exponentiation of e and n (e = ~2.71828)
]]
function gn.exp(n)
	-- sillydev0050 fixed: propagate NaN and map ±Inf exponents correctly
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: exp(), Input 1")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: exp-like functions are positive; -Inf -> 0, +Inf -> Inf
	if l < 0 then
		return gn.new(1,-1,1)
	elseif l == math.huge then
		if s < 0 then return buf end
		return gn.new(1,math.huge,1)
	end
	--checks
	if s == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif s == 1 and l == 0 and e == 1 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,euler)
		return buf
	end
	--mul
	if l == 0 then
		local n = ln_10 * e
		s = s * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l == 1 then
		local a = e + ln_10x2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,math.pow(10,s*e))
		return buf
	elseif e < 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	else
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,l+1)
		buffer.writef64(buf,9,s*e)
		return buf
	end
end

--[[
	Logarithm of n1 in base n2
]]
function gn.log(n1,n2)
	-- sillydev0050 fixed: canonicalize native NaN/Inf before domain checks
	if type(n1) == "number" and (n1 ~= n1 or math.abs(n1) == math.huge) then n1 = gn.fromNumber(n1) end
	if type(n2) == "number" and (n2 ~= n2 or math.abs(n2) == math.huge) then n2 = gn.fromNumber(n2) end
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: log(), Input 1")
	end
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: log(), Input 2")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: logs require x>0, base>0, and base~=1; NaN propagates
	if l1 < 0 or l2 < 0 or s1 <= 0 or s2 <= 0 or (l2 == 0 and e2 == 1) then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l2 == math.huge then
		-- sillydev0050 fixed: finite logarithm in an infinite base tends to zero; Inf/Inf is undefined
		if l1 == math.huge then return gn.new(1,-1,1) end
		return buf
	elseif l1 == math.huge then
		-- log_base(+Inf) is signed by whether base is above or below 1
		local baseVsOne = compareMagnitude(l2,e2,0,1)
		return gn.new(if baseVsOne > 0 then 1 else -1,math.huge,1)
	elseif l1 == 0 and l2 == 0 then
		local n = math.log10(e1) / math.log10(e2)
		if n == 0 then
			return buf
		end
		buffer.writei8(buf,0,math.sign(n))
		if math.abs(n) >= 1e10 or math.abs(n) <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.abs(n)))
			return buf
		else
			buffer.writef64(buf,9,math.abs(n))
			return buf
		end
	end
	--log10s
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	if l2 == 0 then
		e2 = math.log10(e2)
		s2 = math.sign(e2)
		e2 = math.abs(e2)
	else
		s2 = math.sign(e2)
		l2 -= 1
		e2 = math.abs(e2)
	end
	--div
	if l1 == 0 and l2 == 0 then
		local n = e1 / e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	elseif l1 == l2 and e1 == e2 then
		buffer.writei8(buf,0,s1*s2)
		buffer.writef64(buf,9,1)
		return buf
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		elseif l1 < l2 then
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,-e2)
			return buf
		elseif math.abs(e1) > math.abs(e2) then
			buffer.writei8(buf,0,s1)
			buffer.writef64(buf,1,l1)
			buffer.writef64(buf,9,e1)
			return buf
		else
			buffer.writei8(buf,0,s2)
			buffer.writef64(buf,1,l2)
			buffer.writef64(buf,9,-e2)
			return buf
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		buffer.writei8(buf,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(buf,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l1)
				buffer.writef64(buf,9,e1)
				return buf
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e1s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e1s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e1s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e1s * a)
					return buf
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(buf,1,l2)
				buffer.writef64(buf,9,-e2)
				return buf
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(buf,1,3)
					buffer.writef64(buf,9,e2s * math.log10(a))
					return buf
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(buf,9,e2s * 10 ^ a)
						return buf
					end
					buffer.writef64(buf,1,1)
					buffer.writef64(buf,9,e2s * a)
					return buf
				else
					buffer.writef64(buf,1,2)
					buffer.writef64(buf,9,e2s * a)
					return buf
				end
			end
		end
	end
end

--[[
	Logarithm of n in base 2
]]
function gn.log2(n)
	-- sillydev0050 fixed: canonicalize native NaN/Inf before domain checks
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: log2(), Input 1")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: NaN/negative/zero domain handling and canonical log(1)=0
	if l < 0 or s <= 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	elseif l == 0 then
		local n = math.log10(e) / log10_2
		if n == 0 then return buf end
		buffer.writei8(buf,0,math.sign(n))
		if math.abs(n) >= 1e10 or math.abs(n) <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.abs(n)))
			return buf
		else
			buffer.writef64(buf,9,math.abs(n))
			return buf
		end
	end
	--log10s
	if l == 0 then
		e = math.log10(e)
		s = math.sign(e)
		e = math.abs(e)
	else
		s = math.sign(e)
		l -= 1
		e = math.abs(e)
	end
	--div
	if l == 0 then
		local n = e / log10_2
		buffer.writei8(buf,0,s * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	elseif l == 1 then
		local a = e - log10_2x2
		buffer.writei8(buf,0,s * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	else
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,-e)
		return buf
	end
end

--[[
	Logarithm of n in base e (~2.71828)
]]
function gn.ln(n)
	-- sillydev0050 fixed: canonicalize native NaN/Inf before domain checks
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: ln(), Input 1")
	end
	local buf = buffer.create(17)
	-- sillydev0050 fixed: NaN/negative/zero domain handling and canonical log(1)=0
	if l < 0 or s <= 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,1,-1)
		buffer.writef64(buf,9,1)
		return buf
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	elseif l == 0 then
		local n = math.log10(e) / ln_10
		if n == 0 then return buf end
		buffer.writei8(buf,0,math.sign(n))
		if math.abs(n) >= 1e10 or math.abs(n) <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(math.abs(n)))
			return buf
		else
			buffer.writef64(buf,9,math.abs(n))
			return buf
		end
	end
	--log10s
	if l == 0 then
		e = math.log10(e)
		s = math.sign(e)
		e = math.abs(e)
	else
		s = math.sign(e)
		l -= 1
		e = math.abs(e)
	end
	--div
	if l == 0 then
		local n = e / ln_10
		buffer.writei8(buf,0,s * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,math.log10(n))
			return buf
		else
			buffer.writef64(buf,9,n)
			return buf
		end
	elseif l == 1 then
		local a = e - ln_10x2
		buffer.writei8(buf,0,s * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(buf,1,2)
			buffer.writef64(buf,9,math.log10(a))
			return buf
		elseif a < 10 then
			buffer.writef64(buf,9,10 ^ a)
			return buf
		else
			buffer.writef64(buf,1,1)
			buffer.writef64(buf,9,a)
			return buf
		end
	else
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,-e)
		return buf
	end
end

--[[
	n1↑↑n2 (n2 must be an integer)
	Tetration of n1 and n2
]]
function gn.tetr(n1,n2)
	-- sillydev0050 fixed: enforce documented integer height and handle negative/special bases through pow()
	if type(n1) == "number" and (n1 ~= n1 or math.abs(n1) == math.huge) then n1 = gn.fromNumber(n1) end
	local s1,l1,e1,s2,l2,e2
	if type(n1) == "buffer" then
		s1, l1, e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	elseif type(n1) == "number" then
		if n1 == 0 then
			s1, l1, e1 = 0, 0, 0
		elseif n1 == nil then
			s1, l1, e1 = 1, -1, 1
		else
			s1, n1 = math.sign(n1), math.abs(n1)
			if n1 >= 1e10 or n1 <= 1e-10 then
				l1, e1 = 1, math.log10(n1)
			else
				l1, e1 = 0, n1
			end
		end
	else
		error("Wrong Type: tetr(), Input 1")
	end
	s2 = s1
	l2 = l1
	e2 = e1
	if type(n2) ~= "number" then
		error("Wrong Type: tetr(), Input 2")
	end
	local buf = buffer.create(17)
	if n2 ~= n2 or math.abs(n2) == math.huge or n2 ~= math.floor(n2) or n2 < 0 then
		return gn.new(1,-1,1)
	end
	if l1 < 0 then return gn.new(1,-1,1) end
	if n2 == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	end
	if s1 <= 0 or l1 == math.huge then
		-- sillydev0050 fixed v1.1.1: native inputs were converted to abs() during tuple
		-- extraction, so cloning n1 here turned -1 into +1. Rebuild from the tuple.
		local baseValue = gn.createCheckless(s1,l1,e1)
		if s1 == -1 and l1 == 0 and e1 == 1 then return baseValue end
		local result = gn.clone(baseValue)
		for _=2,n2 do
			result = gn.pow(baseValue,result)
			if gn.isNaN(result) then return result end
			if gn.isInf(result) and s1 > 0 then return result end
		end
		return result
	end
	--checks
	if n2 <= 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif n2 == 1 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	elseif s1 == 0 then
		return buf
	elseif (s1 == 1 and l1 == 0 and e1 == 1) or s2 == 0 then
		buffer.writei8(buf,0,1)
		buffer.writef64(buf,9,1)
		return buf
	elseif s2 == 1 and l2 == 0 and e2 == 1 then
		buffer.writei8(buf,0,s1)
		buffer.writef64(buf,1,l1)
		buffer.writef64(buf,9,e1)
		return buf
	end
	--abslog10
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	local s,l,e
	for i=1,n2-1 do
		if l1 == 0 and l2 == 0 then
			local n = e1 * e2
			s = s1 * s2 * math.sign(n)
			if n >= 1e10 or n <= 1e-10 then
				l = 1
				e = math.log10(n)
			else
				l = 0
				e = n
			end
		elseif l1 == l2 and e1 == -e2 then
			s = s1*s2
			l = 0
			e = 1
		elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
			s = s1*s2
			if l1 > l2 then
				l = l1
				e = e1
			elseif l1 < l2 then
				s2 = 1
				l2 += n2-i
				e2 *= s
				break
			elseif math.abs(e1) > math.abs(e2) then
				l = l1
				e = e1
			else
				s2 = 1
				l2 += n2-i
				e2 *= s
				break
			end
		elseif l1 == 1 and l2 == 1 then
			local a = e1 + e2
			s = s1 * s2 * math.sign(a)
			if a >= 1e10 then
				l = 2
				e = math.log10(a)
			elseif a < 10 then
				l = 0
				e = 10 ^ a
			else
				l = 1
				e = a
			end
		elseif l1 == 1 and l2 == 0 then
			local a = e1 + math.log10(e2)
			s = s1 * s2 * math.sign(a)
			if a >= 1e10 then
				l = 2
				e = math.log10(a)
			elseif a < 10 then
				l = 0
				e = 10 ^ a
			else
				l = 1
				e = a
			end
		elseif l1 == 0 and l2 == 1 then
			local a = math.log10(e1) + e2
			s = s1 * s2 * math.sign(a)
			if a >= 1e10 then
				l = 2
				e = math.log10(a)
			elseif a < 10 then
				l = 0
				e = 10 ^ a
			else
				l = 1
				e = a
			end
		else
			local fe1 = e1
			local fe2 = e2
			if l1 == 1 then
				fe1 = math.sign(e1) * math.log10(math.abs(e1))
			elseif l2 == 1 then
				fe2 = math.sign(e2) * math.log10(math.abs(e2))
			end
			s = s1 * s2
			local e1s = math.sign(fe1)
			local e2s = math.sign(fe2)
			local e1a = math.abs(fe1)
			local e2a = math.abs(fe2)
			if e1a >= e2a then
				local oomdif = e1a - e2a
				if oomdif >= 16 then
					l = l1
					e = e1
				else
					local a = math.abs(e2a + math.log10(math.abs(e2s + e1s * 10 ^ oomdif)))
					if a >= 1e10 then
						l = 3
						e = e1s * math.log10(a)
					elseif a < 10 then
						a = 10 ^ a
						if a < 10 then
							e = e1s * 10 ^ a
						else
							l = 1
							e = e1s * a
						end
					else
						l = 2
						e = e1s * a
					end
				end
			else
				local oomdif = e2a - e1a
				if oomdif >= 16 then
					l = l2
					e = e2
				else
					local a = math.abs(e1a + math.log10(math.abs(e1s + e2s * 10 ^ oomdif)))
					if a >= 1e10 then
						l = 3
						e = e2s * math.log10(a)
					elseif a < 10 then
						a = 10 ^ a
						if a < 10 then
							e = e2s * 10 ^ a
						else
							l = 1
							e = e2s * a
						end
					else
						l = 2
						e = e2s * a
					end
				end
			end
		end
		--pow10
		if l == 0 and e < 10 then
			s2 = 1
			l2 = 0
			e2 = math.pow(10,s*e)
		elseif e < 0 then
			s2 = 1
			l2 = 0
			e2 = 1
		else
			s2 = 1
			l2 = l+1
			e2 = s*e
		end
	end
	buffer.writei8(buf,0,s2)
	buffer.writef64(buf,1,l2)
	buffer.writef64(buf,9,e2)
	return buf
end
--[[
	n1 += n2
	Sets n1 to Sum of n1 and n2
]]
function gn.addeq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: addeq(), Input 1")
	end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: addeq(), Input 2")
	end
	-- sillydev0050 fixed: keep the fast finite path, delegate only special values to add()
	if l1 < 0 or l2 < 0 or l1 == math.huge or l2 == math.huge then
		local special = gn.add(n1,n2)
		buffer.copy(n1,0,special,0,17)
		return n1
	end
	if s1 == 0 then
		buffer.writei8(n1,0,s2)
		buffer.writef64(n1,1,l2)
		buffer.writef64(n1,9,e2)
		return n1
	elseif s2 == 0 then
		return n1
	elseif s1 == -s2 and l1 == l2 and e1 == e2 then
		buffer.writei8(n1,0,0)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,0)
		return n1
	elseif l1 >= 2 or l2 >= 2 then
		local l1s = if e1 > 0 then l1 else -l1
		local l2s = if e2 > 0 then l2 else -l2
		if l1s > l2s then
			return n1
		elseif l1s < l2s then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		elseif e1 > e2 then
			return n1
		else
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		end
	elseif l1 == 0 and l2 == 0 then
		local n = s1 * e1 + s2 * e2
		if n == 0 then
			buffer.writei8(n1,0,0)
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,0)
			return n1
		elseif n == nil or type(n) ~= "number" then
			buffer.writei8(n1,0,1)
			buffer.writef64(n1,1,-1)
			buffer.writef64(n1,9,1)
			return n1
		else
			buffer.writei8(n1,0,math.sign(n))
			n = math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,math.log10(n))
				return n1
			else
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,n)
				return n1
			end
		end
	elseif l1 == 1 and l2 == 0 then
		local oomdif = e1 - math.log10(e2)
		if math.abs(oomdif) >= 16 then
			return n1
		end
		local n = s2 + s1 * math.pow(10,oomdif)
		buffer.writei8(n1,0,math.sign(n))
		local a = math.log10(e2 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 0 and l2 == 1 then
		local oomdif = e2 - math.log10(e1)
		if math.abs(oomdif) >= 16 then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		end
		local n = s1 + s2 * math.pow(10,oomdif)
		buffer.writei8(n1,0,math.sign(n))
		local a = math.log10(e1 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif e1 >= e2 then
		local oomdif = e1 - e2
		if oomdif >= 16 then
			return n1
		else
			local n = s2 + s1 * 10 ^ oomdif
			buffer.writei8(n1,0,math.sign(n))
			local a = e2 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(n1,1,2)
				buffer.writef64(n1,9,math.log10(a))
				return n1
			elseif a < 10 then
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,10 ^ a)
				return n1
			else
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,a)
				return n1
			end
		end
	else
		local oomdif = e2 - e1
		if oomdif >= 16 then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		else
			local n = s1 + s2 * 10 ^ oomdif
			buffer.writei8(n1,0,math.sign(n))
			local a = e1 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(n1,1,2)
				buffer.writef64(n1,9,math.log10(a))
				return n1
			elseif a < 10 then
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,10 ^ a)
				return n1
			else
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,a)
				return n1
			end
		end
	end
end
--[[
	n1 -= n2
	Sets n1 to Difference of n1 and n2
]]
function gn.subeq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: subeq(), Input 1")
	end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: subeq(), Input 2")
	end
	-- sillydev0050 fixed: keep the fast finite path, delegate only special values to sub()
	if l1 < 0 or l2 < 0 or l1 == math.huge or l2 == math.huge then
		local special = gn.sub(n1,n2)
		buffer.copy(n1,0,special,0,17)
		return n1
	end
	if s1 == 0 then
		buffer.writei8(n1,0,-s2)
		buffer.writef64(n1,1,l2)
		buffer.writef64(n1,9,e2)
		return n1
	elseif s2 == 0 then
		return n1
	elseif s1 == -s2 and l1 == l2 and e1 == e2 then
		buffer.writei8(n1,0,0)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,0)
		return n1
	elseif l1 >= 2 or l2 >= 2 then
		local l1s = if e1 > 0 then l1 else -l1
		local l2s = if e2 > 0 then l2 else -l2
		if l1s > l2s then
			return n1
		elseif l1s < l2s then
			buffer.writei8(n1,0,-s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		elseif e1 > e2 then
			return n1
		else
			buffer.writei8(n1,0,-s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		end
	elseif l1 == 0 and l2 == 0 then
		local n = s1 * e1 - s2 * e2
		if n == 0 then
			buffer.writei8(n1,0,0)
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,0)
			return n1
		elseif n == nil or type(n) ~= "number" then
			buffer.writei8(n1,0,1)
			buffer.writef64(n1,1,-1)
			buffer.writef64(n1,9,1)
			return n1
		else
			buffer.writei8(n1,0,math.sign(n))
			n = math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,math.log10(n))
				return n1
			else
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,n)
				return n1
			end
		end
	elseif l1 == 1 and l2 == 0 then
		local oomdif = e1 - math.log10(e2)
		if math.abs(oomdif) >= 16 then
			return n1
		end
		local n = s1 * math.pow(10,oomdif) - s2
		buffer.writei8(n1,0,math.sign(n))
		local a = math.log10(e2 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 0 and l2 == 1 then
		local oomdif = math.log10(e1) - e2
		if math.abs(oomdif) >= 16 then
			buffer.writei8(n1,0,-s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		end
		local n = s1 + s2 * math.pow(10,oomdif)
		buffer.writei8(n1,0,math.sign(n))
		local a = math.log10(e1 * math.abs(n))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif e1 >= e2 then
		local oomdif = e1 - e2
		if oomdif >= 16 then
			return n1
		else
			local n = s1 * 10 ^ oomdif - s2
			buffer.writei8(n1,0,math.sign(n))
			local a = e2 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(n1,1,2)
				buffer.writef64(n1,9,math.log10(a))
				return n1
			elseif a < 10 then
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,10 ^ a)
				return n1
			else
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,a)
				return n1
			end
		end
	else
		local oomdif = e2 - e1
		if oomdif >= 16 then
			buffer.writei8(n1,0,-s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		else
			local n = s1 - s2 * 10 ^ oomdif
			buffer.writei8(n1,0,math.sign(n))
			local a = e1 + math.log10(math.abs(n))
			if a >= 1e10 then
				buffer.writef64(n1,1,2)
				buffer.writef64(n1,9,math.log10(a))
				return n1
			elseif a < 10 then
				buffer.writef64(n1,1,0)
				buffer.writef64(n1,9,10 ^ a)
				return n1
			else
				buffer.writef64(n1,1,1)
				buffer.writef64(n1,9,a)
				return n1
			end
		end
	end
end
--[[
	n1 *= n2
	Sets n1 to Product of n1 and n2
]]
function gn.muleq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: muleq(), Input 1")
	end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: muleq(), Input 2")
	end
	-- sillydev0050 fixed: keep the fast finite path, delegate only special values to mul()
	if l1 < 0 or l2 < 0 or l1 == math.huge or l2 == math.huge then
		local special = gn.mul(n1,n2)
		buffer.copy(n1,0,special,0,17)
		return n1
	end
	if s1 == 0 or s2 == 0 then
		return n1
	elseif l1 == 0 and l2 == 0 then
		local n = e1 * e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(n))
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,math.log10(n))
			return n1
		else
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,n)
			return n1
		end
	elseif l1 == l2 and e1 == -e2 then
		buffer.writei8(n1,0,s1*s2)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,1)
		return n1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			return n1
		elseif l1 < l2 then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		elseif math.abs(e1) > math.abs(e2) then
			return n1
		else
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,e2)
			return n1
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 + e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 + math.log10(e2)
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) + e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(n1,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l1)
				buffer.writef64(n1,9,e1)
				return n1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s + e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e1s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e1s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e1s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e1s * a)
					return n1
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l2)
				buffer.writef64(n1,9,e2)
				return n1
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s + e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e2s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e2s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e2s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e2s * a)
					return n1
				end
			end
		end
	end
end
--[[
	n1 /= n2
	Sets n1 to Quotient of n1 and n2
]]
function gn.diveq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: diveq(), Input 1")
	end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: diveq(), Input 2")
	end
	-- sillydev0050 fixed: preserve the optimized path while handling NaN/infinity/zero divisors correctly
	if l1 < 0 or l2 < 0 then
		buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1); return n1
	elseif s2 == 0 then
		if s1 == 0 then
			buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1)
		else
			buffer.writei8(n1,0,s1); buffer.writef64(n1,1,math.huge); buffer.writef64(n1,9,1)
		end
		return n1
	elseif l1 == math.huge and l2 == math.huge then
		buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1); return n1
	elseif l1 == math.huge then
		buffer.writei8(n1,0,s1*s2); buffer.writef64(n1,1,math.huge); buffer.writef64(n1,9,1); return n1
	elseif l2 == math.huge then
		buffer.writei8(n1,0,0); buffer.writef64(n1,1,0); buffer.writef64(n1,9,0); return n1
	end
	if s1 == 0 or s2 == 0 then
		return n1
	elseif l1 == 0 and l2 == 0 then
		local n = e1 / e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,math.log10(n))
			return n1
		else
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,n)
			return n1
		end
	elseif l1 == l2 and e1 == e2 then
		buffer.writei8(n1,0,s1*s2)
		buffer.writef64(n1,9,1)
		return n1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			return n1
		elseif l1 < l2 then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,-e2)
			return n1
		elseif math.abs(e1) > math.abs(e2) then
			return n1
		else
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,-e2)
			return n1
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(n1,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l1)
				buffer.writef64(n1,9,e1)
				return n1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e1s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e1s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e1s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e1s * a)
					return n1
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l2)
				buffer.writef64(n1,9,-e2)
				return n1
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e2s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e2s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e2s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e2s * a)
					return n1
				end
			end
		end
	end
end
--[[
	n1 //= n2 (similar to floor(n1 / n2))
	Sets n1 to Integer Quotient of n1 and n2
]]
function gn.intdiveq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: intdiveq(), Input 1")
	end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: intdiveq(), Input 2")
	end
	-- sillydev0050 fixed: integer division edge cases now match div() instead of becoming zero
	if l1 < 0 or l2 < 0 then
		buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1); return n1
	elseif s2 == 0 then
		if s1 == 0 then
			buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1)
		else
			buffer.writei8(n1,0,s1); buffer.writef64(n1,1,math.huge); buffer.writef64(n1,9,1)
		end
		return n1
	elseif l1 == math.huge and l2 == math.huge then
		buffer.writei8(n1,0,1); buffer.writef64(n1,1,-1); buffer.writef64(n1,9,1); return n1
	elseif l1 == math.huge then
		buffer.writei8(n1,0,s1*s2); buffer.writef64(n1,1,math.huge); buffer.writef64(n1,9,1); return n1
	elseif l2 == math.huge then
		buffer.writei8(n1,0,0); buffer.writef64(n1,1,0); buffer.writef64(n1,9,0); return n1
	end
	local s,l,e
	if s1 == 0 or s2 == 0 then
		s, l, e = 0, 0, 0
	elseif l1 == 0 and l2 == 0 then
		local n = e1 / e2
		s = s1 * s2 * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l1 == l2 and e1 == e2 then
		s = s1*s2
		l = 0
		e = 1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		s = s1*s2
		if l1 > l2 then
			l = l1
			e = e1
		elseif l1 < l2 then
			l = l2
			e = -e2
		elseif math.abs(e1) > math.abs(e2) then
			l = l1
			e = e1
		else
			l = l2
			e = -e2
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		s = s1 * s2
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				l = l1
				e = e1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e1s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e1s * 10 ^ a
					else
						l = 1
						e = e1s * a
					end
				else
					l = 2
					e = e1s * a
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				l = l2
				e = e2
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e2s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e2s * 10 ^ a
					else
						l = 1
						e = e2s * a
					end
				else
					l = 2
					e = e2s * a
				end
			end
		end
	end
	if s == 0 then
		buffer.writei8(n1,0,0)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,0)
		return n1
	elseif s == 1 then
		if l == 0 then
			buffer.writei8(n1,0,1)
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,math.floor(e))
			return n1
		elseif e < 0 then
			buffer.writei8(n1,0,0)
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,0)
			return n1
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(n1,0,1)
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,math.log10(math.floor(10^e)))
			return n1
		else
			buffer.writei8(n1,0,1)
			buffer.writef64(n1,1,l)
			buffer.writef64(n1,9,e)
			return n1
		end
	elseif l == 0 then
		buffer.writei8(n1,0,-1)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,math.ceil(e))
		return n1
	elseif e < 0 then
		buffer.writei8(n1,0,-1)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,1)
		return n1
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(n1,0,-1)
		buffer.writef64(n1,1,1)
		buffer.writef64(n1,9,math.log10(math.ceil(10^e)))
		return n1
	else
		buffer.writei8(n1,0,-1)
		buffer.writef64(n1,1,l)
		buffer.writef64(n1,9,e)
		return n1
	end
end
--[[
	n1 ^= n2
	Sets n1 to Exponentiation of n1 and n2
]]
function gn.poweq(n1,n2)
	-- sillydev0050 fixed v1.1.1: keep one exponentiation implementation.
	-- The old in-place copy duplicated gn.pow() and drifted out of sync with its fixes.
	if type(n1) ~= "buffer" then
		error("Wrong Type: poweq(), Input 1")
	end
	local result = gn.pow(n1,n2)
	buffer.copy(n1,0,result,0,17)
	return n1
end
--[[
	n1 ^= n2
	Sets n1 to Exponentiation of n1 and n2
]]
function gn.rooteq(n1,n2)
	-- sillydev0050 fixed: edge cases delegate to corrected pure root() while finite positive hot path stays in-place
	if type(n1) ~= "buffer" then
		error("Wrong Type: rooteq(), Input 1")
	end
	if type(n2) == "number" and (n2 ~= n2 or math.abs(n2) == math.huge) then n2 = gn.fromNumber(n2) end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: rooteq(), Input 2")
	end
	if s1 <= 0 or l1 < 0 or l1 == math.huge or l2 < 0 or l2 == math.huge or s2 == 0 then
		local fixed = gn.root(n1,n2)
		buffer.copy(n1,0,fixed,0,17)
		return n1
	end
	--checks
	if s1 == 0 then
		return n1
	elseif (s1 == 1 and l1 == 0 and e1 == 1) then
		return n1
	elseif s2 == 0 then
		buffer.writei8(n1,0,1)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,1)
		return n1
	elseif s2 == 1 and l2 == 0 and e2 == 1 then
		return n1
	end
	--abslog10
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	--div
	local s,l,e
	if l1 == 0 and l2 == 0 then
		local n = e1 / e2
		s = s1 * s2 * math.sign(n)
		if n >= 1e10 or n <= 1e-10 then
			l = 1
			e = math.log10(n)
		else
			l = 0
			e = n
		end
	elseif l1 == l2 and e1 == e2 then
		s = s1*s2
		l = 0
		e = 1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		s = s1*s2
		if l1 > l2 then
			l = l1
			e = e1
		elseif l1 < l2 then
			l = l2
			e = -e2
		elseif math.abs(e1) > math.abs(e2) then
			l = l1
			e = e1
		else
			l = l2
			e = -e2
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		s = s1 * s2 * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		s = s1 * s2
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				l = l1
				e = e1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e1s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e1s * 10 ^ a
					else
						l = 1
						e = e1s * a
					end
				else
					l = 2
					e = e1s * a
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				l = l2
				e = e2
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					l = 3
					e = e2s * math.log10(a)
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						e = e2s * 10 ^ a
					else
						l = 1
						e = e2s * a
					end
				else
					l = 2
					e = e2s * a
				end
			end
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(n1,0,1)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,math.pow(10,s*e))
		return n1
	elseif e < 0 then
		buffer.writei8(n1,0,1)
		buffer.writef64(n1,1,0)
		buffer.writef64(n1,9,1)
		return n1
	else
		buffer.writei8(n1,0,1)
		buffer.writef64(n1,1,l+1)
		buffer.writef64(n1,9,s*e)
		return n1
	end
end

--[[
	n ^= 0.5
	Sets n to Square Root of n
]]
function gn.sqrteq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: sqrteq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: negative/NaN/Inf semantics match sqrt()
	if s < 0 or l < 0 or l == math.huge then
		local fixed = gn.sqrt(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	--checks
	if s == 0 or (s == 1 and l == 0 and e == 1) then
		return n
	end
	--abslog10
	if l == 0 then
		e = math.log10(e)
		s = math.sign(e)
		e = math.abs(e)
	else
		s = math.sign(e)
		l -= 1
		e = math.abs(e)
	end
	--div
	if l == 0 then
		-- sillydev0050 fixed: do not shadow the mutable GammaNum buffer parameter
		local scaled = e / 2
		s = s * math.sign(scaled)
		if scaled >= 1e10 or scaled <= 1e-10 then
			l = 1
			e = math.log10(scaled)
		else
			l = 0
			e = scaled
		end
	elseif l == 1 then
		local a = e - log10_2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,math.pow(10,s*e))
		return n
	elseif e < 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,1)
		return n
	else
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,l+1)
		buffer.writef64(n,9,s*e)
		return n
	end
end

--[[
	n = 2 ^ n
	Sets n to Exponentiation of 2 and n
]]
function gn.pow2eq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: pow2eq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: special-value behavior mirrors pow2()
	if l < 0 or l == math.huge then
		local fixed = gn.pow2(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	--checks
	if s == 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,9,1)
		return n
	elseif s == 1 and l == 0 and e == 1 then
		buffer.writef64(n,9,2)
		return n
	end
	--mul
	if l == 0 then
		-- sillydev0050 fixed: do not shadow the mutable GammaNum buffer parameter
		local scaled = log10_2 * e
		s = s * math.sign(scaled)
		if scaled >= 1e10 or scaled <= 1e-10 then
			l = 1
			e = math.log10(scaled)
		else
			l = 0
			e = scaled
		end
	elseif l == 1 then
		local a = e + log10_2x2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,math.pow(10,s*e))
		return n
	elseif e < 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,1)
		return n
	else
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,l+1)
		buffer.writef64(n,9,s*e)
		return n
	end
end

--[[
	n = e ^ n
	Sets n to Exponentiation of e and n (e = ~2.71828)
]]
function gn.expeq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: expeq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: special-value behavior mirrors exp()
	if l < 0 or l == math.huge then
		local fixed = gn.exp(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	--checks
	if s == 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,9,1)
		return n
	elseif s == 1 and l == 0 and e == 1 then
		buffer.writef64(n,9,euler)
		return n
	end
	--mul
	if l == 0 then
		-- sillydev0050 fixed: do not shadow the mutable GammaNum buffer parameter
		local scaled = ln_10 * e
		s = s * math.sign(scaled)
		if scaled >= 1e10 or scaled <= 1e-10 then
			l = 1
			e = math.log10(scaled)
		else
			l = 0
			e = scaled
		end
	elseif l == 1 then
		local a = e + ln_10x2
		s = s * math.sign(a)
		if a >= 1e10 then
			l = 2
			e = math.log10(a)
		elseif a < 10 then
			l = 0
			e = 10 ^ a
		else
			l = 1
			e = a
		end
	end
	--pow10
	if l == 0 and e < 10 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,math.pow(10,s*e))
		return n
	elseif e < 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,1)
		return n
	else
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,l+1)
		buffer.writef64(n,9,s*e)
		return n
	end
end

--[[
	n = 10 ^ n
	Sets n to Exponentiation of 10 and n
]]
function gn.pow10eq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: pow10eq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: special-value behavior mirrors pow10()
	if l < 0 or l == math.huge then
		local fixed = gn.pow10(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	if l == 0 and e < 10 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,10^(s*e))
		return n
	elseif e < 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,1)
		return n
	else
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,l+1)
		buffer.writef64(n,9,s*e)
		return n
	end
end

--[[
	n = log10(n)
	Sets n to Logarithm of n in base 10
]]
function gn.log10eq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: log10eq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: invalid/special cases and log(1)=0 are canonical
	if l < 0 or l == math.huge or s <= 0 or (l == 0 and e == 1) then
		local fixed = gn.log10(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	if s <= 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,-1)
		buffer.writef64(n,9,1)
		return n
	elseif l == 0 then
		buffer.writef64(n,9,math.log10(e))
		buffer.writei8(n,0,math.sign(buffer.readf64(n,9)))
		buffer.writef64(n,9,math.abs(buffer.readf64(n,9)))
		return n
	else
		buffer.writei8(n,0,math.sign(e))
		buffer.writef64(n,1,l-1)
		buffer.writef64(n,9,math.abs(e))
		return n
	end
end

--[[
	n = log10(|n|)
	Sets n to Logarithm of the Absolute Value of n in base 10
]]
function gn.abslog10eq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: abslog10eq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	-- sillydev0050 fixed: invalid/special cases and log(1)=0 are canonical
	if l < 0 or l == math.huge or s == 0 or (l == 0 and e == 1) then
		local fixed = gn.abslog10(n)
		buffer.copy(n,0,fixed,0,17)
		return n
	end
	if s == 0 then
		buffer.writei8(n,0,1)
		buffer.writef64(n,1,-1)
		buffer.writef64(n,9,1)
		return n
	elseif l == 0 then
		buffer.writef64(n,9,math.log10(e))
		buffer.writei8(n,0,math.sign(buffer.readf64(n,9)))
		buffer.writef64(n,9,math.abs(buffer.readf64(n,9)))
		return n
	else
		buffer.writei8(n,0,math.sign(e))
		buffer.writef64(n,1,l-1)
		buffer.writef64(n,9,math.abs(e))
		return n
	end
end

--[[
	Sets n to Logarithm of n in base 2
]]
function gn.log2eq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: log2eq(), Input 1")
	end
	-- sillydev0050 fixed: original layer-0 branch shadowed `n` with a number then passed it to buffer.write*
	local fixed = gn.log2(n)
	buffer.copy(n,0,fixed,0,17)
	return n
end

--[[
	Sets n to Logarithm of n in base e (~2.71828)
]]
function gn.lneq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: lneq(), Input 1")
	end
	-- sillydev0050 fixed: original layer-0 branch shadowed `n` with a number then passed it to buffer.write*
	local fixed = gn.ln(n)
	buffer.copy(n,0,fixed,0,17)
	return n
end

--[[
	Sets n1 to Logarithm of n1 in base n2
]]
function gn.logeq(n1,n2)
	-- sillydev0050 fixed: corrected domain/special cases while preserving normal in-place path
	if type(n1) ~= "buffer" then
		error("Wrong Type: logeq(), Input 1")
	end
	if type(n2) == "number" and (n2 ~= n2 or math.abs(n2) == math.huge) then n2 = gn.fromNumber(n2) end
	local s1,l1,e1 = buffer.readi8(n1,0), buffer.readf64(n1,1), buffer.readf64(n1,9)
	local s2,l2,e2
	if type(n2) == "buffer" then
		s2, l2, e2 = buffer.readi8(n2,0), buffer.readf64(n2,1), buffer.readf64(n2,9)
	elseif type(n2) == "number" then
		if n2 == 0 then
			s2, l2, e2 = 0, 0, 0
		elseif n2 == nil then
			s2, l2, e2 = 1, -1, 1
		else
			s2, n2 = math.sign(n2), math.abs(n2)
			if n2 >= 1e10 or n2 <= 1e-10 then
				l2, e2 = 1, math.log10(n2)
			else
				l2, e2 = 0, n2
			end
		end
	else
		error("Wrong Type: logeq(), Input 2")
	end
	if l1 < 0 or l2 < 0 or l1 == math.huge or l2 == math.huge or s1 <= 0 or s2 <= 0 or (l2 == 0 and e2 == 1) or (l1 == 0 and e1 == 1) then
		local fixed = gn.log(n1,n2)
		buffer.copy(n1,0,fixed,0,17)
		return n1
	end
	--checks
	if s1 <= 0 or s2 <= 0 then
		buffer.writei8(n1,0,1)
		buffer.writef64(n1,1,-1)
		buffer.writef64(n1,9,1)
		return n1
	elseif l1 == 0 and l2 == 0 then
		local n = math.log10(e1) / math.log10(e2)
		buffer.writei8(n1,0,math.sign(n))
		if math.abs(n) >= 1e10 or math.abs(n) <= 1e-10 then
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,math.log10(math.abs(n)))
			return n1
		else
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,math.abs(n))
			return n1
		end
	end
	--log10s
	if l1 == 0 then
		e1 = math.log10(e1)
		s1 = math.sign(e1)
		e1 = math.abs(e1)
	else
		s1 = math.sign(e1)
		l1 -= 1
		e1 = math.abs(e1)
	end
	if l2 == 0 then
		e2 = math.log10(e2)
		s2 = math.sign(e2)
		e2 = math.abs(e2)
	else
		s2 = math.sign(e2)
		l2 -= 1
		e2 = math.abs(e2)
	end
	--div
	if l1 == 0 and l2 == 0 then
		local n = e1 / e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(n))
		n = math.abs(n)
		if n >= 1e10 or n <= 1e-10 then
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,math.log10(n))
			return n1
		else
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,n)
			return n1
		end
	elseif l1 == l2 and e1 == e2 then
		buffer.writei8(n1,0,s1*s2)
		buffer.writef64(n1,9,1)
		return n1
	elseif l1 >= 3 or l2 >= 3 or (l1 == 2 and l2 == 0) or (l2 == 2 and l1 == 0) then
		if l1 > l2 then
			buffer.writei8(n1,0,s1)
			buffer.writef64(n1,1,l1)
			buffer.writef64(n1,9,e1)
			return n1
		elseif l1 < l2 then
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,-e2)
			return n1
		elseif math.abs(e1) > math.abs(e2) then
			buffer.writei8(n1,0,s1)
			buffer.writef64(n1,1,l1)
			buffer.writef64(n1,9,e1)
			return n1
		else
			buffer.writei8(n1,0,s2)
			buffer.writef64(n1,1,l2)
			buffer.writef64(n1,9,-e2)
			return n1
		end
	elseif l1 == 1 and l2 == 1 then
		local a = e1 - e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 1 and l2 == 0 then
		local a = e1 - math.log10(e2)
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	elseif l1 == 0 and l2 == 1 then
		local a = math.log10(e1) - e2
		buffer.writei8(n1,0,s1 * s2 * math.sign(a))
		if a >= 1e10 then
			buffer.writef64(n1,1,2)
			buffer.writef64(n1,9,math.log10(a))
			return n1
		elseif a < 10 then
			buffer.writef64(n1,1,0)
			buffer.writef64(n1,9,10 ^ a)
			return n1
		else
			buffer.writef64(n1,1,1)
			buffer.writef64(n1,9,a)
			return n1
		end
	else
		local fe1 = e1
		local fe2 = e2
		if l1 == 1 then
			fe1 = math.sign(e1) * math.log10(math.abs(e1))
		elseif l2 == 1 then
			fe2 = math.sign(e2) * math.log10(math.abs(e2))
		end
		buffer.writei8(n1,0,s1 * s2)
		local e1s = math.sign(fe1)
		local e2s = math.sign(fe2)
		local e1a = math.abs(fe1)
		local e2a = math.abs(fe2)
		if e1a >= e2a then
			local oomdif = e1a - e2a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l1)
				buffer.writef64(n1,9,e1)
				return n1
			else
				local a = math.abs(e2a + math.log10(math.abs(e2s - e1s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e1s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e1s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e1s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e1s * a)
					return n1
				end
			end
		else
			local oomdif = e2a - e1a
			if oomdif >= 16 then
				buffer.writef64(n1,1,l2)
				buffer.writef64(n1,9,-e2)
				return n1
			else
				local a = math.abs(e1a + math.log10(math.abs(e1s - e2s * 10 ^ oomdif)))
				if a >= 1e10 then
					buffer.writef64(n1,1,3)
					buffer.writef64(n1,9,e2s * math.log10(a))
					return n1
				elseif a < 10 then
					a = 10 ^ a
					if a < 10 then
						buffer.writef64(n1,1,0)
						buffer.writef64(n1,9,e2s * 10 ^ a)
						return n1
					end
					buffer.writef64(n1,1,1)
					buffer.writef64(n1,9,e2s * a)
					return n1
				else
					buffer.writef64(n1,1,2)
					buffer.writef64(n1,9,e2s * a)
					return n1
				end
			end
		end
	end
end

--[[
	n1 %= n2
	Sets n1 to Modulus of n1 and n2
]]
function gn.modeq(n1,n2)
	-- sillydev0050 fixed v1.1.1: modeq now delegates to the corrected mod() implementation
	-- instead of maintaining a second copy of the old broken quotient/remainder algorithm.
	if type(n1) ~= "buffer" then
		error("Wrong Type: modeq(), Input 1")
	end
	local result = gn.mod(n1,n2)
	buffer.copy(n1,0,result,0,17)
	return n1
end
--[[
	Sets n to a new gammanum from s,l,e
]]
function gn.set(n,s,l,e)
	if type(n) ~= "buffer" then
		error("Wrong Type: set(), Input 1")
	end
	-- sillydev0050 fixed: reuse new() so setter normalization cannot drift from constructor behavior
	local fixed = gn.new(s,l,e)
	buffer.copy(n,0,fixed,0,17)
	return n
end
--[[
	Sets n to a new gammanum from number
]]
function gn.setFromNumber(n,number)
	if type(n) ~= "buffer" then
		error("Wrong Type: setFromNumber(), Input 1")
	end
	-- sillydev0050 fixed: the old code checked `n == 0` (the buffer) instead of `number == 0`
	local converted = gn.fromNumber(number)
	buffer.copy(n,0,converted,0,17)
	return n
end

--[[
	Sets n1 to n2
]]
function gn.copy(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: copy(), Input 1")
	end
	if type(n2) ~= "buffer" then
		error("Wrong Type: copy(), Input 2")
	end
	buffer.copy(n1,0,n2,0)
	return n1
end
--[[
	Sets n to Greatest integer less than n
]]
function gn.flooreq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: flooreq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	if s == 0 then
		return n
	elseif s == 1 then
		if l == 0 then
			local rou = math.floor(e)
			if rou == 0 then
				buffer.writei8(n,0,0)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,0)
				return n
			else
				buffer.writei8(n,0,1)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,rou)
				return n
			end
		elseif e < 0 then
			buffer.writei8(n,0,0)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,0)
			return n
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,1)
			buffer.writef64(n,9,math.log10(math.floor(10^e)))
			return n
		else
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,l)
			buffer.writef64(n,9,e)
			return n
		end
	elseif l == 0 then
		buffer.writei8(n,0,-1)
		local rou = math.ceil(e)
		if rou == 1e10 then
			buffer.writef64(n,1,1)
			buffer.writef64(n,9,10)
			return n
		else
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,rou)
			return n
		end
	elseif e < 0 then
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,1)
		return n
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,1)
		buffer.writef64(n,9,math.log10(math.ceil(10^e)))
		return n
	else
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,l)
		buffer.writef64(n,9,e)
		return n
	end
end
--[[
	Sets n to Least integer greater than n
]]
function gn.ceileq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: ceileq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	if s == 0 then
		return n
	elseif s == 1 then
		if l == 0 then
			buffer.writei8(n,0,1)
			local rou = math.ceil(e)
			if rou == 1e10 then
				buffer.writef64(n,1,1)
				buffer.writef64(n,9,10)
				return n
			else
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,rou)
				return n
			end
		elseif e < 0 then
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,1)
			return n
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,1)
			buffer.writef64(n,9,math.log10(math.ceil(10^e)))
			return n
		else
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,l)
			buffer.writef64(n,9,e)
			return n
		end
	elseif l == 0 then
		local rou = math.floor(e)
		if rou == 0 then
			buffer.writei8(n,0,0)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,0)
			return n
		else
			buffer.writei8(n,0,-1)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,rou)
			return n
		end
	elseif e < 0 then
		buffer.writei8(n,0,0)
		buffer.writef64(n,1,0)
		buffer.writef64(n,9,0)
		return n
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,1)
		buffer.writef64(n,9,math.log10(math.floor(10^e)))
		return n
	else
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,l)
		buffer.writef64(n,9,e)
		return n
	end
end
--[[
	Sets n to Closest integer to n
]]
function gn.roundeq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: roundeq(), Input 1")
	end
	local s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	if s == 0 then
		return n
	elseif s == 1 then
		if l == 0 then
			local rou = math.round(e)
			if rou == 0 then
				buffer.writei8(n,0,0)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,0)
				return n
			elseif rou == 1e10 then
				buffer.writei8(n,0,1)
				buffer.writef64(n,1,1)
				buffer.writef64(n,9,10)
				return n
			else
				buffer.writei8(n,0,1)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,rou)
				return n
			end
		elseif e < 0 then
			-- sillydev0050 fixed: preserve correct half-up rounding below 1
			if l == 1 and e >= -0.3010299956639812 then
				buffer.writei8(n,0,1)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,1)
			else
				buffer.writei8(n,0,0)
				buffer.writef64(n,1,0)
				buffer.writef64(n,9,0)
			end
			return n
		elseif l == 1 and e <= l1_THRESHOLD then
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,1)
			buffer.writef64(n,9,math.log10(math.round(10^e)))
			return n
		else
			buffer.writei8(n,0,1)
			buffer.writef64(n,1,l)
			buffer.writef64(n,9,e)
			return n
		end
	elseif l == 0 then
		local rou = math.round(e)
		if rou == 0 then
			buffer.writei8(n,0,0)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,0)
			return n
		elseif rou == 1e10 then
			buffer.writei8(n,0,-1)
			buffer.writef64(n,1,1)
			buffer.writef64(n,9,10)
			return n
		else
			buffer.writei8(n,0,-1)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,rou)
			return n
		end
	elseif e < 0 then
		-- sillydev0050 fixed: symmetric negative rounding below 1
		if l == 1 and e >= -0.3010299956639812 then
			buffer.writei8(n,0,-1)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,1)
		else
			buffer.writei8(n,0,0)
			buffer.writef64(n,1,0)
			buffer.writef64(n,9,0)
		end
		return n
	elseif l == 1 and e <= l1_THRESHOLD then
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,1)
		buffer.writef64(n,9,math.log10(math.round(10^e)))
		return n
	else
		buffer.writei8(n,0,-1)
		buffer.writef64(n,1,l)
		buffer.writef64(n,9,e)
		return n
	end
end
--[[
	Rounds n1 to nearest multiple of n2
]]
function gn.roundtoeq(n1,n2)
	if type(n1) ~= "buffer" then
		error("Wrong Type: roundtoeq(), Input 1")
	end
	-- sillydev0050 fixed: mirror the corrected roundto() formula and keep eq mutation semantics
	local result = gn.roundto(n1,n2)
	buffer.copy(n1,0,result,0,17)
	return n1
end

--[[
	n = 1 / n
	Sets n to Reciprocal of n
]]
function gn.recipeq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: recipeq(), Input 1")
	end
	-- sillydev0050 fixed: use recip() so zero/NaN handling stays consistent
	local result = gn.recip(n)
	buffer.copy(n,0,result,0,17)
	return n
end

--[[
	n = |n|
	Sets n to Absolute Value of n
]]
function gn.abseq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: abseq(), Input 1")
	end
	buffer.writei8(n,0,math.abs(buffer.readi8(n,0)))
	return n
end
--[[
	n = -n
	Sets n to Negated of n
]]
function gn.negeq(n)
	if type(n) ~= "buffer" then
		error("Wrong Type: negeq(), Input 1")
	end
	buffer.writei8(n,0,-buffer.readi8(n,0))
	return n
end
--[[
	Sign of n (1 if positive, -1 if negative, 0 if zero)
]]
function gn.sign(n)
	if type(n) == "buffer" then
		return buffer.readi8(n,0)
	elseif type(n) == "number" then
		return math.sign(n)
	else
		error("Wrong Type: sign(), Input 1")
	end
end
--[[
	if n is POSITIVE then TRUE else FALSE
]]
function gn.isPositive(n)
	if type(n) == "buffer" then
		-- sillydev0050 fixed: NaN is neither positive nor negative
		return buffer.readf64(n,1) >= 0 and buffer.readi8(n,0) > 0
	elseif type(n) == "number" then
		return n > 0
	else
		error("Wrong Type: isPositive(), Input 1")
	end
end

--[[
	if n is NEGATIVE then TRUE else FALSE
]]
function gn.isNegative(n)
	if type(n) == "buffer" then
		-- sillydev0050 fixed: NaN is neither positive nor negative
		return buffer.readf64(n,1) >= 0 and buffer.readi8(n,0) < 0
	elseif type(n) == "number" then
		return n < 0
	else
		error("Wrong Type: isNegative(), Input 1")
	end
end

--[[
	if n is ZERO then TRUE else FALSE
]]
function gn.isZero(n)
	if type(n) == "buffer" then
		return buffer.readi8(n,0) == 0
	elseif type(n) == "number" then
		return n == 0
	else
		error("Wrong Type: isZero(), Input 1")
	end
end
--[[
	if n is in range of numbers (<~1.79e308) then TRUE else FALSE
]]
function gn.isNumber(n)
	if type(n) == "number" then
		return n == n and math.abs(n) < math.huge
	elseif type(n) ~= "buffer" then
		error("Wrong Type: isNumber(), Input 1")
	end
	local s,l,e = buffer.readi8(n,0),buffer.readf64(n,1),buffer.readf64(n,9)
	if l < 0 or l == math.huge then
		return false
	elseif s == 0 or l == 0 then
		return true
	elseif l == 1 then
		-- sillydev0050 fixed: layer >= 2 is not a native-number-safe value
		return math.abs(e) <= inf_limit
	end
	return false
end

--[[
	SillyDev0050 QoL helpers
]]
function gn.isGammaNum(n)
	return type(n) == "buffer" and buffer.len(n) == 17
end
function gn.clone(n)
	-- sillydev0050 fixed: makes mutating *eq APIs safer to use with shared values/constants
	if type(n) == "number" then
		return gn.fromNumber(n)
	elseif not gn.isGammaNum(n) then
		error("Wrong Type: clone(), Input 1")
	end
	local out = buffer.create(17)
	buffer.copy(out,0,n,0,17)
	return out
end
function gn.compare(n1,n2)
	return compareValues(n1,n2)
end
function gn.isNaN(n)
	if type(n) == "number" then return n ~= n end
	if not gn.isGammaNum(n) then error("Wrong Type: isNaN(), Input 1") end
	return buffer.readf64(n,1) < 0
end
function gn.isInf(n)
	if type(n) == "number" then return math.abs(n) == math.huge end
	if not gn.isGammaNum(n) then error("Wrong Type: isInf(), Input 1") end
	return buffer.readi8(n,0) ~= 0 and buffer.readf64(n,1) == math.huge
end
function gn.isFinite(n)
	return not gn.isNaN(n) and not gn.isInf(n)
end
function gn.toNumber(n)
	if type(n) == "number" then return n end
	if not gn.isGammaNum(n) then error("Wrong Type: toNumber(), Input 1") end
	local s,l,e = buffer.readi8(n,0),buffer.readf64(n,1),buffer.readf64(n,9)
	if l < 0 then return 0/0 end
	if s == 0 then return 0 end
	if l == math.huge then return s*math.huge end
	if l == 0 then return s*e end
	if l == 1 then
		if e > inf_limit then return s*math.huge end
		if e < -324 then return s*0 end
		return s*(10^e)
	end
	return if e > 0 then s*math.huge else s*0
end
function gn.clamp(n,minValue,maxValue)
	if gn.gt(minValue,maxValue) then
		error("Invalid Range: clamp(), minValue > maxValue")
	end
	if gn.lt(n,minValue) then return gn.clone(minValue) end
	if gn.gt(n,maxValue) then return gn.clone(maxValue) end
	return gn.clone(n)
end

--[[
	Random number between n1 and n2
]]
function gn.random(n1,n2)
	return gn.addeq(gn.muleq(gn.sub(n2,n1),math.random()),n1)
end
--[[
	Sum of Geometric Series Range from start to last
	start term is: base * mul ^ start
	last term is: base * mul ^ last
	returns sum of the terms between
]]
function gn.geosum(base, mul, start, last)
	-- sillydev0050 fixed v1.1.1: range is inclusive because `last` is documented
	-- as the final term index.
	if gn.lt(last,start) then
		return buffer.create(17)
	end

	-- sillydev0050 fixed v1.1.1: exact native fast path avoids log/pow roundoff for
	-- common economy formulas such as 2 + 6 + 18 = 26.
	local function nativeValue(value)
		if type(value) == "number" then
			return value
		end
		if gn.isNumber(value) then
			return gn.toNumber(value)
		end
		return nil
	end
	local baseN = nativeValue(base)
	local mulN = nativeValue(mul)
	local startN = nativeValue(start)
	local lastN = nativeValue(last)
	if baseN ~= nil and mulN ~= nil and startN ~= nil and lastN ~= nil then
		local nativeResult
		if mulN == 1 then
			nativeResult = baseN * (lastN - startN + 1)
		else
			nativeResult = baseN * ((mulN ^ (lastN + 1)) - (mulN ^ startN)) / (mulN - 1)
		end
		if nativeResult == nativeResult and math.abs(nativeResult) < math.huge then
			if nativeResult ~= 0 or baseN == 0 or mulN == 1 then
				return gn.fromNumber(nativeResult)
			end
		end
	end

	if gn.eq(mul,1) then
		return gn.mul(gn.add(gn.sub(last,start),1),base)
	else
		return gn.div(gn.mul(gn.sub(gn.pow(mul,gn.add(last,1)),gn.pow(mul,start)),base),gn.sub(mul,1))
	end
end
--[[
	End Index of Geometric Series Range starting at 'start'
	start term is: base * mul ^ start
	range sum is: amount
	returns end index
]]
function gn.geosumR(base, mul, start, amount)
	-- sillydev0050 fixed: inverse now matches the inclusive geosum() endpoint
	if gn.eq(mul,1) then
		return gn.sub(gn.add(gn.div(amount,base),start),1)
	else
		local scaled = gn.div(gn.mul(gn.sub(mul,1),amount),gn.mul(base,gn.pow(mul,start)))
		return gn.sub(gn.add(gn.log(gn.add(scaled,1),mul),start),1)
	end
end

--it's gammaing time
local C = {0.99999999999980993, 676.5203681218851, -1259.1392167224028,771.32342877765313, -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7}
-- sillydev0050 fixed: keep implementation helpers local to this module
local function F_Gamma(n)
	if n > 171.6236 then return 1.8e308 end
	if (n >= 0.5) then 
		n -= 1
		local x = C[1]
		-- sillydev0050 fixed: include the final Lanczos coefficient (C[9])
		for i=1, 8 do
			x += C[i + 1] / (n + i)
		end
		local t = n + 7.5
		return  x * t ^ (n + 0.5 - 36) * math.exp(-t) * t ^ 36 * 2.50662827463100050241576528
	end
	return math.pi / (math.sin(math.pi * n) * F_Gamma(1 - n))
end
--[[
	the gamma function | (n-1)!
	(n-1)*(n-2)*...*2*1
]]
function gn.gamma(n)
	-- sillydev0050 fixed: canonical special values and restore reflection support for negative non-integers
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: gamma(), Input 1")
	end
	if l < 0 or s == 0 then 
		return gn.new(1,-1,1)
	elseif s < 0 then
		-- Gamma has poles at non-positive integers; other negative reals use Lanczos reflection.
		if l ~= 0 or e == math.floor(e) then
			return gn.new(1,-1,1)
		end
		return gn.fromNumber(F_Gamma(-e))
	elseif l == math.huge then
		return gn.new(1,math.huge,1)
	elseif e < 0 then 
		local buf = buffer.create(17)
		buffer.writei8(buf,0,s)
		buffer.writef64(buf,1,l)
		buffer.writef64(buf,9,-e)
		return buf 
	elseif l == 0 then
		if e <= 24 then
			return gn.fromNumber(F_Gamma(s * e))
		end
		local t = e - 1
		local l1 = (0.9189385332046727 + ((t + 0.5) * math.log(t))) - t
		local n2 = t * t
		local np = t
		local lm = 12 * np
		local adj = 1 / lm
		local l2 = l1 + adj
		if l2 == l1 then return gn.exp(l1) end
		l1 = l2
		np *= n2
		lm = 360 * np
		adj = 1 / lm
		l2 = l1 - adj
		if l2 == l1 then return gn.exp(l1) end
		l1 = l2
		np *= n2
		local lt = 1 / (1260 * np)
		-- sillydev0050 fixed: this was `l1 += t`, which catastrophically broke Gamma(n) above 24
		l1 += lt
		np *= n2
		lt = 1 / (1680 * np)
		l1 -= lt
		return gn.exp(l1)
	elseif l == 1 then 
		return gn.expeq(gn.muleq(gn.subeq(gn.ln(n), 1),n))
	end
	return gn.exp(n)
end

--[[
	the factorial function | n!
	n*(n-1)*(n-2)*...*2*1
]]
function gn.fact(n)
	return gn.gamma(gn.add(n,1))
end
local suffixes = {
	{
		{'k','M','B','T','Qd','Qt','Sx','Sp','Oc','No'},
		{'','U','D','T','Qt','Qn','Sx','Sp','Oc','No'},
		{'','Dc','Vt','Tg','qg','Qg','sg','Sg','og','ng'},
		{'','Ce','Du','Tr','Qa','Qi','Se','Si','Ot','Ni'},
	},
	{
		{'k','m','b','t','q','Q','s','S','o','n','d'},
	},
	{
		{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'},
	},
}
--[[
	Converts s,l,e to a number ex.
	3535 = 1,0,3535
	1,000,000,000,000 = 1,1,12
]]
function gn.suffix(i)
	-- sillydev0050 fixed: avoid nil table indexing for zero/negative/non-finite suffix indices
	if type(i) ~= "number" or i ~= i then error("Wrong Type: suffix(), Input 1") end
	if i <= 0 then return "" end
	if i == math.huge then return "Mi" end
	i = math.floor(i)
	if i <= 10 then return suffixes[1][1][i] end
	if i >= 1001 then return "Mi" end
	return suffixes[1][2][((i-1) % 10)+1]..suffixes[1][3][(((i-1) // 10) % 10 )+1]..suffixes[1][4][(((i-1) // 100) % 10)+1]
end
-- sillydev0050 fixed: keep suffix helper local to this module
local function Asuffix(i)
	i += 26
	local s = ""
	while i > 0 do
		local mod = ((i-1) % 26)+1
		i = (i - mod) / 26
		s=suffixes[3][1][mod]..s
	end	
	return s
end
local function addcommas(n)
	-- sillydev0050 fixed: keep helper local and support the whole finite integer range it may receive
	if n ~= n then return "NaN" end
	if math.abs(n) == math.huge then return if n < 0 then "-Inf" else "Inf" end
	local sign = if n < 0 then "-" else ""
	local digits = tostring(math.floor(math.abs(n)))
	local parts = {}
	while #digits > 3 do
		table.insert(parts,1,digits:sub(-3))
		digits = digits:sub(1,-4)
	end
	table.insert(parts,1,digits)
	return sign..table.concat(parts,",")
end
--[[
	Converts s,l,e to a number ex.
	3535 = 1,0,3535
	1,000,000,000,000 = 1,1,12
]]
function gn.std(s,l,e)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 or l >= 2 or (l==1 and e>=inf_limit) then
		return "0"
	end
	local n = s * (if l == 0 then e else 10^e)
	if math.abs(n) >= 1 then
		local exponent = math.floor(math.log10(math.abs(n)))
		local mod3 = exponent % 3
		return string.format(digitcuts[math.max(gn.DefaultTotalDigits-mod3,0)],n*pow10[mod3-exponent])
	else
		return string.format(digitcuts[math.max(gn.DefaultTotalDigits,0)],s*e)
	end
end

--[[
	Converts s,l,e to a number replacing DefaultTotalDigits with i
]]
function gn.stdsetround(s,l,e,i)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 or l >= 2 or (l==1 and e>=inf_limit) then
		return "0"
	end
	local n = s * (if l == 0 then e else 10^e)
	if math.abs(n) >= 1 then
		local exponent = math.floor(math.log10(math.abs(n)))
		local mod3 = exponent % 3
		return string.format(digitcuts[math.max(i-mod3,0)],n*pow10[mod3-exponent])
	else
		return string.format(digitcuts[math.max(i,0)],s*e)
	end
end

--[[
	Converts s,l,e to suffix notation ex.
	35.35k = 1,0,35.35*1000
]]
function gn.suf(s,l,e)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 then
		return "0"
	elseif l == 0 then
		if e >= 1e-3 and e < 1e3 then
			local mod3 = if e < 10 then 0 elseif e < 100 then 1 else 2
			local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
			local a = pow10[mod3]
			return string.format(digitcuts[roundingpoint-mod3],s*(if e > a*capthres[roundingpoint] then a*capvalue[roundingpoint] else e))
		end
		local exp,man = math.modf(math.abs(math.log10(e)))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return (if s<0 then"-"else"")..(if e<1 then"1/"else"")..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man)))..gn.suffix((exp - mod3)/3)
	elseif l == 1 and math.abs(e) < 3006 then
		local Esign = math.sign(e)
		local exp,man = math.modf(math.abs(e))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return (if s<0 then"-"else"")..(if Esign<0 then"1/"else"")..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man)))..gn.suffix((exp - mod3)/3)
	elseif l <= gn.MaxEs or (l == gn.MaxEs + 1 and math.abs(e) < 3006) then
		local Esign = math.sign(e)
		e = math.abs(e)
		local exp,man = math.modf(if e < 3006 then e else math.log10(e))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return (if s<0 then"-"else"")..(if Esign<0 then"1/"else"1")..Etrail[if e<3006 then l-1 else l]..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man)))..gn.suffix((exp - mod3)/3)
	elseif l < 1e6 then
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..addcommas(l)
	else
		local exp,man = math.modf(math.log10(l))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..string.format(digitcuts[roundingpoint-mod3],(if man>capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man))*pow10[mod3])..gn.suffix((exp - mod3)/3)
	end
end

--[[
	Converts s,l,e to scientific notation ex.
	3.535e4 = 1,0,3.535*10000
]]
function gn.sci(s,l,e)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 then
		return "0e0"
	elseif l == 0 then 
		local exp = math.floor(math.log10(e))
		local man = e/pow10[exp]
		return string.format(digitcuts[gn.DefaultDigits],s*(if man>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else man)).."e"..exp
	elseif l == 1 and math.abs(e) < 1e6 then
		local Esign = math.sign(e)
		e = math.abs(e)
		local exp,man = math.modf(e)
		return string.format(digitcuts[gn.DefaultDigits],s*(if man>capthresl10[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else math.pow(10,man))).."e"..addcommas(Esign*exp)
	elseif l <= gn.MaxEs or (l == gn.MaxEs + 1 and math.abs(e) < 1e6) then
		local Esign = math.sign(e)
		e = math.abs(e)
		local exp,man = math.modf(if e < 1e6 then e else math.log10(e))
		return s..Etrail[if e<1e6 then l-1 else l]..string.format(digitcuts[gn.DefaultDigits],Esign*(if man>capthresl10[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else math.pow(10,man))).."e"..addcommas(exp)
	elseif l < 1e6 then
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..addcommas(l)
	else
		local exp,man = math.modf(math.log10(l))
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..string.format(digitcuts[gn.DefaultDigits],(if man>capthresl10[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else math.pow(10,man))).."e"..exp
	end
end

--[[
	Converts s,l,e to engineer notation ex.
	35.35e3 = 1,0,35.35*1000
]]
function gn.eng(s,l,e)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 then
		return "0e0"
	elseif l == 0 then
		local exp,man = math.modf(math.log10(e))
		if exp < 0 then
			exp -= 1
			man += 1
		end
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return (if s<0 then"-"else"")..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man))).."e"..(exp - mod3)
	elseif l == 1 and math.abs(e) < 1000002 then
		local Esign = math.sign(e)
		e = math.abs(e)
		local exp,man = math.modf(e)
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return string.format(digitcuts[roundingpoint-mod3],s*pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man))).."e"..addcommas(Esign*(exp - mod3))
	elseif l <= gn.MaxEs or (l == gn.MaxEs + 1 and math.abs(e) < 1000002) then
		local Esign = math.sign(e)
		e = math.abs(e)
		local exp,man = math.modf(if e < 1000002 then e else math.log10(e))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		return s..Etrail[if e<1000002 then l-1 else l]..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man))).."e"..addcommas(Esign*(exp - mod3))
	elseif l < 1e6 then
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..addcommas(l)
	else
		local exp,man = math.modf(math.log10(l))
		local mod3 = exp % 3
		local roundingpoint = math.max(gn.DefaultTotalDigits,mod3)
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..string.format(digitcuts[roundingpoint-mod3],pow10[mod3]*(if man > capthresl10[roundingpoint] then capvalue[roundingpoint] else math.pow(10,man))).."e"..(exp-mod3)
	end
end

--[[
	Converts s,l,e to layered notation ex.
	3.5L+3 = 1,3,10^3.5(~+3162)
	3.5L-3 = 1,3,-10^3.5(~-3162)
	-3.5L+3 = -1,3,10^3.5(~+3162)
	-3.5L-3 = -1,3,-10^3.5(~-3162)
]]
function gn.lay(s,l,e)
	-- sillydev0050 fixed: format special values explicitly instead of indexing suffix/exponent tables
	if l < 0 then return "NaN" end
	if l == math.huge or math.abs(e) == math.huge then return if s < 0 then "-Inf" else "Inf" end
	if s == 0 then
		return "0L+0"
	elseif l == 0 then
		return string.format(digitcuts[gn.DefaultDigits],s*math.abs(math.log10(e)))
			.."L"..(if e >= 1 then "+" else "-").."0"
	elseif l < 1e6 then
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..addcommas(l)
	else
		local exp,man = math.modf(math.log10(l))
		local expmant = math.log10(math.abs(e))
		return string.format(digitcuts[gn.DefaultDigits],s*(if expmant>capthres[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else expmant)).."L"..(if e > 0 then "+" else "-")..string.format(digitcuts[gn.DefaultDigits],(if man>capthresl10[gn.DefaultDigits] then capvalue[gn.DefaultDigits] else math.pow(10,man))).."e"..exp
	end
end

--[[
	Converts gammanum to suffix notation ex.
	35.35k = 1,0,35.35*1000
]]
function gn.toSuffix(n)
	-- sillydev0050 fixed: normalize native NaN/Inf before formatting
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: toSuffix(), Input 1")
	end
	return gn.suf(s,l,e)
end

--[[
	Converts gammanum to scientific notation ex.
	3.535e4 = 1,0,3.535*10000
]]
function gn.toScientific(n)
	-- sillydev0050 fixed: normalize native NaN/Inf before formatting
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: toScientific(), Input 1")
	end
	return gn.sci(s,l,e)
end

--[[
	Converts gammanum to engineer notation ex.
	35.35e3 = 1,0,35.35*1000
]]
function gn.toEngineer(n)
	-- sillydev0050 fixed: normalize native NaN/Inf before formatting
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: toEngineer(), Input 1")
	end
	return gn.eng(s,l,e)
end

--[[
	Converts gammanum to layered notation ex.
	3.5L+3 = 1,3,10^3.5(~+3162)
	3.5L-3 = 1,3,-10^3.5(~-3162)
	-3.5L+3 = -1,3,10^3.5(~+3162)
	-3.5L-3 = -1,3,-10^3.5(~-3162)
]]
function gn.toLayered(n)
	-- sillydev0050 fixed: normalize native NaN/Inf before formatting
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: toLayered(), Input 1")
	end
	return gn.lay(s,l,e)
end

--[[
	Converts gammanum to string with given suffixtype
	Defaults to .DefaultSuffixType
	if 3rd input is an overide for TotalDefaultDigits for small numbers (0.001<|n|<1000)
	ex. n=3.594381 would return 4 if the 3rd input is 0
]]
function gn.tostring(n, suffixtype, intround)
	-- sillydev0050 fixed: normalize native NaN/Inf before formatting
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then n = gn.fromNumber(n) end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: tostring(), Input 1")
	end
	if suffixtype == nil then suffixtype = gn.DefaultSuffixType end
	if suffixtype == gn.SuffixTypes.Scientific then return gn.sci(s,l,e)
	elseif suffixtype == gn.SuffixTypes.Scientific3 then return if l >= 1 or e >= 1e3 or e <= 1e-3 then gn.sci(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Scientific36 then return if l >= 2 or (l == 1 and (e >= 36 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.sci(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Scientific306 then return if l >= 2 or (l == 1 and (e >= 306 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.sci(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Scientific3006 then return if l >= 2 or (l == 1 and (e >= 3006 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.sci(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Engineer then return gn.eng(s,l,e)
	elseif suffixtype == gn.SuffixTypes.Engineer3 then return if l >= 1 or e >= 1e3 or e <= 1e-3 then gn.eng(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Engineer36 then return if l >= 2 or (l == 1 and (e >= 36 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.eng(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Engineer306 then return if l >= 2 or (l == 1 and (e >= 306 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.eng(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Engineer3006 then return if l >= 2 or (l == 1 and (e >= 3006 or e < 0)) or (l == 0 and (e <= 1e-3)) then gn.eng(s,l,e) elseif (l == 1 and e > 0) or (l == 0 and e >= 1e3) then gn.suf(s,l,e) else (if intround then gn.stdsetround(s,l,e,intround) else gn.std(s,l,e))
	elseif suffixtype == gn.SuffixTypes.Layered then return gn.lay(s,l,e)
	end
	error("Unknown SuffixType: tostring(), Input 2")
end

--[[
	Encodes n into something that can be stored in an OrderedDataStore
]]
function gn.lbencode(n)
	-- sillydev0050 fixed: native NaN/Inf are not valid OrderedDataStore scores
	if type(n) == "number" and (n ~= n or math.abs(n) == math.huge) then
		error("Cannot lbencode NaN or infinity")
	end
	local s,l,e
	if type(n) == "buffer" then
		s, l, e = buffer.readi8(n,0), buffer.readf64(n,1), buffer.readf64(n,9)
	elseif type(n) == "number" then
		if n == 0 then
			s, l, e = 0, 0, 0
		elseif n == nil then
			s, l, e = 1, -1, 1
		else
			s, n = math.sign(n), math.abs(n)
			if n >= 1e10 or n <= 1e-10 then
				l, e = 1, math.log10(n)
			else
				l, e = 0, n
			end
		end
	else
		error("Wrong Type: lbencode(), Input 1")
	end
	-- sillydev0050 fixed: OrderedDataStore scores must be finite
	if l < 0 or l == math.huge then
		error("Cannot lbencode NaN or infinity")
	end
	if s == 0 then
		return 0
	elseif l == 0 then
		return s*math.round(4503599627370496 + 2199023255552 * (math.log10(e)/10))
	elseif l >= 1024 and math.sign(e) == 1 then
		return s*(6755399441055744 + 2199023255552 * math.log(l+(math.log10(e)-1)/9,2))
	elseif l < 1024 and math.sign(e) == 1 then
		return s*math.round(4503599627370496 + 2199023255552 * (l + (math.log10(e)-1)/9))
	elseif l < 1024 and math.sign(e) == -1 then
		return s*math.round(2251799813685248 + 2199023255552 * (1024 - l - (math.log10(-e)-1)/9))
	elseif l >= 1024 and math.sign(e) == -1 then
		return s*(2199023255552 * (1024-math.log(l+(math.log10(-e)-1)/9,2)))
	end
end

--[[
	Decodes from .lbencode()
]]
function gn.lbdecode(n)
	if type(n) ~= "number" then
		error("Wrong Type: lbdecode(), Input 1")
	end
	if n ~= n or math.abs(n) == math.huge then
		error("Invalid non-finite score: lbdecode()")
	end
	local buf = buffer.create(17)
	if n == 0 then
		return buf
	end
	buffer.writei8(buf,0,math.sign(n))
	n = math.abs(n)
	if math.abs(n-4503599627370496) <= 2199023255552 then
		buffer.writef64(buf,9,10^((n-4503599627370496)/219902325555.2))
		return buf
	elseif n <= 2251799813685248 then
		n = 2^(1024-(n/2199023255552))
		local floor = math.floor(n)
		buffer.writef64(buf,1,floor)
		buffer.writef64(buf,9,-(10^(1+(n-floor)*9)))
		return buf
	elseif n <= 4503599627370496 then
		n = 1024-((n-2251799813685248)/2199023255552)
		local floor = math.floor(n)
		buffer.writef64(buf,1,floor)
		buffer.writef64(buf,9,-(10^(1+(n-floor)*9)))
		return buf
	elseif n <= 6755399441055744 then
		n = (n-4503599627370496)/2199023255552
		local floor = math.floor(n)
		buffer.writef64(buf,1,floor)
		buffer.writef64(buf,9,10^(1+(n-floor)*9))
		return buf
	else
		n = 2^((n-6755399441055744)/2199023255552)
		local floor = math.floor(n)
		buffer.writef64(buf,1,floor)
		buffer.writef64(buf,9,10^(1+(n-floor)*9))
		return buf
	end
end
--[[
	Encodes n into base64 without dataloss
]]
function gn.b64encode(n)
	-- sillydev0050 fixed: encode the actual 17-byte GammaNum buffer instead of JSON slicing
	local input
	if type(n) == "buffer" then
		input = n
	elseif type(n) == "number" then
		input = gn.fromNumber(n)
	else
		error("Wrong Type: b64encode(), Input 1")
	end
	if not gn.isGammaNum(input) then
		error("Invalid GammaNum buffer: b64encode()")
	end
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local out = {}
	local length = buffer.len(input)
	for i=0,length-1,3 do
		local b1 = buffer.readu8(input,i)
		local has2 = i+1 < length
		local has3 = i+2 < length
		local b2 = if has2 then buffer.readu8(input,i+1) else 0
		local b3 = if has3 then buffer.readu8(input,i+2) else 0
		local packed = b1*65536+b2*256+b3
		out[#out+1] = alphabet:sub((packed // 262144)%64+1,(packed // 262144)%64+1)
		out[#out+1] = alphabet:sub((packed // 4096)%64+1,(packed // 4096)%64+1)
		if has2 then out[#out+1] = alphabet:sub((packed // 64)%64+1,(packed // 64)%64+1) end
		if has3 then out[#out+1] = alphabet:sub(packed%64+1,packed%64+1) end
	end
	return table.concat(out)
end

--[[
	Decodes n from .encode()
]]
function gn.b64decode(n)
	if type(n) ~= "string" then
		error("Wrong Type: b64decode(), Input 1")
	end
	-- sillydev0050 fixed: strict unpadded/padded Base64 decoder; no HttpService JSON internals
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local decode = {}
	for i=1,#alphabet do decode[alphabet:sub(i,i)] = i-1 end
	n = n:gsub("%s+","")
	n = n:gsub("=+$","")
	if #n % 4 == 1 then error("Invalid Base64: b64decode()") end
	local bytes = {}
	local i = 1
	while i <= #n do
		local c1 = decode[n:sub(i,i)]
		local c2 = decode[n:sub(i+1,i+1)]
		local c3 = if i+2 <= #n then decode[n:sub(i+2,i+2)] else nil
		local c4 = if i+3 <= #n then decode[n:sub(i+3,i+3)] else nil
		if c1 == nil or c2 == nil or (i+2 <= #n and c3 == nil) or (i+3 <= #n and c4 == nil) then
			error("Invalid Base64: b64decode()")
		end
		local packed = c1*262144+c2*4096+(c3 or 0)*64+(c4 or 0)
		bytes[#bytes+1] = string.char((packed // 65536)%256)
		if c3 ~= nil then bytes[#bytes+1] = string.char((packed // 256)%256) end
		if c4 ~= nil then bytes[#bytes+1] = string.char(packed%256) end
		i += 4
	end
	local raw = table.concat(bytes)
	if #raw ~= 17 then error("Invalid GammaNum Base64 length: b64decode()") end
	return buffer.fromstring(raw)
end

--[[
	Encodes n into hexadecimal without dataloss
]]
function gn.hexencode(n)
	if type(n) == "buffer" then
		-- sillydev0050 fixed: only canonical 17-byte GammaNum buffers are accepted
		if buffer.len(n) ~= 17 then error("Invalid GammaNum buffer: hexencode()") end
	elseif type(n) == "number" then
		n = gn.fromNumber(n)
	else
		error("Wrong Type: hexencode(), Input 1")
	end
	local str = ""
	for i=0,buffer.len(n)-1 do
		local a = buffer.readu8(n,i)
		local n1 = a // 16
		local n2 = a % 16
		str ..= string.char(if n1 < 10 then n1+48 else n1+87,if n2 < 10 then n2+48 else n2+87)
	end
	return str
end

--[[
	Decodes n from .hexencode()
]]
function gn.hexdecode(n)
	if type(n) ~= "string" then
		error("Wrong Type: hexdecode(), Input 1")
	end
	-- sillydev0050 fixed: validate length/chars and accept uppercase hex too
	if #n ~= 34 then
		error("Invalid GammaNum hex length: hexdecode()")
	end
	local function hexValue(byte)
		if byte >= 48 and byte <= 57 then return byte-48 end
		if byte >= 65 and byte <= 70 then return byte-55 end
		if byte >= 97 and byte <= 102 then return byte-87 end
		return nil
	end
	local chars = {}
	for i=1,#n,2 do
		local hi = hexValue(string.byte(n,i))
		local lo = hexValue(string.byte(n,i+1))
		if hi == nil or lo == nil then
			error("Invalid Hex: hexdecode()")
		end
		chars[#chars+1] = string.char(hi*16+lo)
	end
	return buffer.fromstring(table.concat(chars))
end

gn.Constants = {
	Zero = gn.new(0),
	One = gn.new(1,0,1),
	Pi = gn.new(1,0,math.pi),
	-- sillydev0050 fixed: Inf previously stored the maximum native-number magnitude, not GammaNum infinity
	Inf = gn.new(1,math.huge,1),
	NegInf = gn.new(-1,math.huge,1),
	NaN = gn.new(1,-1,1),
	MaxNumber = gn.new(1,1,inf_limit),
}
return gn
