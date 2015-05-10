def detect_cycle(_l, head)
  # Write your code here
  # To print results to the standard output you can use puts or print
  # Example: puts "Hello world!"
  visited = Set.new
  index = head
  res = -1
  while res < 0 and _l[index] >= 0 do
    visited.add(index)
    index = _l[index]
    if visited.include? index do
      res = 1
    end
  end
  puts res
end