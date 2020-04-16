"
A mock transcript class
"
Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
MockTranscript >> contents [
	^contents contents.
]

{ #category : #accessing }
MockTranscript >> contents: aString [
	contents nextPutAll: aString
]

{ #category : #accessing }
MockTranscript >> cr [ 
	contents nextPutAll: String cr.
]

{ #category : #initialization }
MockTranscript >> initialize [ 
	super initialize.
	contents := String new writeStream.
]

{ #category : #accessing }
MockTranscript >> open [ 
	^nil.
]

{ #category : #accessing }
MockTranscript >> show: aString [
	self contents: aString.
	
]
