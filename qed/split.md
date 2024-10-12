## Phony.split

`Phony.split(international_number)` splits a *normalized* international number into its components, like so:
`[CC, NDC, LOCAL1, LOCAL2, ..., LOCALN]`.

You really need to give it a *normalized* phone number WITH a country code, so:

    Phony.split('3643532') # This ... no.

Phony is happy with these:

    Phony.split('43198110').assert == ['43', '1', '98110']
    Phony.split('33112345678').assert == ['33', '1', '12','34','56','78']
    Phony.split('4976112345').assert == ['49', '761', '123', '45']
    Phony.split('3928061371').assert == ['39', '2', '806', '1371']
    Phony.split('41443643532').assert == ['41', '44', '364', '35', '32']
    Phony.split('15551115511').assert == ['1', '555', '111', '5511']
    Phony.split('6491234567').assert == ['64', '9', '123', '4567']
    Phony.split('41800334455').assert == ['41', '800', '33', '44', '55']

It handles missing pieces gracefully.

    Phony.split('4144').assert == ['41', '44', '']
    Phony.split('4144364').assert == ['41', '44', '364']
    Phony.split('414436435').assert == ['41', '44', '364', '35']
