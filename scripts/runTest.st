| path stream repoPath unitTests numberOfPassed env cout packagesRegExp packages |
"We create a file that will contain the result of the test execution"
path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
stream := path asFileReference writeStream.


env := Smalltalk os environment.
cout := Stdio stdout.
cout << '>>> Removing old roassal code'; crlf.

packagesRegExp := { '*Roassal3*' }.

packages := packagesRegExp flatCollect: [ :regExp |
	RPackageOrganizer default packages
		select: [ :p | regExp match: p packageName ] ].

packages := packages reject: [ :pck | pck name = 'Roassal3-Pharo7' ].
packages do: [ :package | package removeFromSystem ].

cout << '>>> Updating fonts'; crlf.
FreeTypeFontProvider current updateFromSystem.

cout << '>>> Clonning from: '.

repoPath := 'gitlocal://', (env at: 'GITHUB_WORKSPACE').
cout << 'Loading: '; << repoPath; crlf.
"We load the application software analyzer"
[ Metacello new
    baseline: 'Roassal3';
    repository: repoPath;
    load: 'Full' ] on: MCMergeOrLoadWarning do: [ :warning | warning load ].
cout << '>>> Running tests:'; crlf.
"We identify the unit tests contained in the loaded application"
unitTests := (TestCase withAllSubclasses select: [ :cls | cls package packageName beginsWith: 'Roassal3' ]) sorted: [ :c1 :c2 | c1 name < c2 name ].

numberOfPassed := 0.
"We run the unit tests"
unitTests do: [ :unitTestClass | | res |
	res := unitTestClass buildSuite run.
	(res hasFailures or: [ res hasErrors ]) ifTrue: [ 

		stream 
			nextPutAll: 'ERROR: ';
			nextPutAll: unitTestClass name; space;
			nextPutAll: res asString;
			crlf.
		unitTestClass name = #RSExamplesTest ifTrue: [
			[RSExamplesTest new testExamples]
			on: Error 
			do: [ :ex | ex signalContext shortDebugStackOn: stream ].
			stream nextPutAll: '-:V-';crlf.
		] 
	].
	numberOfPassed := numberOfPassed + res passed size.
].

stream crlf.
stream nextPutAll: 'NUMBER OF UNIT TESTS=', unitTests size asString; crlf.
stream nextPutAll: 'NUMBER OF PASSED TEST METHODS=', numberOfPassed asString; crlf.
stream nextPutAll: 'NUMBER OF TEST METHODS=', (unitTests flatCollect: [ :cls | cls buildSuite tests ]) size asString; crlf.
stream nextPutAll: 'END'; crlf.

"We close the stream and quit Pharo"
stream close.

SmalltalkImage current quitPrimitive
