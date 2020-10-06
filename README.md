### LazyTools - [src](https://github.com/thechainercygnus/LazyTools)
Now with these exciting cmdlets:
1. Test-IPNetworking
* It's like Ping, but with a boolean output!
* Use it to easily embed Connectivity Tests into scripts.
* Defaults to `Test-Connection 1.1.1.1`
* Accepts any IP Address as a String as an argument.
* `Test-IPNetworking 8.8.8.8` if you're feeling froggy.
2. Test-DNSLookup
* It's like Test-IPNetworking, but with URL's.
* Defaults to `Test-Connecting durish.xyz`
* Accepts any URL as a string.
* `Test-DNSLookup github.com`
3. Test-Comparison
* Tests values against each other.
* Uses the *magic* of positional arguments to build your tests.
* `Test-Comparison "blue" eq "red" string` will cast blue and red as string types and let you know if they're equal.
4. Get-PowerPlan
* Returns an object containing all Power Plans that can be selected on the system.
* ```
PowerPlan                   GUID                            
---------                   ----                            
Balanced                    381b4222-f694-41f0-9685-ff5bb260
High performance            8c5e7fda-e8bf-4a96-9a85-a6e23a8c
AMD RyzenT Power Saver      951a752a-925f-4830-ab5a-e013024f
AMD RyzenT Balanced         9897998c-92de-4669-853f-b7cd3ecb
AMD RyzenT High Performance 9935e61f-1661-40c5-ae2f-8495027d
Power saver                 a1841308-3541-4fab-bc81-f71556f2
```
5. Set-PowerPlan (Coming Soon)

What more could you ask for? Seriously. [Tell me.](https://github.com/thechainercygnus/LazyTools/issues)