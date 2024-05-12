//Patterns, Events and Streams

(
~pat = {
  var note;
  loop{
    note = -12;
    note.yield;
    3.do{
      note = note + [2, 5, 7].choose;
      note.yield;
    };
  };
};

~seq = r(~pat);
)

~seq.next;


(
~myFunc = {
	var count=0;

	while({count<6},{
		count=count+1;
		count.yield;
	})
};

r = Routine(~myFunc)
)

r.next


//Patterns

// Pseries

(
~pat = Pseries(50, 7, 5); //Pseries(start, step, length)
~seq = ~pat.asStream;
)


~seq.next;


//Pseq

(~pat = Pseq([1,2,3],inf);

~seq = ~pat.asStream;)

~seq.next;


// Only numerical type of patterns can be treated like number


(~pat = Pseq([1,2,3],inf);
~pat = ~pat + Pseq([10,20], inf);

~seq = ~pat.asStream;)

~seq.next;


// Nesting of patterns

(
~pat = Pseq(
	[
		5,
		Pwhite(lo: 0,hi: 9,length: 1),
		Pseq([1,2],2)
    ],3);

~seq = ~pat.asStream;
)

~seq.next;



//EVENTS

().play;

e = (abc:1,def:2,ghi:3)
e.class;
e.keys;
e.values;
e.[\abc];
e.ghi

(amp:0.5,freq:500, dur:3).play

(amp:0.3,freq:60.midicps, dur:3).play
60.midicps;

(amp:0.5,midinote:60, dur:3).play

Event.eventTypes.keys.postln;
Event.partialEvents.pitchEvent.keys;

Event.partialEvents.pitchEvent[\note].postcs

(amp:0.5,midinote:60, ctranspose:1).play
(amp:0.5,midinote:60, ctranspose:2).play
(amp:0.5,midinote:60, ctranspose:3).play


(amp:0.5,midinote:60, harmonic:1).play
(amp:0.5,midinote:60, harmonic:2).play
(amp:0.5,midinote:60, harmonic:3).play



(db:-30,midinote:60, harmonic:3).play



// Synth with events

(
SynthDef(\simpleSine, { |freq=300|
	var sig, env;

	env = EnvGen.kr(
		Env.new(
			levels: [0, 0.5, 0.75, 1, 0.75, 0.5, 0],
			times: [0.3, 0.15,0.15, 0.15,0.15, 0.3],
			curve: [-3,-2,-1,1,2,3]
		),
		doneAction: 2
	);

	sig = SinOsc.ar(freq) * env;
	Out.ar(0, sig ! 2);  // Output to both stereo channels
}).add;

)

(instrument: \simpleSine, amp:0.1).play;



//Pbind Pattern

(
~pat = Pbind(\instrument, \simpleSine, \amp,0.1,
	\midinote,60
);

~seq = ~pat.asStream;
)
~seq.next(()).play;

1.next
