Function Get-Easter {
<#
.SYNOPSIS
  Compute the Gregorian Easter date for the given year.

.DESCRIPTION
  Implements the Meeus/Jones/Butcher (Anonymous Gregorian) algorithm.

.PARAMETER Year
  Year(s) in the interval [1583, 4099] to get the date of Easter Sunday from.
  Defaults to the current year.

.INPUTS
  System.Int32

.OUTPUTS
  System.DateTime

.EXAMPLE
  Get-Easter

.EXAMPLE
  Get-Easter 2030

.EXAMPLE
  1583 .. 4099 | Get-Easter
#>
  [CmdletBinding()]
  param([Parameter(ValueFromPipeline)] [ValidateRange(1583, 4099)] [Int32[]]$Year = (Get-Date).Year)
  # The code is optimized for performance. Integer arithmetic is used wherever possible.
  # Therefore, (N -shr 2) replaces floor(N / 4) for N >= 0, and results of floor() are immediately casted to int.
  process {
    ForEach ($yr In $Year) {
      $gn = $yr % 19 # zero-based Golden Number
      $cent = [Int32][Math]::Floor($yr / 100) # century
      $ep = (19 * $gn + $cent - ($cent -shr 2) - [Int32][Math]::Floor(($cent - [Int32][Math]::Floor(($cent + 8) / 25) + 1) / 3) + 15) % 30 # Gregorian epact-related correction
      $wkd = (32 + $cent % 4 * 2 + (($yr % 100) -shr 2) * 2 - $ep - $yr % 4) % 7 # weekday correction
      $dn = $ep + $wkd - [Int32][Math]::Floor(($gn + 11 * $ep + 22 * $wkd) / 451) * 7 + 114 # days after March 21, plus 114 which consists of +21 shifting the origin to March 0 and +3*31 making March month 3
      [DateTime]::new($yr, [Int32][Math]::Floor($dn / 31), $dn % 31 + 1)
    }
  }
}

$EasterBasedFeastOffsets = [ordered]@{
  AshWednesday = New-TimeSpan -Days -46
  PalmSunday = New-TimeSpan -Days -7
  GoodFriday = New-TimeSpan -Days -2
  EasterSunday = New-TimeSpan -Days 0
  AscensionDay = New-TimeSpan -Days 39
  Pentecost = New-TimeSpan -Days 49
  CorpusChristi = New-TimeSpan -Days 60
}
