s.boot;
s.reboot;
s.quit;
s.freeAll;

0.3 ! 2

// Low Pass Filter
(
{

	var sig;
	sig = PinkNoise.ar(0.3 ! 2);
	sig = LPF.ar(
		in:sig,
		freq:600
	)
}.play
)

// High Pass Filter
(
{

	var sig;
	sig = PinkNoise.ar();
	sig = HPF.ar(
		in:sig,
		freq:600
	)
}.play
)


// High Pass Filter with modulation -> MouseX

(
{

	var sig;
	sig = PinkNoise.ar();
	sig = HPF.ar(
		in:sig,
		freq:MouseX.kr(10,1000).poll;
	)
}.play
)




// Sinwave as modultor

{SinOsc.ar(1).range(100,2000)}.plot(1)

(
{

	var sig;
	sig = PinkNoise.ar();
	sig = HPF.ar(
		in:sig,
		freq:SinOsc.ar(1).range(100,2000);
	)
}.plot
)


// Resonacne Low Pass Filter
(
{

	var sig;
	sig = PinkNoise.ar(0.3 ! 2);
	sig = RLPF.ar(
		in:sig,
		freq:MouseX.kr(100,6000).poll,
		rq:MouseY.kr(0.01,1).poll
	)
}.play
)


// Band Pass Filter
(
{

	var sig;
	sig = PinkNoise.ar(0.3 ! 2);
	sig = BPF.ar(
		in:sig,
		freq:MouseX.kr(100,6000).poll,
		rq:MouseY.kr(0.01,1).poll
	)
}.play
)



//RANGE MAPPING @16:00

rrand(1,20).postln.linexp(1,20,40,1000)
rrand(1,20).postln.linlin(1,20,40,1000)
rrand(1,20).postln.explin(1,20,40,1000)

(
var num;
num = (1..100);
[num,num.linexp(1,100,1,100), num.explin(1,100,1,100),
	num.lincurve(1,100,1,100,-8)
].plot;
)


({
	var sig;
	sig = SinOsc.ar([369,372], mul:0.2);
}.plot)

/*
Above Code is equivalent to this

({
	var sig;
	sig = SinOsc.ar([369,372]);
	sig = sig*0.2
}.play)
*/


({
    var sig;
    // Create two sine wave oscillators with frequencies 369 Hz and 372 Hz.
    sig = SinOsc.ar([369,372]);

    // Apply a non-linear curve transformation to the signal.
    // The lincurve method reshapes the signal based on a curve factor.
    sig = sig.lincurve(-1,1,-1,1,-1);

    // Multiply the output signal by 0.2 to reduce its amplitude.
    sig = sig*0.2;

    // Play the resulting signal.
}.play)


({
	var sig;
	var mod = LFNoise2.kr(1!2).range(-10,10);
	sig = SinOsc.ar([369,372]);
	sig = sig.lincurve(-1,1,-1,1,mod);
	sig = sig*0.2;
}.plot)


({LFTri.kr(0.15,3).range(50,1200)}.plot)


// lin exp use

({
	var sig, freq;
	freq = LFTri.kr(0.15,3).range(50,1200);
	sig = SinOsc.ar(freq*[0,1], mul:0.03);
}.play)


({
	var sig, freq;
	freq = LFTri.kr(0.15,3).range(50,1200).linexp(50,1200,50,1200);
	sig = SinOsc.ar(freq*[0,1], mul:0.03);
}.play)


//shortcut
({
	var sig, freq;
	freq = LFTri.kr(0.15,3).exprange(50,1200);
	sig = SinOsc.ar(freq*[0,1], mul:0.03);
}.play)



//Sampling and Buffer

b=Buffer.read(server:s,path:"C:/Users/Rishi/Downloads/Crowd Talking.mp3")
b.play;
b.free;

b.query
b.duration;
b.numChannels;


thisProcess.nowExecutingPath;
PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/c.mp3";


(
~path = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/b.mp3";
b=Buffer.read(s,~path);
/*b.play*/
)
b.play



// Buffer Playing Ugens

({
	var sig;
	sig=PlayBuf.ar(
		numChannels:b.numChannels,
		bufnum: \buf.kr(b.bufnum),
		rate:BufRateScale.kr(b),
		// to match sampling rate of server and buffer
		doneAction:Done.freeSelf
	)
}.play)





