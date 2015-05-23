## Issues

A collection of former issues, for quick reference.

### #136

Works for Italy.

    Phony.normalize('+39 393 0000000').assert == '393930000000'

Specifically fixes the issue.

    italia = Phony['39']
    italia.normalize('363 000000').assert == '363000000'

Works for country with CC 46.

    Phony.normalize('+46 (0)46 222 0000').assert == '46462220000'

### #151

Normalizes, but this is a non-real case.

    Phony.normalize('1-111-111-1111').assert        == '1111111111'
    Phony.normalize('111-111-1111', cc: '1').assert == '1111111111'

### #152

Italy numbers needed a 0 to be splittable (officially needed). Now they at least work. In a way.

    Phony.split('39694805123').assert == ['39', '694805123', []]
    Phony.format('39694805123').assert == '+39 694805123 '
    
### #221

    Phony.assert.plausible?('+39 081 1925 2698')