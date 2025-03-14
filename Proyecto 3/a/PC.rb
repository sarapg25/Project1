# Simulación del Program Counter (PC) de 16 bits

# Simulación de un sumador de 16 bits para incremento
def add16(a, b)
  (a + b) & 0xFFFF # Asegurar que se mantenga en 16 bits
end

# Registro de 16 bits para simular la memoria interna del contador
class PC
  def initialize
    @state = 0 # Estado inicial en 0
    @prev_clock = 0 # Estado anterior del clock
  end

  def tick(input, load, inc, reset, clock)
    # Detectar flanco ascendente del clock
    if clock == 1 && @prev_clock == 0
      if reset == 1
        @state = 0
      elsif load == 1
        @state = input & 0xFFFF
      elsif inc == 1
        @state = add16(@state, 1)
      end
    end
    @prev_clock = clock # Guardar el estado actual del clock
  end

  def output
    @state
  end
end

# Prueba del Program Counter
pc = PC.new

# Casos de prueba [input, load, inc, reset]
test_cases = [
  [0x0000, 0, 1, 0], # Incrementa de 0 -> 1
  [0x0000, 0, 1, 0], # Incrementa de 1 -> 2
  [0x0005, 1, 0, 0], # Carga 5
  [0x0000, 0, 1, 0], # Incrementa de 5 -> 6
  [0x0000, 0, 1, 0], # Incrementa de 6 -> 7
  [0x000A, 1, 0, 0], # Carga 10
  [0x0000, 0, 1, 1], # Reset (debe volver a 0)
  [0x0000, 0, 1, 0], # Incrementa de 0 -> 1
  [0x0003, 1, 0, 0], # Carga 3
  [0x0000, 0, 1, 0], # Incrementa de 3 -> 4
]

puts " in  | load | inc | reset | clk | out (bin)        | out (hex)"
puts "------------------------------------------------------------"

clock = 0

test_cases.each do |input, load, inc, reset|
  clock = 1 - clock # Alternar clock entre 0 y 1
  pc.tick(input, load, inc, reset, clock)
  out_bin = pc.output.to_s(2).rjust(16, '0')
  out_hex = pc.output.to_s(16).rjust(4, '0').upcase
  puts " #{input.to_s(16).rjust(4, '0')} |  #{load}   |  #{inc}  |   #{reset}   |  #{clock}  |  #{out_bin} |  0x#{out_hex}"
end
