[list of classes](reference.md)
# RSEvent
`RSEvent` is the root of all the events handled by Roassal. Events are expressed as an instance of a subclass of `RSEvent`. Some events describe the actions made by the users (e.g., `RSMouseDragEnd`), some other event describes some state change of a shape (e.g., `RSShapeAddedEvent`, `RSHighlightEvent`).

*Responsibility*: model an event triggered either by a user action or a state change.

*Collaborators*: events are emitted by `RSAthensMorph` or by some interaction (e.g., `RSHighlightable`)

*Variables*:
- `canvas`: the `RSCanvas` 
- `morph`: the `RSAthensMorph` 
- `shape`: the shape related to the event
  