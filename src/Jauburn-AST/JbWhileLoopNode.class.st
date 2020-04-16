Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'whileStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
JbWhileLoopNode >> executeIn: environment [
	^ (condition evaluateIn: environment)
		ifTrue: [ whileStatements do: [ :stmt | stmt executeIn: environment ].
			"recursive for each iteration"
			self executeIn: environment ]
]

{ #category : #accessing }
JbWhileLoopNode >> whileStatements [
	^ whileStatements
]

{ #category : #accessing }
JbWhileLoopNode >> whileStatements: anObject [
	whileStatements := anObject
]
