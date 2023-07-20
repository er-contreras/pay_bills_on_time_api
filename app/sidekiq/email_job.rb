class EmailJob
  include Sidekiq::Job

  def perform; end
end

