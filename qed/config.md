## Phony::Config

### Phony::Config.load

Allows for only using a set of CCs.

    Phony::Config.load(only: ['41', '44']).included_ccs.assert == ['41', '44']
    Phony::Config.load(only: ['41', '44']).excluded_ccs.assert == []

Allows for excluding CCs.

    Phony::Config.load(except: ['41', '44']).included_ccs.assert == []
    Phony::Config.load(except: ['41', '44']).excluded_ccs.assert == ['41', '44']
    
Default is loading all.

    Phony::Config.load.included_ccs.assert == []
    Phony::Config.load.excluded_ccs.assert == []

Convenience form.
    
    Phony::Config.load('41', '44').included_ccs.assert == ['41', '44']
    Phony::Config.load('41', '44').excluded_ccs.assert == []