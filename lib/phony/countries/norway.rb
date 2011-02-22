# Norway. Complete plan available here:
# http://www.npt.no/pt_internet/e_164/nummerplaner.html
#
# (5-digit special numbers and 01 is missing)
#
handler = Phony::NationalCode.new(
  Phony::NationalSplitters::None.instance_for,
  Phony::LocalSplitters::Regex.instance_for(/^[1].*$/ => [3], /^[489].*$/ => [3,2,3], :fallback => [2,2,2,2])
)

Phony::Countries::Norway = Phony::Country.new handler