require_relative 'tree'

tree = Tree.new((Array.new(15) { rand(1..100) }))

tree.pretty_print
puts "\n--Balanced?--\n"
puts "#{tree.balanced?} \n"
puts "--Level Order--\n"
p tree.level_order
puts "--In Order--\n"
p tree.inorder
puts "--Pre Order--\n"
p tree.preorder
puts "--Post Order--\n"
p tree.postorder

puts "----Insert elements-----\n\n"

10.times do
  a = rand(100..150)
  tree.insert(a)
  puts "Inserted #{a} to tree."
end

tree.pretty_print

puts "\n--Balanced?--\n"
puts "#{tree.balanced?} \n"
tree.rebalance
puts "--Rebalanced?--\n"
puts "#{tree.balanced?} \n"

tree.pretty_print

puts "--Level Order--\n"
p tree.level_order
puts "--In Order--\n"
p tree.inorder
puts "--Pre Order--\n"
p tree.preorder
puts "--Post Order--\n"
p tree.postorder
