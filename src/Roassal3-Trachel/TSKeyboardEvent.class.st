"
A base class for keyboard events.
"
Class {
	#name : #TSKeyboardEvent,
	#superclass : #TSUserInputEvent,
	#instVars : [
		'keyValue',
		'symbol'
	],
	#classVars : [
		'KeySymbolMap'
	],
	#pools : [
		'OSKeySymbols'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #'class initialization' }
TSKeyboardEvent class >> initialize [ 
	KeySymbolMap := IdentityDictionary newFromPairs: { 
		#A . OSK_a .
		#B . OSK_b .
		#C . OSK_c .
		#D . OSK_d .
		#E . OSK_e .
		#F . OSK_f .
		#G . OSK_g .
		#H . OSK_h .
		#I . OSK_i .
		#J . OSK_j .
		#K . OSK_k .
		#L . OSK_l .
		#M . OSK_m .
		#N . OSK_n .
		#O . OSK_o .
		#P . OSK_p .
		#Q . OSK_q .
		#R . OSK_r .
		#S . OSK_s .
		#T . OSK_t .
		#U . OSK_u .
		#W . OSK_w .
		#X . OSK_x .
		#Y . OSK_y .
		#Z . OSK_z .
		#SPACE . OSK_SPACE .
		#KP_SPACE . OSK_SPACE .
		#KP_UP . OSK_UP .
		#KP_LEFT . OSK_LEFT .
		#KP_RIGHT . OSK_RIGHT .
		#KP_DOWN . OSK_DOWN .
		#CONTROL_L . OSK_LCTRL.
		#SHIFT_L . OSK_LSHIFT.
		#ALT_L . OSK_LALT.
		#META_L . OSK_LGUI.
	}.
]

{ #category : #public }
TSKeyboardEvent class >> symbolFor: keyValue [ 
	| keyName |
	keyName := (Smalltalk os keyForValue: keyValue) name asSymbol.
	
	^ KeySymbolMap at: keyName ifAbsent: [ OSK_UNKNOWN ].
]

{ #category : #comparing }
TSKeyboardEvent >> = anotherKeyDown [
	"Do we really need this method? It has been imported from Roassal1"
	(self class == anotherKeyDown) ifFalse: [  ^ false ].
	^ self keyValue = anotherKeyDown keyValue
]

{ #category : #initialize }
TSKeyboardEvent >> initialize [
	super initialize.
	keyValue := 0
]

{ #category : #accessing }
TSKeyboardEvent >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
TSKeyboardEvent >> keyCombination: anObject [
	keyCombination := anObject
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue [
	^ keyValue
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue: anObject [
	keyValue := anObject
]

{ #category : #accessing }
TSKeyboardEvent >> symbol [ 
	^ symbol ifNil: [ symbol := self class symbolFor: keyValue ].
]
