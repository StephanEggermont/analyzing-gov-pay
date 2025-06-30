Class {
	#name : #Visualisation,
	#superclass : #Object,
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
Visualisation class >> borderForFile: aFile [
	(aFile basename matches: '*Test*')
		ifTrue: [ ^ BlBorder paint: Color green width: 3 ].
	^ BlBorder paint: Color gray
]

{ #category : #accessing }
Visualisation class >> javaFiles: files [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			GtMondrianUMLClassElement withDefaultContainer
				label: each basename;
				border: (self borderForFile: each) ];
		with: files.
	view layout rectanglePack.
	^ view
]
