if !Rails.env.development?
	ActionMailer::Base.smtp_settings = {
	  :address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => "localhost:3000",
	  :user_name            => "em.clubchief@gmail.com",
	  :password             => "elasticmonkey1",
	  :authentication       => "plain",
	  :enable_starttls_auto => true
	}

	smtp_conn = Net::SMTP.new 'smtp.gmail.com', 587
	smtp_conn.enable_starttls
	smtp_conn.start('smtp.gmail.com', 'em.clubchief@gmail.com', 'elasticmonkey1', :plain)

	ActionMailer::Base.default_url_options[:host] = "localhost:3000"

	Mail.defaults do
	  delivery_method :smtp_connection, { :connection => smtp_conn }
	end
end
#Mail.register_interceptor(DevelopmentMailInterceptor) 

