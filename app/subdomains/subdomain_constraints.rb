class SubdomainConstraints
  def self.matches?(request)
    return request.domain.present? && request.domain == t('app.subdomain.construction')
  end
end