class SubdomainConstraints
  def self.matches?(request)
    return request.domain.present? && request.domain == 'statybos'
  end
end