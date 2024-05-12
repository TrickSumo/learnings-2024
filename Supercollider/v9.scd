80.midicps

500+[0,3]

{ Env.perc(0.001, 1, 1, 10).ar(2)}.plot(1)  // start time, decay time, max value, curve



// Signal Processing

s.boot;

(
SynthDef(\echo, {
    var sig;
    sig = SinOsc.ar(\freq.ir(500) + [0, 3]);
    sig = sig * Env.perc(0.001, \rel.ir(1), 1, \crv.ir(-10)).ar(2);
    sig = sig * \amp.ir(0.3);
    Out.ar(\out.ir(0), sig);
}).add;
)

Synth(\echo, [freq: rrand(45, 85).midicps, amp: 0.2]);


(
SynthDef("percussiveSynth", { |freq = 440, out = 0|
    // Define the envelope with a fast attack and a decay
    var env = Env.perc(0.001, 1, 1, -10).kr();
    // Use the envelope to modulate the amplitude of a sine wave oscillator
    var osc = SinOsc.ar(freq, 0, env);
    // Output the sound to the speakers
    Out.ar(out, osc);
}).add;
)

// Now we can play a percussive sound at a frequency of 440 Hz
x = Synth("percussiveSynth", ["freq", rrand(45, 85).midicps]);


/*When you place env within the argument list of SinOsc.ar, it becomes an argument to the oscillator and directly modulates the amplitude parameter of the SinOsc UGen.

When you multiply sig by env outside of the SinOsc.ar call (as in the \echo SynthDef), you are performing amplitude modulation in a separate step. Theoretically, these two approaches should yield the same result since both are multiplying the oscillator signal by the envelope.*/



//Make notes kind of echo like


(
SynthDef(\echo, {
    var sig, fx;
    sig = SinOsc.ar(\freq.ir(500) + [0, 3]);
    sig = sig * Env.perc(0.001, \rel.ir(1), 1, \crv.ir(-10)).ar(2);
	// Line.ar(0,0,4,doneAction:2);
	fx = CombL.ar(sig,0.2,0.2,4);
	sig = sig + fx;
    sig = sig * \amp.ir(0.3);


    Out.ar(\out.ir(0), sig);
}).add;
)

Synth(\echo, [freq: rrand(45, 85).midicps, amp: 0.2]);

// in abpve example, envolpe fades even before echo is done



//

(
SynthDef(\echo, {
    var sig;
    sig = SinOsc.ar(\freq.ir(500) + [0, 3]);
    sig = sig * Env.perc(0.001, \rel.ir(1), 1, \crv.ir(-10)).ar(2);
    sig = sig * \amp.ir(0.3);
	Out.ar(\out.ir(1), sig);
}).add;
)

Synth(\echo, [freq: rrand(45, 85).midicps, amp: 0.2]);

s.meter;
s.scope;

s.options.numAudioBusChannels;
s.options.numOutputBusChannels;
s.options.numPrivateAudioBusChannels;



//PASSING SIG FROM ONE SYNTH TO OTHER



(
SynthDef(\src, {
    var sig;
	sig = SinOsc.ar(\freq.ir(500)+[0,3]);
    sig = sig * Env.perc(0.001, \rel.ir(1), 1, \crv.ir(-10)).ar(2);
    sig = sig * \amp.ir(0.3);
	Out.ar(\out.ir(1), sig);
}).add;
)

(
SynthDef(\echo,{
	var sig;
	sig = In.ar(\in.ir(19),2); // This meansI want 2 buses starting from 19th, means19th and 20th bus
	sig = sig + CombL.ar(sig,0.2,0.2,4);
	Out.ar(\out.ir(0),sig)
}).add;)

Synth(\echo, [in:19, out:0]);
Synth(\src, [out:19]);
Synth(\src, [out:19, freq:rrand(45,85).midicps]);


s.freeAll;


b = Bus.audio(s, 2);
Synth(\echo, [in:b, out:0]);
Synth(\src, [out:b, freq:rrand(45,100).midicps]);


