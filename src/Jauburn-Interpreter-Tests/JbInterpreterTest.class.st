Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #test }
JbInterpreterTest >> testAbsBinding [
	self interpret: 'var xxx = abs(-4);'.
	self assert: (interpreter environment at: 'xxx') equals: 4. 

	self interpret: 'var xxx = abs(4);'.
	self assert: (interpreter environment at: 'xxx') equals: 4. 
]

{ #category : #running }
JbInterpreterTest >> testArity1Operator [
	self interpret: 'var x = -3; var y = -3 - x;'.
	self assert: (interpreter environment at: 'x') equals: -3.
	self assert: (interpreter environment at: 'y') equals: 0.
]

{ #category : #running }
JbInterpreterTest >> testArity2Operator [
	self interpret: 'var x = 12+12;'.
	self assert: (interpreter environment at: 'x') equals: 24.
	self interpret: 'var x = 100*2;'.
	self assert: (interpreter environment at: 'x') equals: 200.
	self interpret: 'var x = 15 / 3;'.
	self assert: (interpreter environment at: 'x') equals: 5.
	self interpret: 'var x = 5 - 6;'.
	self assert: (interpreter environment at: 'x') equals: -1.
	self interpret: 'var x = 1 == 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 1 == 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self interpret: 'var x = 1 < 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 1 < 1;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self interpret: 'var x = 1 <= 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 1 <= 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 1 <= 0;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self interpret: 'var x = 1 > 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	self interpret: 'var x = 1 > 1;'.
	self assert: (interpreter environment at: 'x') equals: false.  
	self interpret: 'var x = 3 > 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 1 >= 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 3 >= 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 3 != 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	self interpret: 'var x = 3 != 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #test }
JbInterpreterTest >> testAssignmentStatementNode [
	self interpret: 'xxx = true;'.
	self assert: (interpreter environment at: 'xxx') isNotNil.
	

]

{ #category : #test }
JbInterpreterTest >> testConcatBinding [
	self interpret: 'var xxx = concat("hello", "goodbye");'.
	self assert: (interpreter environment at: 'xxx') equals: 'hellogoodbye'. 
	
	 
]

{ #category : #test }
JbInterpreterTest >> testConstantExpressionNode [
	self interpret: 'xxx = true;'.
	self assert: (interpreter environment at: 'xxx') equals: true.
	
	self interpret: 'xxx = 1;'.
	self assert: (interpreter environment at: 'xxx') equals: 1.

	self interpret: 'xxx = "hello";'.
	self assert: (interpreter environment at: 'xxx') equals: 'hello'.
	

]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #test }
JbInterpreterTest >> testIf [
	self interpret: 'if (true) { var xxx = 3; var yyy = 4; };'.
	self assert: (interpreter environment at: 'xxx') equals: 3.
	self assert: (interpreter environment at: 'yyy') equals: 4. 
	
	self interpret: 'var str = "str"; if (false) { str = 3; };'.
	self assert: (interpreter environment at: 'str') equals: 'str'.
	
	self interpret: 'var str = "str"; if (true) { str = 3; };'.
	self assert: (interpreter environment at: 'str') equals: 3.
	 
]

{ #category : #test }
JbInterpreterTest >> testIfElse [
	self interpret: 'if (true) { var xxx = 3; var yyy = 4; } else {xxx = 100; yyy = 99;};'.
	self assert: (interpreter environment at: 'xxx') equals: 3.
	self assert: (interpreter environment at: 'yyy') equals: 4. 
	
	self interpret: 'var str = "str"; if (false) { str = 3; } else {str = 99; };'.
	self assert: (interpreter environment at: 'str') equals: 99.
	
	self interpret: 'var str = "str"; if (true) { str = 3; } else {str = 99; };'.
	self assert: (interpreter environment at: 'str') equals: 3.
	 
	
]

{ #category : #test }
JbInterpreterTest >> testInputBinding [
	| mi |
	mi := MockUiManager new.
	interpreter uiManager: mi.
	
	self interpret: 'var xxx = input("hello");'.
	self assert: mi prompt equals: 'hello'. 
	
	 
]

{ #category : #running }
JbInterpreterTest >> testJbFunctionCall [
	
	self interpret: 'var x = function() { return function(){}; }; var g = x();'.
	self assert: (interpreter environment at: 'g') class equals: JbFunction.

	self interpret: 'var f = function() { return "hello"; }; var result = f();'.
	self assert: (interpreter environment at: 'result') equals: 'hello'.
		
	self interpret: 'var f = function(a, b) { return a + b; }; var result = f(5, 10);'.
	self assert: (interpreter environment at: 'result') equals: 15.
	
	self interpret: 'var f = function(a, b) { var x = 3; return a + b + x; }; var result = f(5, 10);'.
	self assert: (interpreter environment at: 'result') equals: 18. 



]

{ #category : #running }
JbInterpreterTest >> testJbFunctionDeclaration [
	self interpret: 'var f = function() {};'.
	self assert: (interpreter environment at: 'f')  class equals: JbFunction.
	self assert: (interpreter environment at: 'f')  parameters size equals: 0.
	self assert: (interpreter environment at: 'f')  body size equals: 0.
	
	self interpret: 'var f = function(x, y) { var l = 3;};'.
	self assert: (interpreter environment at: 'f')  parameters size equals: 2.
	self assert: (interpreter environment at: 'f')  body size equals: 1.
	
	self interpret: 'var f = function(x, y) { var l = 3; var p = y;};'.
	self assert: (interpreter environment at: 'f')  parameters size equals: 2.
	self assert: (interpreter environment at: 'f')  body size equals: 2.
	
]

{ #category : #test }
JbInterpreterTest >> testLengthBinding [
	self interpret: 'var xxx = length("hello");'.
	self assert: (interpreter environment at: 'xxx') equals: 5. 
	
	 self interpret: 'var xxx = length("");'.
	self assert: (interpreter environment at: 'xxx') equals: 0. 
	
]

{ #category : #test }
JbInterpreterTest >> testModBinding [
	self interpret: 'var xxx = mod(3, 4);'.
	self assert: (interpreter environment at: 'xxx') equals: 3. 
	
	self interpret: 'var xxx = mod(4, 4);'.
	self assert: (interpreter environment at: 'xxx') equals: 0. 

	self interpret: 'var xxx = mod(4, 3);'.
	self assert: (interpreter environment at: 'xxx') equals: 1. 
	
	self interpret: 'var xxx = mod(4, 2);'.
	self assert: (interpreter environment at: 'xxx') equals: 0. 
]

{ #category : #test }
JbInterpreterTest >> testNotBinding [
	self interpret: 'var xxx = not(true);'.
	self assert: (interpreter environment at: 'xxx') equals: false. 
	
	self interpret: 'var xxx = not(false);'.
	self assert: (interpreter environment at: 'xxx') equals: true. 
	
	self interpret: 'var xxx = not(5 == 5);'.
	self assert: (interpreter environment at: 'xxx') equals: false. 
	
	self interpret: 'var xxx = not(5 == 6);'.
	self assert: (interpreter environment at: 'xxx') equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testPrintBinding [
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt.
	
	self interpret: 'var xxx = print("hello");'.
	self assert: mt contents equals: '''hello'''. 
	
	self interpret: 'var xxx = print(77);'.
	self assert: mt contents equals: '''hello''77'. 
	
	self interpret: 'var xxx = print("goodbye");'.
	self assert: mt contents equals: '''hello''77''goodbye'''. 
]

{ #category : #tests }
JbInterpreterTest >> testPrintLnBinding [
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt.
	
	self interpret: 'var xxx = println("hello");'.
	self assert: mt contents equals: '''hello''', String cr,  ''. 
	
	self interpret: 'var xxx = println(77);'.
	self assert: mt contents equals: '''hello''', String cr, '77', String cr. 
	
	self interpret: 'var xxx = println("goodbye");'.
	self assert: mt contents equals: '''hello''', String cr, '77', String cr, '''goodbye''', String cr,  ''.
]

{ #category : #running }
JbInterpreterTest >> testReturnStatement [

	self interpret: 'var x = function(){return 5;}; var y = x();'.
	self assert: (interpreter environment at: 'y') equals: 5. 

]

{ #category : #test }
JbInterpreterTest >> testStringToNumberBinding [
	self interpret: 'var xxx = stringToNumber("44");'.
	self assert: (interpreter environment at: 'xxx') equals: 44. 
	
	self interpret: 'var xxx = stringToNumber("hello");'.
	self assert: (interpreter environment at: 'xxx') equals: 'Not a numerical string!'. 
]

{ #category : #running }
JbInterpreterTest >> testWhileStatement [
	self interpret: 'var n = 1; var sum = 0; while(n <= 10) {sum = sum + n; n = n + 1;}'.
	self assert: (interpreter environment at: 'sum') equals: 55.
]
