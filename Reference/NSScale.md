[list of classes](reference.md)
# NSScale
`NSScale` is a common scale interpolator. It transformes numerical or ordinal values using a range and a domain. `NSScale` offers several scales as class side methods. The code of the scales are inspired from https://github.com/d3/d3-scale

*Responsibility*: act as a scale interpolator for numerical and ordinal values.

*Collaborators*: `NSScale` depends on a number of Pharo packages, including `Colors`, `Random-Core`. The scales are intensively used by Roassal

*Variables*:
- `range`: contains an array of two elements. The range variable defines the range of the scaled value.
- `VARIABLE2`:

*Example*:
```Smalltalk
s := NSScale linear.
s range: { 5 . 10 }.
s scale: 0. "=> 5"
s scale: 0.5. "=> 7.5"
s scale: 1. "=> 10"
```

```Smalltalk
s := NSScale linear.
s domain: { -1 . 1 }.
s range: { 5 . 10 }.
s scale: 0.5
```

```Smalltalk
s := NSScale linear.
s range: { Color white . Color black }.
s scale: 0.5  "=> Color gray"
```