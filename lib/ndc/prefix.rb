# Splits a national number using a prefix code.
#
class E164::NDC::Prefix

  class_inheritable_accessor :max_ndc_size, :ndcs, :format

  def self.split(number)
    number = number.dup
    presumed_code = ''
    1.upto(max_ndc_size) do |i|
      presumed_code << number.slice!(0..0)
      sized_ndcs = ndcs[i]
      break unless sized_ndcs && !sized_ndcs.include?(presumed_code)
    end
    return [presumed_code, number]
  end

  def self.formatted(number)
    (format || '%s %s %s %s') % split(number)
  end

end