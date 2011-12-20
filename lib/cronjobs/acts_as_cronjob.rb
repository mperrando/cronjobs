module Cronjobs
  module ActsAsCronjob
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_cronjob(options = {})
        cattr_accessor :schedules_accessor_name
        self.schedules_accessor_name = (options[:as] || 'schedules').to_s
        has_many self.schedules_accessor_name.to_sym, :class_name => 'Cronjobs::Schedule', :as => :cronjob
      end
    end
  end
end

ActiveRecord::Base.send :include, Cronjobs::ActsAsCronjob
