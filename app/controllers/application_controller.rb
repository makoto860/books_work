class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_book_specification
  
  def current_book_specification
    @current_book_specification ||= begin
      if params[:book_specification_id]
        BookSpecification.find_by(id: params[:book_specification_id])
      elsif controller_name == "book_specifications" &&
        params[:id].present? &&
        %w[show edit update destroy].include?(action_name)
        BookSpecification.find_by(id: params[:id])
      end
    end
  end
end
