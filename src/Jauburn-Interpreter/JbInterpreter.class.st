"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'primitives',
		'transcript',
		'uiManager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^#abs -> [:n | n abs]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^#concat -> [:a :b | a asString , b asString ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	primitives := Set new.
	self initializeEnvBindings.
]

{ #category : #initialization }
JbInterpreter >> initializeEnvBindings [
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding |
				binding := self perform: s.
				primitives add: binding key.
				environment at: binding key put: (JbPrimitive new block: binding value)]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [
	^#input -> [:value | self uiManager default request: value.]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^#length -> [:s | s size]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^#mod -> [:a :b | a \\ b]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [:n | n not]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^#print -> [:value | self transcript show: value printString]
]

{ #category : #primitives }
JbInterpreter >> printLnBinding [
	^#println -> [:value | self transcript show: value printString; cr.]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #primitives }
JbInterpreter >> stringToNumberBinding [
	^#stringToNumber -> [:s | [s asNumber] on: Error do: [ 'Not a numerical string!' ] ]
]

{ #category : #accessing }
JbInterpreter >> transcript [ 
   ^transcript ifNil: [ Transcript  ]
]

{ #category : #accessing }
JbInterpreter >> transcript: aTranscript [
   transcript := aTranscript
]

{ #category : #accessing }
JbInterpreter >> uiManager [ 
	  ^uiManager ifNil: [ UIManager   ]
]

{ #category : #accessing }
JbInterpreter >> uiManager: aUiManager [
   uiManager := aUiManager
]
