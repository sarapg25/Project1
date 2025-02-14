def puerta_or8way(entrada)
  entrada.reduce(:|)
end

# Pruebas
casos_de_prueba = [
  [[0, 0, 0, 0, 0, 0, 0, 0], 0],
  [[1, 0, 0, 0, 0, 0, 0, 0], 1],
  [[0, 1, 1, 1, 0, 0, 0, 0], 1]
]

casos_de_prueba.each do |entrada, esperado|
  resultado = puerta_or8way(entrada)
  raise "Error: OR8Way(#{entrada}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de OR8Way pasaron exitosamente "
