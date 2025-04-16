module RepairsHelper
  TAT_STATUSES = [
    { name: "Good", css_sufix: "green", id: "tat_statuses_good" },
    { name: "Neutral", css_sufix: "yellow", id: "tat_statuses_neutral" },
    { name: "Unsatisfied", css_sufix: "orange", id: "tat_statuses_unsatisfied" },
    { name: "Very unsatisfied", css_sufix: "red", id: "tat_statuses_very_unsatisfied" }
  ]

  def calculate_tat_info(device, created_at, output = nil)
      tat_days = working_days_between(created_at, Time.zone.now)

      case tat_days
      when 0..device.tat_neutral
        status = TAT_STATUSES[0]
        days_to_next_stage = device.tat_neutral - tat_days
      when device.tat_neutral..device.tat_unsatisfied
        status = TAT_STATUSES[1]
        days_to_next_stage = device.tat_unsatisfied - tat_days
      when device.tat_unsatisfied..device.tat_very_unsatisfied
        status = TAT_STATUSES[2]
        days_to_next_stage = device.tat_very_unsatisfied - tat_days
      else
        status = TAT_STATUSES[3]
        days_to_next_stage = "N/A"
      end

      css_class = output ? "#{output}-#{status[:css_sufix]}" : status[:css_sufix]

      {
        status: status[:name],
        days_to_next_stage: days_to_next_stage,
        css_class: css_class
      }
    end

    # Return the CSS class for styling (replacing calculate_tat_stage)
    def set_tat_css(device, created_at, output)
      calculate_tat_info(device, created_at, output)[:css_class]
    end

    # Return just the status string for filtering
    def determine_tat_status(device, created_at)
      calculate_tat_info(device, created_at)[:status]
    end

    # Return just the days to next stage
    def days_to_next_tat_stage(device, created_at)
      calculate_tat_info(device, created_at)[:days_to_next_stage]
    end

  def find_tat(repair)
    device = Device.find_by(brand: repair.brand, device_type: repair.device_type)
    device
  end

  def disable_if_not_locked_by_current_user(repair)
    if repair.locked_by.nil? || repair.locked_by?(current_user.email_address)
      {} # No disabled attribute
    else
      { disabled: true } # Add disabled attribute
    end
  end

  private
  def working_days_between(start_date, end_date)
    total_days = (start_date.to_date..end_date.to_date).to_a
    weekdays = total_days.reject { |d| d.saturday? || d.sunday? }
    weekdays.size
  end
end
