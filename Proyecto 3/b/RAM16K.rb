# Simulación de un multiplexor de 4 vías de 16 bits
def mux4way16(a, b, c, d, sel)
  case sel
  when 0 then a
  when 1 then b
  when 2 then c
  when 3 then d
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de un demultiplexor de 4 vías
def dmux4way(in_val, sel)
  case sel
  when 0 then [in_val, 0, 0, 0]
  when 1 then [0, in_val, 0, 0]
  when 2 then [0, 0, in_val, 0]
  when 3 then [0, 0, 0, in_val]
  else
    raise "Invalid selection value: #{sel}"
  end
end

# Simulación de una memoria RAM4K (4096 registros de 16 bits)
class RAM4K
  def initialize
    @memory = Array.new(4096, 0)
  end

  def write(input, load, address)
    @memory[address] = input & 0xFFFF if load == 1
  end

  def read(address)
    @memory[address]
  end
end

# Simulación de la memoria RAM16K
class RAM16K
  def initialize
    @ram0 = RAM4K.new
    @ram1 = RAM4K.new
    @ram2 = RAM4K.new
    @ram3 = RAM4K.new
  end

  def write(input, load, address)
    return if address >= 0x4000  # Evitar direcciones fuera de rango

    sel = (address >> 12) & 0x3   # Extraer bits 12 y 13 para seleccionar RAM4K
    ram_address = address & 0xFFF # Dirección interna dentro de cada RAM4K

    # Demultiplexar la señal de carga
    load0, load1, load2, load3 = dmux4way(load, sel)

    # Escribir en la RAM correspondiente
    @ram0.write(input, load0, ram_address)
    @ram1.write(input, load1, ram_address)
    @ram2.write(input, load2, ram_address)
    @ram3.write(input, load3, ram_address)
  end

  def read(address)
    return 0 if address >= 0x4000  # Evitar direcciones fuera de rango

    sel = (address >> 12) & 0x3   # Extraer bits 12 y 13
    ram_address = address & 0xFFF # Dirección interna dentro de cada RAM4K

    # Leer de la RAM correspondiente
    out0 = @ram0.read(ram_address)
    out1 = @ram1.read(ram_address)
    out2 = @ram2.read(ram_address)
    out3 = @ram3.read(ram_address)

    # Multiplexar la salida
    mux4way16(out0, out1, out2, out3, sel)
  end
end

# Prueba del RAM16K
ram16k = RAM16K.new

# Casos de prueba [input, load, address, expected_out]
test_cases = [
  [0x1234, 1, 0x0000, 0x1234], # Escribir 0x1234 en la dirección 0x0000
  [0x5678, 1, 0x1000, 0x5678], # Escribir 0x5678 en la dirección 0x1000
  [0x9ABC, 1, 0x2000, 0x9ABC], # Escribir 0x9ABC en la dirección 0x2000
  [0xDEF0, 1, 0x3000, 0xDEF0], # Escribir 0xDEF0 en la dirección 0x3000
  [0x0000, 0, 0x0000, 0x1234], # Leer de la dirección 0x0000 (debe ser 0x1234)
  [0x0000, 0, 0x1000, 0x5678], # Leer de la dirección 0x1000 (debe ser 0x5678)
  [0x0000, 0, 0x2000, 0x9ABC], # Leer de la dirección 0x2000 (debe ser 0x9ABC)
  [0x0000, 0, 0x3000, 0xDEF0], # Leer de la dirección 0x3000 (debe ser 0xDEF0)
]

puts " input  | load | address | expected | out"
puts "------------------------------------------"

test_cases.each do |input, load, address, expected_out|
  ram16k.write(input, load, address) if load == 1 # Solo escribir si load == 1
  out = ram16k.read(address)
  puts " 0x#{input.to_s(16).rjust(4, '0')} |  #{load}   | 0x#{address.to_s(16).rjust(4, '0')} | 0x#{expected_out.to_s(16).rjust(4, '0')} | 0x#{out.to_s(16).rjust(4, '0')}"
end
