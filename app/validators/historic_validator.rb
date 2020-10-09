class HistoricValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value <= Time.now

    record.errors[attribute] << (options[:message] || "is in the future")
  end
end
