--!optimize 2
--!native

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GammaNum = require(ReplicatedStorage.GammaNum)

local tests = {}
local covered = {}
local passed = 0
local failed = 0
local warnings = 0

local function api(name, description, callback)
	covered[name] = true
	table.insert(tests, {
		name = name .. " :: " .. description,
		run = callback,
	})
end

local function case(description, callback)
	table.insert(tests, {
		name = "regression :: " .. description,
		run = callback,
	})
end

local function expect(condition, message)
	if not condition then
		error(message or "expectation failed", 2)
	end
end

local function approx(a, b, epsilon)
	epsilon = epsilon or 1e-9
	if a == b then
		return true
	end
	return math.abs(a - b) <= epsilon
end

local function relativeApprox(a, b, epsilon)
	epsilon = epsilon or 1e-9
	if a == b then
		return true
	end
	return math.abs(a - b) <= epsilon * math.max(1, math.abs(a), math.abs(b))
end

local function expectEq(actual, expected, message)
	expect(GammaNum.eq(actual, expected), message or (GammaNum.tostring(actual) .. " ~= " .. GammaNum.tostring(expected)))
end

local function expectNumber(actual, expected, epsilon, message)
	local n = GammaNum.toNumber(actual)
	expect(relativeApprox(n, expected, epsilon or 1e-9), message or (tostring(n) .. " ~= " .. tostring(expected)))
end

local function expectGamma(n, message)
	expect(GammaNum.isGammaNum(n), message or "expected a 17-byte GammaNum buffer")
end

local function expectError(callback, message)
	local ok = pcall(callback)
	expect(not ok, message or "expected function to error")
end

api("ExampleOperation", "custom example operation remains callable", function()
	local result = GammaNum.ExampleOperation(2)
	expectGamma(result)
	expectNumber(result, 0.01, 1e-12)
end)

api("ExampleToString", "custom example string operation remains callable", function()
	expect(GammaNum.ExampleToString(2) == "1_1_-2")
end)

api("totuple", "number and buffer conversion", function()
	local s1, l1, e1 = GammaNum.totuple(-42)
	expect(s1 == -1 and l1 == 0 and e1 == 42)
	local s2, l2, e2 = GammaNum.totuple(GammaNum.fromNumber(1e20))
	expect(s2 == 1 and l2 == 1 and approx(e2, 20))
end)

api("tobuffer", "creates canonical GammaNum buffers", function()
	local n = GammaNum.tobuffer(-123.5)
	expectGamma(n)
	expectNumber(n, -123.5)
end)

api("createCheckless", "raw tuple creation", function()
	local n = GammaNum.createCheckless(-1, 3, 77)
	local s, l, e = GammaNum.show(n)
	expect(s == -1 and l == 3 and e == 77)
end)

api("print", "debug printer accepts mixed values", function()
	local ok = pcall(function()
		GammaNum.print(GammaNum.fromNumber(123), "GammaNum-test", 5)
	end)
	expect(ok)
end)

api("show", "returns sign layer exponent", function()
	local s, l, e = GammaNum.show(GammaNum.fromNumber(-55))
	expect(s == -1 and l == 0 and e == 55)
end)

api("showS", "returns readable tuple string", function()
	local str = GammaNum.showS(GammaNum.fromNumber(-55))
	expect(type(str) == "string" and string.find(str, "-1", 1, true) ~= nil and string.find(str, "55", 1, true) ~= nil)
end)

api("new", "constructs canonical values", function()
	expectEq(GammaNum.new(1, 0, 500), 500)
	expectEq(GammaNum.new(-1, 0, 500), -500)
end)

api("fromScientific", "scientific mantissa exponent conversion", function()
	expectNumber(GammaNum.fromScientific(2.5, 3), 2500)
	expectNumber(GammaNum.fromScientific(-2.5, 3), -2500)
end)

