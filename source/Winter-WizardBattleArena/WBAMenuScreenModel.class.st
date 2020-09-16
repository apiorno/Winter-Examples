Class {
	#name : #WBAMenuScreenModel,
	#superclass : #BaseMenuScreenModel,
	#category : #'Winter-WizardBattleArena'
}

{ #category : #animations }
WBAMenuScreenModel >> endAnimation [

	game scheduler stopGameTickActionFor: self
]

{ #category : #'screen building' }
WBAMenuScreenModel >> endScreenComputation [
]

{ #category : #'event handling' }
WBAMenuScreenModel >> enterCode [

	^ 40
]

{ #category : #'event handling' }
WBAMenuScreenModel >> eventHandler [

	| handler |

	handler := BasicEventHandler of: game.
	handler registerObserver: self.
	^ handler
]

{ #category : #animations }
WBAMenuScreenModel >> every10GameTickDo: aBlock [

	game scheduler
		newGameTickAction: ( ConfigurableAnimation doing: aBlock every: 10 )
		for: self
]

{ #category : #'event handling' }
WBAMenuScreenModel >> handleGenericKeyStroke: code [
	"key codes for arrows"
	code = 81 ifTrue: [ self downSelection ].
	code = 80 ifTrue: [ self leftSelection ].
	code = 79 ifTrue: [ self rightSelection ].
	code = 82 ifTrue: [ self upSelection ].
]

{ #category : #'event handling' }
WBAMenuScreenModel >> handleKeyDown: aKeyEvent [

	
]

{ #category : #'event handling' }
WBAMenuScreenModel >> handleKeyStrokeFor: playerIndex key: index [ 


]

{ #category : #'event handling' }
WBAMenuScreenModel >> handleKeyUp: anEvent [

	anEvent scanCode = self enterCode
		ifTrue: [ self nextScreen ].
	self hasPlayerSpecificHandling
		ifTrue: [ self handlePlayersKeyStroke: anEvent scanCode ]
		ifFalse: [ self handleGenericKeyStroke: anEvent scanCode ]
]

{ #category : #'event handling' }
WBAMenuScreenModel >> handlePlayersKeyStroke: code [	
	
	game players withIndexDo: [ :player :playerIndex |
		| index |
		((index := player keyboardCodes indexOf: code) between: 1 and: 4)
			ifTrue: [ self handleKeyStrokeFor: playerIndex key: index ] ]
]

{ #category : #testing }
WBAMenuScreenModel >> hasPlayerSpecificHandling [

	^ false
]

{ #category : #initialization }
WBAMenuScreenModel >> loadCadreSprites: numPlayers [

	^ ( WBACadreDescriptor for: numPlayers )
		loadSpritesWith: screen surface
		using: game assetsManager
]

{ #category : #private }
WBAMenuScreenModel >> loadWidgets [

	self subclassResponsibility
]

{ #category : #'screen building' }
WBAMenuScreenModel >> newCadreWidgets: numPlayers [

	| cadreSprites |
	cadreSprites := self loadCadreSprites: numPlayers.
	^ (1 to: numPlayers) collect: [ :i | 
		self newSingleSpriteWidget: (cadreSprites at: i) ].
]

{ #category : #'screen building' }
WBAMenuScreenModel >> newLargeArrowSelectWidget: space [

	^ self 
		newRowWidget: { (self textWidgetAt: #arrowLeft0) . (self textWidgetAt: #arrowRight0) } 
		space: space
]

{ #category : #'screen building' }
WBAMenuScreenModel >> newSelectWidget: sprite [

	^ self 
		newRowWidget: { (self textWidgetAt: #select) . sprite }
		space: 160
]

{ #category : #actions }
WBAMenuScreenModel >> nextScreen [

	self endAnimation.
	self endScreenComputation.
	self switchToNextScreen.
]

{ #category : #'screen building' }
WBAMenuScreenModel >> nextScreen: screenModel [

	screenModel new
		screen: screen;
		game: game;
		display
]

{ #category : #private }
WBAMenuScreenModel >> renderWidgetsOn: aCanvas [

	self subclassResponsibility
]

{ #category : #animations }
WBAMenuScreenModel >> startAnimation [
]

{ #category : #'screen building' }
WBAMenuScreenModel >> switchToNextScreen [

	self subclassResponsibility 
]

{ #category : #private }
WBAMenuScreenModel >> textSpriteAt: name [

	^ screen surface createFormPaint: (game textSpritesAt: name asString)
]

{ #category : #private }
WBAMenuScreenModel >> textWidgetAt: name [

	^ self newSingleSpriteWidget: (self textSpriteAt: name)
]
