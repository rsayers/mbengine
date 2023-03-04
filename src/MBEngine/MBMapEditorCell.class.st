Class {
	#name : #MBMapEditorCell,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'mapCell'
	],
	#category : #MBEngine
}

{ #category : #initialization }
MBMapEditorCell >> initialize [ 
	super initialize.
	self label: ''.
	self borderWidth: 2.
	bounds := 0 @ 0 corner: 50 @ 50.
	offColor := Color paleYellow.
	onColor := Color blue.
	self useSquareCorners.
	self turnOff
]

{ #category : #initialization }
MBMapEditorCell >> map [ 
	^ owner map.
]

{ #category : #accessing }
MBMapEditorCell >> mapCell [

	^ mapCell
]

{ #category : #accessing }
MBMapEditorCell >> mapCell: anObject [

	mapCell := anObject
]

{ #category : #initialization }
MBMapEditorCell >> mouseDown: evt [ 
	| cellVal |
	super mouseDown: evt.
	self toggleState.
	cellVal := self isOn ifTrue: [ 1 ] ifFalse: [ 0 ].
	self map at: (mapCell) put: cellVal.
	self map game changed.
]
