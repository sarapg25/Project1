def half_adder(a, b)
  sum = a ^ b   # XOR 
  carry = a & b # AND
  { sum: sum, carry: carry }
end

def full_adder(a, b, c)  
  ha1 = half_adder(a, b)
  ha2 = half_adder(ha1[:sum], c)
  carry = ha1[:carry] | ha2[:carry] # OR
  { sum: ha2[:sum], carry: carry }
end

#Casos de prueba
test_cases = [
  [0, 0, 0],
  [0, 0, 1],
  [0, 1, 0],
  [0, 1, 1],
  [1, 0, 0],
  [1, 0, 1],
  [1, 1, 0],
  [1, 1, 1]
]

#Imprimir encabezado de la tabla
puts "+---+---+---+-------+-----+"
puts "| a | b | c | carry | sum |"
puts "+---+---+---+-------+-----+"

#Iterar sobre los casos de prueba y mostrar resultados
test_cases.each do |a, b, c|
  result = full_adder(a, b, c)
  puts "| #{a} | #{b} | #{c} |   #{result[:carry]}   |  #{result[:sum]}  |"
end

puts "+---+---+---+-------+-----+"
