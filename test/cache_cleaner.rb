module CacheCleaner
  def after_teardown
    Rails.cache.clear
    super
  end
end