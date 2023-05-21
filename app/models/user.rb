class User < ApplicationRecord

    MAILER_FROM_EMAIL  = "no-reply@example.com"

    before_save :downcase_email
    
    has_secure_password
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    def confirm!
        update_columns(confirmed_at: Time.current)
    end

    def generate_confirmation_token
        signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_mail
    end

    def send_confirmation_email!
        confirmation_token = generate_confirmation_token
        UserMailer.confirmation(self, confirmation_token).deliver_now
    end

    private
    
    def downcase_email
        self.email = email.downcase
    end

end