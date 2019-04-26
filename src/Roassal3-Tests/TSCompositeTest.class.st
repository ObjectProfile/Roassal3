Class {
	#name : #TSCompositeTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSCompositeTest >> testPaddingError [

	| exception |
	exception := nil.
	[ TSComposite new padding: 5 ] on: Exception do: [ :ex | exception := ex ].

	self assert: exception notNil.
	self assert: (exception description beginsWith: 'Error: Composite cannot not be empty')
]

{ #category : #tests }
TSCompositeTest >> testPaddingError2 [
	

	| exception |
	exception := nil.
	[TSComposite new
		shapes: TSGroup new;
		padding: 5] on: Exception do: [ :ex | exception := ex ].

	self assert: exception notNil.
	self assert: (exception description beginsWith: 'Error: Composite cannot not be empty')
	

]

{ #category : #tests }
TSCompositeTest >> testPaddingOkay [
	"No error should be raised"
	TSComposite new
		shapes: (TSGroup new add: TSBox new; yourself);
		padding: 5.

	TSComposite new
		shapes: (TSGroup new add: TSBox new; add: TSBox new; yourself);
		padding: 5.

]
