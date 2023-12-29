"
Used to created a box for the popup of roassal
"
Class {
	#name : 'RSSimpleBoxBuilder',
	#superclass : 'RSObject',
	#instVars : [
		'color',
		'cornerRadius',
		'border',
		'padding'
	],
	#category : 'Roassal-Interaction-Popup',
	#package : 'Roassal-Interaction',
	#tag : 'Popup'
}

{ #category : 'accessing' }
RSSimpleBoxBuilder >> border [
	^ border
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> border: aRSBorder [
	border := aRSBorder
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> color [
	^ color
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> color: aColor [
	color := aColor
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> cornerRadius [
	^ cornerRadius
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> cornerRadius: aCornerRadius [
	cornerRadius := aCornerRadius
]

{ #category : 'initialization' }
RSSimpleBoxBuilder >> initialize [
	super initialize.
	self
		border: (RSBorder new color: Color gray);
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		padding: 10@7
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> padding [
	^ padding
]

{ #category : 'accessing' }
RSSimpleBoxBuilder >> padding: aPoint [
	padding := aPoint
]

{ #category : 'hooks' }
RSSimpleBoxBuilder >> shapeFor: aRSLabel [
	^ RSBox new
		color: self color;
		cornerRadius: self cornerRadius;
		border: self border;
		extent: aRSLabel extent + self padding;
		yourself
]
