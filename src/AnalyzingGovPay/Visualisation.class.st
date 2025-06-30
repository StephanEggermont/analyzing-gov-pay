Class {
	#name : #Visualisation,
	#superclass : #Object,
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
Visualisation class >> javaFiles: files [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			GtMondrianUMLClassElement withDefaultContainer
				label: each basename;
				border: ((each basename matches: '*Test*')
						ifTrue: [ BlBorder paint: Color green width: 3 ]
						ifFalse: [ BlBorder paint: Color gray ]) ];
		with: files.
	view layout rectanglePack.
	^ view
]
