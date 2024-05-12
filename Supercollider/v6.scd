s.boot;
s.reboot;
s.quit;
s.freeAll;

(
~path = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/c.mp3";
b=Buffer.read(s,~path);
)

b.play
b.postln
b.query

SynthDef("test", {
    var sound = PlayBuf.ar(2,0 , loop: 1);
    Out.ar(0, sound);
}).asBytes.printOn(Post); nil


SynthDef("test", {|bufNum = 0|
	// Assuming buffer number 0, stereo sound, and looped playback
	var sound = PlayBuf.ar(2, bufNum,rate: 0.5, loop: 0);
	m = NodeProxy.new;
	m.play;
	m.source_({ Impulse.ar([5, 5.1], mul: 0.5) * SinOsc.kr(0.2, 3pi/2).exprange(0.1, 1) });
	Out.ar(0, sound+m);
}).add


SynthDef("test", { |bufNum = 0, gain = 1.0|
    var sound = PlayBuf.ar(2, bufNum, loop: 1);
    sound = sound * dbamp(gain); // Gain adjusted more appropriately
    Out.ar(0, sound); // Simplify output routing
}).add // Don't forget to add the SynthDef to the server





Synth("test")


// Test loading a simple buffer
(
d = Buffer.alloc(s, 44100, 1);
d.setn(0, [73, 68, 51, 3, 0, 0, 0, 0, 0, 102, 84, 73, 84, 50, 0, 0, 0, 37, 0, 0, 1, 255, 254, 87, 0, 101, 0, 116, 0, 32, 0, 84, 0, 105, 0, 114, 0, 101, 0, 32, 0, 68, 0, 114, 0, 105, 0, 118, 0, 101, 0, 32, 0, 66, 0, 121, 0, 84, 65, 76, 66, 0, 0, 0, 45, 0, 0, 1, 255, 254, 89, 0, 111, 0, 117, 0, 84, 0, 117, 0, 98, 0, 101, 0, 32, 0, 65, 0, 117, 0, 100, 0, 105, 0, 111, 0, 32, 0, 76, 0]);
SynthDef("test", {|bufNum = 0|
    var sound = PlayBuf.ar(1, bufNum, loop: 1);
    Out.ar(0, sound);
}).add;
s.sync;  // Ensure server has completed operations
Synth.new("test", [\bufNum, d]);
)




(
SynthDef(\play, {
	arg buf = 0;
	var sig;

	sig = PlayBuf.ar(
		numChannels:2,
		bufnum:buf,
		rate:BufRateScale.ir(buf) * \rate.kr(1),
		trigger: Impulse.kr(\trighz.kr(6)),
		startPos: \spos.kr(0),
		loop: \loop.kr(0)
	);

	Out.ar(\out.ir(0),sig);
}).add;
)

(
Synth(\play,[
	buf:b,
	rate:24.midiratio,
	loop:0,
	trighz:exprand(0.5,50),
	spos:rrand(0,b.numFrames-1),
])
)



//BufRd


(
SynthDef(\play,{

	arg buf =0;
	var sig, phs;

	phs = Line.ar(
		start:0,
		end:BufFrames.ir(buf)-1,
		dur:BufDur.ir(buf),
		doneAction:2

	);

	sig = BufRd.ar(
		numChannels:2,bufnum:buf,phase:phs
	);
	Out.ar(\out.ir(0),sig)
})
)

x = Synth(\play, [buf:b])



(
{
	var phs;
	phs= Line.ar(
		start:0,
		end:BufFrames.ir(b)-1,
		dur:BufDur.ir(b),
		doneAction:2
		)
}.plot)


//@40