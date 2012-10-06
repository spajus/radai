class OnePrimaryServiceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    raise "implement it!"
    puts record, attribute, value
  end

end