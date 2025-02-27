class ALU
  attr_reader :out, :zr, :ng

  def initialize(x, y, zx, nx, zy, ny, f, no)
    @x = x & 0xFFFF  # Asegura que x sea de 16 bits
    @y = y & 0xFFFF  # Asegura que y sea de 16 bits
    @zx = zx
    @nx = nx
    @zy = zy
    @ny = ny
    @f = f
    @no = no
    compute
  end

  private

  def compute
    # Paso 1: Aplicar zx y nx a x
    x1 = @zx == 1 ? 0 : @x
    x2 = @nx == 1 ? ~x1 & 0xFFFF : x1

    # Paso 2: Aplicar zy y ny a y
    y1 = @zy == 1 ? 0 : @y
    y2 = @ny == 1 ? ~y1 & 0xFFFF : y1

    # Paso 3: Calcular la operación (f == 1 ? x + y : x & y)
    if @f == 1
      out1 = (x2 + y2) & 0xFFFF  # Suma y asegura 16 bits
    else
      out1 = (x2 & y2) & 0xFFFF  # AND y asegura 16 bits
    end

    # Paso 4: Aplicar no al resultado
    @out = @no == 1 ? ~out1 & 0xFFFF : out1

    # Paso 5: Calcular zr (1 si out == 0, 0 en caso contrario)
    @zr = @out == 0 ? 1 : 0

    # Paso 6: Calcular ng (1 si out < 0, 0 en caso contrario)
    @ng = (@out & 0x8000) != 0 ? 1 : 0  # Verifica el bit más significativo
  end
end

# Función para probar la ALU
def test_alu(x, y, zx, nx, zy, ny, f, no)
  alu = ALU.new(x, y, zx, nx, zy, ny, f, no)
  puts "x: #{x.to_s(2).rjust(16, '0')}, y: #{y.to_s(2).rjust(16, '0')}, " \
       "zx: #{zx}, nx: #{nx}, zy: #{zy}, ny: #{ny}, f: #{f}, no: #{no} => " \
       "out: #{alu.out.to_s(2).rjust(16, '0')}, zr: #{alu.zr}, ng: #{alu.ng}"
end

# Pruebas
test_alu(0b0000000000000000, 0b1111111111111111, 1, 0, 1, 0, 1, 0) # Compute 0
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 1, 1, 1, 1) # Compute 1
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 1, 0, 1, 0) # Compute -1
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 1, 1, 0, 0) # Compute x
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 0, 0, 0, 0) # Compute y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 1, 1, 0, 1) # Compute !x
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 0, 0, 0, 1) # Compute !y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 1, 1, 1, 1) # Compute -x
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 0, 0, 1, 1) # Compute -y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 1, 1, 1, 1, 1) # Compute x + 1
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 0, 1, 1, 1) # Compute y + 1
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 1, 1, 1, 0) # Compute x - 1
test_alu(0b0000000000000000, 0b1111111111111111, 1, 1, 0, 0, 1, 0) # Compute y - 1
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 0, 0, 1, 0) # Compute x + y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 1, 0, 0, 1, 1) # Compute x - y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 0, 1, 1, 1) # Compute y - x
test_alu(0b0000000000000000, 0b1111111111111111, 0, 0, 0, 0, 0, 0) # Compute x & y
test_alu(0b0000000000000000, 0b1111111111111111, 0, 1, 0, 1, 0, 1) # Compute x | y