class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return unless record[attribute] < Time.now

    record.errors.add(attribute, :invalid, message: (options[:message] || 'must be in the future.'))
  end
end
