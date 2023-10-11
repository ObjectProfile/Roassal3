Extension { #name : 'TKTCommonQueueWorkerPool' }

{ #category : '*Roassal3-OpenStreetMap' }
TKTCommonQueueWorkerPool >> cancelIfNotStarted: aTKTFuture [

	taskQueue removeAllSuchThat: [ :futureExecution |
		futureExecution future = aTKTFuture ]
]
