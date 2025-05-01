# Clase que gestiona la tabla de símbolos, que guarda las direcciones de las etiquetas y las variables
class SymbolTable
  def initialize
    # Inicializa la tabla con los registros predefinidos de Hack y direcciones reservadas
    @table = Hash["SP", "0", "LCL", "1", "ARG", "2", "THIS",
      "3", "THAT", "4", "SCREEN", "16384", "KBD", "24576"]
    # Asocia las direcciones de R0 a R15
    (0..15).each { |n| @table["R#{n}"] = "#{n}" } # R0~R15
    @variable_num = 0  # Contador para asignar direcciones a nuevas variables
  end

  def insert(label, value)
    # Inserta una etiqueta con su valor en la tabla si no existe
    @table[label] = value unless has_symbol?(label)
  end

  def insert_variable(label)
    # Inserta una variable en la tabla con una dirección empezando desde 16
    unless has_symbol?(label)
      @table[label] = (16 + @variable_num).to_s  # Asigna la dirección a la variable
      @variable_num+=1  # Incrementa el contador de variables
    end
  end

  def read(label)
    # Lee el valor asociado a una etiqueta en la tabla
    @table[label]
  end

private
  def has_symbol?(label)
    # Verifica si una etiqueta ya existe en la tabla
    @table.has_key?(label)
  end
end
