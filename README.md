# GammaNum v1.1.2 — Decimal Math Edition

A high-performance large-number library for Roblox/Luau, based on **GammaNum** by [@Valkzius](https://www.roblox.com/), with additional correctness fixes, safer serialization, regression coverage, and quality-of-life helpers maintained in the **SillyDev0050 Fixed Edition**.

GammaNum represents values far beyond the range of normal IEEE-754 doubles using a compact sign/layer/exponent model stored in a 17-byte Roblox `buffer`. The library is designed for games that need extremely large values while keeping arithmetic, formatting, comparisons, and serialization practical.

> **Original creator:** @Valkzius  
> **Fixed Edition:** @sillydev0050  
> **Current version:** `1.1.2`

---

## Features

- Large-number support up to approximately `10↑↑2^1024`
- Compact 17-byte `buffer` representation
- Native-number and scientific-number conversion
- Addition, subtraction, multiplication, division, modulo, powers, roots, and logarithms
- Integer and decimal-height tetration, Gamma, factorial, and geometric-series helpers
- Mutable `*eq` operations for in-place updates
- Scientific, engineering, suffix, layered, and standard formatting
- OrderedDataStore-compatible encoding
- Base64 and hexadecimal lossless serialization
- NaN and Infinity handling
- Native-number representability checks
- Decimal-height tetration with integer-result compatibility
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
print(GammaNum.Version) -- 1.1.2
print(GammaNum.FixedBy) -- sillydev0050
```

---

## Quick Start

```lua
local GammaNum = require(path.to.GammaNum)

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

### Decimal Tetration

Starting in `v1.1.2`, `GammaNum.tetr()` accepts finite non-negative decimal heights for positive finite bases.

```lua
local a = GammaNum.tetr(2, 0.5)
local b = GammaNum.tetr(2, 1.5)
local c = GammaNum.tetr(2, 2.5)
local d = GammaNum.tetr(2, 3)

print(GammaNum.toScientific(a))
print(GammaNum.toScientific(b))
print(GammaNum.toScientific(c))
print(GammaNum.toScientific(d))
```

Integer heights keep the original tetration behavior:

```text
2 ↑↑ 0 = 1
2 ↑↑ 1 = 2
2 ↑↑ 2 = 4
2 ↑↑ 3 = 16
2 ↑↑ 4 = 65,536
```

For a fractional height `0 < f < 1`, the fixed edition uses:

```text
T(base, f) = base ^ f
T(base, h + 1) = base ^ T(base, h)
```

This makes decimal heights continuous with the library's power recursion while preserving every integer-height result.

> Fractional tetration is not mathematically unique. GammaNum v1.1.2 intentionally uses this recurrence-based continuation rather than claiming to implement every possible analytic tetration extension.

Current decimal-height rules:

- Positive finite bases support finite heights `>= 0`.
- Integer heights retain the original optimized tetration path.
- Negative heights return GammaNum `NaN`.
- Fractional heights on zero or negative bases return GammaNum `NaN`.
- GammaNum heights are accepted when they can be converted to a finite native height.
- Very large decimal heights use convergence/layer fast paths when possible.

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

## v1.1.2 Fixes and Changes

Version `1.1.2` expands the fixed edition from correctness-only patches into decimal-height tetration support while preserving the existing integer tetration behavior.

### v1.1.2

- Added decimal-height support to `tetr(base, height)`.
- Preserved the original optimized path for integer tetration.
- Added support for GammaNum height inputs when the height is finite and representable as a native number.
- Added recurrence-based fractional tetration for positive finite bases.
- Added convergence handling for bases whose repeated powers stabilize.
- Added layer fast-forwarding for very large decimal heights after the power sequence becomes a pure layer increment.
- Kept negative tetration heights invalid.
- Kept fractional tetration of zero or negative bases invalid instead of returning misleading real-number results.
- Updated tetration documentation and regression coverage for decimal heights.

### v1.1.1

The `v1.1.1` patch focused on special values, normalization, and correctness hardening. It included fixes such as:

- Canonical NaN and Infinity conversion.
- Safer `fromScientific()` handling.
- Correct native scientific-string parsing in `fromString()`.
- Better negative-number reconstruction in tetration.
- Corrected rounding edge cases near zero.
- Safer Base64 and hexadecimal decoding validation.
- Consistent comparison behavior across negative values and special values.
- Additional QoL helpers and release metadata.

### v1.1.0

The `v1.1.0` release was produced after a complete All-API regression pass and fixed several remaining correctness problems:

- Canonical finite scientific-string parsing in `fromString()`.
- Correct floor-modulo behavior in `mod()`.
- `modeq()` delegating to the corrected modulo implementation.
- Exact native-number fast paths in `pow()` where appropriate.
- `poweq()` delegating to the corrected power implementation.
- Negative-base reconstruction in `tetr()`.
- Canonical native geometric-series results in `geosum()`.

Earlier SillyDev0050 fixes also addressed comparison ordering, round-to-step behavior, conversion sign handling, serialization validation, logarithm and power edge cases, Gamma/Stirling math, mutable-operation buffer shadowing, special-value formatting, and additional NaN/Infinity behavior.

Search the source for:

```lua
-- sillydev0050 fixed:
```

and version-specific patch comments to locate corrected areas.

---

## Testing

The package includes:

```text
GammaNum_v1.1.0_AllAPI_Tests.server.lua
GammaNum_DecimalTetr_Test.server.lua
```

The All-API suite is designed to cover every exported function plus regression cases for previously discovered bugs. The decimal tetration regression script specifically checks fractional heights, integer-height compatibility, GammaNum height inputs, recurrence behavior, and invalid-height handling.

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
- Prefer integer tetration heights when possible; they use the original optimized path.
- Decimal tetration may require repeated `pow()` evaluation before convergence or layer fast-forwarding can take over.

---

## Credits

**GammaNum** was originally created by **@Valkzius**.

The **SillyDev0050 Fixed Edition** keeps the original creator credit and adds correctness fixes, safer codecs, decimal-height tetration, regression testing, and QoL helpers by **@sillydev0050**.

If you use or redistribute this edition, keep the original GammaNum credit and the fixed-edition patch credit in the source.

---

## Release Files

```text
GammaNum.lua
GammaNum_v1.1.0_AllAPI_Tests.server.lua
GammaNum_DecimalTetr_Test.server.lua
GammaNum_v1.1.0_PATCH_NOTES.txt
README.md
```

---

## Version

```text
GammaNum v1.1.2
Decimal Math Edition
SillyDev0050 Fixed Edition
2026-08-29
```
