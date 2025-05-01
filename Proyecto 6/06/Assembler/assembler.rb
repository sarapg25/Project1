require "./instruction_type.rb"
require "./symbol_table.rb"
require "./code.rb"
require "tempfile"

class Assembler
  # El constructor inicializa los archivos y la tabla de símbolos
  def initialize(path)
    @hack_file = File.open(path+".hack", "w")  # Archivo donde se escribirá el código binario Hack
    @asm_file = File.open(path+".asm", "r")    # Archivo con el código fuente en ensamblador
    @t_file = Tempfile.new("temp.txt")         # Archivo temporal para almacenar las líneas limpias de código
    @symbol_table = SymbolTable.new            # Se crea una tabla de símbolos para gestionar etiquetas y variables
  end

  # Método principal que compila el archivo .asm a .hack
  def compile
    # Elimina comentarios y líneas vacías, y guarda el código limpio en un archivo temporal
    @asm_file.each_line do |line|
      line = line.gsub(/\s+|^$\n|\/\/.+/, "")  # Limpieza de la línea (eliminar espacios, comentarios y vacías)
      @t_file.puts line unless line.chomp.empty?  # Escribe solo las líneas no vacías en el archivo temporal
    end

    # Inserta las etiquetas en la tabla de símbolos
    index = 0  # Contador de línea para las instrucciones
    @t_file.open.each_line do |line|
      code = Code.new(line.gsub("\n", ""))  # Analiza cada línea para identificar etiquetas
      if code.type == LABEL_INSTRUCTION  # Si es una etiqueta, se guarda en la tabla de símbolos
        @symbol_table.insert(code._destination, index)
      else
        index += 1  # Si no es una etiqueta, aumenta el índice para la siguiente instrucción
      end
    end

    # Inserta las variables en la tabla de símbolos
    @t_file.open.each_line do |line|
      code = Code.new(line.gsub("\n", ""))  # Analiza nuevamente las líneas
      @symbol_table.insert_variable(code._destination) if code.type == VARIABLE_INSTRUCTION
      # Si es una variable, se agrega a la tabla de símbolos
    end

    # Compila el código a binario y lo escribe en el archivo .hack
    @t_file.open.each_line do |line|
      code = Code.new(line.gsub("\n", ""), @symbol_table)  # Se analiza el código con la tabla de símbolos
      @hack_file.write "#{code.compile}\n" unless code.type == LABEL_INSTRUCTION
      # Si no es una etiqueta, se escribe la instrucción compilada en el archivo .hack
    end

    # Cierra los archivos abiertos
    @asm_file.close
    @hack_file.close
  end
end
