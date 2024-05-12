squared(4)

4.squared

wait(4);


4.squared.neg;
neg(squared(4));



// Binary Operators

4.pow(3)


// interpreter variable

(x=4;
x=x.squared;
x)

// Error - multi chartater variable name can't be used without "var" keyword
(val=3;
val)

//variables

(
var myVal=3;
myVal = myVal.squared;
myVal;
)

// environment variables

(
~test=6;
~test
)


//strings

x = "hello"
x.size

x = 'hello'
x.asString.size


// arrays

x = [1,2,3,4]
x=x+3

x.scramble.postln
x.keep(2)


//functions
(
x ={
var num;
	num =8;
	num= num.squared
}
)


x.()
x.value()


//function with argument
(
x ={
arg num;
	num= num.squared
}
)


x.(3)
x.value()




(
x ={
|num=0|
	num= num.squared
}
)
x.(3)
x.value()



// Random number

rrand(1,29)
exprand(1,240)


// Duplicate array
rrand(1,6).dup(3)

{rrand(1,6)}.dup(3)

{rrand(1,6)} !3


// iteration

//this will not work
x = [1,2,3,4,5,6]
x=x+{rrand(2,3)}

(
x = [1,2,3,4,5,6];
x.collect({
	|item|
	item.postln;
	item+rrand(2,3)
})
)
