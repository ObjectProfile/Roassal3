"
The PLTSpineDecoration class represent the spine of a matplot visualization. It represents the surrounding box that contains plots and scatters.

The class has the responsibilty to draw a usually black box around a visualization. 

The class collaborates with PLT and PLTTitleDecoration. The PLTTitleDecoration class requires the shape in order to put a title above.

The method is not meant to be used by a normal user as it represents a functionality to be used directly by PLT, and does not offer much configuration.

  Instance Variables
	shape:		<TSBox>	The box that surrounds the visualization

"
Class {
	#name : #PLTSpineDecoration,
	#superclass : #PLTDecoration,
	#instVars : [
		'shape'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTSpineDecoration >> renderIn: canvas [
	shape := RSBox new color: nil; extent: plt extent; border: RSBorder new.
	shape translateTo: (plt extent x / 2) @ (plt extent y negated / 2).
	canvas addShape: shape
]

{ #category : #rendering }
PLTSpineDecoration >> shape [
	^ shape
]
