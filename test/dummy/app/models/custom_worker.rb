class CustomWorker < ActiveRecord::Base
    acts_as_cronjob :as => :programs
end
