module CoreExtensions
  module Date
    module CustomFormats
      AMERICAN_DATE_FORMAT = "%m/%d/%Y"

      module InstanceMethods
        def american_date
          strftime(AMERICAN_DATE_FORMAT)
        end
      end

      module ClassMethods
        def american_date str
          strptime(str, AMERICAN_DATE_FORMAT)
        end
      end
    end
  end
end
