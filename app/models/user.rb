class User < ApplicationRecord

    before_save :downcase_email
    before_save :downcase_unconfirmed_email

    attr_accessor :current_password

    CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
    PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

    MAILER_FROM_EMAIL = "no-reply@example.com"

    has_secure_password
    has_secure_token :remember_token
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validate :unconfirmed_email, format: { with: URI::MailTO::EMAIL_REGEXP, allow_blank: true }

    def confirm!
        if unconfirmed_or_reconfirming?
            if unconfirmed_email.present?
                return false unless update(email: unconfirmed_email, unconfirmed_email: nil)
            end
        update_columns(confirmed_at: Time.current)
        else
            false
        end
    end

    def confirmed?
        confirmed_at.present?
    end

    def unconfirmed?
        !confirmed?
    end

    def generate_confirmation_token
        signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_mail
    end

    def send_confirmation_email!
        confirmation_token = generate_confirmation_token
        UserMailer.confirmation(self, confirmation_token).deliver_now
    end

    def generate_password_reset_token
        signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: reset_password
    end

    def send_password_reset_email!
        password_reset_token = generate_password_reset_token
        UserMailer.password_reset(self,password_reset_token).deliver_now
    end

    def confirmable_email
        if unconfirmed_email.present?_
            unconfirmed_email
        else
            email
        end
    end

    def reconfirming?
        unconfirmed_email.present?
    end

    def unconfirmed_or_reconfirming?
        unconfirmed? || reconfirming?
    end

    private

    def downcase_email
        self.email = email.downcase
    end

    def downcase_unconfirmed_email
        return if unconfirmed_email.nil?
        self.unconfirmed_email = unconfirmed_email.downcase
    end

end
