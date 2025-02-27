def Add16(a, b)
  raise ArgumentError, "Las entradas deben ser arreglos binarios de 16 bits" unless a.is_a?(Array) && b.is_a?(Array) && a.size == 16 && b.size == 16

  # Definición del medio sumador (half adder)
  def half_adder(a, b)
    sum = a ^ b   # XOR para la suma
    carry = a & b # AND para el acarreo
    [sum, carry]
  end

  # Definición del sumador completo (full adder)
  def full_adder(a, b, carry_in)
    sum1, carry1 = half_adder(a, b)
    sum2, carry2 = half_adder(sum1, carry_in)
    carry_out = carry1 | carry2 # OR para el acarreo de salida
    [sum2, carry_out]
  end

  out = []
  carry = 0

  # Procesar los bits de derecha a izquierda (LSB a MSB)
  (15).downto(0) do |i|
    if i == 15
      sum, carry = half_adder(a[i], b[i])
    else
      sum, carry = full_adder(a[i], b[i], carry)
    end
    out.unshift(sum) # Agregar el bit de suma al principio del arreglo
  end

  out
end

# Casos de prueba
test_cases = [
  [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
  [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
  [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
  [[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0], [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]],
  [[0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0], [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0]],
  [[0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0], [1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0]]
]

# Encabezado
puts "+------------------+------------------+------------------+"
puts "|        a        |        b        |       out       |"
puts "+------------------+------------------+------------------+"

test_cases.each do |a, b|
  resultado = Add16(a, b)
  puts "| #{a.join} | #{b.join} | #{resultado.join} |"
end

puts "+------------------+------------------+------------------+"