# Require this file, or put this in where Rails will auto load it.

# = Usage
#  validates :attribute, :url => true

# Pass in a domain to validate a url belongs to a domain (including any sub-domains and pages beneath the domain and sub-domains)
# validates :attribute, :url => {:domain => 'facebook.com'}

class UrlValidator < ActiveModel::EachValidator
  def initialize(options)
    super

    @domain = options[:domain]
    @permissible_schemes = options[:schemes] || %w(http https)
    @error_message = options[:message] || I18n.translate("activerecord.errors.url.invalid")
  end

  def validate_each(record, attribute, value)
    return if value.nil? or value.empty?

    if URI::regexp(@permissible_schemes).match(value)
      begin
        uri = URI.parse(value)
        if @domain
          record.errors.add(attribute, t('activerecord.errors.url.no_domain'), :value => value) unless uri.host == @domain || uri.host.ends_with?(".#{@domain}")
        end
      rescue URI::InvalidURIError
        record.errors.add(attribute, @error_message, :value => value)
      end
    else
      record.errors.add(attribute, @error_message, :value => value)
    end
  end
end