api("fromNumber", "native number conversion", function()
	expectNumber(GammaNum.fromNumber(-9876.5), -9876.5)
	local s, l, e = GammaNum.show(GammaNum.fromNumber(-1e20))
	expect(s == -1 and l == 1 and approx(e, 20))
end)

api("fromString", "parses normal scientific and layer strings", function()
	expectEq(GammaNum.fromString("123.5"), 123.5)
	expectEq(GammaNum.fromString("2e3"), 2000)
	local layered = GammaNum.fromString("2;20")
	expectGamma(layered)
end)

api("floor", "floor rounding", function()
	expectEq(GammaNum.floor(3.9), 3)
	expectEq(GammaNum.floor(-3.1), -4)
end)

api("ceil", "ceiling rounding", function()
	expectEq(GammaNum.ceil(3.1), 4)
	expectEq(GammaNum.ceil(-3.9), -3)
end)

api("round", "nearest integer rounding", function()
	expectEq(GammaNum.round(3.49), 3)
	expectEq(GammaNum.round(3.51), 4)
end)

api("roundto", "nearest multiple rounding", function()
	expectNumber(GammaNum.roundto(12.3, 0.5), 12.5)
	expect(GammaNum.isNaN(GammaNum.roundto(10, 0)))
end)

api("lt", "less-than comparison", function()
	expect(GammaNum.lt(-100, -10))
	expect(not GammaNum.lt(10, 10))
end)

api("lte", "less-than-or-equal comparison", function()
	expect(GammaNum.lte(-100, -10))
	expect(GammaNum.lte(10, 10))
end)

api("gt", "greater-than comparison", function()
	expect(GammaNum.gt(-10, -100))
	expect(not GammaNum.gt(10, 10))
end)

api("gte", "greater-than-or-equal comparison", function()
	expect(GammaNum.gte(-10, -100))
	expect(GammaNum.gte(10, 10))
end)

api("eq", "equality comparison", function()
	expect(GammaNum.eq(GammaNum.fromNumber(25), 25))
	expect(not GammaNum.eq(25, 26))
end)

api("max", "maximum across varargs", function()
	expectEq(GammaNum.max(-100, 4, 20, 3), 20)
end)

api("min", "minimum across varargs", function()
	expectEq(GammaNum.min(-100, 4, 20, 3), -100)
end)

api("maxabs", "maximum absolute magnitude", function()
	expectEq(GammaNum.maxabs(-100, 40, 20), -100)
end)

api("minabs", "minimum absolute magnitude", function()
	expectEq(GammaNum.minabs(-100, -3, 5), -3)
end)

api("add", "addition", function()
	expectNumber(GammaNum.add(12.5, 7.5), 20)
end)

api("sub", "subtraction", function()
	expectNumber(GammaNum.sub(12.5, 7.5), 5)
end)

api("mul", "multiplication", function()
	expectNumber(GammaNum.mul(-12, 4), -48)
end)

api("div", "division", function()
	expectNumber(GammaNum.div(21, 3), 7)
end)

api("intdiv", "floor integer division", function()
	expectEq(GammaNum.intdiv(17, 5), 3)
	expectEq(GammaNum.intdiv(-17, 5), -4)
end)

api("mod", "floor-division modulo", function()
	expectEq(GammaNum.mod(17, 5), 2)
	expectEq(GammaNum.mod(-17, 5), 3)
end)

api("recip", "reciprocal", function()
	expectNumber(GammaNum.recip(4), 0.25)
end)

api("abs", "absolute value", function()
	expectEq(GammaNum.abs(-50), 50)
end)

api("neg", "negation", function()
	expectEq(GammaNum.neg(50), -50)
end)

api("pow10", "base-10 exponentiation", function()
	expectNumber(GammaNum.pow10(3), 1000)
end)

api("log10", "base-10 logarithm", function()
	expectNumber(GammaNum.log10(1000), 3)
end)

api("abslog10", "base-10 logarithm of absolute value", function()
	expectNumber(GammaNum.abslog10(-1000), 3)
end)

