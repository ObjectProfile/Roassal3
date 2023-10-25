"
I am group of fields that describe a layout, each field is editable and can be create a presenter that will edit a layout
"
Class {
	#name : 'RSLayoutDefinition',
	#superclass : 'RSObject',
	#instVars : [
		'fields'
	],
	#category : 'Roassal-LayoutStudio-Core',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Core'
}

{ #category : 'initialization' }
RSLayoutDefinition >> add: aRSLayoutField [
	fields add: aRSLayoutField
]

{ #category : 'accessing - computed' }
RSLayoutDefinition >> fieldNamed: aString [
	^ fields detect: [ :field | field selector = aString ] ifNone: [ nil ]
]

{ #category : 'accessing' }
RSLayoutDefinition >> fields [
	^ fields
]

{ #category : 'printing' }
RSLayoutDefinition >> generateStringCode [
	^ String streamContents: [ :stream | self generateStringCodeOn: stream ]
]

{ #category : 'printing' }
RSLayoutDefinition >> generateStringCodeOn: stream [
	self generateStringCodeOn: stream tab: 0
]

{ #category : 'printing' }
RSLayoutDefinition >> generateStringCodeOn: stream tab: tabsSize [
	| layout changedFields |
	layout := self layoutStudio.
	layout ifNil: [ ^ stream << '"Nothing to generate"' ].
	layout := layout currentLayout.
	tabsSize isZero ifTrue: [ stream << 'layout := '].
	stream << layout class name << ' new'.
	changedFields := fields select: [ :field | field hasChanged ].
	changedFields ifEmpty: [
		tabsSize isZero ifTrue: [ stream << '.' ].
		^ self ].
	changedFields do: [ :field |
		stream cr.
		tabsSize + 1 timesRepeat: [stream tab].
		field printOn: stream tab: tabsSize + 1.
		stream << ';'.
		 ].
	stream cr.
	tabsSize + 1 timesRepeat: [stream tab].
	stream << 'yourself'.
	tabsSize isZero ifTrue: [ stream << '.' ]
]

{ #category : 'initialization' }
RSLayoutDefinition >> initialize [
	super initialize.
	fields := OrderedCollection new
]

{ #category : 'accessing' }
RSLayoutDefinition >> layoutStudio [
	^ fields
		ifEmpty: [ nil ]
		ifNotEmpty: [ fields first layoutStudio ]
]

{ #category : 'updating' }
RSLayoutDefinition >> update [
	self fields do: [ :field |
		field disableEvent; update; enableEvent ]
]
