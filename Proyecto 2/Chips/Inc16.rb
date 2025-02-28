class Inc16
  def self.increment(input)
    raise ArgumentError, "Confirmamos que sea un arreglo de 16bits" unless input.is_a?(Array) && input.size == 16
    
    result = []
    carry = 1 # Incremento de 1

    (15).downto(0) do |i|
      sum = input[i] ^ carry  # XOR
      new_carry = input[i] & carry # AND
      result.unshift(sum)
      carry = new_carry
    end
    
    result
  end
end

# Casos de prueba
test_cases = [
  [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1],
  [1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,0],
  [1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1]
]

# Encabezado
puts "+------------------+------------------+"
puts "|      Input       |      Output      |"
puts "+------------------+------------------+"

test_cases.each do |input|
  output = Inc16.increment(input)
  puts "| #{input.join} | #{output.join} |"
end

puts "+------------------+------------------+"

