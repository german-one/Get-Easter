# Get-Easter

The `Get-Easter` PowerShell function computes the Gregorian Easter date for the given year(s).  

Why might one consider this function instead of some other PowerShell code for calculating the date of Easter?  
A code comment states: "The code is optimized for performance." What this actually means is that there is absolutely no reason for a script to consume more computing resources than is appropriate for its purpose - not even in the case of such a small piece of code.  

----

The `$EasterBasedFeastOffsets` dictionary is a small extra that contains the time intervals for certain feasts, measured from Easter.  

----

```powershell
# Test Code

$easter = Get-Easter 2026
$EasterBasedFeastOffsets.Keys | ForEach-Object { "$_`t$(($easter + $EasterBasedFeastOffsets.$_).ToString('dddd, yyyy-MM-dd'))" }
```

Output:  

```plaintext
AshWednesday    Wednesday, 2026-02-18
PalmSunday      Sunday, 2026-03-29
GoodFriday      Friday, 2026-04-03
EasterSunday    Sunday, 2026-04-05
AscensionDay    Thursday, 2026-05-14
Pentecost       Sunday, 2026-05-24
CorpusChristi   Thursday, 2026-06-04
```
