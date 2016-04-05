class User < ActiveRecord::Base
	validates :email, :password_digest, :session_token, presence: true
	validates :email, :session_token, uniqueness: true
	validates :password, length: { minimum: 6, maximum: 60, allow_nil: true }
	before_validation :ensure_session_token
	attr_reader :password

	has_many :views
	has_many :viewed, through: :views, source: :ad

	def self.generate_session_token
		token = SecureRandom.urlsafe_base64(16)
		while User.find_by_session_token(token)
			token = SecureRandom.urlsafe_base64(16)
		end
		return token
	end

	def self.find_by_credentials(email, password)
		user = User.find_by_email(email)
		return nil unless user && user.valid_password?(password)
		user
	end

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def valid_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def reset_session_token!
		self.session_token = User.generate_session_token
		self.save!
		self.session_token
	end

	def get_watched_hash
		return self.views.map.with_object(Hash.new) do |view, hash|
			hash[view.ad_id] = view
		end
	end


	private

	def ensure_session_token
		self.session_token ||= User.generate_session_token
	end

end
