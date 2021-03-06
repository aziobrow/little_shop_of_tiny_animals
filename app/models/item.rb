class Item < ApplicationRecord

  validates_presence_of :description
  validates :title, presence: true, uniqueness: true
  validates :unit_price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  belongs_to :category
  has_many :order_items

  enum unit: ['fifteen_min', 'hourly', 'daily', 'flat_rate']

  def subtotal(quantity)
    self.unit_price * quantity
  end

  def retired?
    !active?
  end

  def retire
    update(active: false)
  end

  def image_url
    super || "https://cdn.builtincolorado.com/sites/www.builtincolorado.com/files/company_logos/turing-logo-black.png"
  end

end
