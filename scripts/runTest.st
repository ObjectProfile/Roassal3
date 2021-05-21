"We capture all the unit tests in Pharo"
unitTestsBefore := TestCase withAllSubclasses.

"We load the application software analyzer"
[ Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load: 'GraphViz' ] on: MCMergeOrLoadWarning do: [ :warning | warning load ]

"We identify the unit tests contained in the loaded application"
unitTests := (TestCase withAllSubclasses copyWithoutAll: unitTestsBefore) sorted: [ :c1 :c2 | c1 name < c2 name ].

"We create a file that will contain the result of the test execution"
path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
stream := path asFileReference writeStream.

"We run the unit tests"
unitTests do: [ :unitTestClass |
	res := unitTestClass buildSuite run.
	(res hasFailures or: [ res hasErrors ]) ifTrue: [ stream nextPutAll: 'ERROR: ' ].
	stream nextPutAll: unitTestClass name, ' ', res asString.
	stream crlf
].

"We close the stream and quit Pharo"
stream close.
SmalltalkImage current quitPrimitive
