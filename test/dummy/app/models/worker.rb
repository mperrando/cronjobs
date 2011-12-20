class Worker < ActiveRecord::Base
    acts_as_cronjob
end
