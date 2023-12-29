"
The PLTSpineDecoration class represent the spine of a matplot visualization. It represents the surrounding box that contains plots and scatters.

The class has the responsibilty to draw a usually black box around a visualization. 

The class collaborates with PLT and PLTTitleDecoration. The PLTTitleDecoration class requires the shape in order to put a title above.

The method is not meant to be used by a normal user as it represents a functionality to be used directly by PLT, and does not offer much configuration.

  Instance Variables
	shape:		<TSBox>	The box that surrounds the visualization

"
Class {
	#name : 'RSChartSpineDecoration',
	#superclass : 'RSAbstractChartDecoration',
	#instVars : [
		'box'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'accessing' }
RSChartSpineDecoration >> box [
	^ box
]

{ #category : 'accessing' }
RSChartSpineDecoration >> createdShapes [
	^ { box }
]

{ #category : 'initialization' }
RSChartSpineDecoration >> defaultShape [
	^ RSBox new
		noPaint;
		border: (RSBorder new joinMiter);
		yourself
]

{ #category : 'testing' }
RSChartSpineDecoration >> isSpineDecoration [
	^ true
]

{ #category : 'rendering' }
RSChartSpineDecoration >> renderIn: canvas [

	box := self shape copy
		       borderColor: self styler spineColor;
		       extent: chart extent.
	box translateTo: chart extent x / 2 @ (chart extent y negated / 2).
	canvas add: box
]

{ #category : 'accessing' }
RSChartSpineDecoration >> zeroPoint [
	^ 0 @ self chart extent y
]
