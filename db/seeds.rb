# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.delete_all
Column.delete_all
Board.delete_all
UserInfo.delete_all
User.delete_all

FIRST_USER_CONST = "hvphuc"
SECOND_USER_CONST = "nvan"

User.create([
	{
		username: FIRST_USER_CONST,
		email: "hvphuc@gmail.com",
		password: "123123"
	},
	{
		username: SECOND_USER_CONST,
		email: "nvan@gmail.com",
		password: "123123"
	},
])

User.find_by(username: FIRST_USER_CONST).create_user_info(first_name: "Phuc", last_name: "Hoang")
User.find_by(username: SECOND_USER_CONST).create_user_info(first_name: "An", last_name: "Nguyen")

User.find_by(username: FIRST_USER_CONST).boards.create([
	{
		name: "Early morning activities"
	},
	{
		name: "Evening activities"
	},
	{
		name: "Night activities"
	},
])


# First board: create columns and cards 
User.find_by(username: FIRST_USER_CONST).boards.first.columns.create([
	{
		name: "Well Went"
	},
	{
		name: "To Improve"
	},
	{
		name: "Action Items"
	},
])

User.find_by(username: FIRST_USER_CONST).boards.first.columns.first.cards.create([
	{
		content: "Brush teeth",
	},
	{
		content: "Has breakfast",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.first.columns.second.cards.create([
	{
		content: "Get up early",
	},
	{
		content: "Do exercise",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.first.columns.third.cards.create([
	{
		content: "Go to bed before 10:00 PM",
	},
	{
		content: "Get up before 5:00 AM",
	}
])

# Second board: create columns and cards 
User.find_by(username: FIRST_USER_CONST).boards.second.columns.create([
	{
		name: "Well Went"
	},
	{
		name: "To Improve"
	},
	{
		name: "Action Items"
	},
])

User.find_by(username: FIRST_USER_CONST).boards.second.columns.first.cards.create([
	{
		content: "Play sports",
	},
	{
		content: "Has dinner",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.second.columns.second.cards.create([
	{
		content: "Do homework",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.second.columns.third.cards.create([
	{
		content: "Do homework before play sport",
	}
])


# Third board: create columns and cards 
User.find_by(username: FIRST_USER_CONST).boards.third.columns.create([
	{
		name: "Well Went"
	},
	{
		name: "To Improve"
	},
	{
		name: "Action Items"
	},
])

User.find_by(username: FIRST_USER_CONST).boards.third.columns.first.cards.create([
	{
		content: "Do homework",
	},
	{
		content: "Play games",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.third.columns.second.cards.create([
	{
		content: "Go to bed before 10:00 PM",
	}
])

User.find_by(username: FIRST_USER_CONST).boards.third.columns.third.cards.create([
	{
		content: "Don't play games",
	}
])