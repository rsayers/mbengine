Class {
	#name : #MBGame,
	#superclass : #Morph,
	#instVars : [
		'screenWidth',
		'screenHeight',
		'renderDelay',
		'player',
		'raycastPrecision',
		'map',
		'running',
		'process'
	],
	#pools : [
		'SDL2Constants',
		'SDL2Types'
	],
	#category : #MBEngine
}

{ #category : #cleanup }
MBGame class >> cleanUp [ 
	MBGame allInstancesDo: [ :x | x renderer destroy. x window destroy ]
]

{ #category : #drawing }
MBGame >> drawOn: canvas [ 

	| rayAngle ray rayCos raySin wall distance wallHeight b|
	b := [ 
	rayAngle := self player halfFov.

	1 to: screenWidth do: [ :rayCount | 
		ray := MBRay new.
		ray position: player position.
		rayCos := rayAngle degreesToRadians cos / raycastPrecision.
		raySin := rayAngle degreesToRadians sin / raycastPrecision.
		wall := 0.
		[ wall = 0 ] whileTrue: [ 
			ray position: ray position + (rayCos @ raySin).
			wall := (map at: ray position y floor) at: (ray position x floor) ].

		distance := player position distanceTo: ray position.
		wallHeight := (self halfScreenHeight / distance) floor.
		canvas fillRectangle: (rayCount@0 extent: 1@(self halfScreenHeight - wallHeight)) color: Color cyan.
		canvas fillRectangle: (rayCount@(self halfScreenHeight - wallHeight) extent:  1@(self halfScreenHeight + wallHeight)) color: Color red.
		canvas fillRectangle: (rayCount@(self halfScreenHeight + wallHeight) extent: 1@(self screenHeight)) color: Color green.

		rayAngle := rayAngle + self rayIncrementAngle ].
	] bench.
	b inspect.
]

{ #category : #'as yet unclassified' }
MBGame >> halfScreenHeight [
	^ self screenHeight / 2
]

{ #category : #'as yet unclassified' }
MBGame >> halfScreenWidth [
	^ self screenWidth / 2
]

{ #category : #initialization }
MBGame >> initialize [
	super initialize.
	self bounds: (0@0 corner: 640@480).
	screenWidth := 640.
	screenHeight := 640.
	renderDelay := 30.
	raycastPrecision := 64.
	player := MBPlayer new.
	player fov: 60.
	player position: 2@2.
	map := { 
		       { 1. 1. 1. 1. 1. 1. 1. 1. 1. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 1. 1. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 0. 1. 0. 0. 1 }.
		       { 1. 0. 0. 1. 0. 1. 1. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 0. 0. 0. 0. 0. 0. 0. 0. 1 }.
		       { 1. 1. 1. 1. 1. 1. 1. 1. 1. 1 } }.

]

{ #category : #accessing }
MBGame >> map [

	^ map
]

{ #category : #accessing }
MBGame >> map: anObject [

	map := anObject
]

{ #category : #accessing }
MBGame >> player [

	^ player
]

{ #category : #accessing }
MBGame >> player: anObject [

	player := anObject
]

{ #category : #'as yet unclassified' }
MBGame >> pointsOnLineFrom: startPoint to: endPoint [
    | x1 y1 x2 y2 dx dy steps x y points |
    x1 := startPoint x.
    y1 := startPoint y.
    x2 := endPoint x.
    y2 := endPoint y.
    dx := x2 - x1.
    dy := y2 - y1.
    steps := dx abs max: dy abs.
    dx := dx asFloat / steps.
    dy := dy asFloat / steps.
    x := x1 asFloat.
    y := y1 asFloat.
    points := OrderedCollection new.
    1 to: steps + 1 do: [ :i |
        points add: x asInteger @ y asInteger.
        x := x + dx.
        y := y + dy.
    ].
    ^ points
]

{ #category : #'as yet unclassified' }
MBGame >> rayIncrementAngle [
	^ self player fov / self screenWidth 
]

{ #category : #accessing }
MBGame >> raycastPrecision [

	^ raycastPrecision
]

{ #category : #accessing }
MBGame >> raycastPrecision: anObject [

	raycastPrecision := anObject
]

{ #category : #accessing }
MBGame >> renderDelay [

	^ renderDelay
]

{ #category : #accessing }
MBGame >> renderDelay: anObject [

	renderDelay := anObject
]

{ #category : #accessing }
MBGame >> screenHeight [

	^ screenHeight
]

{ #category : #accessing }
MBGame >> screenHeight: anObject [

	screenHeight := anObject
]

{ #category : #accessing }
MBGame >> screenWidth [

	^ screenWidth
]

{ #category : #accessing }
MBGame >> screenWidth: anObject [

	screenWidth := anObject
]