// Taking mic input

(
SynthDef(\mic, {
	var sig;
	sig = In.ar(\in.ir(2),1);
	sig=sig*\amp.kr(0.25);
	sig = sig!2;
	Out.ar(\out.ir(0),sig);
}).add;
)

Synth(\echo, [in:b, out:0]);
Synth(\mic, [out:b, amp:30]);

//SoundIn @30:00
(
SynthDef(\mic, {
	var sig;
	sig = SoundIn.ar(\in.ar(0));
	sig=sig*\amp.kr(0.25);
	sig = sig!2;
	Out.ar(\out.ir(0),sig);
}).add;
)


// Order of Execution

(

    SynthDef(\src, {
        var sig, freq;
        freq = LFNoise0.kr([7, 8]).range(45, 85).midicps;
        sig = SinOsc.ar(freq);
        sig = sig + Env.adsr().ar(2, \gate.kr(1));
        sig = sig * \amp.ir(0.3);
        Out.ar(\out.ir(0), sig);
    }).add;

    SynthDef(\echo, {
        var sig;
        sig = In.ar(\in.ir(0), 2);
        sig = sig + CombL.ar(sig, 0.2, 0.2, 4);
        Out.ar(\out1.ir(0), sig);
    }).add;
)

~fx = Synth(\echo, [in:b, out:0]);
~src = Synth(\src, [out: b]);

~src.set(\gate, 0);
~fx.free;


// WRONG ORDER  (ORDER inside node tree matters, code order looks correct but check in node tree)
~src = Synth(\src, [out: b]);
~fx = Synth(\echo, [in:b, out:0]);

~src.set(\gate, 0);
~fx.free;


//GROUPS

~fxgrp = Group.new;
~srcgrp = Group.new;

~fx = Synth(\echo, [in:b, out:0], ~fxgrp);
~src = Synth(\src, [out: b], ~srcgrp);

//ADD ACTIONS - tell where to add in group

~src = Synth(\src, [out: b]);
~fx = Synth(\echo, [in:b, out:0], addAction: \addToTail);
// Even with wrong order, its wokring because addAction taking care to add in correct place


//SynthDef can also be used as target - not working though

~src = Synth(\src, [out: b]);
~fx = Synth(\echo, [in:b, out:0], target: ~src, addAction: \addToTail);


// Dry/Wet Mixing

(
SynthDef(\src, {
    var sig, freq;
    // Generates a stepped random value at control rate, scales it between 45 and 85,
    // and converts it from MIDI note numbers to cycles per second.
    freq = LFNoise0.kr([7, 8]).range(45, 85).midicps;

    // Creates a sine wave oscillator with the frequency determined by 'freq'.
    sig = SinOsc.ar(freq);

    // Adds an ADSR envelope to the signal, controlled by a 'gate' at control rate.
    sig = sig + Env.adsr().ar(2, \gate.kr(1));

    // Multiplies the signal by an amplitude scaling factor, reducing its volume.
    sig = sig * \amp.ir(0.3);

    // Outputs the signal to the specified audio bus.
    Out.ar(\out.ir(0), sig);
}).add;

SynthDef(\echo, {
    var sig, fx;

    // Takes an input signal from the specified audio bus.
    sig = In.ar(\in.ir(0), 2);

    // Processes the input signal with a comb filter to create an echo effect.
    fx = CombL.ar(sig, 0.2, 0.2, 4);

    // Blends the original signal with the echo effect based on a mix control rate parameter.
    sig = sig.blend(fx, \mix.kr(0.5));

    // Outputs the blended signal to the specified audio bus.
    Out.ar(\out.ir(0), sig);
}).add;
)


~srcgrp = Group.new;
~fxgrp = Group.after(~srcgrp);

~fx = Synth(\echo, [in: b, out: 0], ~fxgrp);
~fx.set(\mix, 0.3);

~src = Synth(\src, [out: b, amp: 0.1], ~srcgrp);
~src.set(\gate, 0);
















