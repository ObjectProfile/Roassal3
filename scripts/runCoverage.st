| profiler classSizeScale classColorCoverage m lbl fileCoverageResult str |
   
'Loading spy2 roassal3 and exporters' traceCr.
[ Metacello new 
	baseline: 'Spy2'; 
	repository: 'github://ObjectProfile/Spy2'; 
	load: 'HapaoCore' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ].
[ 
'Starting with Hapao' traceCr.
profiler := 'Hapao2' asClass runTestsForPackagesMatching: 'Roassal3*'.
'Profiler created' traceCr.
classSizeScale := 'NSScale' asClass linear range: #(5 30); domain: { 0 . (profiler allClasses max: #numberOfMethods) }.
classColorCoverage := 'NSScale' asClass linear range: {Color red . Color black}; domain: { 0 . 100 }.
m := 'RSMondrian' asClass new.
m shape labeled: #packageName; color: Color white; borderColor: Color gray.
m nodes: profiler packages forEach: [ :pak |
	m shape box 
		size: [ :cls | classSizeScale scale: cls numberOfMethods ];
		color: [ :cls | classColorCoverage scale: cls coverage ];
		if: #isTestClass color: Color green darker.
	m nodes: pak classes.
	m orthoVerticalLine connectFrom: #superclass.
	m layout tidyTree
].
m build.

lbl := RSLabel text: 'Ratio of covered methods = ', (profiler coverage asString), ' %'. 
RSLocation move: lbl above: m canvas nodes.
m canvas add: lbl.

fileCoverageResult := '/tmp/ratio' asFileReference.
fileCoverageResult exists ifTrue: [ fileCoverageResult delete ].
str := fileCoverageResult writeStream.
str nextPutAll: profiler coverage asString.
str close.
'Ratio created' traceCr.
m canvas extent: (1500 @ 1500).

'RSPNGExporter' asClass new
  canvas: m canvas;
  exportToFile: 'coverage.png' asFileReference.

'coverage.png created' traceCr.
SmalltalkImage current quitPrimitive
