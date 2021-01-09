Class {
	#name : #RSFlowCanvasExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #examples }
RSFlowCanvasExample >> example01 [
	| shapes f |

	f := RSFlowCanvas new.
	f when: SmallInteger visualize: [ :canvas :number |
		shapes := RSCircle models: (1 to: number).
		canvas addAll: shapes.
		shapes @ RSLabeled @ RSPopup @ RSDraggable.
		RSNormalizer size
			shapes: shapes;
			normalize: #yourself.
		RSFlowLayout on: shapes.
		canvas @ RSCanvasController.
	].
	f clickOnModel: 20.
	f open
]
