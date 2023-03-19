# Tasmota device management

Contains scripts that are useful when managing a "fleet" of tasmota devices.  Scripts written to act on one at a time and be used singularly:
```
./config.sh kitchen-lights
```
or in a loop as in:
```
for i in `cat tasmoten.list ` ; do ./config.sh $i; done
```
where `cat tasmoten.list` is whatever it takes to get a list of names.

# Tasmota device updater

This doesn't help with initial flashing.  Once you get the initial flash and setup done, this will update a group of devices from about version 6 to 11.  Trust my binaries or replace them with ones from http://ota.tasmota.com/tasmota/.  This isn't optimal and you may need to run it multiple times, but tasmota seems to tolerate failure well.  Only tested against tasmota running on sonoff devices, ymmv.

## How to use:

`ota-server.sh` will serve every file in this folder.  Add your builds directly to the root of this project.  it needs python.


Edit `update.sh` to fit what you need.  You'll probably want to add password support.  I used to have mqtt running without a password :-\.

Check `config.sh` for options and use it to configure your tasmoten.

Someone should really make this better.