api("pow", "general exponentiation", function()
	expectEq(GammaNum.pow(-2, 3), -8)
	expectEq(GammaNum.pow(-2, 4), 16)
end)

api("root", "general real root", function()
	expectNumber(GammaNum.root(81, 4), 3)
	expectNumber(GammaNum.root(-8, 3), -2)
end)

api("sqrt", "square root", function()
	expectNumber(GammaNum.sqrt(81), 9)
	expect(GammaNum.isNaN(GammaNum.sqrt(-4)))
end)

api("pow2", "base-2 exponentiation", function()
	expectNumber(GammaNum.pow2(10), 1024)
end)

api("exp", "natural exponentiation", function()
	expectNumber(GammaNum.exp(1), math.exp(1), 1e-10)
end)

api("log", "arbitrary-base logarithm", function()
	expectNumber(GammaNum.log(8, 2), 3)
end)

api("log2", "base-2 logarithm", function()
	expectNumber(GammaNum.log2(8), 3)
end)

api("ln", "natural logarithm", function()
	expectNumber(GammaNum.ln(math.exp(1)), 1, 1e-10)
end)

api("tetr", "integer-height tetration", function()
	expectEq(GammaNum.tetr(2, 3), 16)
	expectEq(GammaNum.tetr(2, 0), 1)
end)

api("addeq", "in-place addition", function()
	local n = GammaNum.fromNumber(10)
	GammaNum.addeq(n, 5)
	expectEq(n, 15)
end)

api("subeq", "in-place subtraction", function()
	local n = GammaNum.fromNumber(10)
	GammaNum.subeq(n, 5)
	expectEq(n, 5)
end)

api("muleq", "in-place multiplication", function()
	local n = GammaNum.fromNumber(10)
	GammaNum.muleq(n, -5)
	expectEq(n, -50)
end)

api("diveq", "in-place division", function()
	local n = GammaNum.fromNumber(21)
	GammaNum.diveq(n, 3)
	expectEq(n, 7)
end)

api("intdiveq", "in-place integer division", function()
	local n = GammaNum.fromNumber(17)
	GammaNum.intdiveq(n, 5)
	expectEq(n, 3)
end)

api("poweq", "in-place exponentiation", function()
	local n = GammaNum.fromNumber(-2)
	GammaNum.poweq(n, 3)
	expectEq(n, -8)
end)

api("rooteq", "in-place root", function()
	local n = GammaNum.fromNumber(-8)
	GammaNum.rooteq(n, 3)
	expectNumber(n, -2)
end)

api("sqrteq", "in-place square root normal layer-0 path", function()
	local n = GammaNum.fromNumber(81)
	GammaNum.sqrteq(n)
	expectNumber(n, 9)
end)

api("pow2eq", "in-place base-2 exponent normal layer-0 path", function()
	local n = GammaNum.fromNumber(10)
	GammaNum.pow2eq(n)
	expectNumber(n, 1024)
end)

api("expeq", "in-place natural exponent normal layer-0 path", function()
	local n = GammaNum.fromNumber(1)
	GammaNum.expeq(n)
	expectNumber(n, math.exp(1), 1e-10)
end)

api("pow10eq", "in-place base-10 exponentiation", function()
	local n = GammaNum.fromNumber(3)
	GammaNum.pow10eq(n)
	expectNumber(n, 1000)
end)

api("log10eq", "in-place base-10 logarithm", function()
	local n = GammaNum.fromNumber(1000)
	GammaNum.log10eq(n)
	expectNumber(n, 3)
end)

api("abslog10eq", "in-place absolute log10", function()
	local n = GammaNum.fromNumber(-1000)
	GammaNum.abslog10eq(n)
	expectNumber(n, 3)
end)

api("log2eq", "in-place base-2 logarithm", function()
	local n = GammaNum.fromNumber(8)
	GammaNum.log2eq(n)
	expectNumber(n, 3)
end)

api("lneq", "in-place natural logarithm", function()
	local n = GammaNum.fromNumber(math.exp(1))
	GammaNum.lneq(n)
	expectNumber(n, 1, 1e-10)
end)

