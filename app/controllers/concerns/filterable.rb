module Filterable
  extend ActiveSupport::Concern

  def filter_by_search(collection)
    return collection unless params[:query].present? && params[:search_in].present?

    search_term = params[:query]
    search_field = params[:search_in]

    case search_field
    when "order_number"
      collection.where(order_number: "RD-" + search_term)
    when "phone_number"
      collection.where(phone_number: search_term)
    when "email"
      collection.where(email: search_term)
    when "imei"
      collection.where(imei: search_term)
    when "serial"
      collection.where(serial: search_term)
    else
      collection
    end
  end

  def filter_by_brands(collection)
    return collection unless params[:brands].present?
    collection.where(brand: params[:brands])
  end

  def filter_by_device_types(collection)
    return collection unless params[:device_types].present?
    collection.where(device_type: params[:device_types])
  end

  def filter_by_repair_statuses(collection)
    return collection unless params[:repair_statuses].present?

    matching_repair_ids = []

    collection.find_each do |repair|
      if repair.current_status && params[:repair_statuses].include?(repair.current_status.name)
        matching_repair_ids << repair.id
      end
    end

    collection.where(id: matching_repair_ids)
  end

  def filter_by_tat_statuses(collection)
    return collection unless params[:tat_statuses].present?
    filtered_items = []
    collection.find_each do |item|
      device = Device.find_by(brand: item.brand, device_type: item.device_type)
      if device
        status = helpers.determine_tat_status(device, item.created_at)
        filtered_items << item.id if params[:tat_statuses].include?(status)
      end
    end
    collection.where(id: filtered_items)
  end

  def filter_by_status_name(collection)
    return collection unless params[:status_name].present?
    collection.where("LOWER(name) LIKE LOWER(?)", "%#{params[:status_name]}%")
  end

  def filter_by_status_active(collection)
    return collection unless params[:status_active].present? && [ "true", "false" ].include?(params[:status_active])
    collection.where(active: params[:status_active] == "true")
  end

  def filter_by_user_role(collection)
    return collection unless params[:user_role].present?
    collection.where(role: params[:user_role])
  end

  def filter_by_locations(collection)
    return collection unless params[:locations].present?
    collection.where(location: params[:locations])
  end
end
