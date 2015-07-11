# Generated with RailsBricks
# Initial seed file to use with Devise User Model
print "---------- Generating Seed Data ----------\n"
# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!
# generate user accounts
(1..10).each do |i|
	u = User.new(
		email: "user#{i}@example.com",
		password: "1234",
		password_confirmation: "1234",
		first_name: "user",
		last_name: "\##{i}"
	)
	u.skip_confirmation!
	u.save!
	print i, " user(s) created with id ", u.id, "\n"
	# generate dummy posts
	(1..6).each do |i|
		p = Post.new(
			title: (0...8).map { (65 + rand(26)).chr }.join,
			user: u,
			content_md: "this is a descriptive description!",
			year_created: (2000 + i),
			medium: (0...4).map { (65 + rand(26)).chr }.join,
			dimension_height: (1 + rand(69)),
			dimension_width: (1 + rand(69)),
			measurement: 'in',
			weight_in_pounds: rand(22),
			price: (rand(1000000)) * (0.01),
			quantity: rand(33),
			image: File.new('app/assets/images/test.png')
		)
=begin
		# attempt to generate dummy comments (makes comments but doesn't associate them with a post)
		(1..10).each do |i|
			c = Comment.new(
				message: (0...25).map { (65 + rand(26)).chr }.join,
				user_id: u.uid,
				post_id: p.id,
				user: u
			)
			c.save!
		end
=end
		p.save!	
		print i, "..."
	end
	print " posts created!\n"
end
print "---------- Seed Data Generated ----------\n"