api("logeq", "in-place arbitrary-base logarithm", function()
	local n = GammaNum.fromNumber(8)
	GammaNum.logeq(n, 2)
	expectNumber(n, 3)
end)

api("modeq", "in-place modulo", function()
	local n = GammaNum.fromNumber(17)
	GammaNum.modeq(n, 5)
	expectEq(n, 2)
end)

api("set", "replace an existing buffer from tuple", function()
	local n = GammaNum.fromNumber(1)
	GammaNum.set(n, -1, 0, 42)
	expectEq(n, -42)
end)

api("setFromNumber", "replace an existing buffer from number", function()
	local n = GammaNum.fromNumber(1)
	GammaNum.setFromNumber(n, -123.5)
	expectNumber(n, -123.5)
	GammaNum.setFromNumber(n, 0)
	expect(GammaNum.isZero(n))
end)

api("copy", "copies one GammaNum into another", function()
	local dst = GammaNum.fromNumber(1)
	local src = GammaNum.fromNumber(-500)
	GammaNum.copy(dst, src)
	expectEq(dst, -500)
end)

api("flooreq", "in-place floor", function()
	local n = GammaNum.fromNumber(3.9)
	GammaNum.flooreq(n)
	expectEq(n, 3)
end)

api("ceileq", "in-place ceil", function()
	local n = GammaNum.fromNumber(3.1)
	GammaNum.ceileq(n)
	expectEq(n, 4)
end)

api("roundeq", "in-place round", function()
	local n = GammaNum.fromNumber(3.6)
	GammaNum.roundeq(n)
	expectEq(n, 4)
end)

api("roundtoeq", "in-place round-to-step", function()
	local n = GammaNum.fromNumber(12.3)
	GammaNum.roundtoeq(n, 0.5)
	expectNumber(n, 12.5)
end)

api("recipeq", "in-place reciprocal", function()
	local n = GammaNum.fromNumber(4)
	GammaNum.recipeq(n)
	expectNumber(n, 0.25)
end)

api("abseq", "in-place absolute value", function()
	local n = GammaNum.fromNumber(-4)
	GammaNum.abseq(n)
	expectEq(n, 4)
end)

api("negeq", "in-place negation", function()
	local n = GammaNum.fromNumber(4)
	GammaNum.negeq(n)
	expectEq(n, -4)
end)

api("sign", "returns -1 zero or 1", function()
	expect(GammaNum.sign(-5) == -1)
	expect(GammaNum.sign(0) == 0)
	expect(GammaNum.sign(5) == 1)
end)

api("isPositive", "positive predicate", function()
	expect(GammaNum.isPositive(5))
	expect(not GammaNum.isPositive(-5))
end)

api("isNegative", "negative predicate", function()
	expect(GammaNum.isNegative(-5))
	expect(not GammaNum.isNegative(5))
end)

api("isZero", "zero predicate", function()
	expect(GammaNum.isZero(0))
	expect(not GammaNum.isZero(1))
end)

api("isNumber", "native-double representability predicate", function()
	expect(GammaNum.isNumber(GammaNum.fromNumber(1e100)))
	expect(not GammaNum.isNumber(GammaNum.new(1, 2, 20)))
end)

api("isGammaNum", "GammaNum buffer predicate", function()
	expect(GammaNum.isGammaNum(GammaNum.fromNumber(1)))
	expect(not GammaNum.isGammaNum(1))
end)

api("clone", "independent clone", function()
	local original = GammaNum.fromNumber(50)
	local clone = GammaNum.clone(original)
	GammaNum.addeq(clone, 25)
	expectEq(original, 50)
	expectEq(clone, 75)
end)

api("compare", "three-way compare", function()
	expect(GammaNum.compare(-100, -10) == -1)
	expect(GammaNum.compare(10, 10) == 0)
	expect(GammaNum.compare(11, 10) == 1)
end)

