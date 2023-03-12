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
		'process',
		'texture'
	],
	#category : #MBEngine
}

{ #category : #cleanup }
MBGame class >> cleanUp [ 
	MBGame allInstancesDo: [ :x | x renderer destroy. x window destroy ]
]

{ #category : #cleanup }
MBGame class >> menuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Run Game')
		order: 100;
		help: 'Run Game';
		action: [ MBGame new openInWindow ]
]

{ #category : #drawing }
MBGame >> drawOn: canvas [

	| rayAngle ray rayCos raySin wall distance wallHeight wallColor texX scaledCol |
	super drawOn: canvas.
	rayAngle := self player angle - self player halfFov.

	1 to: screenWidth do: [ :rayCount | 
		ray := MBRay new.
		ray position: player position.
		rayCos := rayAngle degreesToRadians cos / raycastPrecision.
		raySin := rayAngle degreesToRadians sin / raycastPrecision.
		wall := 0.
		[ wall = 0 ] whileTrue: [ 
			ray position: ray position + (rayCos @ raySin).
			wall := map at: ray position y floor @ ray position x floor ].

		distance := player position distanceTo: ray position.
		distance := distance
		            * (rayAngle - self player angle) degreesToRadians cos.
		wallColor := Color red.

		wallHeight := (self halfScreenHeight / distance) floor.
		distance floor timesRepeat: [ wallColor := wallColor darker ].
		scaledCol := texture getCol: (ray position) wallHeight: wallHeight.
		canvas translateBy: owner bounds origin + (3 @ 30) during: [ :c | 
			
			c
				fillRectangle:
				(rayCount @ 0 extent: 1 @ (self halfScreenHeight - wallHeight))
				color: Color cyan.

			c drawImage: scaledCol at: rayCount@(self halfScreenHeight - wallHeight).
			
		"	c
				fillRectangle:
					(rayCount @ (self halfScreenHeight - wallHeight) extent:
						 1 @ (self halfScreenHeight + wallHeight))
				color: wallColor."
			c
				fillRectangle:
					(rayCount @ (self halfScreenHeight + wallHeight) extent:
						 1 @ self screenHeight)
				color: Color green ].

		rayAngle := rayAngle + self rayIncrementAngle ]
]

{ #category : #'as yet unclassified' }
MBGame >> drawTexture: x texX: texX wallHeight: wallHeight [
	| tmp |
	tmp := texture scaledToSize: wallHeight@wallHeight*2.
	^ tmp copy: ((texX)@0 corner: (texX+1)@(wallHeight*2)).
]

{ #category : #'accessing - computed' }
MBGame >> halfScreenHeight [
	^ self screenHeight / 2
]

{ #category : #'accessing - computed' }
MBGame >> halfScreenWidth [
	^ self screenWidth / 2
]

{ #category : #'event handling' }
MBGame >> handleKeystroke: anEvent [
    | keyValue pCos pSin newPosition |
	 
	pCos := (player angle degreesToRadians cos) * player moveSpeed.
	pSin := (player angle degreesToRadians sin) * player moveSpeed.
	newPosition := player position.
	
    keyValue := anEvent keyValue.

    keyValue = $w asInteger
        ifTrue: [newPosition := player position + (pCos@pSin)].
    keyValue = $s asInteger "down arrow"
        ifTrue: [newPosition :=  player position - (pCos@pSin)].
    keyValue = $d asInteger "right arrow"
        ifTrue: [self player angle: self player angle + self player rotationSpeed].
    keyValue = $a asInteger "left arrow"
        ifTrue: [self player angle: self player angle - self player rotationSpeed].

	(map at: newPosition) = 0 ifTrue: [ player position: newPosition ].
    self changed. 

]

{ #category : #accessing }
MBGame >> handlesMouseDown: anEvent [
    ^ true
]

{ #category : #accessing }
MBGame >> handlesMouseOver: anEvent [
    ^ true
]

{ #category : #initialization }
MBGame >> initialize [ 
	super initialize.
	
	screenWidth := 640.
	screenHeight := 480.
	self extent: screenWidth@screenHeight.
	renderDelay := 30.
	raycastPrecision := 64.
	player := MBPlayer new.
	player fov: 60.
	player angle: 90.
	player position: 2@2.
	player moveSpeed: 0.5.
	player rotationSpeed: 5.0.
	map := MBMap new.
	map width: 10.
	map height: 10.
	map mapData: (OrderedCollection newFrom: { 
	        1. 1. 1. 1. 1. 1. 1. 1. 1. 1.
	        1. 0. 0. 0. 0. 0. 0. 0. 0. 1.
	        1. 0. 0. 0. 0. 0. 0. 0. 0. 1.
	        1. 0. 0. 1. 1. 0. 1. 0. 0. 1.
	        1. 0. 0. 1. 0. 0. 1. 0. 0. 1.
	        1. 0. 0. 1. 0. 0. 1. 0. 0. 1.
	        1. 0. 0. 1. 0. 1. 1. 0. 0. 1.
	        1. 0. 0. 0. 0. 0. 0. 0. 0. 1.
	        1. 0. 0. 0. 0. 0. 0. 0. 0. 1.
	        1. 1. 1. 1. 1. 1. 1. 1. 1. 1 }).
	
	map game: self.
	
	texture := MBTexture new load: '/Users/rsayers/Desktop/brick.png'.
	
	

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
MBGame >> mouseEnter: anEvent [
    anEvent hand newKeyboardFocus: self
]

{ #category : #accessing }
MBGame >> player [

	^ player
]

{ #category : #accessing }
MBGame >> player: anObject [

	player := anObject
]

{ #category : #'accessing - geometry' }
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

{ #category : #'accessing - computed' }
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
