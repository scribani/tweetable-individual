# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Start seeding"
Tweet.destroy_all
User.destroy_all

# Create 7 users using random data
puts "Seeding users..."
7.times do |number|
  user_data = {
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.safe_email,
    name: Faker::Name.name,
    password: Faker::Internet.password(min_length: 6)
  }
  new_user = User.new(user_data)

  io_path = (number + 1) > 5 ? "app/assets/images/default_avatar.png" : "app/assets/images/avatar#{number + 1}.png"
  filename = io_path.split("/").last
  new_user.avatar.attach(io: File.open(io_path), filename: filename)

  puts "User not created. Errors: #{new_user.errors.full_messages}" unless new_user.save
end

# Create tweets for each user using random data
puts "Seeding tweets..."
users = User.all
users.each do |user|
  rand(3..7).times do
    tweet_data = {
      body: Faker::Lorem.paragraph(sentence_count: 1, random_sentences_to_add: 2),
      user: user
    }
    new_tweet = Tweet.new(tweet_data)
    puts "Tweet not created. Errors: #{new_tweet.errors.full_messages}" unless new_tweet.save
  end
end

# Create comments for each user using random data
puts "Seeding comments..."
users = User.all
tweets = Tweet.all
users.each do |user|
  rand(3..7).times do
    comment_data = {
      body: Faker::Lorem.paragraph(sentence_count: 1, random_sentences_to_add: 2),
      user: user,
      tweet: tweets.sample
    }
    new_comment = Comment.new(comment_data)
    puts "Comment not created. Errors: #{new_comment.errors.full_messages}" unless new_comment.save
  end
end
puts "Finish seeding"
