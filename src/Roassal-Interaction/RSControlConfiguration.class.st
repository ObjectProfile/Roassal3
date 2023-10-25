"
A control configuration is shared by the interactions of `RSCanvasController`. For example, by modifying a control configuration, the minimum zoom, or maximum zoom, the padding.

For examples:
- `RSControlConfiguration class >> #example1`
- `RSControlConfiguration class >> #example2`
"
Class {
	#name : 'RSControlConfiguration',
	#superclass : 'RSObject',
	#instVars : [
		'padding',
		'maxScale',
		'minScale',
		'shouldUseBasicZoom',
		'shouldShowLegend',
		'shouldAnimateZoom'
	],
	#category : 'Roassal-Interaction-Utils',
	#package : 'Roassal-Interaction',
	#tag : 'Utils'
}

{ #category : 'initialization' }
RSControlConfiguration >> initialize [
	super initialize.
	self
		"used in zoom out"
		minScale: 0.04;
		"used in zoom in"
		maxScale: 7;
		padding: 25;
		withLegend;
		noBasicZoom;
		shouldAnimateZoom: true
]

{ #category : 'accessing' }
RSControlConfiguration >> maxScale [
	^ maxScale
]

{ #category : 'accessing' }
RSControlConfiguration >> maxScale: aNum [
	"Set the maximum scale for the configuration.
	Used in the zoom in level"
	maxScale := aNum
]

{ #category : 'accessing' }
RSControlConfiguration >> minScale [
	^ minScale
]

{ #category : 'accessing' }
RSControlConfiguration >> minScale: aNum [
	"Set the minimum scale allowed by the configuration.
	Used in zoom out level"
	minScale := aNum
]

{ #category : 'configuration' }
RSControlConfiguration >> noBasicZoom [
	shouldUseBasicZoom := false
]

{ #category : 'configuration' }
RSControlConfiguration >> noLegend [
	shouldShowLegend := false
]

{ #category : 'accessing' }
RSControlConfiguration >> padding [
	^ padding
]

{ #category : 'accessing' }
RSControlConfiguration >> padding: aMargin [
	padding := aMargin asMargin
]

{ #category : 'accessing' }
RSControlConfiguration >> shouldAnimateZoom [

	^ shouldAnimateZoom
]

{ #category : 'accessing' }
RSControlConfiguration >> shouldAnimateZoom: aBoolean [

	shouldAnimateZoom := aBoolean
]

{ #category : 'testing' }
RSControlConfiguration >> shouldShowLegend [
	^ shouldShowLegend
]

{ #category : 'testing' }
RSControlConfiguration >> shouldUseBasicZoom [
	^ shouldUseBasicZoom
]

{ #category : 'configuration' }
RSControlConfiguration >> useBasicZoom [
	shouldUseBasicZoom := true
]

{ #category : 'configuration' }
RSControlConfiguration >> withLegend [
	shouldShowLegend := true
]
