Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfElseNode >> executeIn: environment [
	(condition evaluateIn: environment)
		ifTrue: [ ^ (trueStatements collect: [ :stmt | stmt executeIn: environment ])
				last ]
		ifFalse: [ ^ (falseStatements collect: [ :stmt | stmt executeIn: environment ])
				last ]
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
