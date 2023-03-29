class QuizerDeletion
  def self.run
    Quizer::Quiz.where(paid: false).
      where('created_at < ?', Quizer::Quiz::FREE_PERIOD_DAYS.days.ago).
      destroy_all

    Quizer::Quiz.where(paid: true).
      where('created_at < ?', Quizer::Quiz::PAID_PERIOD_DAYS.days.ago).
      destroy_all
  end
end
