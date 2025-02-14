def puerta_dmux4way(entrada, sel)
  salida = [0, 0, 0, 0]
  salida[sel] = entrada
  salida
end

# Pruebas
casos_de_prueba = [
  [1, 0, [1, 0, 0, 0]],
  [1, 1, [0, 1, 0, 0]],
  [1, 2, [0, 0, 1, 0]],
  [1, 3, [0, 0, 0, 1]]
]

casos_de_prueba.each do |entrada, sel, esperado|
  resultado = puerta_dmux4way(entrada, sel)
  raise "Error: DMux4Way(#{entrada}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de DMux4Way pasaron exitosamente "
