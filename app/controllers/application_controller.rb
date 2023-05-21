class ApplicationController < ActionController::Base
    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end
    
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
    
    def user_params
      params.require(:user).permit(:email,:password,:password_confirmation)
  end

end