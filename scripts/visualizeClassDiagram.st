[ Metacello new
    baseline: 'Roassal';
    repository: 'github://pharo-graphics/Roassal';
    load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'RoassalExporters';
    repository: 'github://pharo-graphics/RoassalExporters';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'ReinforcementLearning';
    repository: 'github://bergel/ReinforcementLearning:main';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ].


packageNameRegExp := 'Roassal3*'.
packages := RPackageOrganizer default packages select: [ :p | packageNameRegExp match: p packageName ].
allClasses := packages flatCollect: #definedClasses.
uml := RSUMLClassBuilder new.
uml classes: allClasses.
uml build.

uml canvas extent: 5000 @ 800.

RSPNGExporter new
  canvas: uml canvas;
  exportToFile: 'uml.png' asFileReference.

SmalltalkImage current quitPrimitive
