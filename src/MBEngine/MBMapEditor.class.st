Class {
	#name : #MBMapEditor,
	#superclass : #BorderedMorph,
	#instVars : [
		'map',
		'cells'
	],
	#category : #MBEngine
}

{ #category : #accessing }
MBMapEditor >> cells [

	^ cells
]

{ #category : #accessing }
MBMapEditor >> cells: anObject [

	cells := anObject
]

{ #category : #actions }
MBMapEditor >> load: aMap [
	| sampleCell width height matrix |
	map := aMap.
	sampleCell := MBMapEditorCell  new.
	width := sampleCell width.
	height := sampleCell height.
	self bounds: (5 @ 5 extent: (width * map width) @ (height * map height) + (2 * self borderWidth)).
	matrix :=  Array2D rows: (map width) columns: (map height).  
	cells := matrix indicesCollect: [ :i :j | self newCellAt: i at: j].
]

{ #category : #accessing }
MBMapEditor >> map [

	^ map
]

{ #category : #accessing }
MBMapEditor >> map: anObject [

	map := anObject
]

{ #category : #accessing }
MBMapEditor >> newCellAt: i at: j [
	| c origin |
	c := MBMapEditorCell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i) * c width) @ ((j) * c height) + origin.
	c turnOff.
	((map at: i@j) = 1) ifTrue: [ c turnOn ].
	c mapCell: i@j.
	^ c
]

{ #category : #actions }
MBMapEditor >> toggleNeighboursOfCellAt: i at: j [
   i > 1
		ifTrue: [ (cells at: i - 1 at: j) toggleState ].
	i < map width
		ifTrue: [ (cells at: i + 1 at: j) toggleState ].
	j > 1
		ifTrue: [ (cells at: i at: j - 1) toggleState ].
	j < map height
		ifTrue: [ (cells at: i at: j + 1) toggleState ]
]
