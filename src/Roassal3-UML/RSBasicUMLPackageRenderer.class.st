"
A basic renderer for UML packages
"
Class {
	#name : #RSBasicUMLPackageRenderer,
	#superclass : #RSAbstractUMLPackageRenderer,
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #initialization }
RSBasicUMLPackageRenderer >> initialize [
	super initialize.
	packageBoxShape := RSShapeBuilder box
								paint: (Color colorFrom: 'cfd9df');								
								border: self border.
	packageNameBoxShape := RSShapeBuilder box
								paint: (Color colorFrom: 'cfd9df');								
								border: self border							
]

{ #category : #'private - initialization' }
RSBasicUMLPackageRenderer >> initializeShape [
	
	packageShape := RSShapeBuilder composite shapes: [ :pck | 
			| title group box1Element box2Element rec1 rec2 |
			 
			group := TSGroup new.
			group add: (self packageNameShape elementOn: pck).

			title := group first.
			
			box1Element := self packageNameBoxShape elementOn: pck.
			group addFirst: box1Element.

			rec1 := group encompassingRectangle.
			box1Element
				extent: rec1 extent + (10@10); "padding"
				position: rec1 rsCenter.			

			title position: rec1 rsCenter x @ title position y.
			
			box2Element := self packageBoxShape elementOn: pck.
			group addFirst: box2Element.
			 			
			rec2 := Rectangle origin: (rec1 bottomLeft + (-5@5)) extent: (rec1 extent + (250@200)).  "-5@5 is shift by half padding"
		
			box2Element
				extent: rec2 extent;
				position: rec2 rsCenter.
			
			group
	];
		interactionDo: [ :i | i popup; draggable; browseable ]
]
