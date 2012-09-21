import haxe.PosInfos;
using Std;

/**
 *  BenchMarking class for Haxe.
 */
class BenchMark {
  private var startTime(default, null):Float;
  private var endTime(default, null):Float;
  private var loopCount(default, null):Int;
  private var func(default, null):Dynamic;
  private var obj(default, null):Dynamic;
  private var args(default, null):Array<Dynamic>;
  private var pos(default, null):PosInfos;

  /*
   * func:Target function or method
   * obj:Setting this if func is instance method
   * args:for func of parameter
   * pos: In using, no need
   *
   * Usage:
   * var bench = new BenchMark(Test, check, []);
   * bench.start(10);
   * bench.end();
   *
   * Result:
   * [target name] Test.check
   * [loop count] 10
   * [time] 0.011/sec
   *
   */
  public function new(func:Dynamic,
                      ?obj:Dynamic = null,
                      ?args:Array<Dynamic> = null,
                      ?pos:PosInfos) {
    this.func = func;
    this.obj = obj;
    this.args = args;
    this.pos = pos;
  }
  /*
   * Bench start method.before end() execute
   * loopCount: number of times
   */
  public function start(loopCount:Int = 1) {
    this.loopCount = loopCount;
    for (i in 0...loopCount) {
      startTime = Date.now().getTime();
      Reflect.callMethod(obj, func, args);
    }
  }
  /*
   * Bench end method.
   */
  public function end() {
    endTime = Date.now().getTime();
    var resultTime = endTime - startTime;
    disp(resultTime / 1000);
  }
  /*
   * Display of results
   */
  private function disp(resultTime:Float) {
    var funcName = pos.className + "." + pos.methodName;
    trace("[target name] $funcName".format());
    trace("[loop count] $loopCount".format());
    trace("[time] $resultTime/sec".format());
  }
}
