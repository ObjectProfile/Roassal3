"
I am the test class for TSAthensRenderer 
"
Class {
	#name : 'RSAthensRendererTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Shapes-Tests',
	#package : 'Roassal-Shapes-Tests'
}

{ #category : 'tests' }
RSAthensRendererTest >> testArcCorner [
	| renderer |
	renderer := RSAthensRenderer new.
	self assert: (renderer
		arcCornerTangets: -17.172947580489485@ -71.29423293069038
		p1: -58.258908750504766 @ -212.1459392757739
		r: 220
		rc: 11.316433244555238
		cw: true)

		equals: (-54.9506649278924@ 200.80455223867077) -> (-46.47771241701749@ 215.03446758248086)
]
