def puerta_mux8way16(a, b, c, d, e, f, g, h, sel)
  case sel
  when 0 then a
  when 1 then b
  when 2 then c
  when 3 then d
  when 4 then e
  when 5 then f
  when 6 then g
  when 7 then h
  end
end

# Pruebas
casos_de_prueba = [
  [[0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, 0, [0]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, 1, [1]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, 4, [0]*16],
  [[0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, [0]*16, [1]*16, 7, [1]*16]
]

casos_de_prueba.each do |a, b, c, d, e, f, g, h, sel, esperado|
  resultado = puerta_mux8way16(a, b, c, d, e, f, g, h, sel)
  raise "Error: MUX8Way16(#{a}, #{b}, #{c}, #{d}, #{e}, #{f}, #{g}, #{h}, #{sel}) debería ser #{esperado}, pero dio #{resultado}" unless resultado == esperado
end

puts "Pruebas de MUX8Way16 pasaron exitosamente "
