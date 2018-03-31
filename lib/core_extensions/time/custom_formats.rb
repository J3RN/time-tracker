module CoreExtensions
  module Time
    module CustomFormats
      AMERICAN_DATE_TIME_FORMAT = "%m/%d/%Y %H:%M %p".freeze

      module InstanceMethods
        def american_date
          strftime(AMERICAN_DATE_TIME_FORMAT)
        end
      end

      module ClassMethods
        def american_date(str)
          strptime(str, AMERICAN_DATE_TIME_FORMAT)
        end
      end
    end
  end
end