api("isNaN", "NaN predicate", function()
	expect(GammaNum.isNaN(GammaNum.Constants.NaN))
	expect(not GammaNum.isNaN(1))
end)

api("isInf", "infinity predicate", function()
	expect(GammaNum.isInf(GammaNum.Constants.Inf))
	expect(GammaNum.isInf(GammaNum.Constants.NegInf))
	expect(not GammaNum.isInf(1))
end)

api("isFinite", "finite predicate", function()
	expect(GammaNum.isFinite(GammaNum.new(1, 2, 20)))
	expect(not GammaNum.isFinite(GammaNum.Constants.Inf))
	expect(not GammaNum.isFinite(GammaNum.Constants.NaN))
end)

api("toNumber", "converts representable values to native numbers", function()
	expect(approx(GammaNum.toNumber(GammaNum.fromNumber(-123.5)), -123.5))
	expect(GammaNum.toNumber(GammaNum.Constants.Inf) == math.huge)
end)

api("clamp", "clamps to GammaNum range", function()
	expectEq(GammaNum.clamp(-5, 0, 10), 0)
	expectEq(GammaNum.clamp(5, 0, 10), 5)
	expectEq(GammaNum.clamp(15, 0, 10), 10)
end)

api("random", "random value stays inside range", function()
	for _ = 1, 32 do
		local n = GammaNum.random(-5, 5)
		expect(GammaNum.gte(n, -5) and GammaNum.lte(n, 5))
	end
end)

api("geosum", "inclusive geometric-series sum", function()
	expectEq(GammaNum.geosum(2, 3, 0, 2), 26)
	expectEq(GammaNum.geosum(2, 1, 0, 2), 6)
end)

api("geosumR", "inverse geometric-series endpoint", function()
	local ending = GammaNum.geosumR(2, 3, 0, 26)
	expectEq(GammaNum.round(ending), 2)
end)

api("gamma", "gamma function", function()
	expectNumber(GammaNum.gamma(5), 24, 1e-10)
	expectNumber(GammaNum.gamma(-0.5), -3.544907701811032, 1e-9)
end)

api("fact", "factorial via gamma", function()
	expectNumber(GammaNum.fact(5), 120, 1e-10)
end)

api("suffix", "suffix lookup", function()
	expect(GammaNum.suffix(0) == "")
	expect(GammaNum.suffix(1) == "k")
end)

api("std", "standard fixed formatting", function()
	expect(GammaNum.std(1, 0, 123.456) == "123.5")
	expect(GammaNum.std(-1, 0, 123.456) == "-123.5")
end)

api("stdsetround", "standard formatting with custom rounding", function()
	expect(GammaNum.stdsetround(1, 0, 123.456, 0) == "123")
end)

api("suf", "suffix formatter", function()
	local result = GammaNum.suf(1, 0, 1500)
	expect(type(result) == "string" and string.find(result, "k", 1, true) ~= nil)
end)

api("sci", "scientific formatter", function()
	expect(GammaNum.sci(1, 0, 1500) == "1.500e3")
end)

api("eng", "engineering formatter", function()
	expect(GammaNum.eng(1, 0, 1500) == "1.500e3")
end)

api("lay", "layered formatter", function()
	local result = GammaNum.lay(1, 0, 1500)
	expect(type(result) == "string" and string.find(result, "L+0", 1, true) ~= nil)
end)

api("toSuffix", "GammaNum suffix formatting", function()
	local result = GammaNum.toSuffix(1500)
	expect(type(result) == "string" and string.find(result, "k", 1, true) ~= nil)
end)

api("toScientific", "GammaNum scientific formatting", function()
	expect(GammaNum.toScientific(1500) == "1.500e3")
end)

api("toEngineer", "GammaNum engineering formatting", function()
	expect(GammaNum.toEngineer(1500) == "1.500e3")
end)

api("toLayered", "GammaNum layered formatting", function()
	local result = GammaNum.toLayered(1500)
	expect(type(result) == "string" and string.find(result, "L+0", 1, true) ~= nil)
end)

