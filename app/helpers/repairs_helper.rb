module RepairsHelper
  def calculate_tat_stage(created_at)
    tat_days = working_days_between(created_at, Time.zone.now)

    case tat_days
    when 0..@device.tat_neutral
      "pointer-green"
    when @device.tat_neutral..@device.tat_unsatisfied
      "pointer-yellow"
    when @device.tat_unsatisfied..@device.tat_very_unsatisfied
      "pointer-orange"
    else
      "pointer-red"
    end
  end

  private
  def working_days_between(start_date, end_date)
    total_days = (start_date.to_date..end_date.to_date).to_a
    weekdays = total_days.reject { |d| d.saturday? || d.sunday? }
    weekdays.size
  end
end
