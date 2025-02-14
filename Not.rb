# Definimos la compuerta NOT
def puerta_not(entrada)
  entrada == 1 ? 0 : 1
end

# Imprimir tabla de verdad
puts "Tabla de verdad para la compuerta NOT:"
puts "Entrada | Salida"
puts "-------------------"
[0, 1].each do |entrada|
  resultado = puerta_not(entrada)
  puts "#{entrada}      | #{resultado}"
end

# Pruebas
casos_de_prueba = [[0, 1], [1, 0]]

casos_de_prueba.each do |entrada, esperado|
  resultado = puerta_not(entrada)
  raise "Error: NOT(#{entrada}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de NOT pasaron exitosamente"
