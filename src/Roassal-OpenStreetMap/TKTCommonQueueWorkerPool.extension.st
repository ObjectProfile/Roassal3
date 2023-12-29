Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*Roassal-OpenStreetMap' }
TKTCommonQueueWorkerPool >> cancelIfNotStarted: aTKTFuture [

	taskQueue removeAllSuchThat: [ :futureExecution |
		futureExecution future = aTKTFuture ]
]
