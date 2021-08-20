class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_location
  has_many :order_items, dependent: :delete_all

  before_create :calculate_total_amount

  scope :paid, -> { where.not(ordered_at: nil) }

  def fix!(minifinancier_payment_id:, time:)
    update!(
      minifinancier_payment_id: minifinancier_payment_id,
      ordered_at: time,
      delivery_date: 1.day.since(time).beginning_of_day + 12.hours,
    )
  end

  private

  def calculate_total_amount
    self.total_amount ||= order_items.sum { |item| item.product.price * item.quantity }
  end
end
