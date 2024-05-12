 // Recap of Signal Flow, Busses, & Order of Execution

s.boot;

(
s.newBusAllocators;
~abus = Bus.audio(s, 2);

SynthDef(\sin, {
    var sig, trig;
    trig = Impulse.kr(0.5);
    sig = SinOsc.ar(\freq.kr(1000) + [0, 5], mul: 0.2);
    sig = sig * Env.perc().ar(0, trig);
    Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\rev, {
    var sig = In.ar(\in.kr(0), 2);
    sig = FreeVerb.ar(sig, 0.3, 0.999, 0.7);
    Out.ar(\out.kr(0), sig);
}).add;
)

~src = Synth(\sin, [out: ~abus]);
~fx = Synth(\rev, [in: ~abus, out: 0], ~src, \addAfter);



//Control buses

s.options.numControlBusChannels;

x = {  Out.kr(3, SinOsc.kr(1))  }.play;

//manually setting bus value in control buses

b = Bus.control(s,4);
b.setn([0,0,0,0])

(
s.newBufferAllocators;
b=Bus.control(s,1);
)

b.value(500)







~kbus = Bus.control(s, 1);

SynthDef(\sin, {
    var sig, trig;
    trig = Impulse.kr(0.5);
    sig = SinOsc.ar(\freq.kr(1000) + [0, 5], mul: 0.2);
    sig = sig * Env.perc().ar(0, trig);
    Out.ar(\out.kr(0), sig);
}).add;

SynthDef(\rev, {
    var sig = In.ar(\in.kr(0), 2);
    sig = FreeVerb.ar(sig, 0.3, 0.999, 0.7);
    Out.ar(\out.kr(0), sig);
}).add;

~src = Synth(\sin, [in: ~kbus, out: ~abus]);

~fx = Synth(\rev, [in: ~abus, out: 0], ~src, \addAfter);

~src.set(\freq, rrand(200, 800));
~src.set(\freq, ~kbus.asMap);

~src.free;
~fx.free;

~lfo = { Out.kr(~kbus, SinOsc.kr(3).range(200, 800)) }.play;

~lfo.free;


