	m = NodeProxy.new;
	m.play;
	m.source_({ Impulse.ar([5, 5.1], mul: 0.5) * SinOsc.kr(0.2, 3pi/2).exprange(0.1, 1) });

m.fadeTime_(6);  // time to change source in live coding

	m.source_({ SinOsc.kr(330) });


m.pause;
m.resume;

m.release;
m.send;


////////////////////////////////////////////////////////////

Ndef(\n).play;
Ndef(\n).fadeTime_(3);

(
Ndef(\n, {
    var sig, mod;
    mod = SinOsc.ar(MouseX.kr(200, 2000, 1), mul: MouseY.kr(1, 10000, 1));
    sig = SinOsc.ar(300 + mod, mul: 0.2!2);
});
)

/////////////////////////////////////////////////////////////////

// ProxySpace

~a = 3;
~b = 7;

currentEnvironment;

e = Environment.new;
e.push;

~a = 19;
~b = 104;

e.pop;

d = Environment.new;
d.push;

~d = 5;

d.pop;

////////////////////////////////////////// Mix of proxtspace, events and pthers

s.quit;

p = ProxySpace.new(s.boot).push;


x.play;
x.fadeTime_(3);

x = { LFTri.ar(300 + SinOsc.ar(12).bipolar(100), mul: 0.1!2) };

x.release;

b = Buffer.read(s, "/Users/eli/Sounds/scaudio/kenzie/tongueram/tr_01_C3_01.aiff");

a = ();

a.fl0 = Buffer.read(s, "/Users/eli/Sounds/scaudio/kenzie/tongueram/tr_01_C3_01.aiff");

a.pitches = [];

a.fl0.numChannels;

y.fadeTime_(3).play;

y = { PlayBuf.ar(2, a.fl0, LFNoise1.kr(1).range(0.3, 0.8), Impulse.kr(8)) * 0.5 };

y.release;
