module Cronjobs
  class ScheduleCheck
    def initialize months_of_year, days_of_month, days_of_week
      @moy = ScheduleCheck.parse months_of_year, 1, 12
      @dom = ScheduleCheck.parse days_of_month, 1, 31
      @dow = ScheduleCheck.parse days_of_week, 0, 6
    end

    def schedulable_moment_before time
      time = Time.new(time.year, time.month, time.day, 0, 0, 0)
      until in_day?(time) && in_month?(time) do
        time -= 1.day 
      end
      time
    end

    private
    def in_month? time
      #puts time, @moy
      true unless @moy
      @moy.include? time.month
    end

    def every_day?
      @dow.nil? && @dom.nil?
    end

    def in_day? time
      #puts time, @dow, @dom
      return true if every_day?
      return @dow.include? time.wday unless @dom
      return @dom.include? time.day unless @dow
      @dom.include? time.day and @dow.include? time.wday
    end

    def self.parse value, min, max
      return nil if value == '*' || value.nil?
      value.split(',').collect do |s|
        if /([0-9]+)(\s*-\s*([0-9]+))?/ =~ s
          from = $1.to_i
          raise "range out of bounds #{s}" unless (min..max).include? from
          if $3 
            to = $3.to_i
            #puts "form => #{from}to => #{to}"
            raise "range out of bounds #{s}" unless (min..max).include? to
            raise "invalid range #{s}" if from > to
            if from < to
              (from..to).to_a
            else
              from
            end
          else
            from
          end
        else
          raise "invalid range #{s}"
        end
      end.flatten
    end
  end
end
