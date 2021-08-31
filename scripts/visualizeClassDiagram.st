[ Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ].

[ Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
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

uml canvas extent: 1000 @ 1000.
RSPNGExporter new
  canvas: uml canvas;
  exportToFile: 'uml.png' asFileReference.

SmalltalkImage current quitPrimitive
