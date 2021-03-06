"
Class representenging the character selection view model

Public API and Key Messages

- downSelection
- upSelection
- endScreenComputation
- loadWidgets
- switchToNextScreen
- renderWidgetsOn:
- screen:
 
Internal Representation and Key Implementation Points.

    Instance Variables
		currentChoice 
		arrowWidget 
		titleWidget 
		playersWidget
	
"
Class {
	#name : #WBANumberPlayerSelectScreenModel,
	#superclass : #WBAMenuScreenModel,
	#instVars : [
		'currentChoice',
		'arrowWidget',
		'titleWidget',
		'playersWidget'
	],
	#category : #'Winter-WizardBattleArena'
}

{ #category : #actions }
WBANumberPlayerSelectScreenModel >> downSelection [
	currentChoice := currentChoice \\ 3 + 1.
	
]

{ #category : #actions }
WBANumberPlayerSelectScreenModel >> endScreenComputation [
	| keyCodes |
	keyCodes := WBAPlayer defaultKeyboardCodes.
	game players: ((1 to: currentChoice + 1) collect: [ :i | WBAPlayer new
			keyboards: (keyCodes at: i);
			yourself ])
]

{ #category : #initialization }
WBANumberPlayerSelectScreenModel >> initialize [

	super initialize.

	currentChoice := 1.
	game := WBA new.
]

{ #category : #initialization }
WBANumberPlayerSelectScreenModel >> loadWidgets [
	titleWidget := self newSingleSpriteWidget: (self textSpriteAt: #title).
	playersWidget := (2 to: 4) collect: [ :i | self newNumPlayersWidget: i ].
	arrowWidget := self newLargeArrowSelectWidget: 300.
]

{ #category : #'Screen Building' }
WBANumberPlayerSelectScreenModel >> newNumPlayersWidget: num [
	^ self newRowWidget: { (self textWidgetAt: num) . (self textWidgetAt: #players) } space: 40
]

{ #category : #rendering }
WBANumberPlayerSelectScreenModel >> renderWidgetsOn: canvas [
	titleWidget renderOn: canvas translatedBy: 30@30.
	canvas pathTransform translateBy: 220@30.
	playersWidget do: [ :widget |
		widget renderOn: canvas translatedBy: 0@100. ].
	arrowWidget renderOn: canvas translatedBy: -75 @ ((-3 + currentChoice) * 100 + 10)
]

{ #category : #accessing }
WBANumberPlayerSelectScreenModel >> screen: sc [
	super screen: sc.
	game screen: screen.
]

{ #category : #accessing }
WBANumberPlayerSelectScreenModel >> setUpGame [

	game screen: screen.
	screen rootSystem: game rootSystem.
]

{ #category : #actions }
WBANumberPlayerSelectScreenModel >> switchToNextScreen [
	
	self nextScreen: WBASeasonSelectScreenModel 
]

{ #category : #actions }
WBANumberPlayerSelectScreenModel >> upSelection [
	currentChoice := currentChoice - 1.
	currentChoice = 0 ifTrue: [ currentChoice := 3 ].
	
]
