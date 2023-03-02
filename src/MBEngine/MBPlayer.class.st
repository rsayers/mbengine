Class {
	#name : #MBPlayer,
	#superclass : #Object,
	#instVars : [
		'fov',
		'position',
		'angle',
		'rotationSpeed',
		'moveSpeed'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBPlayer >> angle [

	^ angle
]

{ #category : #accessing }
MBPlayer >> angle: anObject [

	angle := anObject
]

{ #category : #accessing }
MBPlayer >> fov [

	^ fov.
]

{ #category : #accessing }
MBPlayer >> fov: anObject [

	fov := anObject
]

{ #category : #accessing }
MBPlayer >> halfFov [

	^ fov // 2
]

{ #category : #accessing }
MBPlayer >> moveSpeed [

	^ moveSpeed
]

{ #category : #accessing }
MBPlayer >> moveSpeed: anObject [

	moveSpeed := anObject
]

{ #category : #accessing }
MBPlayer >> position [

	^ position
]

{ #category : #accessing }
MBPlayer >> position: anObject [

	position := anObject
]

{ #category : #accessing }
MBPlayer >> rotationSpeed [

	^ rotationSpeed
]

{ #category : #accessing }
MBPlayer >> rotationSpeed: anObject [

	rotationSpeed := anObject
]
