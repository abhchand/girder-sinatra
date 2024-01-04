return if Widget.count > 0

puts "\t=== Seeding Widgets"
w1 = Widget.create!(name: "Foo")
