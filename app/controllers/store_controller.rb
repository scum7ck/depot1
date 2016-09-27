class StoreController < ApplicationController
	skip_before_action :authorize
	include SessionCounter

	include CurrentCart
	before_action :set_cart

	def index
		if params[:set_locale]
			redirect_to store_url(locale: params[:set_locale])
		else
			@products = Product.order(:title)
		end

  	# переменная для записи кол-ва обращений
  	@counter = increment_counter
  end
end
