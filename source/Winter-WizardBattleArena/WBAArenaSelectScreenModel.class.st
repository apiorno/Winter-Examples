"
Class representenging the arena selection view model

Public API and Key Messages

- downSelection  
- upSelection
- endScreenComputation
- switchToNextScreen
- renderWidgetsOn:
 
Internal Representation and Key Implementation Points.

    Instance Variables
		currentChoice 
		titleWidget 
		arrowWidget 
		arenaWidget 
		arenas
	
"
Class {
	#name : #WBAArenaSelectScreenModel,
	#superclass : #WBAMenuScreenModel,
	#instVars : [
		'currentChoice',
		'titleWidget',
		'arrowWidget',
		'arenaWidget',
		'arenas'
	],
	#category : #'Winter-WizardBattleArena'
}

{ #category : #actions }
WBAArenaSelectScreenModel >> downSelection [
	currentChoice := currentChoice \\ self numArenas + 1.
]

{ #category : #actions }
WBAArenaSelectScreenModel >> endScreenComputation [
	game gameDescriptor arenaDescriptor: (WBAArenaDescriptor perform: (arenas at: currentChoice)).
]

{ #category : #'event handling' }
WBAArenaSelectScreenModel >> handleKeyStrokeFor: playerIndex key: index [ 

]

{ #category : #initialization }
WBAArenaSelectScreenModel >> initialize [

	super initialize.

	currentChoice := 1.
]

{ #category : #initialization }
WBAArenaSelectScreenModel >> loadWidgets [
	titleWidget := self newSelectWidget: (self textWidgetAt: #arena).
	arenas := WBAArenaDescriptor perform: ('available' , game players size printString, 'Players') asSymbol.
	arenaWidget := self newArenaWidget: self numArenas.
	arrowWidget := self newLargeArrowSelectWidget: 300.
]

{ #category : #'Screen Building' }
WBAArenaSelectScreenModel >> newArenaWidget: numArenas [
	^ self newColumnWidget: ((1 to: numArenas) collect: [ :i | self newSubArenaWidget: i ]) space: 80
]

{ #category : #'Screen Building' }
WBAArenaSelectScreenModel >> newSubArenaWidget: num [
	^ self newRowWidget: { (self textWidgetAt: #arena) . (self textWidgetAt: num) } space: 170
]

{ #category : #Accessing }
WBAArenaSelectScreenModel >> numArenas [
	^ arenas size min: 4
]

{ #category : #Rendering }
WBAArenaSelectScreenModel >> renderWidgetsOn: canvas [
	titleWidget renderOn: canvas translatedBy: 210@30.
	canvas pathTransform translateBy: -40@90.
	arenaWidget renderOn: canvas translatedBy: 100@0.
	arrowWidget renderOn: canvas translatedBy: -75 @ (currentChoice * 80 - 70)
]

{ #category : #actions }
WBAArenaSelectScreenModel >> switchToNextScreen [

	WBAArenaBootstrap new bootstrapGame: game on: screen
]

{ #category : #actions }
WBAArenaSelectScreenModel >> upSelection [
	currentChoice := currentChoice - 1.
	currentChoice = 0 ifTrue: [ currentChoice := self numArenas ].
]
