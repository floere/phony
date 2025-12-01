# Releasing

Needed:

```bash
$ gem install gem-release
```

Steps:

1. `bundle exec rspec`
2. `phony.gemspec` - increase version: New country, patch; New/changed feature, minor; Completely changed API, major.
3. history.md - add a new entry on top with the version. Describe and give thanks!
4. `gem release`
5. `gem tag`
