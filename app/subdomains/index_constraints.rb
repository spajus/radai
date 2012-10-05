class IndexConstraints
  def self.matches?(request)
    return request.domain.blank? || request.domain == 'www'
  end
end