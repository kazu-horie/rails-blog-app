class ApplicationController < ActionController::Base
  rescue_from Exception, with: :render_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

  def render_404(_error)
    render file: 'public/404.html', status: 404, layout: false
  end

  def render_500(_error)
    render file: 'public/500.html', status: 500, layout: false
  end
end
