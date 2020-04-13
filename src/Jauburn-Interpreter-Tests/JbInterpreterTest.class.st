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
