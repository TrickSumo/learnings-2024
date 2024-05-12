//Routine
// routine takes one function as argument and have auto and manual mode.
// It can wait or yield

(
r=Routine({
	0.postln;
	1.yield;
	10.postln;
	3.yield;
	9.postln;
})
)

//manual  mode
r.next;
r.next;
r.next;

r.reset


// Auto mode

r.play
r.reset


(
{
	var sig, env;

	env = EnvGen.kr(
		Env.new(
			levels: [0, 0.5, 0.75, 1, 0.75, 0.5, 0],
			times: [0.3, 0.15,0.15, 0.15,0.15, 0.3],
			curve: [-3,-2,-1,1,2,3]
		),
		doneAction: 2
	);

	sig = SinOsc.ar(300) * env;
	env
}.plot(3))


// Routine example

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

Synth(\simpleSine, ["freq":100]);


(
f={
	Synth(\simpleSine, ["freq":100]);
	1.wait;
	Synth(\simpleSine, ["freq":200]);
	1.wait;
	Synth(\simpleSine, ["freq":300]);
	1.wait;
		Synth(\simpleSine, ["freq":400]);
	1.wait;
	Synth(\simpleSine, ["freq":500]);
	1.wait;
	Synth(\simpleSine, ["freq":600]);
	1.wait;
		Synth(\simpleSine, ["freq":700]);
	1.wait;
	Synth(\simpleSine, ["freq":700]);
	1.wait;
	Synth(\simpleSine, ["freq":600]);
	1.wait;
	Synth(\simpleSine, ["freq":500]);
	1.wait;
	Synth(\simpleSine, ["freq":400]);
	1.wait;
		Synth(\simpleSine, ["freq":300]);
	1.wait;
	Synth(\simpleSine, ["freq":200]);
	1.wait;
	Synth(\simpleSine, ["freq":100]);
	1.wait;

};

r= Routine(f);

)

r.reset
r.play



// Routine shortcut
[1, 2, 3].collect({ |item| item + 3 })

(
f = {
	[150,200,300,400,500,600,500, 400, 300, 200, 150].collect( {
		|freq|

		Synth(\simpleSine, ["freq":freq]);
		1.wait;
	}
	)
};

r=Routine(f)
)

r.reset
r.play


// Binding to server clock

(
f = {
	[150,300,450,600,600,450, 300,150].collect( {
		|freq|

		s.bind({Synth(\simpleSine, ["freq":freq])});
		1.wait;
	}
	)
};

r=Routine(f)
)

(loop{
	r.reset;
    r.play;
})

[1,2,3].choose


