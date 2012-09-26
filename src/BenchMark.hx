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

  /**
    Constructor

    func:Target function or method
    obj:Setting this if func is instance method
    args:for func of parameter
    pos: In using, no need

    Usage:
    var bench = new BenchMark(Test, check, []);
    bench.start(10);
    bench.end();

    Result:
    [target name] Test.check
    [loop count] 10
    [time] 0.011/sec

  **/
  public function new(loopCount:Int = 1) {
    this.loopCount = loopCount;
  }

  /**
    set starting microtime
  **/
  public function start(?pos:PosInfos):Void {
    this.pos = pos;
    trace("\n---------------------------");
    startTime = Date.now().getTime();
  }

  /**
    get result time and display
  **/
  public function end():Void {
    endTime = Date.now().getTime();
    var resultTime = endTime - startTime;
    disp(resultTime / 1000);
  }

  /**
    Bench start method.before end() execute
    loopCount: number of times
  **/
  public function startExecFunc(func:Dynamic,
                                ?obj:Dynamic = null,
                                ?args:Array<Dynamic> = null,
                                ?pos:PosInfos):Array<Dynamic> {
    this.func = func;
    this.obj = obj;
    this.args = args;
    this.pos = pos;

    var results = [];
    trace("\n---------------------------");
    startTime = Date.now().getTime();
    for (i in 0...loopCount) {
      results.push(Reflect.callMethod(obj, func, args));
    }
    return results;
  }

  /**
    Bench end method.
  **/
  public function endExecFunc():Void {
    endTime = Date.now().getTime();
    var resultTime = endTime - startTime;
    disp(resultTime / 1000);
  }

  /**
    Display of results
  **/
  private function disp(resultTime:Float) {
    var funcName = pos.className + "." + pos.methodName;
    var lineNumber = pos.lineNumber;
    trace("[target name] $funcName".format());
    trace("[line number] $lineNumber".format());
    trace("[loop count] $loopCount".format());
    trace("[time] $resultTime/sec".format());
  }
}
