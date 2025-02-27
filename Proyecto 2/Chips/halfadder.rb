
def half_adder(a, b)
  sum = a ^ b   # XOR 
  carry = a & b # AND
  { sum: sum, carry: carry }
end

# Casos de prueba
test_cases = [
  [0, 0],
  [0, 1],
  [1, 0],
  [1, 1]
]

# Imprimir encabezado
puts "+---+---+-----+-------+"
puts "| a | b | sum | carry |"
puts "+---+---+-----+-------+"

# Iteraracion con los casos
test_cases.each do |a, b|
  result = half_adder(a, b)
  puts "| #{a} | #{b} |  #{result[:sum]}  |   #{result[:carry]}   |"
end

puts "+---+---+-----+-------+"