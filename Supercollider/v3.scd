s.boot;
s.reboot;
s.quit;

// unit generatorss Ugens
(
{
PinkNoise.ar * -30.dbamp;
}.play;

)



// ugens with args

(
{
	PinkNoise.ar(300);
}.plot

)

//s.meter
s.meter


// Modulation

(x = {
	var mod, sig;
	mod = LFTri.kr(1);
	sig = SinOsc.ar(150 + mod);
	sig = sig * -12.dbamp;
}.play)



(x = {
	var sig = SinOsc.ar(150);
	sig = sig * -12.dbamp;
}.play;)

{LFTri.kr(1)}.plot(4)


(x = {
	var mod, sig;
	mod = LFTri.kr(1)*200;
	sig = SinOsc.ar(200 + mod);
	sig = sig * -12.dbamp;
}.play)



(x = {
	var mod, sig;
	mod = LFTri.kr(1)*200;
	sig = SinOsc.ar(200 + mod);
	sig = sig * -12.dbamp;
}.play)


{LFPulse.ar(frq:9).range(300,500)}.plot(1);


(
{
	var mod,sig;
	mod = LFPulse.kr(freq:4).range(400,900);
	sig = SinOsc.ar(freq:mod);
	sig=sig * -20.dbamp;
}.plot(30);
)


(
{
	var mod,sig;
	mod = LFPulse.kr(freq:4).range(400,900);
	sig = SinOsc.ar(freq:mod);
	sig=sig * -20.dbamp;
}.play;
)



/// Moving avaway from monophonic

(
{
	var mod1 , mod2,sig;
	mod1 = LFPulse.kr(freq:4).range(400,900);
	mod2 = LFPulse.kr(freq:4).range(600,700);
	sig = [SinOsc.ar(freq:mod1), SinOsc.ar(freq:mod2)];
	sig=sig * -20.dbamp;
}.play;
)


(
{
	var mod1 , mod2,sig;
	mod1 = LFPulse.kr(freq:4).range(400,900);
	mod2 = LFPulse.kr(freq:4).range(600,700);
	sig = SinOsc.ar(freq:[mod1,mod2]);
	sig=sig * -20.dbamp;
}.play;
)

{exprand(100,8000)}!50

{exprand(100,8000)}.dup(50)


// Summing 30 sine wave to get song
(
x = {
	var sig;
	sig = SinOsc.ar(freq:{exprand(100,4000)}!30);
	sig = sig.sum;
	sig=sig * -45.dbamp;
}.plot)

(
x = {
	var sig;
	sig = SinOsc.ar(freq:{exprand(100,4000)}!30);
	sig = sig.sum;
	sig=sig * -45.dbamp;
}.play

)
x.release(4)




(
x = {
	var sig;
	sig = SinOsc.ar(freq:{exprand(300,6000)}!30);
	sig = Splay.ar(inArray:sig);
	sig=sig * -45.dbamp;
	}.play
)




