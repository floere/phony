area_code      = Phony::NationalSplitters::None.instance_for
national_code  = Phony::LocalSplitters::Regex.instance_for [2,2,2,2], /^[489].*$/ => [3,2,3]
handler        = Phony::NationalCode.new area_code, national_code

Phony::Countries::Norway = Phony::Country.new handler