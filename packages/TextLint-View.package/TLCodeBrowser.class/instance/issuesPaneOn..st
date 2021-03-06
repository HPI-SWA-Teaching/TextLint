Glamour
issuesPaneOn: browser
	| fileContents firstResults groupedByCategory groupedByCategoryAndClass filePath |
	browser transmit 
		to: #issues; 
		from: #files;
		andShow: [:presentation | 
			(presentation custom: GLMTLTreePresentation new)
				title: 'Issues';
				display: [ :file | 
					Cursor wait showWhile: [
						file = filePath ifFalse: [textToCheck := nil].
						textToCheck ifNil: [filePath := file.
											textToCheck := MultiByteFileStream
															readOnlyFileNamed: file
															do: [ :stream | stream contents ]].
						textLintChecker reset.
						results := (textLintChecker parse: textToCheck) results.

						firstResults := (results groupedBy: [ :each | each rule class categoryDescriptions 
																at: each rule category ]) asOrderedCollection.
						
						groupedByCategory := OrderedCollection new.
						firstResults do: [ :each | groupedByCategory add: each asOrderedCollection].
						
						groupedByCategoryAndClass := OrderedCollection new.
						groupedByCategory do: [ :each |
												groupedByCategoryAndClass add: ((each groupedBy: [ :any | any rule class]) asOrderedCollection). 
											].
						
						groupedByCategoryAndClass.
						]];
				children: [ :item :x :level |
					item isCollection 
						ifTrue: [ item ]
						ifFalse: [ #() ]];
				format: [ :each | 
					each isCollection
						ifTrue: [ each first isCollection
									ifTrue: [each first first rule class categoryDescriptions 
												at: each first first rule category]
									ifFalse: [each first rule name] ]
						ifFalse: [
							String streamContents: [ :stream | stream nextPutAll: (each element processFor: self)] ] ];
				updateOn: TLFileSaved from: [saveAnnouncer];
				updateOn: TLStyleChanged from:[styleAnnouncer.].
			].
		^ browser