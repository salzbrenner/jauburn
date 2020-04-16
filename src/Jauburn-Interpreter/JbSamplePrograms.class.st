"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> gcd [
	"self run: #gcd"
	^'var gcd = function(a, b) {
		if (a == 0) { 
			return b;
		} else { 
			return gcd(mod(b, a), a);
		}
	};
	
	var firstNumber = stringToNumber(input("Enter the first number"));
	var secondNumber = stringToNumber(input("Enter the second number"));
	
	var t = gcd(firstNumber, secondNumber);
	var p = println(t);
'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'sample programs' }
JbSamplePrograms class >> squareRoot [
"self run: #squareRoot"
^'var input = input("Enter a number");
	var n = stringToNumber(input);
	var r =  n / 2;
	var i = 0;
	var better = r;
	
  	while(i <= 10) {
        better = (r + (n/r)) / 2;
        r = better;
		 i = i + 1;
		var c = println(better);
	}
	
  	var b = println(better);
'
]
