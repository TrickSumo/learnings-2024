s.boot;
s.reboot;
s.quit;


// Arguments

(
x={
	arg wdt=0.9, amp=0.03;
	var sig;
	sig = VarSaw.ar(freq:[300,301],width:wdt);
	sig=sig*amp;

}.play;
)
x.set(\wdt,1)
x.set(\amp,0.01)

x.set(\wdt,1, \amp,0.01)


# Channels and frequenccies must be literal

(
x={
	arg freq = #[600,603], wdt=0.9, amp=0.03;
	var sig;
	sig = VarSaw.ar(freq:freq,width:wdt);
	sig=sig*amp;

}.play;
)
x.set(\wdt,1)
x.set(\amp,0.01)

x.set(\freq, [220,221], \wdt,1, \amp,0.01)


// THIRD WAY TO create args

(
x={
	var sig;
	sig = VarSaw.ar(freq:\freq.kr(330)+[0,3],width:\wdt.kr(0.9));
	sig=sig*\amp.kr(-20.dbamp);

}.play;
)
x.set(\wdt,1)
x.set(\amp,0.01)

x.set(\freq, [220,221], \wdt,1, \amp,0.01)


# Interpolate between

(
x={
	arg freq = #[600,603], wdt=0.9, amp=0.03;
	var sig;
	sig = VarSaw.ar(freq:freq.varlag(1,0),width:wdt.lag(6));
	sig=sig*amp.lag(3);

}.play;
)
x.set(\wdt,1)
x.set(\amp,0.01)

x.set(\freq, [220,221], \wdt,1, \amp,0.01)


//Envelopes

(
e=Env.new(
	levels:[0,1,0],
	times:[0.5,2],
	curve:[-4, -1]
);
)

e.plot

(
x={
	var sig,env;
	env = EnvGen.kr(Env.new(
	levels:[0,1,0],
	times:[0.5,2],
	curve:[-4, -1]
     ),
	/*doneAction:2*/
	doneAction:Done.freeSelf
	);
	sig = VarSaw.ar(freq:[300,301],width:0.9);
	sig=sig*env;
	sig= sig* -20.dbamp;

}.play;
)


//Shortcut

(
x={
	var sig,env;
	env = Env.new(
	levels:[0,1,0],
	times:[0.5,2],
	curve:[-4, -1]
	).kr(2);
	sig = VarSaw.ar(freq:[300,301],width:0.9);
	sig=sig*env;
	sig= sig* -20.dbamp;

}.play;
)

//Retriggerable enevlopes

(
x={
	var sig,env;
	env = Env.new(
	levels:[0,1,0],
	times:[0.3,0.9],
	curve:[-4, -1]
	).kr(0, \trig.tr(1));
	sig = VarSaw.ar(freq:[300,301],width:0.9);
	sig=sig*env;
	sig= sig* -20.dbamp;

}.play;

)
x.set(\trig,1)


//SynthDef and Synth

(
SynthDef.new(\eli,{
	arg freq = #[600,603], wdt=0.9, amp=0.03;
	var sig;
	sig = VarSaw.ar(freq:freq,width:wdt);
	sig=sig*amp;
	Out.ar(\out.kr(0), sig);
}).add;
)

x = Synth.new(\eli)

x.free


