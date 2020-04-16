"
A mock ui manager class
"
Class {
	#name : #MockUiManager,
	#superclass : #Object,
	#instVars : [
		'prompt',
		'response'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
MockUiManager >> default [ 
	^self
]

{ #category : #accessing }
MockUiManager >> prompt [
	^ prompt
]

{ #category : #accessing }
MockUiManager >> prompt: anObject [
	prompt := anObject
]

{ #category : #accessing }
MockUiManager >> request: aString [ 
	prompt := aString.
	response := 'Some user response'.
]

{ #category : #accessing }
MockUiManager >> response [
	^ response
]

{ #category : #accessing }
MockUiManager >> response: anObject [
	response := anObject
]
