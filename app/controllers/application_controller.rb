class ApplicationController < ActionController::Base
include Authentication
    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end

      def article_params
        params.require(:article).permit(:title, :body, :status)
      end

      def create_user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
      end

      def update_user_params
        params.requrie(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
      end

end
