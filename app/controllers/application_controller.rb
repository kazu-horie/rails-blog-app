class ApplicationController < ActionController::Base
  rescue_from Exception, with: :render_500 if Rails.env.production?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404 if Rails.env.production?

  private

  def render_404(_error)
    render file: 'public/404.html', status: 404, layout: false
  end

  def render_500(_error)
    render file: 'public/500.html', status: 500, layout: false
  end
end
