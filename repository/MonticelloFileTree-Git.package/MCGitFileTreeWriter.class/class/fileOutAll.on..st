instance creation
fileOutAll: anArrayOfVersions on: aMCFileTreeGitRepository
	"Only one approach to filing out: a set of versions in one commit."

	"Small note: since we do not provide the package or the full version itself to the main writer method, we write by hand after each version some package related data that seems a relic of the old mcz format."

	| aWriter subDirectoryString |
	aWriter := self new.
	aWriter repository: aMCFileTreeGitRepository.
	subDirectoryString := aMCFileTreeGitRepository subDirectoryString.
	anArrayOfVersions first
		in: [ :aVersion | 
			aWriter
				outputCommit: (aMCFileTreeGitRepository authorName: aVersion)
				email: (aMCFileTreeGitRepository authorEmail: aVersion)
				time: aVersion info timeStamp
				message: aVersion info message ].
	anArrayOfVersions
		do: [ :each | 
			| packageDir |
			packageDir := subDirectoryString , each package name , '.package'.
			aWriter writeSnapshot: each snapshot in: packageDir.
			aWriter
				outputFileModify: packageDir , '/monticello.meta/package'
				with: '(name ''' , each package name , ''')'.
			aWriter writeDependencies: each dependencies in: packageDir ].
	^ aWriter stream