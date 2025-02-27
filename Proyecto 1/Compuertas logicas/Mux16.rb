def puerta_mux16(a, b, sel)
  sel == 0 ? a : b
end

# Pruebas
casos_de_prueba = [
  [[0]*16, [1]*16, 0, [0]*16],
  [[0]*16, [1]*16, 1, [1]*16]
]

casos_de_prueba.each do |a, b, sel, esperado|
  resultado = puerta_mux16(a, b, sel)
  raise "Error: MUX16(#{a}, #{b}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de MUX16 pasaron exitosamente "
