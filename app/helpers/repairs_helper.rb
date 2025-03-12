module RepairsHelper
  def calculate_tat_stage(device, created_at, output)
    tat_days = working_days_between(created_at, Time.zone.now)

    case tat_days
    when 0..device.tat_neutral
      @tat_status = "Good"
      @days_to_next_stage = device.tat_neutral - tat_days
      tat_css = output + "-green"
    when device.tat_neutral..device.tat_unsatisfied
      @tat_status = "Neutral"
      @days_to_next_stage = device.tat_unsatisfied - tat_days
      tat_css = output + "-yellow"
    when device.tat_unsatisfied..device.tat_very_unsatisfied
      @tat_status = "Unsatisfied"
      @days_to_next_stage = device.tat_very_unsatisfied - tat_days
      tat_css = output + "-orange"
    else
      @tat_status = "Very unsatisfied"
      @days_to_next_stage = "N/A"
      tat_css = output + "-red"
    end
    tat_css
  end

  def find_tat(repair)
    device = Device.find_by(brand: repair.brand, device_type: repair.device_type)
    device
  end

  def lock_visibility_class(repair)
    repair.locked? ? "show" : "hide"
  end


  private
  def working_days_between(start_date, end_date)
    total_days = (start_date.to_date..end_date.to_date).to_a
    weekdays = total_days.reject { |d| d.saturday? || d.sunday? }
    weekdays.size
  end
end
