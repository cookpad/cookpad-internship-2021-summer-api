class Order < ApplicationRecord
  Error = Class.new(StandardError)
  AlreadyCanceledError = Class.new(Error)
  NotCancelableError = Class.new(Error)

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

  def cancel!(time:)
    raise AlreadyCanceledError, 'Already canceled' if canceled?
    raise NotCancelableError, 'Cancellation deadline exceeded' unless cancelable?(time: time)

    update!(canceled_at: time)
  end

  def canceled?
    !canceled_at.nil?
  end

  def cancelable?(time: Time.zone.now)
    time <= ordered_at.end_of_day
  end

  private

  def calculate_total_amount
    self.total_amount ||= order_items.sum { |item| item.product.price * item.quantity }
  end
end
