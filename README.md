# BenchMark-Haxe

BenchMarking class for Haxe.

---------------------------------------
## usage
  var bench = new BenchMark(Test, check, []);
  bench.start(10);
  bench.end();

---------------------------------------
## parameters
new BenchMark(funk, obj, args);

* func:Target function or method
* obj:Setting this if func is instance method
* args:for func of parameter

bench.start(10);

* loopCount:number of times

---------------------------------------
## reults
  [target name] Test.check
  [loop count] 10
  [time] 0.011/sec


