## Templates

```ruby
  Phony.format('41443643532', :format => 'A%{cc}B%{trunk}C%{ndc}D%{local}').assert == 'A41B0C44D364 35 32'
  Phony.format('41443643532', :format => '%{local} %{ndc} %{trunk} %{cc}', :local_spaces => '').assert == '3643532 44 0 41'
  Phony.format('41443643532', :format => 'A%{cc}B%{ndc}C%{local}', :local_spaces => '/').assert == 'A41B44C364/35/32'
  Phony.format('71234567890', :format => '+%{cc} (%{trunk}%{ndc}) %{local}', :local_spaces => '-').assert == '+7 (8123) 45-67890'
  Phony.format('13015550100', :format => '+%{cc} %{trunk}%{ndc} %{local}', :local_spaces => '-').assert == '+1 301 555-0100'
```