def puerta_mux4way16(a, b, c, d, sel)
  case sel
  when 0 then a
  when 1 then b
  when 2 then c
  when 3 then d
  end
end

# Pruebas
casos_de_prueba = [
  [[0]*16, [1]*16, [0]*16, [1]*16, 0, [0]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, 1, [1]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, 2, [0]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, 3, [1]*16]
]

casos_de_prueba.each do |a, b, c, d, sel, esperado|
  resultado = puerta_mux4way16(a, b, c, d, sel)
  raise "Error: MUX4Way16(#{a}, #{b}, #{c}, #{d}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de MUX4Way16 pasaron exitosamente "
