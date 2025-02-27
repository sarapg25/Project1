# Definimos la compuerta OR
def puerta_or(a, b)
  a | b
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta OR:"
puts "Entrada A | Entrada B | Salida"
puts "---------------------------"
[0, 1].each do |a|
  [0, 1].each do |b|
    resultado = puerta_or(a, b)
    puts "#{a}        | #{b}        | #{resultado}"
  end
end

# Pruebas
casos_de_prueba = [[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]]

casos_de_prueba.each do |a, b, esperado|
  resultado = puerta_or(a, b)
  raise "Error: OR(#{a}, #{b}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de OR pasaron exitosamente"