api("tostring", "default and explicit suffix mode formatting", function()
	local default = GammaNum.tostring(1500)
	expect(type(default) == "string" and string.find(default, "k", 1, true) ~= nil)
	expect(GammaNum.tostring(1500, GammaNum.SuffixTypes.Scientific) == "1.500e3")
end)

api("lbencode", "OrderedDataStore score encoding", function()
	local encoded = GammaNum.lbencode(1000)
	expect(type(encoded) == "number" and encoded == encoded and math.abs(encoded) < math.huge)
end)

api("lbdecode", "OrderedDataStore score decoding", function()
	local original = GammaNum.fromNumber(1000)
	local decoded = GammaNum.lbdecode(GammaNum.lbencode(original))
	expectNumber(decoded, 1000, 1e-8)
end)

api("b64encode", "lossless Base64 encoding", function()
	local encoded = GammaNum.b64encode(GammaNum.new(-1, 2, 25))
	expect(type(encoded) == "string" and #encoded == 23)
end)

api("b64decode", "lossless Base64 decoding", function()
	local original = GammaNum.new(-1, 2, 25)
	local decoded = GammaNum.b64decode(GammaNum.b64encode(original))
	expectEq(decoded, original)
end)

api("hexencode", "lossless hexadecimal encoding", function()
	local encoded = GammaNum.hexencode(GammaNum.new(-1, 2, 25))
	expect(type(encoded) == "string" and #encoded == 34)
end)

api("hexdecode", "lossless hexadecimal decoding including uppercase", function()
	local original = GammaNum.new(-1, 2, 25)
	local decoded = GammaNum.hexdecode(string.upper(GammaNum.hexencode(original)))
	expectEq(decoded, original)
end)

case("negative huge and tiny native numbers keep sign separate", function()
	local s1, l1, e1 = GammaNum.show(GammaNum.fromNumber(-1e20))
	local s2, l2, e2 = GammaNum.show(GammaNum.fromNumber(-1e-20))
	expect(s1 == -1 and l1 == 1 and approx(e1, 20))
	expect(s2 == -1 and l2 == 1 and approx(e2, -20))
end)

case("constructor canonicalizes NaN and infinities", function()
	expect(GammaNum.isNaN(GammaNum.new(1, 0, 0 / 0)))
	expect(GammaNum.isInf(GammaNum.new(1, 0, -math.huge)))
	expect(GammaNum.sign(GammaNum.new(1, 0, -math.huge)) == -1)
	expect(GammaNum.isZero(GammaNum.new(1, 1, -math.huge)))
	expectEq(GammaNum.new(1, 2, -math.huge), 1)
end)

case("division special values", function()
	expect(GammaNum.isInf(GammaNum.div(1, 0)))
	expect(GammaNum.isInf(GammaNum.div(-1, 0)) and GammaNum.sign(GammaNum.div(-1, 0)) == -1)
	expect(GammaNum.isNaN(GammaNum.div(0, 0)))
	expect(GammaNum.isNaN(GammaNum.div(GammaNum.Constants.Inf, GammaNum.Constants.Inf)))
end)

case("undefined infinity arithmetic becomes NaN", function()
	expect(GammaNum.isNaN(GammaNum.mul(0, GammaNum.Constants.Inf)))
	expect(GammaNum.isNaN(GammaNum.add(GammaNum.Constants.Inf, GammaNum.Constants.NegInf)))
	expect(GammaNum.isNaN(GammaNum.sub(GammaNum.Constants.Inf, GammaNum.Constants.Inf)))
end)

case("power domain edge cases", function()
	expectEq(GammaNum.pow(0, 0), 1)
	expect(GammaNum.isInf(GammaNum.pow(0, -1)))
	expect(GammaNum.isNaN(GammaNum.pow(-2, 0.5)))
end)

case("root domain edge cases", function()
	expect(GammaNum.isNaN(GammaNum.root(-8, 2)))
	expect(GammaNum.isNaN(GammaNum.root(8, 0)))
	expect(GammaNum.isInf(GammaNum.root(0, -2)))
end)

case("exp-family special values", function()
	expect(GammaNum.isNaN(GammaNum.pow10(GammaNum.Constants.NaN)))
	expect(GammaNum.isInf(GammaNum.pow10(GammaNum.Constants.Inf)))
	expect(GammaNum.isZero(GammaNum.pow10(GammaNum.Constants.NegInf)))
	expect(GammaNum.isZero(GammaNum.pow2(GammaNum.Constants.NegInf)))
	expect(GammaNum.isZero(GammaNum.exp(GammaNum.Constants.NegInf)))
end)

case("logarithm domain and canonical zero", function()
	expect(GammaNum.isZero(GammaNum.log10(1)))
	expectEq(GammaNum.abslog10(-100), 2)
	expect(GammaNum.isNaN(GammaNum.log(10, 1)))
	expect(GammaNum.isZero(GammaNum.log(1, 10)))
	expect(GammaNum.isZero(GammaNum.log2(1)))
	expect(GammaNum.isZero(GammaNum.ln(1)))
end)

case("newly found in-place shadowing crash paths stay fixed", function()
	local a = GammaNum.fromNumber(9)
	local b = GammaNum.fromNumber(3)
	local c = GammaNum.fromNumber(2)
	GammaNum.sqrteq(a)
	GammaNum.pow2eq(b)
	GammaNum.expeq(c)
	expectEq(a, 3)
	expectNumber(b, 8)
	expectNumber(c, math.exp(2), 1e-10)
end)

case("Gamma Stirling and reflection paths", function()
	expectNumber(GammaNum.gamma(25), 6.204484017332394e23, 1e-9)
	expectNumber(GammaNum.gamma(-0.5), -3.544907701811032, 1e-9)
	expect(GammaNum.isNaN(GammaNum.gamma(-2)))
end)

case("tetration rejects invalid heights", function()
	expect(GammaNum.isNaN(GammaNum.tetr(2, 2.5)))
	expect(GammaNum.isNaN(GammaNum.tetr(2, -1)))
	expectEq(GammaNum.tetr(-1, 20), -1)
end)

case("formatters support special values", function()
	expect(GammaNum.tostring(GammaNum.Constants.Inf) == "Inf")
	expect(GammaNum.toSuffix(GammaNum.Constants.NegInf) == "-Inf")
	expect(GammaNum.toScientific(GammaNum.Constants.NaN) == "NaN")
	expectError(function()
		GammaNum.tostring(10, 99999)
	end)
end)

case("Base64 and hex reject malformed values", function()
	expectError(function()
		GammaNum.b64decode("not valid base64")
	end)
	expectError(function()
		GammaNum.hexdecode("xyz")
	end)
end)

case("clamp rejects reversed ranges", function()
	expectError(function()
		GammaNum.clamp(5, 10, 0)
	end)
end)

case("OrderedDataStore encoding rejects non-finite scores", function()
	expectError(function()
		GammaNum.lbencode(GammaNum.Constants.Inf)
	end)
	expectError(function()
		GammaNum.lbencode(GammaNum.Constants.NaN)
	end)
end)

case("constants are usable and immutable-by-clone convention", function()
	expectEq(GammaNum.Constants.Zero, 0)
	expectEq(GammaNum.Constants.One, 1)
	expectNumber(GammaNum.Constants.Pi, math.pi, 1e-12)
	expect(GammaNum.isNaN(GammaNum.Constants.NaN))
	expect(GammaNum.isInf(GammaNum.Constants.Inf))
	expect(GammaNum.isInf(GammaNum.Constants.NegInf))
end)

case("v1.1.1 finite scientific strings canonicalize exactly", function()
	expectEq(GammaNum.fromString("2e3"), 2000)
	expectEq(GammaNum.fromString("2E3"), 2000)
	expectEq(GammaNum.fromString("  -2.5e2  "), -250)
end)

case("v1.1.1 modulo follows floor-mod signs", function()
	expectEq(GammaNum.mod(17, 5), 2)
	expectEq(GammaNum.mod(-17, 5), 3)
	expectEq(GammaNum.mod(17, -5), -3)
	expectEq(GammaNum.mod(-17, -5), -2)
end)

case("v1.1.1 modeq shares corrected modulo semantics", function()
	local a = GammaNum.fromNumber(-17)
	GammaNum.modeq(a, 5)
	expectEq(a, 3)
	local b = GammaNum.fromNumber(17)
	GammaNum.modeq(b, -5)
	expectEq(b, -3)
end)

case("v1.1.1 native power path stays exact", function()
	expectEq(GammaNum.pow(-2, 3), -8)
	expectEq(GammaNum.pow(-2, 4), 16)
	expectNumber(GammaNum.pow(-2, -3), -0.125, 1e-12)
	local n = GammaNum.fromNumber(-2)
	GammaNum.poweq(n, 3)
	expectEq(n, -8)
end)

case("v1.1.1 negative-base tetration preserves the base tuple", function()
	expectEq(GammaNum.tetr(-1, 1), -1)
	expectEq(GammaNum.tetr(-1, 2), -1)
	expectEq(GammaNum.tetr(-1, 20), -1)
end)

case("v1.1.1 geometric sums keep exact native results", function()
	expectEq(GammaNum.geosum(2, 3, 0, 2), 26)
	expectEq(GammaNum.geosum(2, 1, 0, 2), 6)
	expectEq(GammaNum.geosum(2, 3, 3, 2), 0)
end)

local exportedFunctions = {}
for name, value in pairs(GammaNum) do
	if type(value) == "function" then
		exportedFunctions[name] = true
	end
end

local missingCoverage = {}
for name in pairs(exportedFunctions) do
	if not covered[name] then
		table.insert(missingCoverage, name)
	end
end

table.sort(missingCoverage)

local staleCoverage = {}
for name in pairs(covered) do
	if not exportedFunctions[name] then
		table.insert(staleCoverage, name)
	end
end

table.sort(staleCoverage)

print("------------------------------------------------------------")
print("GammaNum v1.1.1 SillyDev0050 All-API Test Suite")
print("Registered API tests:", 109)
print("Total test cases:", #tests)
print("------------------------------------------------------------")

if #missingCoverage > 0 then
	failed += #missingCoverage
	warn("[API COVERAGE FAIL] Untested exported functions: " .. table.concat(missingCoverage, ", "))
end

if #staleCoverage > 0 then
	warnings += #staleCoverage
	warn("[API COVERAGE WARN] Tests reference missing exports: " .. table.concat(staleCoverage, ", "))
end

for index, test in ipairs(tests) do
	local ok, err = xpcall(test.run, debug.traceback)
	if ok then
		passed += 1
		print(string.format("[PASS %03d/%03d] %s", index, #tests, test.name))
	else
		failed += 1
		warn(string.format("[FAIL %03d/%03d] %s\n%s", index, #tests, test.name, tostring(err)))
	end
end

local exportedCount = 0
for _ in pairs(exportedFunctions) do
	exportedCount += 1
end

local coveredCount = 0
for _ in pairs(covered) do
	coveredCount += 1
end

print("------------------------------------------------------------")
print(string.format("Exported API functions : %d", exportedCount))
print(string.format("Covered API functions  : %d", coveredCount))
print(string.format("Passed test cases      : %d", passed))
print(string.format("Failed test cases      : %d", failed))
print(string.format("Warnings               : %d", warnings))
print(string.format("API coverage           : %.2f%%", if exportedCount == 0 then 100 else (coveredCount / exportedCount) * 100))
print("------------------------------------------------------------")

assert(#missingCoverage == 0, "GammaNum API coverage is incomplete")
assert(failed == 0, string.format("%d GammaNum test(s) failed", failed))
print("[SUCCESS] GammaNum updated API passed the complete registered test suite")
