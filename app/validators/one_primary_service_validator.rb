class OnePrimaryServiceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    puts record, attribute, value
  end

end