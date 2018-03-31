Raven.configure do |config|
  config.processors -= [Raven::Processor::PostData] # Send POST data
  config.processors -= [Raven::Processor::Cookies]  # Send cookies

  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
