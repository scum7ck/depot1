class Product < ActiveRecord::Base
	#отношение к лайн айтемам
	has_many :line_items
	has_many :orders, through: :line_items
	#убедиться перед дестроем, что товарных позиций нет
	before_destroy :ensure_not_reference_by_any_line_item


	# валидация для тайтла, цены, дескрипшона и изображения
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a url for GIF, JPG or PNG image.'
	}

	# последний обновленный продукт для кэширования
	def self.latest
		Product.order(:updated_at).last		
	end


	# обработка приват позволяет использовать общий код между контроллерами
	# и не позволяет рельсам делать его доступным в качестве действий контроллера
	private

	# убедиться в отсутствии товарных позиций
	def ensure_not_reference_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'существуют товарные позиции')
			return false
		end
	end
end
