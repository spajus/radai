class EmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.blank?
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] ||
            I18n.translate("activerecord.errors.email.invalid"))
      end
    end
  end

end