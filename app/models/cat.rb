class Cat < ApplicationRecord

  # ransack許可リスト
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "age", "updated_at"]
  end

  # 名前: 必須
  validates :name, presence: true

  # 年齢: 必須 + integer + 0以上
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end