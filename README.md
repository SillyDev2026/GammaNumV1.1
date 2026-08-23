# GammaNum v1.1.0 — SillyDev0050 Fixed Edition

A high-performance large-number library for Roblox/Luau, based on **GammaNum** by [@Valkzius](https://www.roblox.com/), with additional correctness fixes, safer serialization, regression coverage, and quality-of-life helpers maintained in the **SillyDev0050 Fixed Edition**.

GammaNum represents values far beyond the range of normal IEEE-754 doubles using a compact sign/layer/exponent model stored in a 17-byte Roblox `buffer`. The library is designed for games that need extremely large values while keeping arithmetic, formatting, comparisons, and serialization practical.

> **Original creator:** @Valkzius  
> **Fixed Edition:** @sillydev0050  
> **Current version:** `1.1.0`

---

## Features

- Large-number support up to approximately `10↑↑2^1024`
- Compact 17-byte `buffer` representation
- Native-number and scientific-number conversion
- Addition, subtraction, multiplication, division, modulo, powers, roots, and logarithms
- Tetration, Gamma, factorial, and geometric-series helpers
- Mutable `*eq` operations for in-place updates
- Scientific, engineering, suffix, layered, and standard formatting
- OrderedDataStore-compatible encoding
- Base64 and hexadecimal lossless serialization
- NaN and Infinity handling
- Native-number representability checks
- QoL helpers such as `clone`, `compare`, `clamp`, and `toNumber`
- `--!optimize 2` and `--!native` retained for Luau optimization
- Full API coverage test suite for all 109 exported functions

---

## Installation

1. Download `GammaNum.lua`.
2. Create a **ModuleScript** in Roblox Studio.
3. Name it:

```text
GammaNum
```

4. Paste the module source into the ModuleScript.
5. Require it from a Script, LocalScript, or another ModuleScript.

```lua
local GammaNum = require(path.to.GammaNum)
```

You can verify the loaded release at runtime:

```lua
print(GammaNum.Version) -- 1.1.0
print(GammaNum.FixedBy) -- sillydev0050
```

---

## Quick Start

```lua
local GammaNum = require(path.to.GammaNum_v1_1_1_SillyDev0050_Fixed)

local coins = GammaNum.fromNumber(1250)
local reward = GammaNum.fromNumber(750)

coins = GammaNum.add(coins, reward)

print(GammaNum.toSuffix(coins))
-- 2.000k
```

### Huge values

```lua
local huge = GammaNum.new(1, 2, 100)

print(GammaNum.showS(huge))
print(GammaNum.toLayered(huge))
```

### Scientific input

```lua
local value = GammaNum.fromString("2e300")
print(GammaNum.toScientific(value))
```

### In-place operations

The `*eq` functions mutate an existing GammaNum buffer instead of returning a completely separate value.

```lua
local coins = GammaNum.fromNumber(100)

GammaNum.addeq(coins, 50)
GammaNum.muleq(coins, 2)

print(GammaNum.toNumber(coins))
-- 300
```

---

## Representation

GammaNum stores values using three components:

```text
sign, layer, exponent
```

Conceptually:

```text
sign × (10 ^^ layer) ^ exponent
```

Examples:

| GammaNum tuple | Meaning |
|---|---:|
| `{1, 0, 53}` | `53` |
| `{-1, 1, 53}` | `-1e53` |
| `{0, 0, 0}` | `0` |

Use `GammaNum.new(sign, layer, exponent)` when you already know the tuple representation. For ordinary Lua numbers, prefer `GammaNum.fromNumber()`.

---

## API Overview

### Creation and Conversion

```lua
GammaNum.new(sign, layer, exponent)
GammaNum.fromNumber(number)
GammaNum.fromScientific(mantissa, exponent)
GammaNum.fromString(string)
GammaNum.totuple(value)
GammaNum.tobuffer(value)
GammaNum.createCheckless(sign, layer, exponent)
GammaNum.toNumber(value)
GammaNum.clone(value)
```

`createCheckless()` intentionally skips normalization. Only use it when the supplied tuple is already valid.

### Comparison

```lua
GammaNum.eq(a, b)
GammaNum.lt(a, b)
GammaNum.lte(a, b)
GammaNum.gt(a, b)
GammaNum.gte(a, b)
GammaNum.compare(a, b)
GammaNum.max(...)
GammaNum.min(...)
GammaNum.maxabs(...)
GammaNum.minabs(...)
GammaNum.clamp(value, minimum, maximum)
```

`compare()` returns `-1`, `0`, or `1`. It returns `nil` when either value is NaN.

### Arithmetic

```lua
GammaNum.add(a, b)
GammaNum.sub(a, b)
GammaNum.mul(a, b)
GammaNum.div(a, b)
GammaNum.intdiv(a, b)
GammaNum.mod(a, b)
GammaNum.recip(value)
GammaNum.neg(value)
GammaNum.abs(value)
```

### Powers and Logarithms

```lua
GammaNum.pow(base, exponent)
GammaNum.root(value, root)
GammaNum.sqrt(value)
GammaNum.pow2(exponent)
GammaNum.pow10(exponent)
GammaNum.exp(exponent)
GammaNum.log(value, base)
GammaNum.log10(value)
GammaNum.abslog10(value)
GammaNum.log2(value)
GammaNum.ln(value)
GammaNum.tetr(base, height)
```

### Mutable Operations

```lua
GammaNum.addeq(a, b)
GammaNum.subeq(a, b)
GammaNum.muleq(a, b)
GammaNum.diveq(a, b)
GammaNum.intdiveq(a, b)
GammaNum.modeq(a, b)
GammaNum.poweq(a, b)
GammaNum.rooteq(a, b)
GammaNum.sqrteq(value)
GammaNum.pow2eq(value)
GammaNum.pow10eq(value)
GammaNum.expeq(value)
GammaNum.logeq(value, base)
GammaNum.log10eq(value)
GammaNum.abslog10eq(value)
GammaNum.log2eq(value)
GammaNum.lneq(value)
GammaNum.recipeq(value)
GammaNum.negeq(value)
GammaNum.abseq(value)
```

Mutable operations modify the first GammaNum buffer in place. Do not use them on constants you intend to preserve. Clone first when necessary:

```lua
local value = GammaNum.clone(GammaNum.Constants.One)
GammaNum.addeq(value, 10)
```

### Set and Copy

```lua
GammaNum.set(bufferValue, sign, layer, exponent)
GammaNum.setFromNumber(bufferValue, number)
GammaNum.copy(destination, source)
```

### Rounding

```lua
GammaNum.floor(value)
GammaNum.ceil(value)
GammaNum.round(value)
GammaNum.roundto(value, step)

GammaNum.flooreq(value)
GammaNum.ceileq(value)
GammaNum.roundeq(value)
GammaNum.roundtoeq(value, step)
```

### State and Validation

```lua
GammaNum.sign(value)
GammaNum.isPositive(value)
GammaNum.isNegative(value)
GammaNum.isZero(value)
GammaNum.isNumber(value)
GammaNum.isGammaNum(value)
GammaNum.isFinite(value)
GammaNum.isNaN(value)
GammaNum.isInf(value)
```

### Utility Math

```lua
GammaNum.random(minimum, maximum)
GammaNum.geosum(base, multiplier, startIndex, lastIndex)
GammaNum.geosumR(base, multiplier, startIndex, amount)
GammaNum.gamma(value)
GammaNum.fact(value)
```

### Formatting

```lua
GammaNum.tostring(value, suffixType)
GammaNum.toScientific(value)
GammaNum.toEngineer(value)
GammaNum.toSuffix(value)
GammaNum.toLayered(value)

GammaNum.std(sign, layer, exponent)
GammaNum.sci(sign, layer, exponent)
GammaNum.eng(sign, layer, exponent)
GammaNum.suf(sign, layer, exponent)
GammaNum.lay(sign, layer, exponent)
GammaNum.suffix(index)
GammaNum.print(...)
```

Available suffix modes are exposed through `GammaNum.SuffixTypes`.

```lua
GammaNum.DefaultSuffixType = GammaNum.SuffixTypes.Scientific306
GammaNum.DefaultDigits = 3
GammaNum.DefaultTotalDigits = 3
GammaNum.MaxEs = 3
```

---

## Serialization

### Base64

```lua
local value = GammaNum.fromString("1e250")

local encoded = GammaNum.b64encode(value)
local decoded = GammaNum.b64decode(encoded)

print(GammaNum.eq(value, decoded))
-- true
```

### Hexadecimal

```lua
local encoded = GammaNum.hexencode(value)
local decoded = GammaNum.hexdecode(encoded)

print(GammaNum.eq(value, decoded))
-- true
```

### OrderedDataStore Encoding

```lua
local encoded = GammaNum.lbencode(value)
local decoded = GammaNum.lbdecode(encoded)
```

`lbencode()` is intended for values that can safely be represented by the OrderedDataStore score format. Non-finite values are rejected by the fixed edition.

---

## v1.1.0 Fixes

Version `1.1.0` was created after running the complete All-API regression suite against the previous fixed build. That run covered all 109 exported API functions and exposed seven remaining failure areas.

The release includes fixes for:

- Canonical finite scientific-string parsing in `fromString()`
- Correct floor-modulo behavior in `mod()`
- `modeq()` delegating to the corrected modulo implementation
- Exact native-number fast paths in `pow()` where appropriate
- `poweq()` delegating to the corrected power implementation
- Negative-base reconstruction in `tetr()`
- Canonical native geometric-series results in `geosum()`

Earlier SillyDev0050 fixes also addressed comparison ordering, round-to-step behavior, conversion sign handling, serialization validation, logarithm and power edge cases, Gamma/Stirling math, mutable-operation buffer shadowing, special-value formatting, and additional NaN/Infinity behavior.

Search the source for:

```lua
-- sillydev0050 fixed:
```

or:

```lua
-- sillydev0050 fixed v1.1.0:
```

to locate patched areas.

---

## Testing

The package includes:

```text
GammaNum_v1.1.0_AllAPI_Tests.server.lua
```

The suite is designed to cover every exported function plus regression cases for previously discovered bugs.

Place the test Script beside the ModuleScript in Roblox Studio and run the server test.

Expected coverage target:

```text
Exported API functions : 109
Covered API functions  : 109
API coverage           : 100.00%
Failed test cases      : 0
```

The coverage gate also reports newly exported functions that do not yet have registered tests.

---

## Recommended Usage

For normal game economy values:

```lua
local coins = GammaNum.fromNumber(0)

GammaNum.addeq(coins, 100)
GammaNum.muleq(coins, 1.5)

print(GammaNum.toSuffix(coins))
```

For values too large for ordinary Lua numbers:

```lua
local huge = GammaNum.fromString("1e1000")
local doubled = GammaNum.mul(huge, 2)

print(GammaNum.toScientific(doubled))
```

For saved data, serialize the GammaNum value rather than assuming a Roblox DataStore can preserve the raw buffer directly in every storage workflow.

---

## Performance Notes

The source keeps both Luau optimization directives:

```lua
--!optimize 2
--!native
```

For performance-sensitive loops:

- Prefer `fromNumber()` over `fromString()` when the input already exists as a number.
- Prefer mutable `*eq` functions when intentionally reusing the same buffer.
- Avoid repeatedly formatting values every frame unless the displayed value actually changed.
- Use `createCheckless()` only when you fully control and validate the tuple yourself.

---

## Credits

**GammaNum** was originally created by **@Valkzius**.

The **SillyDev0050 Fixed Edition** keeps the original creator credit and adds correctness fixes, safer codecs, regression testing, and QoL helpers by **@sillydev0050**.

If you use or redistribute this edition, keep the original GammaNum credit and the fixed-edition patch credit in the source.

---

## Release Files

```text
GammaNum.lua
GammaNum_v1.1.0_AllAPI_Tests.server.lua
GammaNum_v1.1.0_PATCH_NOTES.txt
README.md
```

---

## Version

```text
GammaNum v1.1.0
SillyDev0050 Fixed Edition
2026-08-22
```
