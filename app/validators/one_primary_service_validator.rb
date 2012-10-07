class OnePrimaryServiceValidator < ActiveModel::EachValidator

  # @param [Specialist] record
  def validate_each(record, attribute, value)
    puts record, attribute, value
    if record.specialist_services.length == 0
      record.errors[:primary_service] << I18n.translate(
          "activerecord.errors.primary_service.required")
    else
      primary_found = false
      record.specialist_services.each do |service|
        if service.primary
          primary_found = true
          break
        end
      end
      unless primary_found
        record.errors[:primary_service] << I18n.translate(
            "activerecord.errors.primary_service.required")
      end
    end
  end

end