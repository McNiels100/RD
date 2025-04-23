module Paginatable
  extend ActiveSupport::Concern

  def paginate(collection, per_page = 35)
    @per_page = per_page
    @page = params[:page].to_i
    @page = 1 if @page <= 0
    @total_pages = (collection.count.to_f / @per_page).ceil
    @total_items = collection.count

    collection.offset((@page - 1) * @per_page).limit(@per_page)
  end
end
