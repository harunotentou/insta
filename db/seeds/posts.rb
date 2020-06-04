puts 'Start inserting seed "posts" ...'
User.limit(10).each do |user|
  post = user.posts.create(content: Faker::Hacker.say_something_smart, remote_picture_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random])
  puts "post#{post.id} has created!"
end