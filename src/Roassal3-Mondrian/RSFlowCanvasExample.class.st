Class {
	#name : #RSFlowCanvasExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Flow'
}

{ #category : #examples }
RSFlowCanvasExample >> example01 [
	| shapes f |

	f := RSFlowCanvas new.
	f when: SmallInteger visualize: [ :canvas :number |
		shapes := RSCircle models: (1 to: number).
		canvas addAll: shapes.
		shapes @ RSLabeledInteraction @ RSPopup @ RSDraggableInteraction.
		RSNormalizer size
			shapes: shapes;
			normalize: #yourself.
		RSFlowLayout on: shapes.
		canvas @ RSCanvasController.
	].
	f clickOnModel: 20.
	f open
]

{ #category : #examples }
RSFlowCanvasExample >> example02CallGraph [
	| f cms lbls |

	f := RSFlowCanvas new.
	f when: CompiledMethod visualize: [ :canvas :compiledMethod |
		cms := compiledMethod messages.
	   lbls := cms collect: [ :cm | 
			RSLabel new model: cm ] as: RSGroup.
		canvas addAll: lbls. 
		RSVerticalLineLayout on: lbls.

	].
	
	f when: ByteSymbol visualize: [ :canvas :symbol |
		cms := SystemNavigation default allImplementorsOf: symbol.
		
		
		lbls := cms collect: [ :cm | 
			RSLabel new text: (cm methodClass asString, cm selector); model: cm ] as: RSGroup.
		canvas addAll: lbls. 
		RSVerticalLineLayout on: lbls.
		
	].
	f clickOnModel: #allMethods.
	f open
]
