# Simulación del RAM4K

# Simulación de un multiplexor de 8 vías de 16 bits
def mux8way16(a, b, c, d, e, f, g, h, sel)
  case sel
  when 0 then a
  when 1 then b
  when 2 then c
  when 3 then d
  when 4 then e
  when 5 then f
  when 6 then g
  when 7 then h
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de un demultiplexor de 8 vías
def dmux8way(in_val, sel)
  case sel
  when 0 then [in_val, 0, 0, 0, 0, 0, 0, 0]
  when 1 then [0, in_val, 0, 0, 0, 0, 0, 0]
  when 2 then [0, 0, in_val, 0, 0, 0, 0, 0]
  when 3 then [0, 0, 0, in_val, 0, 0, 0, 0]
  when 4 then [0, 0, 0, 0, in_val, 0, 0, 0]
  when 5 then [0, 0, 0, 0, 0, in_val, 0, 0]
  when 6 then [0, 0, 0, 0, 0, 0, in_val, 0]
  when 7 then [0, 0, 0, 0, 0, 0, 0, in_val]
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de un RAM512
class RAM512
  def initialize
    @memory = Array.new(512, 0) # 512 registros de 16 bits
  end

  def tick(input, load, address)
    if load == 1
      @memory[address] = input & 0xFFFF # Almacenar el valor de entrada
    end
    @memory[address] # Devolver el valor almacenado en la dirección
  end
end

# Simulación del RAM4K
class RAM4K
  def initialize
    # Crear 8 bloques de RAM512
    @ram0 = RAM512.new
    @ram1 = RAM512.new
    @ram2 = RAM512.new
    @ram3 = RAM512.new
    @ram4 = RAM512.new
    @ram5 = RAM512.new
    @ram6 = RAM512.new
    @ram7 = RAM512.new
  end

  def tick(input, load, address)
    # Extraer los bits de selección (address[9..11])
    sel = (address >> 9) & 0x7

    # Demultiplexar la señal de load
    load0, load1, load2, load3, load4, load5, load6, load7 = dmux8way(load, sel)

    # Dirección dentro de cada RAM512 (address[0..8])
    ram_address = address & 0x1FF

    # Ejecutar cada RAM512
    out0 = @ram0.tick(input, load0, ram_address)
    out1 = @ram1.tick(input, load1, ram_address)
    out2 = @ram2.tick(input, load2, ram_address)
    out3 = @ram3.tick(input, load3, ram_address)
    out4 = @ram4.tick(input, load4, ram_address)
    out5 = @ram5.tick(input, load5, ram_address)
    out6 = @ram6.tick(input, load6, ram_address)
    out7 = @ram7.tick(input, load7, ram_address)

    # Multiplexar la salida
    mux8way16(out0, out1, out2, out3, out4, out5, out6, out7, sel)
  end
end

# Prueba del RAM4K
ram4k = RAM4K.new

# Casos de prueba [input, load, address, expected_out]
test_cases = [
  [0x1234, 1, 0x0000, 0x1234], # Escribir 0x1234 en la dirección 0x0000
  [0x5678, 1, 0x0200, 0x5678], # Escribir 0x5678 en la dirección 0x0200
  [0x9ABC, 1, 0x0400, 0x9ABC], # Escribir 0x9ABC en la dirección 0x0400
  [0xDEF0, 1, 0x0600, 0xDEF0], # Escribir 0xDEF0 en la dirección 0x0600
  [0x0000, 0, 0x0000, 0x1234], # Leer de la dirección 0x0000 (debe ser 0x1234)
  [0x0000, 0, 0x0200, 0x5678], # Leer de la dirección 0x0200 (debe ser 0x5678)
  [0x0000, 0, 0x0400, 0x9ABC], # Leer de la dirección 0x0400 (debe ser 0x9ABC)
  [0x0000, 0, 0x0600, 0xDEF0], # Leer de la dirección 0x0600 (debe ser 0xDEF0)
]

puts " input  | load | address | out (hex)"
puts "----------------------------------"

test_cases.each do |input, load, address, expected_out|
  out = ram4k.tick(input, load, address)
  puts " 0x#{input.to_s(16).rjust(4, '0')} |  #{load}   | 0x#{address.to_s(16).rjust(4, '0')} |  0x#{out.to_s(16).rjust(4, '0')}"
end